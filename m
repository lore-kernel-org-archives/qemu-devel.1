Received: from eggs.gnu.org ([209.51.188.92]:44769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gyasG-0002Qm-6w
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gyasE-0008VY-E6
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:26:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:51213)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1gyasE-0008Lb-3O
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:26:10 -0500
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Tue, 26 Feb 2019 11:25:56 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78060487EA@shsmsx102.ccr.corp.intel.com>
References: <20190226053434.6252-1-chen.zhang@intel.com>
	<20190226053434.6252-3-chen.zhang@intel.com>
	<20190226105522.GC2721@work-vm>
In-Reply-To: <20190226105522.GC2721@work-vm>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/3] Migration/colo.c: Fix COLO failover
 status error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-dev <qemu-devel@nongnu.org>


-----Original Message-----
From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]=20
Sent: Tuesday, February 26, 2019 6:55 PM
To: Zhang, Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>; Zhang Chen <zhangckid@gmail.com>=
; Juan Quintela <quintela@redhat.com>; zhanghailiang <zhang.zhanghailiang@h=
uawei.com>; qemu-dev <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/3] Migration/colo.c: Fix COLO failover status error

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> When finished COLO failover, the status is FAILOVER_STATUS_COMPLETED.
> The origin codes misunderstand the FAILOVER_STATUS_REQUIRE.
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

Why do these 'case's have to only deal with COMPLETED - what stops the REQU=
IRE/ACTIVE states appearing when these routines check the status; even if t=
hose states only happen for a short amount of time?

Yes, other status just marked the failover processing. We can see colo_fail=
over_bh(), the REQUIRE/ACTIVE only exist for a very short time.


Thanks
Zhang Chen

Dave

> ---
>  migration/colo.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c index=20
> a916dc178c..a13acac192 100644
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
>          s->reason =3D COLO_EXIT_REASON_NONE;
>          break;
> -    case FAILOVER_STATUS_REQUIRE:
> +    case FAILOVER_STATUS_COMPLETED:
>          s->reason =3D COLO_EXIT_REASON_REQUEST;
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
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
