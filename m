Received: from eggs.gnu.org ([2001:4830:134:3::10]:51403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fAYzO-0006mS-SP
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fAYzN-0002Wq-TR
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:46:30 -0400
Date: Mon, 23 Apr 2018 11:46:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180423104622.GG2518@work-vm>
References: <20180423064020.25434-1-clg@kaod.org>
	<CAFEAcA-LtNpGTV08jvK4i5C5i64WjM5gMB4zGr8P4fkVSkNH7g@mail.gmail.com>
	<53691cbf-08bf-e3f7-22d3-601a279aa08a@kaod.org>
	<CAFEAcA9XBHE5YxN27M1ugprmSf=o5iiNakO2omrY+HBgCszV5Q@mail.gmail.com>
	<a5ca89ac-7c8f-c565-30d0-357bacb1f61e@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a5ca89ac-7c8f-c565-30d0-357bacb1f61e@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] timer/aspeed: fix vmstate version id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>

* C=E9dric Le Goater (clg@kaod.org) wrote:
> On 04/23/2018 11:34 AM, Peter Maydell wrote:
> > On 23 April 2018 at 10:28, C=E9dric Le Goater <clg@kaod.org> wrote:
> >> On 04/23/2018 11:12 AM, Peter Maydell wrote:
> >>>> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
> >>>> index 50acbf530a3a..7df19bd9df91 100644
> >>>> --- a/hw/timer/aspeed_timer.c
> >>>> +++ b/hw/timer/aspeed_timer.c
> >>>> @@ -498,8 +498,8 @@ static const VMStateDescription vmstate_aspeed=
_timer =3D {
> >>>>
> >>>>  static const VMStateDescription vmstate_aspeed_timer_state =3D {
> >>>>      .name =3D "aspeed.timerctrl",
> >>>> -    .version_id =3D 1,
> >>>> -    .minimum_version_id =3D 1,
> >>>> +    .version_id =3D 2,
> >>>> +    .minimum_version_id =3D 2,
> >>>>      .fields =3D (VMStateField[]) {
> >>>>          VMSTATE_UINT32(ctrl, AspeedTimerCtrlState),
> >>>>          VMSTATE_UINT32(ctrl2, AspeedTimerCtrlState),
> >>> Wouldn't it be simpler to just fix the incorrect value in
> >>> the VMSTATE_STRUCT_ARRAY(timers, AspeedTimerCtrlState,
> >>> line ?
> >>
> >> Yes. Also.
> >>
> >> Or bring back all the version ids to 1, as we never supported
> >> migration before.
> >=20
> > I think it's nice to at least do the "bump version" thing, so you
> > get a (hopefully comprehensible) error rather than just wrong
> > data if you do try a cross version migration,=20
>=20
> On that topic, the error message was :
>=20
> 	Missing section footer for aspeed.timerctrl
>=20
> which is not very comprehensible for a version mismatch issue.

Was that before your patch?

The VMSTATE fields in the structure have no metadata stored
for them to be parsed with; if you send a different number
of array entries to the number the destination receives you end
up with a corrupt stream. Section footers are just a canary
that tells you something went wrong in that devices data.
It has no more information to give you a more detailed error.

Dave

> Thanks,
>=20
> C.=20
>=20
> > so I would
> > vote for just fixing the one thing that was wrong: the
> > number in VMSTATE_STRUCT_ARRAY is the version to be used of
> > the substruct, so it didn't need to be bumped in commit
> > 1d3e65aa7a; the main version numbers for vmstate_aspeed_timer
> > did need to be bumped because part of the main struct changed.
> >=20
> > thanks
> > -- PMM
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
