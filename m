Received: from eggs.gnu.org ([2001:4830:134:3::10]:53255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBOui-00059A-TN
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBOue-0001Hl-Oo
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:08:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dBOue-0001HP-FY
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:08:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3908261D04
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:08:31 +0000 (UTC)
Date: Thu, 18 May 2017 18:08:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170518170825.GI2079@work-vm>
References: <20170518161655.30311-1-quintela@redhat.com>
	<20170518161655.30311-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170518161655.30311-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/9] migration: Export qemu-file-channel.c
 functions in its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h |  1 +
>  include/migration/qemu-file.h |  4 ----
>  migration/channel.c           |  1 +
>  migration/colo.c              |  1 +
>  migration/migration.c         |  1 +
>  migration/qemu-file-channel.c |  1 +
>  migration/qemu-file-channel.h | 32 ++++++++++++++++++++++++++++++++
>  migration/rdma.c              |  1 +
>  migration/savevm.c            |  1 +
>  tests/test-vmstate.c          |  1 +
>  10 files changed, 40 insertions(+), 4 deletions(-)
>  create mode 100644 migration/qemu-file-channel.h
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index e831259..8280df1 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -19,6 +19,7 @@
>  #include "qemu/thread.h"
>  #include "qemu/notify.h"
>  #include "migration/vmstate.h"
> +#include "io/channel.h"
>  #include "qapi-types.h"
>  #include "exec/cpu-common.h"
>  #include "qemu/coroutine_int.h"
> diff --git a/include/migration/qemu-file.h b/include/migration/qemu-file.h
> index 0cd648a..b5ac800 100644
> --- a/include/migration/qemu-file.h
> +++ b/include/migration/qemu-file.h
> @@ -27,8 +27,6 @@
>  
>  #include "qemu-common.h"
>  #include "exec/cpu-common.h"
> -#include "io/channel.h"
> -
>  
>  /* Read a chunk of data from a file at the given position.  The pos argument
>   * can be ignored if the file is only be used for streaming.  The number of
> @@ -119,8 +117,6 @@ typedef struct QEMUFileHooks {
>  } QEMUFileHooks;
>  
>  QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops);
> -QEMUFile *qemu_fopen_channel_input(QIOChannel *ioc);
> -QEMUFile *qemu_fopen_channel_output(QIOChannel *ioc);
>  void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks);
>  int qemu_get_fd(QEMUFile *f);
>  int qemu_fclose(QEMUFile *f);
> diff --git a/migration/channel.c b/migration/channel.c
> index f50267a..124857d 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -16,6 +16,7 @@
>  #include "qemu/osdep.h"
>  #include "channel.h"
>  #include "migration/migration.h"
> +#include "qemu-file-channel.h"
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "io/channel-tls.h"
> diff --git a/migration/colo.c b/migration/colo.c
> index dd38fed..9cd0250 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/timer.h"
>  #include "sysemu/sysemu.h"
> +#include "qemu-file-channel.h"
>  #include "migration/colo.h"
>  #include "migration/block.h"
>  #include "io/channel-buffer.h"
> diff --git a/migration/migration.c b/migration/migration.c
> index 217616d..2d9379c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -19,6 +19,7 @@
>  #include "qemu/main-loop.h"
>  #include "migration/blocker.h"
>  #include "migration/migration.h"
> +#include "qemu-file-channel.h"
>  #include "migration/qemu-file.h"
>  #include "sysemu/sysemu.h"
>  #include "block/block.h"
> diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
> index 45c13f1..dc991c9 100644
> --- a/migration/qemu-file-channel.c
> +++ b/migration/qemu-file-channel.c
> @@ -23,6 +23,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu-file-channel.h"
>  #include "migration/qemu-file.h"
>  #include "io/channel-socket.h"
>  #include "qemu/iov.h"
> diff --git a/migration/qemu-file-channel.h b/migration/qemu-file-channel.h
> new file mode 100644
> index 0000000..0028a09
> --- /dev/null
> +++ b/migration/qemu-file-channel.h
> @@ -0,0 +1,32 @@
> +/*
> + * QEMUFile backend for QIOChannel objects
> + *
> + * Copyright (c) 2015-2016 Red Hat, Inc
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */

OK, I think that is correct, and we can change it to something else
later if we want, so:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> +#ifndef QEMU_FILE_CHANNEL_H
> +#define QEMU_FILE_CHANNEL_H
> +
> +#include "io/channel.h"
> +
> +QEMUFile *qemu_fopen_channel_input(QIOChannel *ioc);
> +QEMUFile *qemu_fopen_channel_output(QIOChannel *ioc);
> +#endif
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 7eaaf96..166cd60 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -20,6 +20,7 @@
>  #include "migration/migration.h"
>  #include "migration/qemu-file.h"
>  #include "exec/cpu-common.h"
> +#include "qemu-file-channel.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/sockets.h"
> diff --git a/migration/savevm.c b/migration/savevm.c
> index a728414..8565103 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -36,6 +36,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/timer.h"
>  #include "migration/migration.h"
> +#include "qemu-file-channel.h"
>  #include "postcopy-ram.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/error-report.h"
> diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
> index f694a89..1c13570 100644
> --- a/tests/test-vmstate.c
> +++ b/tests/test-vmstate.c
> @@ -27,6 +27,7 @@
>  #include "qemu-common.h"
>  #include "migration/migration.h"
>  #include "migration/vmstate.h"
> +#include "../migration/qemu-file-channel.h"
>  #include "qemu/coroutine.h"
>  #include "io/channel-file.h"
>  
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
