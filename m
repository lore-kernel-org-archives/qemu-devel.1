Received: from eggs.gnu.org ([2001:4830:134:3::10]:57409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGPE1-00009U-FW
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGPE0-0002Cg-Gt
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:29:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dGPE0-0002CS-8x
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:29:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 512A31A6726
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 12:29:11 +0000 (UTC)
Date: Thu, 1 Jun 2017 13:29:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170601122905.GM2083@work-vm>
References: <20170531103509.22021-1-quintela@redhat.com>
	<20170531103509.22021-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531103509.22021-5-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/10] migration: Export fd.c functions
 in its own file
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

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/migration.h |  4 ----
>  migration/fd.c                |  1 +
>  migration/fd.h                | 23 +++++++++++++++++++++++
>  migration/migration.c         |  1 +
>  4 files changed, 25 insertions(+), 4 deletions(-)
>  create mode 100644 migration/fd.h
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index d04f045..d249c13 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -171,10 +171,6 @@ void unix_start_incoming_migration(const char *path, Error **errp);
>  
>  void unix_start_outgoing_migration(MigrationState *s, const char *path, Error **errp);
>  
> -void fd_start_incoming_migration(const char *path, Error **errp);
> -
> -void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **errp);
> -
>  void rdma_start_outgoing_migration(void *opaque, const char *host_port, Error **errp);
>  
>  void rdma_start_incoming_migration(const char *host_port, Error **errp);
> diff --git a/migration/fd.c b/migration/fd.c
> index 05e0a5c..0077a50 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -18,6 +18,7 @@
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "channel.h"
> +#include "fd.h"
>  #include "migration/migration.h"
>  #include "monitor/monitor.h"
>  #include "io/channel-util.h"
> diff --git a/migration/fd.h b/migration/fd.h
> new file mode 100644
> index 0000000..a14a63c
> --- /dev/null
> +++ b/migration/fd.h
> @@ -0,0 +1,23 @@
> +/*
> + * QEMU live migration via generic fd
> + *
> + * Copyright Red Hat, Inc. 2009-2016
> + *
> + * Authors:
> + *  Chris Lalancette <clalance@redhat.com>
> + *  Daniel P. Berrange <berrange@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.
> + */
> +
> +#ifndef QEMU_MIGRATION_FD_H
> +#define QEMU_MIGRATION_FD_H
> +void fd_start_incoming_migration(const char *path, Error **errp);
> +
> +void fd_start_outgoing_migration(MigrationState *s, const char *fdname,
> +                                 Error **errp);
> +#endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 31fa56f..f3a1236 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -19,6 +19,7 @@
>  #include "qemu/main-loop.h"
>  #include "migration/blocker.h"
>  #include "exec.h"
> +#include "fd.h"
>  #include "migration/migration.h"
>  #include "savevm.h"
>  #include "qemu-file-channel.h"
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
