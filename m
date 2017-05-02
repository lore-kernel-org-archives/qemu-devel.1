Received: from eggs.gnu.org ([2001:4830:134:3::10]:57882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d5PPw-0004Po-BX
	for qemu-devel@nongnu.org; Tue, 02 May 2017 00:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d5PPv-0007Iv-5K
	for qemu-devel@nongnu.org; Tue, 02 May 2017 00:28:04 -0400
Date: Tue, 2 May 2017 14:27:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170502042712.GF10741@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-8-git-send-email-imammedo@redhat.com>
	<20170412210239.GC27126@thinpad.lan.raisama.net>
	<20170419131458.59e2d00e@nial.brq.redhat.com>
	<20170426122138.GU3482@thinpad.lan.raisama.net>
	<20170427151406.57fbfa79@nial.brq.redhat.com>
	<20170427163225.GE3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Content-Disposition: inline
In-Reply-To: <20170427163225.GE3482@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH for-2.10 07/23] pc: add node-id property to
 CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 01:32:25PM -0300, Eduardo Habkost wrote:
> On Thu, Apr 27, 2017 at 03:14:06PM +0200, Igor Mammedov wrote:
> > On Wed, 26 Apr 2017 09:21:38 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >=20
> > adding Peter to CC list
> >=20
> > [...]
> >=20
> > > On Wed, Apr 19, 2017 at 01:14:58PM +0200, Igor Mammedov wrote:
> > > > On Wed, 12 Apr 2017 18:02:39 -0300
> > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > >  =20
> > > > > On Wed, Mar 22, 2017 at 02:32:32PM +0100, Igor Mammedov wrote: =
=20
> > > > > > it will allow switching from cpu_index to property based
> > > > > > numa mapping in follow up patches.   =20
> > > > >=20
> > > > > I am not sure I understand all the consequences of this, so I
> > > > > will give it a try:
> > > > >=20
> > > > > "node-id" is an existing field in CpuInstanceProperties.
> > > > > CpuInstanceProperties is used on both query-hotpluggable-cpus
> > > > > output and in MachineState::possible_cpus.
> > > > >=20
> > > > > We will start using MachineState::possible_cpus to keep track of
> > > > > NUMA CPU affinity, and that means query-hotpluggable-cpus will
> > > > > start reporting a "node-id" property when a NUMA mapping is
> > > > > configured.
> > > > >=20
> > > > > To allow query-hotpluggable-cpus to report "node-id", the CPU
> > > > > objects must have a "node-id" property that can be set. This
> > > > > patch adds the "node-id" property to X86CPU.
> > > > >=20
> > > > > Is this description accurate? Is the presence of "node-id" in
> > > > > query-hotpluggable-cpus the only reason we really need this
> > > > > patch, or is there something else that requires the "node-id"
> > > > > property? =20
> > > > That accurate description, node-id is in the same 'address'
> > > > properties category as socket/core/thread-id. So if you have
> > > > numa enabled machine you'd see node-id property in
> > > > query-hotpluggable-cpus. =20
> > >=20
> > > I agree that we can make -numa cpu affect query-hotpluggable-cpus
> > > output (i.e. affect some field on HotpluggableCPU.props).
> > >=20
> > > But it looks like we disagree about the purpose of
> > > HotpluggableCPU.props:
> > >=20
> > > I believe HotpluggableCPU.props is just an opaque identifier for
> > > the location we want to plug the CPU, and the only requirement is
> > > that it should be unique and have all the information device_add
> > > needs. As socket IDs are already unique on our existing machines,
> > > and socket<=3D>node mapping is already configured using -numa cpu,
> > > node-id doesn't need to be in HotpluggableCPU.props. (see example
> > > below)
> > node-id is also location property which logically complements
> > to socket/core/thread properties.  Also socket is not necessarily
> > unique id that maps 1:1 to node-id from generic pov.
> > BTW -numa cpu[s] is not the only way to specify mapping,
> > it could be specified like we do with pc-dimm:
> >    device_add pc-dimm,node=3Dx
> >=20
> > Looking at it more genericly, there could be the same
> > socket-ids for different nodes, then we would have to add
> > node-id to props anyway and end up with 2 node-id, one in props
> > and another in the parent struct.
>=20
> This is where my expectations are different: I think
> HotpluggableCPU.props is just an identifier property for CPU
> slots that is used for device_add (and will be used for -numa
> cpu), and isn't supposed to be be interpreted by clients.
>=20
> The problem I see is that the property has two completely
> different purposes: identifying a given CPU slot for device_add
> (and -numa cpu), and introspection of topology information about
> the CPU slot. Today we are lucky and those goals don't conflict
> with each other, but I worry this might cause trouble in the
> future.

Yeah, I share your concern.  And even if we allow that the topology
information may be read by the user, at the moment the
socket/core/thread values are "read only" in the sense that the client
should do nothing by read them from the query (possibly look at them
for its own interest) and echo them back verbatim to device_add.

node id is different because it's something the user/management might
want to actually choose.  So it seems dubious to me that it's in the
same structure.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZCAqgAAoJEGw4ysog2bOScG0P/jKb9yS69r2jpoR4n76IFXU8
lfTsfCS1tWrgFtQU3rI6GCrW0CAGRKUnFCZZv0GSZupfRrzs0jnyJQviRYqcLHmr
3LMplLaheJMajQLE0wr9EeLy3eGzas33ySelEPQjdamlwGWK75DgQIWzwcQT7ugE
8W6JHSSHBwl/+/dzZHpS8V7I26G4J1DrCaYIlQQQjdYz2AgMzDbluI/LXTY9+NiF
T5Z1lfKu9H8vRBwUQUEYVIIOK9IxybyzY9OxG0ZRBHHoNOvHYALg0lmATpYH2ncj
irVTpHxnRzsnlYuhfzTo8D5lkIlyl9LrhVJo4xzyJU8VXSOTOVMjOGzRng5P3HxH
Cn2Km/tK0iUfvAvbVsWx1QFuqXGmS6R8SvI8gxEjwXPR1ic6FWvO6O1esqvvQDem
poAUhJhm6/UhETDgxUBSbc+nRLqQ1ow3acW0a5VCPTiEGq6c6HifWe7VBsZpqjda
ncAN2NKFbVVHoTAf//KZeWTjVKAPLP/iV+9F36Vc1B2L094gXf/pwd9kRKWqFcBP
CQiiqVAldERRzSoLA8Sfzt3TXsx/Mqyf4q6abJ37Fdu8Dcx5yl1bOmp2o0c0B3dB
gvci2a2wmrWv7PetxMB7OaSLk/KD7XKxETktymVOJfCCv64nJsKIOD1DmztSvWS3
jmPaYu2nownio4LYqqSn
=UgsG
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--
