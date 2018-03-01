Received: from eggs.gnu.org ([2001:4830:134:3::10]:32774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erIE2-0002mw-SS
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erIE1-0007aR-Jc
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:01:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erIE1-0007a6-Dg
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:01:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E680B4015184
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 07:01:56 +0000 (UTC)
Date: Thu, 1 Mar 2018 15:01:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180301070150.GQ27381@xz-mi>
References: <20180228164937.18450-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228164937.18450-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Fix block failure cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

On Wed, Feb 28, 2018 at 04:49:37PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> This fixes a couple of cases where the block migration capability
> doesn't get cleared when a migration failed.
> 
> 1) When block migration is compiled out:
>   (qemu) migrate -d -b  "exec:cat > /dev/null"
>   QEMU compiled without old-style (blk/-b, inc/-i) block migration
>   Use drive_mirror+NBD instead.
>   (qemu) migrate_set_capability xbzrle off
>   QEMU compiled without old-style (blk/-b, inc/-i) block migration
>   Use drive_mirror+NBD instead.
> 
>   This corresponds to https://bugzilla.redhat.com/show_bug.cgi?id=1550022
> 
> 2) When a migration with a bad protocol is tried:
>   (qemu) migrate -d -b "foo:bah"
>   Parameter 'uri' expects a valid migration protocol
>   (qemu) info migrate_capabilities
>   xbzrle: off
>   rdma-pin-all: off
>   auto-converge: off
>   zero-blocks: off
>   compress: off
>   events: off
>   postcopy-ram: off
>   x-colo: off
>   release-ram: off
>   block: on   <<<<<<-----
>   return-path: off
>   pause-before-switchover: off
>   x-multifd: off
> 
> Fixes: 2833c59b947
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/migration.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index b913b98803..da0e4a1f56 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1391,11 +1391,12 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>              return;
>          }
>          migrate_set_block_enabled(true, &local_err);
> +        s->must_remove_block_options = true;
>          if (local_err) {
>              error_propagate(errp, local_err);
> +            block_cleanup_parameters(s);
>              return;
>          }
> -        s->must_remove_block_options = true;
>      }
>  
>      if (has_inc && inc) {
> @@ -1417,11 +1418,10 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>      } else if (strstart(uri, "fd:", &p)) {
>          fd_start_outgoing_migration(s, p, &local_err);
>      } else {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
> +        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
>                     "a valid migration protocol");
>          migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                            MIGRATION_STATUS_FAILED);
> -        return;
>      }
>  
>      if (local_err) {
> -- 
> 2.14.3
> 

Ouch...

Instead it seems to be my fault in 4a84214ebe ("migration: provide
migrate_caps_check()", 2017-07-18).  For now I cannot understand why I
did that before since it's obviously strange if without this
squashed...

diff --git a/migration/migration.c b/migration/migration.c
index 0aa596f867..88ed9375aa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -747,13 +747,15 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
 {
     MigrationState *s = migrate_get_current();
     MigrationCapabilityStatusList *cap;
+    bool cap_list[MIGRATION_CAPABILITY__MAX];
 
     if (migration_is_setup_or_active(s->state)) {
         error_setg(errp, QERR_MIGRATION_ACTIVE);
         return;
     }
 
-    if (!migrate_caps_check(s->enabled_capabilities, params, errp)) {
+    memcpy(cap_list, s->enabled_capabilities, sizeof(cap_list));
+    if (!migrate_caps_check(cap_list, params, errp)) {
         return;
     }

Otherwise I'll get:

(qemu) migrate_set_capability postcopy-ram on                                  
(qemu) migrate_set_capability compress on                                      
Postcopy is not currently compatible with compression                          
(qemu) info migrate_capabilities       
xbzrle: off                            
rdma-pin-all: off                      
auto-converge: off                     
zero-blocks: off                       
compress: on         <------------------------- :(
events: off                            
postcopy-ram: on                       
x-colo: off                            
release-ram: off                       
block: off                             
return-path: off                       
pause-before-switchover: off           
x-multifd: off
 
And it looks very likely that this should solve the block bug too.

(So I think either I got a brain fart last July, or now...)

Thanks,

-- 
Peter Xu
