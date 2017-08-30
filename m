Received: from eggs.gnu.org ([2001:4830:134:3::10]:38224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn5AJ-0006iV-PN
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn5AD-0004u4-W6
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:44:27 -0400
Date: Wed, 30 Aug 2017 16:44:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830154416.GV24565@stefanha-x1.localdomain>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822131832.20191-9-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 08/10] scsi: build
 qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

On Tue, Aug 22, 2017 at 03:18:30PM +0200, Paolo Bonzini wrote:
> diff --git a/docs/interop/pr-helper.rst b/docs/interop/pr-helper.rst
> new file mode 100644
> index 0000000000..765174c31f
> --- /dev/null
> +++ b/docs/interop/pr-helper.rst
> @@ -0,0 +1,78 @@
> +..
> +
> +======================================
> +Persistent reservation helper protocol
> +======================================
> +
> +QEMU's SCSI passthrough devices, ``scsi-block`` and ``scsi-generic``,
> +can delegate implementation of persistent reservations to an external
> +(and typically privilege) program.  Persistent Reservations allow

privileged

> diff --git a/scsi/pr-helper.h b/scsi/pr-helper.h
> new file mode 100644
> index 0000000000..2c7ccc9928
> --- /dev/null
> +++ b/scsi/pr-helper.h
> @@ -0,0 +1,13 @@

Do you want to license this file under the BSD license just in case
someone wants to copy it into an external helper implementation?  The
file is trivial but still.

> +#ifndef QEMU_PR_HELPER_H
> +#define QEMU_PR_HELPER_H 1
> +

Missing #include <stdint.h> for in32_t and uint8_t.

> +#include "qemu/osdep.h"
> +#include <getopt.h>
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +#include "qemu/cutils.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/error-report.h"
> +#include "qemu/config-file.h"
> +#include "qemu/bswap.h"
> +#include "qemu/log.h"
> +#include "qemu/systemd.h"
> +#include "qapi/util.h"
> +#include "qapi/qmp/qstring.h"
> +#include "io/channel-socket.h"
> +#include "trace/control.h"
> +#include "qemu-version.h"
> +
> +#include "block/aio.h"
> +#include "block/thread-pool.h"
> +
> +#include "scsi/constants.h"
> +#include "scsi/utils.h"
> +#include "pr-helper.h"
> +#include <sys/ioctl.h>
> +#include <linux/dm-ioctl.h>
> +#include <scsi/sg.h>
> +
> +#ifdef CONFIG_LIBCAP
> +#include <cap-ng.h>
> +#endif
> +#include <pwd.h>
> +#include <grp.h>

#include ordering

> +static int prh_read(PRHelperClient *client, void *buf, int sz, Error **errp)
> +{
> +    while (sz > 0) {
> +        int *fds = NULL;
> +        size_t nfds = 0;
> +        int i;
> +        struct iovec iov;
> +        ssize_t n_read;
> +
> +        iov.iov_base = buf;
> +        iov.iov_len = sz;
> +        n_read = qio_channel_readv_full(QIO_CHANNEL(client->ioc), &iov, 1,
> +                                        &fds, &nfds, errp);
> +
> +        if (n_read == QIO_CHANNEL_ERR_BLOCK) {
> +            qio_channel_yield(QIO_CHANNEL(client->ioc), G_IO_IN);
> +            continue;
> +        }
> +        if (n_read <= 0) {
> +            return n_read ? n_read : -1;

This assumes that client->fd == -1.  It's probably true on Linux but I'm
not sure.  What happens if the client sends an fd with a write that is
smaller than sz, and then follows up by closing the socket?  In the
worst case this would leak client->fd (the caller assumes it's -1 on
failure).

> +        }
> +
> +        /* Stash one file descriptor per request.  */
> +        if (nfds) {
> +            for (i = 0; i < nfds; i++) {
> +                if (client->fd == -1) {
> +                    client->fd = fds[i++];

i++ looks like a bug.  The loop is already iterating fds[i] so we don't
need to increment it.  This would leak the following file descriptor.

> +static void prh_co_entry(void *opaque)

coroutine_fn
