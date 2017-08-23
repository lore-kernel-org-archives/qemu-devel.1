Received: from eggs.gnu.org ([2001:4830:134:3::10]:60167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkNbm-0001aF-11
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 00:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkNbk-0007v5-Ln
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 00:49:38 -0400
Date: Wed, 23 Aug 2017 12:49:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170823044926.GB21343@lemon>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822131832.20191-11-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/10] scsi: add persistent reservation
 manager using qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, 08/22 15:18, Paolo Bonzini wrote:
> This adds a concrete subclass of pr-manager that talks to qemu-pr-helper.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scsi/Makefile.objs       |   2 +-
>  scsi/pr-manager-helper.c | 288 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 289 insertions(+), 1 deletion(-)
>  create mode 100644 scsi/pr-manager-helper.c
> 
> diff --git a/scsi/Makefile.objs b/scsi/Makefile.objs
> index 5496d2ae6a..4d25e476cf 100644
> --- a/scsi/Makefile.objs
> +++ b/scsi/Makefile.objs
> @@ -1,3 +1,3 @@
>  block-obj-y += utils.o
>  
> -block-obj-$(CONFIG_LINUX) += pr-manager.o
> +block-obj-$(CONFIG_LINUX) += pr-manager.o pr-manager-helper.o
> diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
> new file mode 100644
> index 0000000000..c9d9606696
> --- /dev/null
> +++ b/scsi/pr-manager-helper.c
> @@ -0,0 +1,288 @@
> +/*
> + * Persistent reservation manager that talks to qemu-mpath-helper

s/qemu-mpath-helper/qemu-pr-helper/

> + *
> + * Copyright (c) 2017 Red Hat, Inc.

Since I'm commenting on a header, just BTW I was educated that (c) stands for
"copyright" so this is actually a ubiquitous redundancy. :)

> + *
> + * Author: Paolo Bonzini <pbonzini@redhat.com>
> + *
> + * This code is licensed under the LGPL.

Interesting, I think the version of the license is required?

> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "scsi/constants.h"
> +#include "scsi/pr-manager.h"
> +#include "scsi/utils.h"
> +#include "io/channel.h"
> +#include "io/channel-socket.h"
> +#include "pr-helper.h"
> +
> +#include <scsi/sg.h>
> +
> +#define PR_MAX_RECONNECT_ATTEMPTS 5
> +
> +#define TYPE_PR_MANAGER_HELPER "pr-manager-helper"
> +
> +#define PR_MANAGER_HELPER(obj) \
> +     INTERFACE_CHECK(PRManagerHelper, (obj), \
> +                     TYPE_PR_MANAGER_HELPER)
> +
> +typedef struct PRManagerHelper {
> +    /* <private> */
> +    PRManager parent;
> +
> +    char *path;
> +
> +    QemuMutex lock;
> +    QIOChannel *ioc;
> +} PRManagerHelper;
> +
> +/* Called with lock held.  */
> +static int pr_manager_helper_read(PRManagerHelper *pr_mgr,
> +                                  void *buf, int sz, Error **errp)
> +{
> +    ssize_t r = qio_channel_read_all(pr_mgr->ioc, buf, sz, errp);
> +
> +    if (r < 0) {
> +        object_unref(OBJECT(pr_mgr->ioc));
> +        pr_mgr->ioc = NULL;
> +        return r;
> +    }
> +
> +    return r < 0 ? r : 0;
> +}
> +
> +/* Called with lock held.  */
> +static int pr_manager_helper_write(PRManagerHelper *pr_mgr,
> +                                   int fd,
> +                                   const void *buf, int sz, Error **errp)
> +{
> +    size_t nfds = (fd != -1);
> +    while (sz > 0) {
> +        struct iovec iov;
> +        ssize_t n_written;
> +
> +        iov.iov_base = (void *)buf;
> +        iov.iov_len = sz;
> +        n_written = qio_channel_writev_full(QIO_CHANNEL(pr_mgr->ioc), &iov, 1,
> +                                            nfds ? &fd : NULL, nfds, errp);
> +
> +        if (n_written <= 0) {
> +            assert(n_written != QIO_CHANNEL_ERR_BLOCK);
> +            object_unref(OBJECT(pr_mgr->ioc));
> +            pr_mgr->ioc = NULL;
> +            return n_written;
> +        }
> +
> +        nfds = 0;
> +        buf += n_written;
> +        sz -= n_written;
> +    }
> +
> +    return 0;
> +}
> +
> +/* Called with lock held.  */
> +static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
> +                                        Error **errp)
> +{
> +    uint32_t flags;
> +
> +    SocketAddress saddr = {
> +        .type = SOCKET_ADDRESS_TYPE_UNIX,
> +        .u.q_unix.path = g_strdup(pr_mgr->path)

Missing g_free()?

> +    };
> +    QIOChannelSocket *sioc = qio_channel_socket_new();
> +    Error *local_err = NULL;
> +
> +    qio_channel_set_name(QIO_CHANNEL(sioc), "pr-manager-helper");
> +    qio_channel_socket_connect_sync(sioc,
> +                                    &saddr,
> +                                    &local_err);
> +    if (local_err) {
> +        object_unref(OBJECT(sioc));
> +        error_propagate(errp, local_err);
> +        return -ENOTCONN;
> +    }
> +
> +    qio_channel_set_delay(QIO_CHANNEL(sioc), false);
> +    pr_mgr->ioc = QIO_CHANNEL(sioc);
> +
> +    /* A simple feature negotation protocol, even though there is
> +     * no optional feature right now.
> +     */
> +    if (pr_manager_helper_read(pr_mgr, &flags, sizeof(flags), errp) < 0) {

Not returning the return value of pr_manager_helper_read()?.

> +        return -EINVAL;
> +    }
> +
> +    flags = 0;
> +    if (pr_manager_helper_write(pr_mgr, -1, &flags, sizeof(flags), errp) < 0) {
> +        return -EINVAL;

Same here.

> +    }
> +
> +    return 0;
> +}
> +
> +static int pr_manager_helper_run(PRManager *p,
> +                                 int fd, struct sg_io_hdr *io_hdr)
> +{
> +    PRManagerHelper *pr_mgr = PR_MANAGER_HELPER(p);
> +
> +    uint32_t len;
> +    PRHelperResponse resp;
> +    int ret;
> +    int expected_dir;
> +    int attempts;
> +    uint8_t cdb[PR_HELPER_CDB_SIZE] = { 0 };
> +
> +    if (!io_hdr->cmd_len || io_hdr->cmd_len > PR_HELPER_CDB_SIZE) {
> +        return -EINVAL;
> +    }
> +
> +    memcpy(cdb, io_hdr->cmdp, io_hdr->cmd_len);
> +    assert(cdb[0] == PERSISTENT_RESERVE_OUT || cdb[0] == PERSISTENT_RESERVE_IN);
> +    expected_dir =
> +        (cdb[0] == PERSISTENT_RESERVE_OUT ? SG_DXFER_TO_DEV : SG_DXFER_FROM_DEV);
> +    if (io_hdr->dxfer_direction != expected_dir) {
> +        return -EINVAL;
> +    }
> +
> +    len = scsi_cdb_xfer(cdb);
> +    if (io_hdr->dxfer_len < len || len > PR_HELPER_DATA_SIZE) {
> +        return -EINVAL;
> +    }
> +
> +    ret = 0;
> +    qemu_mutex_lock(&pr_mgr->lock);
> +
> +    /* Try to reconnect while sending the CDB.  */
> +    for (attempts = 0; attempts < PR_MAX_RECONNECT_ATTEMPTS; attempts++) {
> +        if (!pr_mgr->ioc) {
> +            if (pr_manager_helper_initialize(pr_mgr, NULL) < 0) {
> +                qemu_mutex_unlock(&pr_mgr->lock);
> +                g_usleep(G_USEC_PER_SEC);
> +                qemu_mutex_lock(&pr_mgr->lock);
> +            }
> +        }
> +
> +        if (pr_mgr->ioc) {
> +            if (pr_manager_helper_write(pr_mgr, fd, cdb,
> +                                        ARRAY_SIZE(cdb), NULL) >= 0) {
> +                break;
> +            }
> +        }
> +    }
> +    if (attempts == PR_MAX_RECONNECT_ATTEMPTS) {
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    /* After sending the CDB, any communications failure causes the
> +     * command to fail.  The failure is transient, retrying the command
> +     * will invoke pr_manager_helper_initialize again.
> +     */
> +    if (expected_dir == SG_DXFER_TO_DEV) {
> +        if (pr_manager_helper_write(pr_mgr, -1, io_hdr->dxferp,
> +                                    len, NULL) < 0) {
> +            ret = -EINVAL;
> +            goto out;
> +        }
> +    }
> +    if (pr_manager_helper_read(pr_mgr, &resp, sizeof(resp), NULL) < 0) {
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +    if (expected_dir == SG_DXFER_FROM_DEV && resp.result == 0) {
> +        if (pr_manager_helper_read(pr_mgr, io_hdr->dxferp, len, NULL) < 0) {
> +            ret = -EINVAL;
> +            goto out;
> +        }
> +    }

Same for these three errors, too.

> +
> +    io_hdr->status = resp.result;
> +    if (resp.result == CHECK_CONDITION) {
> +        io_hdr->driver_status = SG_ERR_DRIVER_SENSE;
> +        io_hdr->sb_len_wr = MIN(io_hdr->mx_sb_len, PR_HELPER_SENSE_SIZE);
> +        memcpy(io_hdr->sbp, resp.sense, io_hdr->sb_len_wr);
> +    }
> +
> +out:
> +    if (ret < 0) {
> +        int sense_len = scsi_build_sense(io_hdr->sbp,
> +                                         SENSE_CODE(LUN_COMM_FAILURE));
> +        io_hdr->driver_status = SG_ERR_DRIVER_SENSE;
> +        io_hdr->sb_len_wr = MIN(io_hdr->mx_sb_len, sense_len);
> +        io_hdr->status = CHECK_CONDITION;
> +    }
> +    qemu_mutex_unlock(&pr_mgr->lock);
> +    return ret;
> +}

Fam
