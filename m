Received: from eggs.gnu.org ([2001:4830:134:3::10]:50451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fYc8x-0008DK-1S
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fYc8v-0006ov-Cg
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:59:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32932 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fYc8v-0006o5-5E
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 14:59:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77510B5C9
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 18:59:44 +0000 (UTC)
Date: Thu, 28 Jun 2018 19:59:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180628185938.GC2538@work-vm>
References: <20180628154502.GO3513@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180628154502.GO3513@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> This post is to raise question about helping use of named CPU models wi=
th
> KVM ie any case not using -cpu host.
>=20
> In the old days (ie before 2018), the world was innocent and we had a n=
ice
> set of named CPU models that corresponded to different Intel/AMD physic=
al
> CPU families/generations (lets temporarily ignore the -noTSX fiasco).
>=20
> An application could query libvirt to determine what the host CPU model
> was/is and use that model name in the guest XML and be fairly happy. If
> they wanted to, they could explicitly include the extra features listed
> by capabilities XML, or just rely on the host-model.
>=20
> Then Spectre happened, and QEMU took the decision to almost double the
> number of x86 models, adding in -IBRS / -IBPB variants for most CPU mod=
el,
> so that applications could get the spec_ctrl / ibpb flags set without
> having to manually list them.
>=20
> In retrospect this was somewhat pointless, at least at the QEMU level,
> because there is little difference in complexity between the two approa=
ches:
>=20
>    -cpu Westmere,+spec-ctrl
>    -cpu Westmere-IBRS
>=20
> At a higher level the extra named CPU models were slightly useful in so=
 much
> as many application developers had taken a lazy approach and not provid=
ed
> users any way to explicitly turn on extra flags. This affected oVirt,
> OpenStack and virt-manager, and probably more. Though OpenStack since a=
dded
> ability to turn on arbitrary flags in response to the Spectre flaw, oth=
ers
> have not.
>=20
> Then a recently along came the Speculative Store Bypass hardware vulner=
ability
> requiring addition of yet another CPU flag to guest configs. This requi=
red use
> of 'ssbd' on Intel and 'virt-ssbd' on AMD. While QEMU could have now ad=
ded yet
> more CPU models, eg Westmere-SSBD, this does not feel like a winning st=
rategy
> long term. Looking at the models how would a user have any clue whether=
 the
> -IBRS or -SSBD or -NEXT-FLAW or -YET-ANOTHER-FLAW suffix is "better" ? =
So QEMU
> and libvirt took the joint decision to stop adding new named CPU models=
 when
> CPU vulnerabilities are discovered from this point forwards. Applicatio=
ns /
> users would be expected to turn on CPU features explicitly as needed an=
d are
> considered broken if they don't provide this functionality.
>=20
> As briefly mentioned above though, even before Spectre we had the pain =
of
> dealing with the -noTSX CPU models working around brokenness in the Int=
el TSX
> impl where they had to delete a CPU feature during microcode updates. T=
his was
> rather painful to roll out at the time.
>=20
> An alternative to adding CPU models is to change meaning of existing CP=
U
> models. QEMU has a way todo this by tieing the change to machine types,=
 and
> it has in fact been used to correct mistakes in the specification of CP=
U
> models in the past, when those mistakes have not had dependancies on mi=
crocode
> changes. This is not a particularly attractice way to deal with the err=
ata.
> Short life distros tend to stick with upstream QEMU machine types and w=
on't
> want to diverge by adding their own machine types. This gates them on h=
aving
> upstream define the extra machine types which is tricky under embargo. =
Long
> life distros do typically take on the burden of defining custom machine=
 types,
> but usually only add them when doing major updates.
>=20
> The pain point with machine types is that the testing matrix grows at O=
(n^2)
> Using machine types for CPU security errata would significant increase =
the
> number of machine types and thus the testing matrix. eg if a security f=
ix
> is needed in rhel-7.3, 7.4, 7.5 we can't just add a pc-rhel-7.5.1 machi=
ne
> with the fix, as it would not be possible to implement that in 7.3. So =
we
> would need would need pc-rhel-7.3.1,  pc-rhel-7.4.1,  pc-rhel-7.5.1, ma=
chine
> types, with 7.5 gaining all three. Finally CPU model changes have host
> hardware dependancies and machine types need to be independant of the h=
ost,
> since they are decided statically are build time. The only nice thing a=
bout
> machine type is that it is reasonably obvious what the "best" machine t=
ype
> is as they include a version number in the name, and users automaticall=
y get
> the best if they use an unversioned name.
>=20
>=20
> What if we can borrow the concept of versioning from machine types and =
apply
> it to CPU models directly. For example, considering the history of "Has=
well"
> in QEMU, if we had versioned things, we would by now have:
>=20
>      Haswell-1.3.0 - first version (37507094f350b75c62dc059f998e7185de3=
ab60a)
>      Haswell-2.2.0 - added 'rdrand' (78a611f1936b3eac8ed78a2be2146a742a=
85212c_
>      Haswell-2.3.0 - removed 'hle' & 'rtm' (a356850b80b3d13b2ef737dad2a=
cb05e6da03753)
>      Haswell-2.5.0 - added 'abm' (becb66673ec30cb604926d247ab9449a60ad8=
b11
>      Haswell-2.12.0 - added 'spec-ctrl' (ac96c41354b7e4c70b756342d9b686=
e31ab87458)
>      Haswell-3.0.0  - added 'ssbd' (never done)

OK.
Note that this isn't that different to what happens on some real
hardware where you have different 'steppings'

> If we followed the machine type approach, then a bare "Haswell" would
> statically resolve at build time to the most recent Haswell-X.X.X versi=
on
> associated with the QEMU release. This is unhelpful as we have a direct
> dependancy on the host hardware features. Better would be for a bare
> "Haswell" to be dynamically resolved at runtime, picking the most recen=
t
> version that is capable of launching given the current hardware, KVM/TC=
G impl
> and QEMU version.
>=20
>   ie -cpu  Haswell
>=20
> should use Haswell-2.5.0  if on silicon with the TSX errata applied,
> but use Haswell-2.12.0 if the Spectre errata is applied in microcode,
> and use Haswell-3.0.0 once Intel finally releases SSBD microcode errata=
.
>=20
> Versioning of CPU models as opposed to using arbitrary string suffixes
> (-noTSX, -IBRS) has a number of usability improvements that we would
> gain with versioned machine types, while avoiding exploding the machine
> type matrix. With versioned CPU models we can
>=20
>  - Automatically tailor the best model based on hardware support
>=20
>  - Users always get the best model if they use the bare CPU name
>=20
>  - It is obvious to users which is the "best" / "newest" CPU model
>=20
>  - Avoid combinatorial expansion of machines since same CPU model
>    version can be added to all releases without adding machine types.
>=20
>  - Users can still force a specific downgraded model by using the
>    fully versioned name.
>=20
> Such versioning of CPU models would largely "just work" with existing
> libvirt versions, but to libvirt would really want to expand the bare
> CPU name to a versioned CPU name when recording new guest XML, so the
> ABI is preserved long term.
>=20
> An application like virt-manager which wants a simple UI can forever be
> happy simply giving users a list of bare CPU model names, and allowing
> libvirt / QEMU to automatically expand to the best versioned model for
> their host.
>=20
> An application like oVirt/OpenStack which wants direct control can allo=
w
> the admin to choice if a bare name, or explicitly picking a versioned n=
ame
> if they need to cope with possibility of outdated hosts.

I fear people are going to find this out the hard way, when they add
a new system into their cluster, a little bit later it gets a VM started
on it, and then they try and migrate it to one of the older machines.

Now if there was something that could take the CPU defintions from all
the machines in the cluster and tell it which to use/which problems
they had then that might make sense.  It would be best for each
higher level not to reinvent that.

Would you restrict the combinations to cut down the test matrix - e.g.
not allow Haswell-3.0.0 on anything prior to a 2.12 machine type?

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
