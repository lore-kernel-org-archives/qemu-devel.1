Received: from eggs.gnu.org ([2001:4830:134:3::10]:46564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5TAU-0000hG-8K
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5TAQ-00049A-7L
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:32:54 -0400
Date: Mon, 9 Apr 2018 11:32:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180409113244.380a32c4.cohuck@redhat.com>
In-Reply-To: <3cb8a831-325e-2e1a-3dae-30864df27a75@linux.vnet.ibm.com>
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
	<20180403113619.54ff1e18.cohuck@redhat.com>
	<dd4fceac-818f-14a2-62b4-94ae73e21796@linux.vnet.ibm.com>
	<3cb8a831-325e-2e1a-3dae-30864df27a75@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, mjrosato@linux.vnet.ibm.com, alex.williamson@redhat.com, eskultet@redhat.com, David Hildenbrand <david@redhat.com>, peter.maydell@linaro.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, alifm@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On Fri, 6 Apr 2018 18:07:56 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 04/05/2018 06:38 PM, Tony Krowiak wrote:
> > On=C2=A004/03/2018=C2=A005:36=C2=A0AM,=C2=A0Cornelia=C2=A0Huck=C2=A0wro=
te: =20
> >> On=C2=A0Mon,=C2=A02=C2=A0Apr=C2=A02018=C2=A012:36:27=C2=A0-0400
> >> Tony=C2=A0Krowiak=C2=A0<akrowiak@linux.vnet.ibm.com>=C2=A0wrote:
> >> =20
> >>> On=C2=A003/26/2018=C2=A005:03=C2=A0AM,=C2=A0Pierre=C2=A0Morel=C2=A0wr=
ote: =20
> >>>> On=C2=A026/03/2018=C2=A010:32,=C2=A0David=C2=A0Hildenbrand=C2=A0wrot=
e: =20
> >>>>> On=C2=A016.03.2018=C2=A000:24,=C2=A0Tony=C2=A0Krowiak=C2=A0wrote: =
=20
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0/*
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0The=C2=A0Query=C2=A0Configur=
ation=C2=A0Information=C2=A0(QCI)=C2=A0function=C2=A0(fc=C2=A0=3D=3D=C2=A04)
> >>>>>> does=C2=A0not
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0set=C2=A0a=C2=A0response=C2=
=A0code=C2=A0in=C2=A0reg=C2=A01,=C2=A0so=C2=A0check=C2=A0for=C2=A0that=C2=
=A0along=C2=A0with=C2=A0the
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*=C2=A0AP=C2=A0feature.
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0((fc=C2=A0!=3D=C2=A04)=C2=A0&&=C2=
=A0s390_has_feat(S390_FEAT_AP))=C2=A0{
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0env->regs[1]=C2=
=A0=3D=C2=A00x10000;
> >>>>>> +
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A00;
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0} =20
> >>>>> This=C2=A0would=C2=A0imply=C2=A0an=C2=A0operation=C2=A0exception=C2=
=A0in=C2=A0case=C2=A0fc=3D=3D4,=C2=A0which=C2=A0sounds=C2=A0very
> >>>>> wrong. =20
> >>>> It=C2=A0depends=C2=A0but=C2=A0I=C2=A0think=C2=A0that=C2=A0the=C2=A0S=
390_FEAT_AP_QUERY_CONFIG_INFO=C2=A0must=C2=A0be
> >>>> tested
> >>>> to=C2=A0know=C2=A0what=C2=A0to=C2=A0answer.
> >>>> If=C2=A0the=C2=A0feature=C2=A0is=C2=A0there,=C2=A0QCI=C2=A0must=C2=
=A0be=C2=A0answered=C2=A0correctly. =20
> >>> This=C2=A0is=C2=A0an=C2=A0interesting=C2=A0proposition=C2=A0which=C2=
=A0raises=C2=A0several=C2=A0issues=C2=A0that=C2=A0will
> >>> need=C2=A0to
> >>> be=C2=A0addressed.=C2=A0The=C2=A0only=C2=A0time=C2=A0the=C2=A0PQAP(QC=
I)=C2=A0instruction=C2=A0is=C2=A0intercepted=C2=A0is
> >>> when:
> >>> *=C2=A0A=C2=A0vfio-ap=C2=A0device=C2=A0is=C2=A0NOT=C2=A0defined=C2=A0=
for=C2=A0the=C2=A0guest=C2=A0because=C2=A0the=C2=A0vfio_ap
> >>> device=C2=A0driver
> >>> =C2=A0=C2=A0=C2=A0=C2=A0will=C2=A0set=C2=A0ECA.28=C2=A0and=C2=A0the=
=C2=A0PQAP(QCI)=C2=A0instruction=C2=A0will=C2=A0be=C2=A0interpreted
> >>> *=C2=A0STFLE.12=C2=A0is=C2=A0set=C2=A0for=C2=A0the=C2=A0guest
> >>>
> >>> You=C2=A0say=C2=A0that=C2=A0the=C2=A0QCI=C2=A0must=C2=A0be=C2=A0answe=
red=C2=A0correctly,=C2=A0but=C2=A0what=C2=A0is=C2=A0the=C2=A0correct
> >>> response?
> >>> If=C2=A0we=C2=A0return=C2=A0the=C2=A0matrix=C2=A0-=C2=A0i.e.,=C2=A0AP=
M,=C2=A0ADM=C2=A0and=C2=A0AQM=C2=A0-=C2=A0configured=C2=A0via=C2=A0the
> >>> mediated
> >>> matrix=C2=A0device's=C2=A0sysfs=C2=A0attributes=C2=A0files,=C2=A0then=
=C2=A0if=C2=A0any=C2=A0APQNs=C2=A0are=C2=A0defined=C2=A0in
> >>> the=C2=A0matrix,
> >>> we=C2=A0will=C2=A0have=C2=A0to=C2=A0handle=C2=A0*ALL*=C2=A0AP=C2=A0in=
structions=C2=A0by=C2=A0executing=C2=A0them=C2=A0on=C2=A0behalf
> >>> of=C2=A0the
> >>> guest.=C2=A0I=C2=A0suppose=C2=A0we=C2=A0could=C2=A0return=C2=A0an=C2=
=A0empty=C2=A0matrix=C2=A0in=C2=A0which=C2=A0case=C2=A0the=C2=A0AP
> >>> bus=C2=A0will=C2=A0come
> >>> up=C2=A0without=C2=A0any=C2=A0devices=C2=A0on=C2=A0the=C2=A0guest,=C2=
=A0but=C2=A0what=C2=A0is=C2=A0the=C2=A0expectation=C2=A0of=C2=A0an
> >>> admin=C2=A0who
> >>> deliberately=C2=A0configures=C2=A0the=C2=A0mediated=C2=A0matrix=C2=A0=
device?=C2=A0Should=C2=A0we=C2=A0forego
> >>> handling=C2=A0interception
> >>> of=C2=A0AP=C2=A0instructions=C2=A0and=C2=A0consider=C2=A0a=C2=A0guest=
=C2=A0configuration=C2=A0that=C2=A0turns=C2=A0on
> >>> S390_FEAT_AP=C2=A0but
> >>> does=C2=A0not=C2=A0define=C2=A0a=C2=A0vfio-ap=C2=A0device=C2=A0to=C2=
=A0be=C2=A0erroneous=C2=A0and=C2=A0terminate=C2=A0starting
> >>> of=C2=A0the=C2=A0guest?
> >>> Anybody=C2=A0have=C2=A0any=C2=A0thoughts? =20
> >> Hard=C2=A0to=C2=A0really=C2=A0give=C2=A0good=C2=A0advice=C2=A0without=
=C2=A0access=C2=A0to=C2=A0the=C2=A0documentation,=C2=A0but:
> >> -=C2=A0If=C2=A0we=C2=A0tell=C2=A0the=C2=A0guest=C2=A0that=C2=A0the=C2=
=A0feature=C2=A0is=C2=A0available,=C2=A0but=C2=A0it=C2=A0does=C2=A0not
> >> =C2=A0=C2=A0=C2=A0get=C2=A0any=C2=A0cards=C2=A0to=C2=A0use,=C2=A0retur=
ning=C2=A0an=C2=A0empty=C2=A0matrix=C2=A0makes=C2=A0the=C2=A0most=C2=A0sense
> >> =C2=A0=C2=A0=C2=A0to=C2=A0me.
> >> -=C2=A0I=C2=A0would=C2=A0not=C2=A0tie=C2=A0starting=C2=A0the=C2=A0gues=
t=C2=A0to=C2=A0the=C2=A0presence=C2=A0of=C2=A0a=C2=A0vfio-ap
> >> =C2=A0=C2=A0=C2=A0device.=C2=A0Having=C2=A0the=C2=A0feature=C2=A0avail=
able=C2=A0in=C2=A0theory=C2=A0but=C2=A0without=C2=A0any
> >> =C2=A0=C2=A0=C2=A0devices=C2=A0actually=C2=A0being=C2=A0usable=C2=A0by=
=C2=A0the=C2=A0guest=C2=A0does=C2=A0not=C2=A0really=C2=A0sound
> >> =C2=A0=C2=A0=C2=A0wrong=C2=A0(can=C2=A0we=C2=A0hotplug=C2=A0this=C2=A0=
later?) =20
> > For this phase of development, it is my opinion that introducing AP ins=
truction
> > interception=C2=A0handlers=C2=A0is=C2=A0superfluous=C2=A0for=C2=A0the=
=C2=A0following=C2=A0reasons:
> >=20
> > 1. Interception handling was introduced solely to ensure an operation e=
xception=C2=A0would
> > =C2=A0=C2=A0 not be injected into the guest when CPU model feature for =
AP (i.e., ap=3Don)
> > =C2=A0=C2=A0 is specified but a VFIO AP device (i.e., -device vfio-ap,s=
ysfsdev=3D$path)
> > =C2=A0=C2=A0=C2=A0is=C2=A0not. =20
>=20
> We can kind of (i.e. modulo EECA.28) ensure this in a different fashion I=
 think. How
> about proclaiming a 'has ap instructions, but nothing to see here' in the
> SIE interpreted flavor (ECA.28 set) the default way of having ap instruct=
ions
> under KVM. This should be easily accomplished with an all zero CRYCB and =
eca.28
> set. The for the guest to actually get real work done with AP we would
> still require some sort of driver to either provide a non-zero matrix by
> altering the CRYCB or unsettling ECA.28 and doing the intercepted flavor.
>=20
> Please notice, the cpu facility ap would still keep it's semantic
> 'has ap instructions' (opposed to 'has ap instructions implemented in
> SIE interpreted flavor). And give us all the flexibility.
>=20
> Yet implementing what we want to have in absence of a driver would become
> much easier (under the assumption that ECA.28 equals EECA.28).
>=20
> How about this?

Unfortunately, this is really hard to follow without the AR... let me
summarize it to check whether I got the gist of it :)

- If the "ap" cpu feature is specified, set a bit that indicates "hey,
  we basically have have AP support" and create the basics, but don't
  enable actual SIE handling. This means the guest gets exceptions from
  the SIE already and we don't need to emulate them.
- Actually enable the missing pieces if a vfio device is created. This
  would enable processing by the SIE, and we would not need to do
  emulation, either (for most of it, IIRC).

I may be all wrong, though... can we at least have a translation of
ECA.28 and EECA.28 (the "ap is there" bit and the "ap instructions are
interpreted" bit?)
