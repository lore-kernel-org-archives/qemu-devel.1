Received: from eggs.gnu.org ([2001:4830:134:3::10]:57167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGPD5-0007vF-TN
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGPD2-0001u7-Qu
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:28:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dGPD2-0001sF-Ia
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:28:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A584C3DBEC
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 12:28:11 +0000 (UTC)
Date: Thu, 1 Jun 2017 13:28:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170601122805.GL2083@work-vm>
References: <20170531103509.22021-1-quintela@redhat.com>
	<20170531103509.22021-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531103509.22021-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/10] migration: Export exec.c
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

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h |  4 ----
>  migration/exec.c              |  1 +
>  migration/exec.h              | 26 ++++++++++++++++++++++++++
>  migration/migration.c         |  1 +
>  4 files changed, 28 insertions(+), 4 deletions(-)
>  create mode 100644 migration/exec.h
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index d1a353a..d04f045 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -163,10 +163,6 @@ void migration_tls_channel_connect(MigrationState *s,
>  
>  uint64_t migrate_max_downtime(void);
>  
> -void exec_start_incoming_migration(const char *host_port, Error **errp);
> -
> -void exec_start_outgoing_migration(MigrationState *s, const char *host_port, Error **errp);
> -
>  void tcp_start_incoming_migration(const char *host_port, Error **errp);
>  
>  void tcp_start_outgoing_migration(MigrationState *s, const char *host_port, Error **errp);
> diff --git a/migration/exec.c b/migration/exec.c
> index 57a9335..9077024 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -21,6 +21,7 @@
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "channel.h"
> +#include "exec.h"
>  #include "migration/migration.h"
>  #include "io/channel-command.h"
>  #include "trace.h"
> diff --git a/migration/exec.h b/migration/exec.h
> new file mode 100644
> index 0000000..b210ffd
> --- /dev/null
> +++ b/migration/exec.h
> @@ -0,0 +1,26 @@
> +/*
> + * QEMU live migration
> + *
> + * Copyright IBM, Corp. 2008
> + * Copyright Dell MessageOne 2008
> + * Copyright Red Hat, Inc. 2015-2016
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>
> + *  Charles Duffy     <charles_duffy@messageone.com>
> + *  Daniel P. Berrange <berrange@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + * Contributions after 2012-01-13 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.
> + */
> +
> +#ifndef QEMU_MIGRATION_EXEC_H
> +#define QEMU_MIGRATION_EXEC_H
> +void exec_start_incoming_migration(const char *host_port, Error **errp);
> +
> +void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
> +                                   Error **errp);
> +#endif
> diff --git a/migration/migration.c b/migration/migration.c
> index ea61650..31fa56f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -18,6 +18,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "migration/blocker.h"
> +#include "exec.h"
>  #include "migration/migration.h"
>  #include "savevm.h"
>  #include "qemu-file-channel.h"
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
