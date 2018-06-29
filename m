Received: from eggs.gnu.org ([2001:4830:134:3::10]:52384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYqMb-0002TC-P3
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYqMU-0007A0-T5
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:10:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35716 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYqMU-00079N-LU
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:10:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F03A287903
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 10:10:41 +0000 (UTC)
Date: Fri, 29 Jun 2018 11:10:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180629101029.GA27016@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180628154502.GO3513@redhat.com> <20180628185938.GC2538@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628185938.GC2538@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] CPU model versioning separate from machine type
 versioning ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

On Thu, Jun 28, 2018 at 07:59:38PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > This post is to raise question about helping use of named CPU models =
with
> > KVM ie any case not using -cpu host.
> >=20
> > In the old days (ie before 2018), the world was innocent and we had a=
 nice
> > set of named CPU models that corresponded to different Intel/AMD phys=
ical
> > CPU families/generations (lets temporarily ignore the -noTSX fiasco).
> >=20
> > An application could query libvirt to determine what the host CPU mod=
el
> > was/is and use that model name in the guest XML and be fairly happy. =
If
> > they wanted to, they could explicitly include the extra features list=
ed
> > by capabilities XML, or just rely on the host-model.
> >=20
> > Then Spectre happened, and QEMU took the decision to almost double th=
e
> > number of x86 models, adding in -IBRS / -IBPB variants for most CPU m=
odel,
> > so that applications could get the spec_ctrl / ibpb flags set without
> > having to manually list them.
> >=20
> > In retrospect this was somewhat pointless, at least at the QEMU level=
,
> > because there is little difference in complexity between the two appr=
oaches:
> >=20
> >    -cpu Westmere,+spec-ctrl
> >    -cpu Westmere-IBRS
> >=20
> > At a higher level the extra named CPU models were slightly useful in =
so much
> > as many application developers had taken a lazy approach and not prov=
ided
> > users any way to explicitly turn on extra flags. This affected oVirt,
> > OpenStack and virt-manager, and probably more. Though OpenStack since=
 added
> > ability to turn on arbitrary flags in response to the Spectre flaw, o=
thers
> > have not.
> >=20
> > Then a recently along came the Speculative Store Bypass hardware vuln=
erability
> > requiring addition of yet another CPU flag to guest configs. This req=
uired use
> > of 'ssbd' on Intel and 'virt-ssbd' on AMD. While QEMU could have now =
added yet
> > more CPU models, eg Westmere-SSBD, this does not feel like a winning =
strategy
> > long term. Looking at the models how would a user have any clue wheth=
er the
> > -IBRS or -SSBD or -NEXT-FLAW or -YET-ANOTHER-FLAW suffix is "better" =
? So QEMU
> > and libvirt took the joint decision to stop adding new named CPU mode=
ls when
> > CPU vulnerabilities are discovered from this point forwards. Applicat=
ions /
> > users would be expected to turn on CPU features explicitly as needed =
and are
> > considered broken if they don't provide this functionality.
> >=20
> > As briefly mentioned above though, even before Spectre we had the pai=
n of
> > dealing with the -noTSX CPU models working around brokenness in the I=
ntel TSX
> > impl where they had to delete a CPU feature during microcode updates.=
 This was
> > rather painful to roll out at the time.
> >=20
> > An alternative to adding CPU models is to change meaning of existing =
CPU
> > models. QEMU has a way todo this by tieing the change to machine type=
s, and
> > it has in fact been used to correct mistakes in the specification of =
CPU
> > models in the past, when those mistakes have not had dependancies on =
microcode
> > changes. This is not a particularly attractice way to deal with the e=
rrata.
> > Short life distros tend to stick with upstream QEMU machine types and=
 won't
> > want to diverge by adding their own machine types. This gates them on=
 having
> > upstream define the extra machine types which is tricky under embargo=
. Long
> > life distros do typically take on the burden of defining custom machi=
ne types,
> > but usually only add them when doing major updates.
> >=20
> > The pain point with machine types is that the testing matrix grows at=
 O(n^2)
> > Using machine types for CPU security errata would significant increas=
e the
> > number of machine types and thus the testing matrix. eg if a security=
 fix
> > is needed in rhel-7.3, 7.4, 7.5 we can't just add a pc-rhel-7.5.1 mac=
hine
> > with the fix, as it would not be possible to implement that in 7.3. S=
o we
> > would need would need pc-rhel-7.3.1,  pc-rhel-7.4.1,  pc-rhel-7.5.1, =
machine
> > types, with 7.5 gaining all three. Finally CPU model changes have hos=
t
> > hardware dependancies and machine types need to be independant of the=
 host,
> > since they are decided statically are build time. The only nice thing=
 about
> > machine type is that it is reasonably obvious what the "best" machine=
 type
> > is as they include a version number in the name, and users automatica=
lly get
> > the best if they use an unversioned name.
> >=20
> >=20
> > What if we can borrow the concept of versioning from machine types an=
d apply
> > it to CPU models directly. For example, considering the history of "H=
aswell"
> > in QEMU, if we had versioned things, we would by now have:
> >=20
> >      Haswell-1.3.0 - first version (37507094f350b75c62dc059f998e7185d=
e3ab60a)
> >      Haswell-2.2.0 - added 'rdrand' (78a611f1936b3eac8ed78a2be2146a74=
2a85212c_
> >      Haswell-2.3.0 - removed 'hle' & 'rtm' (a356850b80b3d13b2ef737dad=
2acb05e6da03753)
> >      Haswell-2.5.0 - added 'abm' (becb66673ec30cb604926d247ab9449a60a=
d8b11
> >      Haswell-2.12.0 - added 'spec-ctrl' (ac96c41354b7e4c70b756342d9b6=
86e31ab87458)
> >      Haswell-3.0.0  - added 'ssbd' (never done)
>=20
> OK.
> Note that this isn't that different to what happens on some real
> hardware where you have different 'steppings'
>=20
> > If we followed the machine type approach, then a bare "Haswell" would
> > statically resolve at build time to the most recent Haswell-X.X.X ver=
sion
> > associated with the QEMU release. This is unhelpful as we have a dire=
ct
> > dependancy on the host hardware features. Better would be for a bare
> > "Haswell" to be dynamically resolved at runtime, picking the most rec=
ent
> > version that is capable of launching given the current hardware, KVM/=
TCG impl
> > and QEMU version.
> >=20
> >   ie -cpu  Haswell
> >=20
> > should use Haswell-2.5.0  if on silicon with the TSX errata applied,
> > but use Haswell-2.12.0 if the Spectre errata is applied in microcode,
> > and use Haswell-3.0.0 once Intel finally releases SSBD microcode erra=
ta.
> >=20
> > Versioning of CPU models as opposed to using arbitrary string suffixe=
s
> > (-noTSX, -IBRS) has a number of usability improvements that we would
> > gain with versioned machine types, while avoiding exploding the machi=
ne
> > type matrix. With versioned CPU models we can
> >=20
> >  - Automatically tailor the best model based on hardware support
> >=20
> >  - Users always get the best model if they use the bare CPU name
> >=20
> >  - It is obvious to users which is the "best" / "newest" CPU model
> >=20
> >  - Avoid combinatorial expansion of machines since same CPU model
> >    version can be added to all releases without adding machine types.
> >=20
> >  - Users can still force a specific downgraded model by using the
> >    fully versioned name.
> >=20
> > Such versioning of CPU models would largely "just work" with existing
> > libvirt versions, but to libvirt would really want to expand the bare
> > CPU name to a versioned CPU name when recording new guest XML, so the
> > ABI is preserved long term.
> >=20
> > An application like virt-manager which wants a simple UI can forever =
be
> > happy simply giving users a list of bare CPU model names, and allowin=
g
> > libvirt / QEMU to automatically expand to the best versioned model fo=
r
> > their host.
> >=20
> > An application like oVirt/OpenStack which wants direct control can al=
low
> > the admin to choice if a bare name, or explicitly picking a versioned=
 name
> > if they need to cope with possibility of outdated hosts.
>=20
> I fear people are going to find this out the hard way, when they add
> a new system into their cluster, a little bit later it gets a VM starte=
d
> on it, and then they try and migrate it to one of the older machines.
>=20
> Now if there was something that could take the CPU defintions from all
> the machines in the cluster and tell it which to use/which problems
> they had then that might make sense.  It would be best for each
> higher level not to reinvent that.

Libvirt / QEMU have ability to let apps do that. Nova could choose to
do that, but it does not wish to take advantage of that right now. The
nova admin already has make an explicit config to set the maximum
Nova database object schema version, and maximum machine type version
across the cluster. The max CPU model version fits in with what they
are already doing quite well. Essentially the admin knows what versions
of QEMU they have across their cluster - generally it is jus N, and N+1
during course of a version upgrade. So it is quite easy for the admin
to know what the max version should be. In fact the admin doens't
really need to be involved in it at all - the cluster provisioning
tool already knows the old + new host versions, so can set it automatical=
ly
at the right times during upgrade process.

> Would you restrict the combinations to cut down the test matrix - e.g.
> not allow Haswell-3.0.0 on anything prior to a 2.12 machine type?

The key point of having CPU versions separate from machine type
versions, is to allow arbitrary mixing of versions. For example when
we issued Spectre updates for RHEL, we had to add new CPU model to
something like 12 different QEMU versions, and we needed the same
CPU model changes to work with all the different machine types we
had across those versions. So restricting CPU versions to only
certain machine types would defeat the puporse of having CPU versions.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
