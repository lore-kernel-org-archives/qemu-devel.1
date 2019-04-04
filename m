Received: from eggs.gnu.org ([209.51.188.92]:59608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hBy0g-0000yf-Fq
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hBy0e-0002oo-AD
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:46:10 -0400
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:37543)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hBy0d-0002HP-SP
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:46:08 -0400
Received: from player715.ha.ovh.net (unknown [10.109.143.24])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 97A1920400A
	for <qemu-devel@nongnu.org>; Thu,  4 Apr 2019 10:45:50 +0200 (CEST)
Date: Thu, 4 Apr 2019 10:45:43 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190404104543.6c4e9172@bahia.lan>
In-Reply-To: <cd1b1889-7e03-6268-8d1e-f1ccfb388588@gmail.com>
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
	<20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190328183923.lcd3p6fpy4qvvxoo@maxibm>
	<20190329132951.451d4ef0@bahia.lan>
	<20190401145858.lw7v3xt7fqanp6nc@maxibm>
	<20190402122807.1a141e37@bahia.lan>
	<cd1b1889-7e03-6268-8d1e-f1ccfb388588@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v7 0/2] spapr-rtas: add ibm,
 get-vpd RTAS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Andrea Bolognani <abologna@redhat.com>, david@gibson.dropbear.id.au

On Wed, 3 Apr 2019 18:07:24 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> On 4/2/19 7:28 AM, Greg Kurz wrote:
> > On Mon, 1 Apr 2019 12:01:48 -0300
> > "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> > =20
> >> Hi Greg,
> >>
> >> Thanks for your review. I added some comments below...
> >>
> >> On Fri, Mar 29, 2019 at 01:29:51PM +0100, Greg Kurz wrote: =20
> >>> On Thu, 28 Mar 2019 15:39:45 -0300
> >>> "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> >>>     =20
> >>>> Hi,
> >>>>
> >>>> On Thu, Mar 28, 2019 at 02:21:51PM +0100, Greg Kurz wrote: =20
> >>>>> On Wed, 27 Mar 2019 17:41:00 -0300
> >>>>> "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> >>>>>       =20
> >>>>>> Here are two patches to add a handler for ibm,get-vpd RTAS calls.
> >>>>>> This RTAS exposes host information in case of set QEMU options
> >>>>>> 'host-serial' and 'host-model' as 'passthrough'.
> >>>>>>
> >>>>>> The patch 1 creates helper functions to get valid 'host-serial'
> >>>>>> and 'host-model' parameters, guided by QEMU command line. These
> >>>>>> parameters are useful to build the guest device tree and to return
> >>>>>> get-vpd RTAS calls. The patch 2 adds the ibm,get-vpd itself.
> >>>>>>
> >>>>>> Update v7:
> >>>>>> * rtas_get_vpd_fields as a static array in spapr machine state
> >>>>>>
> >>>>>> Maxiwell S. Garcia (2):
> >>>>>>    spapr: helper functions to get valid host fields
> >>>>>>    spapr-rtas: add ibm,get-vpd RTAS interface
> >>>>>>
> >>>>>>   hw/ppc/spapr.c         | 48 +++++++++++----------
> >>>>>>   hw/ppc/spapr_rtas.c    | 96 ++++++++++++++++++++++++++++++++++++=
++++++
> >>>>>>   include/hw/ppc/spapr.h | 14 +++++-
> >>>>>>   3 files changed, 135 insertions(+), 23 deletions(-)
> >>>>>>       =20
> >>>>> Hi Maxiwell,
> >>>>>
> >>>>> David sent a patch to rework how the host data is exposed to the gu=
est.
> >>>>> Especially, the special casing of the "none" and "passthrough" stri=
ngs
> >>>>> is no more... I'm afraid you'll have to rework your patches accordi=
ngly:
> >>>>> code+changelog in patch 1 and at least changelog in patch 2.
> >>>>>
> >>>>> Cheers, =20
> >>>> IIUC, the 'ibm,get-vpd' RTAS should return information about the
> >>>> platform/cabinet. Thus, it's not necessary to add new nodes in the g=
uest
> >>>> device tree to export information like that. =20
> >>> I agree that these "host-model" and "host-serial" props, which aren't
> >>> described anywhere and not used by either the linux kernel or the
> >>> powerpc-utils, look like a QEMU-specific poor man's version of VPD.
> >>>
> >>> Not quite sure why they were even created since this is the purpose
> >>> of "system-id" and "model" as explained in PAPR, and supposedly
> >>> exposed in /proc/ppc64/lparcfg according to the LPARCFG(5) manual
> >>> page:
> >>>
> >>>         serial_number
> >>>         The serial number of the physical system in which the partiti=
on resides
> >>>
> >>>         system_type
> >>>         The  machine,type-model  of  the physical system in which the=
 partition
> >>>         resides
> >>>
> >>> This is indeed what we get in a PowerVM LPAR running on a tuleta syst=
em:
> >>>
> >>> [root@furax1 ~]# head -3 /proc/ppc64/lparcfg
> >>> lparcfg 1.9
> >>> serial_number=3DIBM,032116A9A
> >>> system_type=3DIBM,8247-22L
> >>>
> >>> [root@furax1 ~]# echo $(cat /proc/device-tree/system-id)
> >>> IBM,032116A9A
> >>> [root@furax1 ~]# echo $(cat /proc/device-tree/model)
> >>> IBM,8247-22L
> >>>
> >>> But QEMU generates a hard coded "IBM pSeries (emulated by qemu)" mode=
l,
> >>> which is clearly not PAPR compliant according to this requirement:
> >>>
> >>> 	R1=E2=80=9312.2=E2=80=9313. There must be a property, =E2=80=9Cmodel=
=E2=80=9D, under the root node
> >>> 	in the format, =E2=80=9C<vendor>,xxxx-yyy=E2=80=9D, where <vendor> i=
s replaced by
> >>> 	one to five letters representing the stock symbol of the company
> >>> 	(for example, for IBM: =E2=80=9CIBM,xxxx-yyy=E2=80=9D), and where xx=
xx-yyy is
> >>> 	derived from the VPD TM field (see Table 160=E2=80=9A =E2=80=9CLoPAP=
R VPD Fields=E2=80=9A=E2=80=9D
> >>> 	on page 343) of the first or =E2=80=98marked=E2=80=99 processor encl=
osure.
> >>>
> >>> And worse, it mixes "vm,uuid" which is QEMU specific concept to uniqu=
ely
> >>> identify guests, with "system-id" which is about the host :-\
> >>>
> >>> All of this is very confusing and need to be sorted out before buildi=
ng
> >>> anything on top of it. Especially since "model" and "system-id" are
> >>> supposed to derive from VPD IIUC.
> >>>
> >>> I guess that we should first decide what we really want to expose
> >>> in "system-id" and "model": what we have now ? the same as in
> >>> "host-serial" and "host-model", ie. user configurable ? Must we
> >>> stay compatible with existing setups ? In any case, I'm afraid that
> >>> we have to diverge from PAPR somehow, since it obviously doesn't
> >>> care about the security concerns that motivated recent changes
> >>> for "host-serial" and "host-model"...
> >>>     =20
> >> Many important changes should be done to solve these inconsistencies.
> >> So, I saw in the 'get-vpd' RTAS a manner to return host information
> >> and that works with live-migration.
> >> =20
> > Yes it does indeed allow that, among other things. My concern is more t=
hat
> > PAPR clearly indicates that the "system-id" and "model" in the root node
> > are derived from the VPD, and this series is about to tie the VPD TM and
> > VPD SE keywords to something else that isn't documented in PAPR...
> >
> > The more I look at the "host-serial" and "host-model" properties, the m=
ore
> > I have the impression that they serve the same purpose as "system-id" a=
nd
> > "model" in PAPR (at least when peeking into the device tree of a PowerVM
> > LPAR as shown somewhere ^^)... what about unifying these ? It would lik=
ely
> > impact some guest software that use this to guess the platform type, li=
ke
> > powerpc-utils for example:
> >
> > 		} else if (strstr(line, "IBM pSeries (emulated by qemu)")) {
> > 			rc =3D PLATFORM_POWERKVM_GUEST;
> > 			break;
> > 		} else if (strstr(line, "pSeries")) {
> >
> > but this is fragile and should be improved anyway...
> > =20
> >>>     =20
> >>>> Since it's a POWER specific
> >>>> functionality, may 'ibm,get-vpd' export host information if the
> >>>> guest instance allows it? Or is it better return only the 'host-seri=
al'
> >>>> and 'host-model' content, like in the patch "spapr: Simplify handling
> >>>> of host-serial and host-model values"?
> >>>>     =20
> >>> I've spent some time reading PAPR on this topic and I'm not sure that
> >>> "ibm,get-vpd" is the way to go for what you were trying to achieve
> >>> initially (ie, obtain up-to-date host model and serial after migratio=
n).
> >>>
> >>> Have you looked at RTAS "ibm,update-properties" ?
> >>> 	7.4.8 ibm,update-properties RTAS Call
> >>>
> >>> 	This RTAS call is used to report updates to the properties changed
> >>> 	due to a massive platform reconfiguration such as when the partition
> >>> 	is migrated between machines.
> >>>
> >>> This explicitly covers updates to "system-id" and "model". Maybe it is
> >>> time to do as Ben was suggesting a long time ago when "host-serial"
> >>> and "host-model" were introduced [1]:
> >>>
> >>> 	On Tue, 2014-07-08 at 12:49 +0200, Alexander Graf wrote: =20
> >>> 	> Please be aware that all of the above is bogus when you start
> >>> 	> thinking
> >>> 	> about live migration. =20
> >>>
> >>> 	What's probably where we need to start thinking about implementing
> >>> 	migration according to PAPR :-)
> >>>
> >>> 	IE. With pre and post-migration notifications to the guest including
> >>> 	device-tree updates.
> >>>
> >>> 	Cheers,
> >>> 	Ben.
> >>>
> >>> [1] https://patchwork.ozlabs.org/patch/367792/#813547
> >>>
> >>> Cheers,
> >>>     =20
> >> The 'ibm,update-properties' and 'ibm,update-nodes' RTAS report which DT
> >> nodes was modified. So, to implement this approach, the QEMU should ch=
ange
> >> the DT nodes when the live-migration finish and some service in the gu=
est
> >> need to call these RTAS to discovery what nodes was changed. Is it the
> >> right way?
> >> =20
> > If QEMU on the target is started with different "host-serial" and
> > "host-model", the DT in QEMU already has the new value. No need to
> > change anything. Appart from that, yes, QEMU should generate a PRRN
> > event at post load to notify the guest, which in turns do the RTAS
> > calls to get the updates.
> > =20
> >> Assuming that in new pseries machine won't be possible choose
> >> 'passthrough' options to 'host-serial' and 'host-model' (last patch of
> >> dgibson about this), it's necessary get the host information and set it
> >> as string in these options. So, if we use the same qemu options in a
> >> live-migration scenario for src and dst (libvirt do that), these
> >> properties will remain the same. Is this behavior expected?
> >> =20
> > The recent fixes around "host-serial" and "host-model" simply moved
> > the decision to expose host data to the upper layer, ie. libvirt
> > which should be involved in this discussion.
> >
> > Cc'ing Andrea for expertise. Problem exposed below.
> >
> > The pseries machine used to expose the content of the host's
> > /proc/device-tree/system-id and /proc/device-tree/model in the guest
> > DT. This led to a CVE and QEMU doesn't do that anymore for new machine
> > types. Instead, two new properties where added to the pseries machine:
> >
> > pseries-4.0.host-serial=3Dstring (Host serial number to advertise in gu=
est device tree)
> > pseries-4.0.host-model=3Dstring (Host model to advertise in guest devic=
e tree)
> >
> > It is up to the caller to pass something... which may be anything,
> > including something like $(cat /proc/device-tree/system-id) or
> > randomly generated.
> >
> > Is there a chance libvirt can be taught to pass a different string
> > to the target QEMU in case of migration ? =20
>=20
>=20
> Isn't that just pushing up the same problem (in this case, CVE-2019-8934)
> to Libvirt? By the CVE description [1], the problem is exactly the exposu=
re
> of /proc/device-tree/system-id and /proc/device-tree/model system attribu=
tes
> in the guest. The only difference is that instead of QEMU doing it, Libvi=
rt
> wll end up doing it if anything meaninful (i.e. anything that can identify
> the host) is passed in host-serial in the destination during a migration.
>=20
> I am no security expert (and please correct me if I'm wrong), but in the=
=20
> end,
> what this CVE is telling is "the guest shouldn't know any host details=20
> or anything
> that can uniquely identify the host". This means that we can't populate=20
> these
> attributes with meaninful host data (serial number, hostname, etc).
>=20

Not exactly IMHO. That CVE is telling that QEMU shouldn't expose host
details unconditionally to the guest without the user or management
layer consent. But as explained in the changelog of 0a794529bd11:

    This does mean that the "passthrough" functionality is no longer
    available with the current machine type.  That's ok though: if a
    user or management layer really wants the information passed
    through they can read it themselves (OpenStack Nova already does
    something similar for x86).

This is a matter of policy.

> This kind of obliterates the point of Max patch - the idea is that the=20
> user wants

If user means the QEMU user, this isn't true. The idea behind Max's patch
is that some software within the guest may need to track the host serial
for some legit purpose, eg. hardware inventory or license validations
software as explained here:

https://bugs.launchpad.net/nova/+bug/1337349/comments/6

> to be able do pinpoint, after migrating, which host is running the VM, by
> checking host_serial. Perhaps we should just discourage this usage=20
> altogether
> and show this CVE as proof. The user will need to go to the VM management
> layer to discover where the guest is (which is the proper way of doing it,
> anyway).
>=20

I agree that exposing real host HW identifiers is not recommended, but
it is ok to expose virtualized ones. For example, the LP above mentions
systemd's /etc/machine-id UUID, which is what Nova now tries first in order
to provide a unique host identifier to the guest IIUC.

My concern is more about reconciling this with PAPR, which doesn't seem
to care that much about not exposing real HW serials or location code
to partitions.

Cheers,

--
Greg


>=20
> Thanks,
>=20
>=20
> DHB
>=20
>=20
> [1] https://access.redhat.com/security/cve/cve-2019-8934
>=20
>=20
>=20
> > =20
> >>> --
> >>> Greg
> >>>
> >>>     =20
> >>>>> --
> >>>>> Greg
> >>>>>       =20
> >>>>     =20
> >>>     =20
> >> =20
> > =20
>=20
