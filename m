Received: from eggs.gnu.org ([209.51.188.92]:42742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2fQT-0005n5-10
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2fQQ-0001t7-TA
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:06:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h2fQP-0001pK-6i
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:06:18 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190303145021.2962-1-chen.zhang@intel.com>
	<20190303145021.2962-5-chen.zhang@intel.com>
Date: Sat, 09 Mar 2019 18:06:13 +0100
In-Reply-To: <20190303145021.2962-5-chen.zhang@intel.com> (Zhang Chen's
	message of "Sun, 3 Mar 2019 22:50:18 +0800")
Message-ID: <87ef7g2d16.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

Zhang Chen <chen.zhang@intel.com > writes:

> From: Zhang Chen <chen.zhang@intel.com>
>
> In this patch we add the processing state for COLOExitReason,
> because we have to identify COLO in the failover processing state or
> failover error state. In the way, we can handle all the failover state.
> We have improved the description of the COLOExitReason by the way.
>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
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
       switch (failover_get_state()) {

failover_get_state() returns FailoverStatus, i.e. one of
FAILOVER_STATUS_NONE, _REQUIRE, _ACTIVE, _COMPLETED, _RELAUNCH.

       case FAILOVER_STATUS_NONE:
           s->reason = COLO_EXIT_REASON_NONE;
           break;
       case FAILOVER_STATUS_REQUIRE:
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

In which FailoverStatus can migration_in_colo_state() return true?

> @@ -579,16 +583,13 @@ out:
       /*
        * There are only two reasons we can get here, some error happened
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

Change of behavior for FAILOVER_STATUS_REQUIRE, _ACTIVE, _COMPLETED,
_RELAUNCH: send a COLO_EXIT event instead of calling abort().  Why?

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

Same question.

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

The old text was better.

>  #
> -# @none: no failover has ever happened. This can't occur in the
> -# COLO_EXIT event, only in the result of query-colo-status.
> +# @none: failover has never happened. This state does not occur
> +# in the COLO_EXIT event, and is only visible in the result of
> +# query-colo-status.

This might be a small improvment.

>  #
> -# @request: COLO exit is due to an external request
> +# @request: COLO exit caused by an external request.
>  #
> -# @error: COLO exit is due to an internal error
> +# @error: COLO exit caused by an internal error.

I like the old text better.

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

The patch conflates addition of a new member with doc improvements.
Tolerable since both are small.
