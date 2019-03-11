Received: from eggs.gnu.org ([209.51.188.92]:44960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h3Gvg-00078K-9o
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1h3Gve-0000mW-UP
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:09:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:45219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1h3Gve-0000hH-IQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:09:02 -0400
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Mon, 11 Mar 2019 09:08:50 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D7806073764@shsmsx102.ccr.corp.intel.com>
References: <20190303145021.2962-1-chen.zhang@intel.com>
	<20190303145021.2962-5-chen.zhang@intel.com>
	<87ef7g2d16.fsf@dusky.pond.sub.org>
In-Reply-To: <87ef7g2d16.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>


-----Original Message-----
From: Markus Armbruster [mailto:armbru@redhat.com]=20
Sent: Sunday, March 10, 2019 1:06 AM
To: Zhang, Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>; Zhang Chen <zhangckid@gmail.com>=
; Dr. David Alan Gilbert <dgilbert@redhat.com>; Juan Quintela <quintela@red=
hat.com>; zhanghailiang <zhang.zhanghailiang@huawei.com>; Eric Blake <eblak=
e@redhat.com>; qemu-dev <qemu-devel@nongnu.org>; Zhang, Chen <chen.zhang@in=
tel.com>
Subject: Re: [Qemu-devel] [PATCH V3 4/7] Migration/colo.c: Add new COLOExit=
Reason to handle all failover state

Zhang Chen <chen.zhang@intel.com > writes:

> From: Zhang Chen <chen.zhang@intel.com>
>
> In this patch we add the processing state for COLOExitReason, because=20
> we have to identify COLO in the failover processing state or failover=20
> error state. In the way, we can handle all the failover state.
> We have improved the description of the COLOExitReason by the way.
>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  migration/colo.c    | 24 +++++++++++++-----------
>  qapi/migration.json | 15 +++++++++------
>  2 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/migration/colo.c b/migration/colo.c index=20
> 89325952c7..dbe2b88807 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -267,7 +267,11 @@ COLOStatus *qmp_query_colo_status(Error **errp)
       switch (failover_get_state()) {

failover_get_state() returns FailoverStatus, i.e. one of FAILOVER_STATUS_NO=
NE, _REQUIRE, _ACTIVE, _COMPLETED, _RELAUNCH.

Yes, have any concern here?

       case FAILOVER_STATUS_NONE:
           s->reason =3D COLO_EXIT_REASON_NONE;
           break;
       case FAILOVER_STATUS_REQUIRE:
>          s->reason =3D COLO_EXIT_REASON_REQUEST;
>          break;
>      default:
> -        s->reason =3D COLO_EXIT_REASON_ERROR;
> +        if (migration_in_colo_state()) {
> +            s->reason =3D COLO_EXIT_REASON_PROCESSING;
> +        } else {
> +            s->reason =3D COLO_EXIT_REASON_ERROR;
> +        }
>      }
> =20
>      return s;

In which FailoverStatus can migration_in_colo_state() return true?

It is no close connection about the FailoverStatus,  except the "FAILOVER_S=
TATUS_REQUIRE",=20
other status still have the possibility be triggered here , if migration_in=
_colo_state() return true means
we still in COLO failover process, otherwise means we have exit COLO with s=
ome failover error.

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
> =20
>      /* Hope this not to be too long to wait here */

Change of behavior for FAILOVER_STATUS_REQUIRE, _ACTIVE, _COMPLETED,
_RELAUNCH: send a COLO_EXIT event instead of calling abort().  Why?

Because if COLO occur failover error, we want to make the VM back to normal=
 running status rather than just crash VM.


> @@ -850,17 +851,18 @@ out:
>          error_report_err(local_err);
>      }
> =20
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
> =20
>      if (fb) {

Same question.

> diff --git a/qapi/migration.json b/qapi/migration.json index=20
> 7a795ecc16..089ed67807 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -983,19 +983,22 @@
>  ##
>  # @COLOExitReason:
>  #
> -# The reason for a COLO exit
> +# Describe the reason for COLO exit.

The old text was better.

OK, I will remove it.

>  #
> -# @none: no failover has ever happened. This can't occur in the -#=20
> COLO_EXIT event, only in the result of query-colo-status.
> +# @none: failover has never happened. This state does not occur # in=20
> +the COLO_EXIT event, and is only visible in the result of #=20
> +query-colo-status.

This might be a small improvment.

>  #
> -# @request: COLO exit is due to an external request
> +# @request: COLO exit caused by an external request.
>  #
> -# @error: COLO exit is due to an internal error
> +# @error: COLO exit caused by an internal error.

I like the old text better.

Sorry, I'm not a native speaker.
I will remove it in next version.

> +#
> +# @processing: COLO is currently handling a failover (since 4.0).
>  #
>  # Since: 3.1
>  ##
>  { 'enum': 'COLOExitReason',
> -  'data': [ 'none', 'request', 'error' ] }
> +  'data': [ 'none', 'request', 'error' , 'processing' ] }
> =20
>  ##
>  # @x-colo-lost-heartbeat:

The patch conflates addition of a new member with doc improvements.
Tolerable since both are small.

Yes, Just tiny fix...

Thanks
Zhang Chen
