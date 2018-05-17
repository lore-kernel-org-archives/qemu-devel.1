Received: from eggs.gnu.org ([2001:4830:134:3::10]:42774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fJFbd-0004MS-LX
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fJFba-0003qe-L6
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:53:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fJFba-0003qD-E5
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:53:50 -0400
Date: Thu, 17 May 2018 10:53:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180517095345.GC2500@work-vm>
References: <20180514165424.12884-1-zhangckid@gmail.com>
	<20180514165424.12884-18-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514165424.12884-18-zhangckid@gmail.com>
Subject: Re: [Qemu-devel] [PATCH V7 RESEND 17/17] COLO: quick failover
 process by kick COLO thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

* Zhang Chen (zhangckid@gmail.com) wrote:
> From: zhanghailiang <zhang.zhanghailiang@huawei.com>
> 
> COLO thread may sleep at qemu_sem_wait(&s->colo_checkpoint_sem),
> while failover works begin, It's better to wakeup it to quick
> the process.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/colo.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 15463e2823..16def4865c 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -135,6 +135,11 @@ static void primary_vm_do_failover(void)
>  
>      migrate_set_state(&s->state, MIGRATION_STATUS_COLO,
>                        MIGRATION_STATUS_COMPLETED);
> +    /*
> +     * kick COLO thread which might wait at
> +     * qemu_sem_wait(&s->colo_checkpoint_sem).
> +     */
> +    colo_checkpoint_notify(migrate_get_current());
>  
>      /*
>       * Wake up COLO thread which may blocked in recv() or send(),
> @@ -552,6 +557,9 @@ static void colo_process_checkpoint(MigrationState *s)
>  
>          qemu_sem_wait(&s->colo_checkpoint_sem);
>  
> +        if (s->state != MIGRATION_STATUS_COLO) {
> +            goto out;
> +        }
>          ret = colo_do_checkpoint_transaction(s, bioc, fb);
>          if (ret < 0) {
>              goto out;
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
