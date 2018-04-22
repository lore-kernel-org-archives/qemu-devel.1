Received: from eggs.gnu.org ([2001:4830:134:3::10]:37395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fADhX-0007A5-Ra
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 08:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fADhT-0007dj-K8
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 08:02:39 -0400
Date: Sun, 22 Apr 2018 20:10:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180422101000.GA4954@umbus.fritz.box>
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-2-david@redhat.com>
	<20180422042615.GY2434@umbus.fritz.box>
	<7809aad5-1513-caed-bc94-c5b08afe2ce6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <7809aad5-1513-caed-bc94-c5b08afe2ce6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] pc-dimm: factor out MemoryDevice
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 22, 2018 at 10:21:34AM +0200, David Hildenbrand wrote:
> On 22.04.2018 06:26, David Gibson wrote:
> > On Fri, Apr 20, 2018 at 02:34:54PM +0200, David Hildenbrand wrote:
> >> On the qmp level, we already have the concept of memory devices:
> >>     "query-memory-devices"
> >> Right now, we only support NVDIMM and PCDIMM.
> >>
> >> We want to map other devices later into the address space of the guest.
> >> Such device could e.g. be virtio devices. These devices will have a
> >> guest memory range assigned but won't be exposed via e.g. ACPI. We want
> >> to make them look like memory device, but not glued to pc-dimm.
> >>
> >> Especially, it will not always be possible to have TYPE_PC_DIMM as a p=
arent
> >> class (e.g. virtio devices). Let's use an interface instead. As a first
> >> part, convert handling of
> >> - qmp_pc_dimm_device_list
> >> - get_plugged_memory_size
> >> to our new model. plug/unplug stuff etc. will follow later.
> >>
> >> A memory device will have to provide the following functions:
> >> - get_addr(): Necessary, as the property "addr" can e.g. not be used f=
or
> >>               virtio devices (already defined).
> >> - get_plugged_size(): The amount this device offers to the guest as of
> >>                       now.
> >> - get_region_size(): Because this can later on be bigger than the
> >>                      plugged size.
> >> - fill_device_info(): Fill MemoryDeviceInfo, e.g. for qmp.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > with the exception of some tiny nits..
> >=20
> > [snip]
> >> +static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
> >> +{
> >> +    MemoryDeviceState *md_a =3D MEMORY_DEVICE(a);
> >> +    MemoryDeviceState *md_b =3D MEMORY_DEVICE(b);
> >=20
> > These probably should be const MemoryDeviceState *.
>=20
> Yes, that could work (depends on what the functions getting called
> internally expect). Will look into it

Well, the only thing being called here is the ->get_addr() hook, which
you can redefine if necessary.  Discarding the const in the passed in
pointers seems like bad idea, even though it won't explicitly warn due
to the existing MEMORY_DEVICE() cast.

> >> +    MemoryDeviceClass *mdc_a =3D MEMORY_DEVICE_GET_CLASS(a);
> >> +    MemoryDeviceClass *mdc_b =3D MEMORY_DEVICE_GET_CLASS(b);
> >> +    const uint64_t addr_a =3D mdc_a->get_addr(md_a);
> >> +    const uint64_t addr_b =3D mdc_b->get_addr(md_b);
> >> +
> >> +    if (addr_a > addr_b) {
> >> +        return 1;
> >> +    } else if (addr_a < addr_b) {
> >> +        return -1;
> >> +    }
> >> +    return 0;
> >> +}
> >> +
> >> +static int memory_device_built_list(Object *obj, void *opaque)
> >=20
> > s/built/build/ will read a bit more clearly I think.
> >=20
>=20
> Indeed, thanks!
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrcX3YACgkQbDjKyiDZ
s5IA2Q/9HlJ3VBaY8TiELQPfHgW7qtbCKKY8Te4TaF9bAJHRZcgEsOJgYaY2lFby
ELon9ZS8eHWUwOsNVjLPpAG8Wf+IgAWyYuwB9vzH/xseTQwk+htrYHPeAqsARzsu
w0JwIWOvJfOpEl2XtLhYoFlnWXizzHCiLVcbxh4ZtaMtez5mPFps+d/nb/QukIVM
8050f+lS62QP1hpx7FV6+jHA2/gCJqD7lRJbA0PvPOAXVwBUgJmljsNABL3EHI91
m8R5aEfP3976EQXYFs3KkPUdICA4hdEOHl566WKysRq1Ic2F2V/+k3Vu12SKH59N
C+pD9rfHUy/fZPGE/OwKkzEVD9b1QyFzXckcunT2JpomV8e8h+J8TzWGr+kk4JzB
g2qT2heOrd3ZsTHY/OqDn5CKqlhSQB178IjEX0cI4OnqJDp6555ML2x6ksJvpeyD
4gr5Rm1A5Yxdr7sGVzt2XeJncfoYagQt0ckbV8/mOHvklFmosXGtkhE0wFFU4Wwo
8HkjBZYGoxJotV1S2O2seCXLT22vXOEj3E2z+Flo6w17y8RicnlCXnbsj2hbWElf
MrydXcoCAqPZZ7YVT3wsRYZubDFcSEfMI4wNpbqqB0G7ClBdsM4FpHmpJUWowZM9
KkXv3vy9/Xt9WoPQLQDy4TX2fbzkDeiTxGEq6jHygirB2xXBRIE=
=erDV
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
