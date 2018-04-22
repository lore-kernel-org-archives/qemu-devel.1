Received: from eggs.gnu.org ([2001:4830:134:3::10]:34871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fA6aW-0008FA-E7
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 00:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fA6aS-0003B9-5Y
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 00:26:56 -0400
Date: Sun, 22 Apr 2018 14:26:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180422042615.GY2434@umbus.fritz.box>
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SBKwXYz1xY/kcGv0"
Content-Disposition: inline
In-Reply-To: <20180420123456.22196-2-david@redhat.com>
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


--SBKwXYz1xY/kcGv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 02:34:54PM +0200, David Hildenbrand wrote:
> On the qmp level, we already have the concept of memory devices:
>     "query-memory-devices"
> Right now, we only support NVDIMM and PCDIMM.
>=20
> We want to map other devices later into the address space of the guest.
> Such device could e.g. be virtio devices. These devices will have a
> guest memory range assigned but won't be exposed via e.g. ACPI. We want
> to make them look like memory device, but not glued to pc-dimm.
>=20
> Especially, it will not always be possible to have TYPE_PC_DIMM as a pare=
nt
> class (e.g. virtio devices). Let's use an interface instead. As a first
> part, convert handling of
> - qmp_pc_dimm_device_list
> - get_plugged_memory_size
> to our new model. plug/unplug stuff etc. will follow later.
>=20
> A memory device will have to provide the following functions:
> - get_addr(): Necessary, as the property "addr" can e.g. not be used for
>               virtio devices (already defined).
> - get_plugged_size(): The amount this device offers to the guest as of
>                       now.
> - get_region_size(): Because this can later on be bigger than the
>                      plugged size.
> - fill_device_info(): Fill MemoryDeviceInfo, e.g. for qmp.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

with the exception of some tiny nits..

[snip]
> +static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
> +{
> +    MemoryDeviceState *md_a =3D MEMORY_DEVICE(a);
> +    MemoryDeviceState *md_b =3D MEMORY_DEVICE(b);

These probably should be const MemoryDeviceState *.

> +    MemoryDeviceClass *mdc_a =3D MEMORY_DEVICE_GET_CLASS(a);
> +    MemoryDeviceClass *mdc_b =3D MEMORY_DEVICE_GET_CLASS(b);
> +    const uint64_t addr_a =3D mdc_a->get_addr(md_a);
> +    const uint64_t addr_b =3D mdc_b->get_addr(md_b);
> +
> +    if (addr_a > addr_b) {
> +        return 1;
> +    } else if (addr_a < addr_b) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static int memory_device_built_list(Object *obj, void *opaque)

s/built/build/ will read a bit more clearly I think.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SBKwXYz1xY/kcGv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrcDucACgkQbDjKyiDZ
s5Jbkw//cw0n13vlEcH0FlYdiBmkaincPzcKWECvQq45NhuNNSQHAnc13oe1dZsE
qMg91mP/Z2sCHcdT4y7cQpu1I92ExY+gm+Z9eu04GrA0u1ftFEATjVdMlavJzZxt
v4Nj9BscS+0OShygVQzF8pSeNJPK1d5zRhBmV4JB1+OfmUZA/XIH3AUgIUS/X4Dw
yHqCxi37L3akCtTeweVY1M+yJQjzkj2u3aWGnDHCPoevwM76nmPNW/GU1dCywSEK
th0XeeM/qATxdJFyvZQRwORPuTeD9I34Dw1ozHxxUzDVNszDTCzgd0ml4Ah6a5kt
l6kHGPn57Yql2f+6J7Jh6ydHaZKcSL6vTG67ybabFZ4Pu6II8xq7iWUVrYPzE2i1
I4xD460H9ADJQ3xuhMboMkKhrsW+KlNYeYYf8FuZT0BqC27JeJ5IEr26qF7Srl1S
hJeHJRN0/2hXffzvQNCWXKRpRA0hrJNQ0vEAs+xZ/QzsYrTd/wPiDAl6XJ589sNG
/10aCEAEZ9cBuF1HIYdg47YgRL7AarVCZRemUYRKOaK794wzkB4IgV9qYNXy+cfx
FnN8w9FbDbcgs2RgwnNDDaczYrEFDiBM0lCCexH5u8SxIRHGtY1zUH7usEERPiCv
xjXbTZ/nZ5zP3eEVbctxIPbS/rx5ZtY+Wls8MxBBrWDsdlnucz8=
=lv1N
-----END PGP SIGNATURE-----

--SBKwXYz1xY/kcGv0--
