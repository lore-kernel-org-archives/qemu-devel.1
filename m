Received: from eggs.gnu.org ([2001:4830:134:3::10]:34456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAtKR-00075s-DV
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAtKE-0002oe-Uu
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:01:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gAtKE-0002k1-Gg
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:01:38 -0400
Date: Fri, 12 Oct 2018 10:01:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181012090131.GB2555@work-vm>
References: <20181012025623.38792-1-jialina01@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012025623.38792-1-jialina01@baidu.com>
Subject: Re: [Qemu-devel] [PATCH] migration: avoid segmentfault when take a
 snapshot of a VM which being migrated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jialina01 <jialina01@baidu.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, chaiwen <chaiwen@baidu.com>, zhangyu <zhangyu31@baidu.com>

* jialina01 (jialina01@baidu.com) wrote:
> During an active background migraion, snapshot will trigger a
> segmentfault. As snapshot clears the "current_migration" struct
> and updates "to_dst_file" before it finds out that there is a
> migration task, Migration accesses the null pointer in
> "current_migration" struct and qemu crashes eventually.
> 
> Signed-off-by: jialina01 <jialina01@baidu.com>
> Signed-off-by: chaiwen <chaiwen@baidu.com>
> Signed-off-by: zhangyu <zhangyu31@baidu.com>

Yes, that looks like an improvement, but is it enough?
With that change does qemu_savevm_state fail cleanly if attempted
during a migration?   I suspect it will still try and do a snapshot,
because I don't see where it's checking the current state
(like the check in migrate_prepare that does a QERR_MIGRATIION_ACTIVE).

Dave


> ---
>  migration/savevm.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 2d10e45582..9cb97ca343 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1319,21 +1319,18 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>      MigrationState *ms = migrate_get_current();
>      MigrationStatus status;
>  
> -    migrate_init(ms);
> -
> -    ms->to_dst_file = f;
> -
>      if (migration_is_blocked(errp)) {
> -        ret = -EINVAL;
> -        goto done;
> +        return -EINVAL;
>      }
>  
>      if (migrate_use_block()) {
>          error_setg(errp, "Block migration and snapshots are incompatible");
> -        ret = -EINVAL;
> -        goto done;
> +        return -EINVAL;
>      }
>  
> +    migrate_init(ms);
> +    ms->to_dst_file = f;
> +
>      qemu_mutex_unlock_iothread();
>      qemu_savevm_state_header(f);
>      qemu_savevm_state_setup(f);
> @@ -1355,7 +1352,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>          error_setg_errno(errp, -ret, "Error while writing VM state");
>      }
>  
> -done:
>      if (ret != 0) {
>          status = MIGRATION_STATUS_FAILED;
>      } else {
> -- 
> 2.13.2.windows.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
