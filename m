Received: from eggs.gnu.org ([2001:4830:134:3::10]:41843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fJFWB-0001B5-BQ
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fJFW7-0000NC-6d
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:48:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59230 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fJFW7-0000MM-24
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:48:11 -0400
Date: Thu, 17 May 2018 10:48:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180517094806.GB2500@work-vm>
References: <20180514165424.12884-1-zhangckid@gmail.com>
	<20180514165424.12884-17-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514165424.12884-17-zhangckid@gmail.com>
Subject: Re: [Qemu-devel] [PATCH V7 RESEND 16/17] COLO: notify net filters
 about checkpoint/failover event
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
> Notify all net filters about the checkpoint and failover event.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/colo.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 3dfd84d897..15463e2823 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -88,6 +88,11 @@ static void secondary_vm_do_failover(void)
>      if (local_err) {
>          error_report_err(local_err);
>      }
> +    /* Notify all filters of all NIC to do checkpoint */
> +    colo_notify_filters_event(COLO_EVENT_FAILOVER, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
>  
>      if (!autostart) {
>          error_report("\"-S\" qemu option will be ignored in secondary side");
> @@ -799,6 +804,13 @@ void *colo_process_incoming_thread(void *opaque)
>              goto out;
>          }
>  
> +        /* Notify all filters of all NIC to do checkpoint */
> +        colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
> +        if (local_err) {
> +            qemu_mutex_unlock_iothread();
> +            goto out;
> +        }
> +
>          vmstate_loading = false;
>          vm_start();
>          trace_colo_vm_state_change("stop", "run");
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
