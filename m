Received: from eggs.gnu.org ([209.51.188.92]:39696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2JMO-0006eG-FV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2JMM-0005Rv-A2
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:32:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h2JML-0005Qe-UH
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:32:38 -0500
Date: Fri, 8 Mar 2019 17:32:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190308173232.GE2834@work-vm>
References: <20190303145021.2962-1-chen.zhang@intel.com>
	<20190303145021.2962-3-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303145021.2962-3-chen.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH V3 2/7] Migration/colo.c: Fix COLO failover
 status error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> When finished COLO failover, the status is FAILOVER_STATUS_COMPLETED.
> The origin codes misunderstand the FAILOVER_STATUS_REQUIRE.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

OK, don't fully understand the colo states, but:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/colo.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index a916dc178c..a13acac192 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -121,6 +121,7 @@ static void secondary_vm_do_failover(void)
>      }
>      /* Notify COLO incoming thread that failover work is finished */
>      qemu_sem_post(&mis->colo_incoming_sem);
> +
>      /* For Secondary VM, jump to incoming co */
>      if (mis->migration_incoming_co) {
>          qemu_coroutine_enter(mis->migration_incoming_co);
> @@ -262,7 +263,7 @@ COLOStatus *qmp_query_colo_status(Error **errp)
>      case FAILOVER_STATUS_NONE:
>          s->reason = COLO_EXIT_REASON_NONE;
>          break;
> -    case FAILOVER_STATUS_REQUIRE:
> +    case FAILOVER_STATUS_COMPLETED:
>          s->reason = COLO_EXIT_REASON_REQUEST;
>          break;
>      default:
> @@ -582,7 +583,7 @@ out:
>          qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
>                                    COLO_EXIT_REASON_ERROR);
>          break;
> -    case FAILOVER_STATUS_REQUIRE:
> +    case FAILOVER_STATUS_COMPLETED:
>          qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
>                                    COLO_EXIT_REASON_REQUEST);
>          break;
> @@ -854,7 +855,7 @@ out:
>          qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
>                                    COLO_EXIT_REASON_ERROR);
>          break;
> -    case FAILOVER_STATUS_REQUIRE:
> +    case FAILOVER_STATUS_COMPLETED:
>          qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
>                                    COLO_EXIT_REASON_REQUEST);
>          break;
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
