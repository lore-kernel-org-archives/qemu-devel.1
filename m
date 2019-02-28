Received: from eggs.gnu.org ([209.51.188.92]:36225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gzLlV-0008IW-VN
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gzLlP-0007RG-T6
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:30:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:41894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1gzLlP-0007N5-IF
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:30:15 -0500
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Thu, 28 Feb 2019 13:29:47 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780606112F@shsmsx102.ccr.corp.intel.com>
References: <20190226053434.6252-1-chen.zhang@intel.com>
	<20190226053434.6252-3-chen.zhang@intel.com>
	<20190226105522.GC2721@work-vm>
	<9CFF81C0F6B98A43A459C9EDAD400D78060487EA@shsmsx102.ccr.corp.intel.com>
	<20190228130245.GF4970@work-vm>
In-Reply-To: <20190228130245.GF4970@work-vm>
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
Sent: Thursday, February 28, 2019 9:03 PM
To: Zhang, Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>; Zhang Chen <zhangckid@gmail.com>=
; Juan Quintela <quintela@redhat.com>; zhanghailiang <zhang.zhanghailiang@h=
uawei.com>; qemu-dev <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/3] Migration/colo.c: Fix COLO failover status error

* Zhang, Chen (chen.zhang@intel.com) wrote:
>=20
> -----Original Message-----
> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> Sent: Tuesday, February 26, 2019 6:55 PM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>; Zhang Chen=20
> <zhangckid@gmail.com>; Juan Quintela <quintela@redhat.com>;=20
> zhanghailiang <zhang.zhanghailiang@huawei.com>; qemu-dev=20
> <qemu-devel@nongnu.org>
> Subject: Re: [PATCH 2/3] Migration/colo.c: Fix COLO failover status=20
> error
>=20
> * Zhang Chen (chen.zhang@intel.com) wrote:
> > From: Zhang Chen <chen.zhang@intel.com>
> >=20
> > When finished COLO failover, the status is FAILOVER_STATUS_COMPLETED.
> > The origin codes misunderstand the FAILOVER_STATUS_REQUIRE.
> >=20
> > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
>=20
> > Why do these 'case's have to only deal with COMPLETED - what stops the =
REQUIRE/ACTIVE states appearing when these routines check the status; even =
if those states only happen for a short amount of time?
>=20
> Yes, other status just marked the failover processing. We can see colo_fa=
ilover_bh(), the REQUIRE/ACTIVE only exist for a very short time.

But those other states do exist - so don't these case statements have to do=
 something with them?

Yes, you are right.
I will add another one patch to handle other states in this series next ver=
sion.

Thanks
Zhang Chen

Dave

>=20
> Thanks
> Zhang Chen
>=20
> Dave
>=20
> > ---
> >  migration/colo.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/migration/colo.c b/migration/colo.c index
> > a916dc178c..a13acac192 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -121,6 +121,7 @@ static void secondary_vm_do_failover(void)
> >      }
> >      /* Notify COLO incoming thread that failover work is finished */
> >      qemu_sem_post(&mis->colo_incoming_sem);
> > +
> >      /* For Secondary VM, jump to incoming co */
> >      if (mis->migration_incoming_co) {
> >          qemu_coroutine_enter(mis->migration_incoming_co);
> > @@ -262,7 +263,7 @@ COLOStatus *qmp_query_colo_status(Error **errp)
> >      case FAILOVER_STATUS_NONE:
> >          s->reason =3D COLO_EXIT_REASON_NONE;
> >          break;
> > -    case FAILOVER_STATUS_REQUIRE:
> > +    case FAILOVER_STATUS_COMPLETED:
> >          s->reason =3D COLO_EXIT_REASON_REQUEST;
> >          break;
> >      default:
> > @@ -582,7 +583,7 @@ out:
> >          qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
> >                                    COLO_EXIT_REASON_ERROR);
> >          break;
> > -    case FAILOVER_STATUS_REQUIRE:
> > +    case FAILOVER_STATUS_COMPLETED:
> >          qapi_event_send_colo_exit(COLO_MODE_PRIMARY,
> >                                    COLO_EXIT_REASON_REQUEST);
> >          break;
> > @@ -854,7 +855,7 @@ out:
> >          qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
> >                                    COLO_EXIT_REASON_ERROR);
> >          break;
> > -    case FAILOVER_STATUS_REQUIRE:
> > +    case FAILOVER_STATUS_COMPLETED:
> >          qapi_event_send_colo_exit(COLO_MODE_SECONDARY,
> >                                    COLO_EXIT_REASON_REQUEST);
> >          break;
> > --
> > 2.17.GIT
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
