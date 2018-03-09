Received: from eggs.gnu.org ([2001:4830:134:3::10]:41543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euJd6-0003Yv-Ou
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euJd1-0008Rm-Ra
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:08:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41118 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1euJd1-0008Ra-Ls
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:08:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5688240252F5
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 15:08:15 +0000 (UTC)
Date: Fri, 9 Mar 2018 15:08:10 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180309150809.GC13990@work-vm>
References: <20180305094938.31374-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305094938.31374-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: fix applying wrong capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> When setting migration capabilities via QMP/HMP, we'll apply them even
> if the capability check failed.  Fix it.
> 
> Fixes: 4a84214ebe ("migration: provide migrate_caps_check()", 2017-07-18)
> Signed-off-by: Peter Xu <peterx@redhat.com>

Queued

> ---
>  migration/migration.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 0aa596f867..88ed9375aa 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -747,13 +747,15 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
>  {
>      MigrationState *s = migrate_get_current();
>      MigrationCapabilityStatusList *cap;
> +    bool cap_list[MIGRATION_CAPABILITY__MAX];
>  
>      if (migration_is_setup_or_active(s->state)) {
>          error_setg(errp, QERR_MIGRATION_ACTIVE);
>          return;
>      }
>  
> -    if (!migrate_caps_check(s->enabled_capabilities, params, errp)) {
> +    memcpy(cap_list, s->enabled_capabilities, sizeof(cap_list));
> +    if (!migrate_caps_check(cap_list, params, errp)) {
>          return;
>      }
>  
> -- 
> 2.14.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
