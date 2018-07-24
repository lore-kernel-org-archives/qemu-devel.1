Received: from eggs.gnu.org ([2001:4830:134:3::10]:52090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhwxp-0004dA-Vr
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhwxk-0001yj-1Y
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:02:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fhwxj-0001yd-TC
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:02:47 -0400
Date: Tue, 24 Jul 2018 21:02:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180724130240.GE2479@xz-mi>
References: <1532434585-14732-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1532434585-14732-1-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] migration: fix the Unknown ending
 state error log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

On Tue, Jul 24, 2018 at 08:16:24PM +0800, Lidong Chen wrote:
> When cancelling migration, the state is MIGRATION_STATUS_CANCELLING.
> The state change to MIGRATION_STATUS_CANCELLED when cleanup_bh is scheduled.
> So when migration_iteration_finish is invoked, the state should be
> MIGRATION_STATUS_CANCELLING.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

Thanks, Lidong.  Dave just posted the same patch some days ago:

  [PATCH] migrate: Fix cancelling state warning

> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 8d56d56..ff05422 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2876,7 +2876,7 @@ static void migration_iteration_finish(MigrationState *s)
>          s->vm_was_running = true;
>          /* Fallthrough */
>      case MIGRATION_STATUS_FAILED:
> -    case MIGRATION_STATUS_CANCELLED:
> +    case MIGRATION_STATUS_CANCELLING:
>          if (s->vm_was_running) {
>              vm_start();
>          } else {
> -- 
> 1.8.3.1
> 
> 

Regards,

-- 
Peter Xu
