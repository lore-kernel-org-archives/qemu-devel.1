Received: from eggs.gnu.org ([209.51.188.92]:40997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2JSz-0001FQ-GC
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2JSy-0001yd-LM
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:39:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h2JSy-0001y1-8F
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:39:28 -0500
Date: Fri, 8 Mar 2019 17:39:23 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190308173922.GF2834@work-vm>
References: <20190303145021.2962-1-chen.zhang@intel.com>
	<20190303145021.2962-5-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303145021.2962-5-chen.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH V3 4/7] Migration/colo.c: Add new
 COLOExitReason to handle all failover state
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
> In this patch we add the processing state for COLOExitReason,
> because we have to identify COLO in the failover processing state or
> failover error state. In the way, we can handle all the failover state.
> We have improved the description of the COLOExitReason by the way.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/colo.c    | 24 +++++++++++++-----------
>  qapi/migration.json | 15 +++++++++------
>  2 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 89325952c7..dbe2b88807 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -267,7 +267,11 @@ COLOStatus *qmp_query_colo_status(Error **errp)
>          s->reason = COLO_EXIT_REASON_REQUEST;
>          break;
>      default:
> -        s->reason = COLO_EXIT_REASON_ERROR;
> +        if (migration_in_colo_state()) {
> +            s->reason = COLO_EXIT_REASON_PROCESSING;
> +        } else {
> +            s->reason = COLO_EXIT_REASON_ERROR;
> +        }
>      }
>  
>      return s;
> @@ -579,16 +583,13 @@ out:
>       * or the user triggered failover.
>       */
>      switch (failover_get_state()) {
> -    case FAILOVER_STATUS_NONE:
> -        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
> -                                  COLO_EXIT_REASON_ERROR);
> -        break;
>      case FAILOVER_STATUS_COMPLETED:
>          qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
>                                    COLO_EXIT_REASON_REQUEST);
>          break;
>      default:
> -        abort();
> +        qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
> +                                  COLO_EXIT_REASON_ERROR);
>      }
>  
>      /* Hope this not to be too long to wait here */
> @@ -850,17 +851,18 @@ out:
>          error_report_err(local_err);
>      }
>  
> +    /*
> +     * There are only two reasons we can get here, some error happened
> +     * or the user triggered failover.
> +     */
>      switch (failover_get_state()) {
> -    case FAILOVER_STATUS_NONE:
> -        qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
> -                                  COLO_EXIT_REASON_ERROR);
> -        break;
>      case FAILOVER_STATUS_COMPLETED:
>          qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
>                                    COLO_EXIT_REASON_REQUEST);
>          break;
>      default:
> -        abort();
> +        qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
> +                                  COLO_EXIT_REASON_ERROR);
>      }
>  
>      if (fb) {
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7a795ecc16..089ed67807 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -983,19 +983,22 @@
>  ##
>  # @COLOExitReason:
>  #
> -# The reason for a COLO exit
> +# Describe the reason for COLO exit.
>  #
> -# @none: no failover has ever happened. This can't occur in the
> -# COLO_EXIT event, only in the result of query-colo-status.
> +# @none: failover has never happened. This state does not occur
> +# in the COLO_EXIT event, and is only visible in the result of
> +# query-colo-status.
>  #
> -# @request: COLO exit is due to an external request
> +# @request: COLO exit caused by an external request.
>  #
> -# @error: COLO exit is due to an internal error
> +# @error: COLO exit caused by an internal error.
> +#
> +# @processing: COLO is currently handling a failover (since 4.0).
>  #
>  # Since: 3.1
>  ##
>  { 'enum': 'COLOExitReason',
> -  'data': [ 'none', 'request', 'error' ] }
> +  'data': [ 'none', 'request', 'error' , 'processing' ] }
>  
>  ##
>  # @x-colo-lost-heartbeat:
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
