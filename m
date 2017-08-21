Received: from eggs.gnu.org ([2001:4830:134:3::10]:59367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djePD-0004tX-4y
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 00:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djePC-0005IM-1o
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 00:33:39 -0400
Date: Mon, 21 Aug 2017 14:33:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170821043327.GI12356@umbus.fritz.box>
References: <1502994790-21856-1-git-send-email-thuth@redhat.com>
	<20170818012501.GK5509@umbus.fritz.box>
	<b08f13f1-39ba-b4c4-a64d-6a84619ecc09@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VkVuOCYP9O7H3CXI"
Content-Disposition: inline
In-Reply-To: <b08f13f1-39ba-b4c4-a64d-6a84619ecc09@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Fix segfault when
 instantiating a 'pc-dimm' without 'memdev'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 09:23:53AM +0200, Thomas Huth wrote:
> On 18.08.2017 03:25, David Gibson wrote:
> > On Thu, Aug 17, 2017 at 08:33:10PM +0200, Thomas Huth wrote:
> >> QEMU currently crashes when trying to use a 'pc-dimm' on the pseries
> >> machine without specifying its 'memdev' property. Let's add a sanity
> >> check to the pre_plug handler to fix this issue.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >=20
> > Thanks for all these patches fixing little bugs in 2.10.
>=20
> ... or 2.11 ;-) ... not sure if there will be another RC next week or
> the final 2.10 release?
>=20
> Anyway, the fixes are required for a new qtest that I'm working on
> (calling device_add + device_del for all available devices), that's why
> I'm coming up with all these patches now. There is another crash with
> one of the ppc64 devices, where I don't know how to fix it yet - so if
> somebody got a clue, help is appreciated:
>=20
> $ qemu-system-ppc64 -nographic -S -nodefaults -monitor stdio -M pseries
> QEMU 2.9.92 monitor - type 'help' for more information
> (qemu) device_add macio-oldworld,id=3Dx
> (qemu) device_del x
> (qemu) **
> ERROR:qemu/qom/object.c:1611:object_get_canonical_path_component:
>  assertion failed: (obj->parent !=3D NULL)
> Aborted (core dumped)
>=20
> >> ---
> >>  hw/ppc/spapr.c | 11 +++++++++--
> >>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index f7a1972..22d400a 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2808,10 +2808,17 @@ static void spapr_memory_pre_plug(HotplugHandl=
er *hotplug_dev, DeviceState *dev,
> >>  {
> >>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
> >>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> >> -    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> >> -    uint64_t size =3D memory_region_size(mr);
> >> +    MemoryRegion *mr;
> >> +    uint64_t size;
> >>      char *mem_dev;
> >> =20
> >> +    if (!dimm->hostmem) {
> >=20
> > Isn't checking dimm->hostmem directly here an abstraction violation?
> > Could we just check for a NULL return from get_memory_region instead?
>=20
> The crash happens within get_memory_region: pc_dimm_get_memory_region()
> calls host_memory_backend_get_memory(), which calls
> host_memory_backend_mr_inited() - and that function dereferences the
> NULL pointer.
>=20
> I could add an additional check to one of the called functions and
> return NULL in case the pointer is already NULL ... do you prefer that?
> Let me know, then I'll send a v2...

Ah, right.  Yeah, I think this is essentially a bug in
get_memory_region() or one of its called functions.  They're unsafe to
call in circumstances that the caller can't really control of
determine (without breaking the abstraction wall).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmaYpYACgkQbDjKyiDZ
s5IUHxAAuen7TkhlCa4mquIB47PfbTrMc/Bb/XVC7amqyYjazx+HZ0PYJDMPTchQ
ZKQLYBavMIXMNupbXuZP/Un/U404YFMk3rjRdN7E5GopN4FIAdxBrnrkVny2TVAn
yWG5I5XN7lNnF3ASOSLMsiPdEWljpvlXYyFInKhJyy/Ym8u1fvxcijT8cgue8RdN
tuaOBxeiKvXX0lfE45Wy9qycCBC2qESsmTuKKXF8KuPCz23AWk3w8TGSgqZq81sk
UecBB9QFG+xWHhPm/+wTX8o7Ec3CwVxNPPbcFLjtlYDIQYbjlVJNosYibCmT/aKB
8PGFxgeiMg/00VdoIigbQgGMAZoAwPkfntlwauY5l5VNNcrRncjhGkYuzWKrbm+f
1D8nizTgsgY8ccnSIdj0DJb72LLuc5B1j+txcjAP2e8x44EcqwW/SKkCAuDaUtJp
FBbt4LrAa3m+a0Rf35jGDzY7ep6Z7z6U+eyl/1baZfcKKSFXt0bUMKmWkFmcuEdg
/S/3xbk9dGobnVTXndSUbUQRiBAA/bbvROYuiIpomrPcTAQZfHRbOQLKvpDJCI1c
Hn4i6PklpRrSAG8IO7LbqLBYBwDd03bjPX3u8CO2ma5mruKbiA181L6B6tsqQjBq
clOOYShrfrw4HouN4lTmPg+H98ax9jcJsPTx+NbNA1PJ+i1ElyM=
=kUa2
-----END PGP SIGNATURE-----

--VkVuOCYP9O7H3CXI--
