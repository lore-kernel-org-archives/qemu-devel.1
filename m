Received: from eggs.gnu.org ([2001:4830:134:3::10]:45360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fpYlm-0002ap-DW
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fpYli-00007V-44
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:49:54 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:56545 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1fpYlf-00005w-UH
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:49:50 -0400
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Tue, 14 Aug 2018 12:49:33 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473B734510@DGGEMM528-MBX.china.huawei.com>
References: <1534243693-9560-1-git-send-email-jianjay.zhou@huawei.com>
	<2278afdb-d2a6-54b3-67c7-c1f43e4d311c@redhat.com>
	<20180814115202.GH2580@work-vm>
In-Reply-To: <20180814115202.GH2580@work-vm>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH] vl: fix migration when watchdog expires
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

> -----Original Message-----
> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> Sent: Tuesday, August 14, 2018 7:52 PM
> To: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Zhoujian (jay) <jianjay.zhou@huawei.com>; qemu-devel@nongnu.org;
> quintela@redhat.com; wangxin (U) <wangxinxin.wang@huawei.com>
> Subject: Re: [RFC PATCH] vl: fix migration when watchdog expires
>=20
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> > On 14/08/2018 12:48, Jay Zhou wrote:
> > > I got the following error when migrating a VM with watchdog
> > > device:
> > >
> > > {"timestamp": {"seconds": 1533884471, "microseconds": 668099},
> > > "event": "WATCHDOG", "data": {"action": "reset"}}
> > > {"timestamp": {"seconds": 1533884471, "microseconds": 677658},
> > > "event": "RESET", "data": {"guest": true}}
> > > {"timestamp": {"seconds": 1533884471, "microseconds": 677874},
> > > "event": "STOP"}
> > > qemu-system-x86_64: invalid runstate transition: 'prelaunch' ->
> 'postmigrate'
> > > Aborted
> > >
> > > The run state transition is RUN_STATE_FINISH_MIGRATE to
> > > RUN_STATE_PRELAUNCH, then the migration thread aborted when it tries =
to
> set RUN_STATE_POSTMIGRATE.
> > > There is a race between the main loop thread and the migration thread=
 I
> think.
> >
> > In that case I think you shouldn't go to POSTMIGRATE at all, because
> > the VM has been reset.
>=20
> Migration has the VM stopped; it's not expecting the state to change at t=
hat
> point.
>=20
> > Alternatively, when the watchdog fires in RUN_STATE_FINISH_MIGRATE
> > state, it might delay the action until after the "cont" command is
> > invoked on the source, but I'm not sure what's the best way to achieve
> > that...
>=20
> Jay: Which watchdog were you using?

Hi Dave,
it is i6300esb, which uses QEMU_CLOCK_VIRTUAL.

>=20
>  a) Should the watchdog expire when the VM is stopped; I think it shouldn=
't -
> hw/acpi/tco.c uses a virtual timer as does i6300esb; so is the bug here t=
hat
> the watchdog being used didn't use a virtual timer?
>=20
>  b) If the watchdog expires just before the VM gets stopped, is there a r=
ace
> which could hit this?  Possibly.

This is the case I met I think.

Regards,
Jay Zhou

>=20
>  c) Could main_loop_should_exit guard all the 'request's by something tha=
t
> checks whether the VM is stopped?
>=20
> Dave
>=20
>=20
> > Paolo
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
