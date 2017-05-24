Received: from eggs.gnu.org ([2001:4830:134:3::10]:38552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDPgE-00081Y-3q
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDPgA-0000i6-Ux
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:21:58 -0400
Date: Wed, 24 May 2017 14:52:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170524045236.GU30246@umbus.fritz.box>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-2-lvivier@redhat.com>
	<20170523172842.1fce414e@bahia.ttt.fr.ibm.com>
	<bc9a69f9-eb7b-943a-a9bf-bb4a3b18f525@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R7Dyui215VKdTDYA"
Content-Disposition: inline
In-Reply-To: <bc9a69f9-eb7b-943a-a9bf-bb4a3b18f525@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/4] spapr: add pre_plug
 function for memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--R7Dyui215VKdTDYA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 06:09:00PM +0200, Laurent Vivier wrote:
> On 23/05/2017 17:28, Greg Kurz wrote:
> > On Tue, 23 May 2017 13:18:09 +0200
> > Laurent Vivier <lvivier@redhat.com> wrote:
> >=20
> >> This allows to manage errors before the memory
> >> has started to be hotplugged. We already have
> >> the function for the CPU cores.
> >>
> >> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >> ---
> >>  hw/ppc/spapr.c | 45 ++++++++++++++++++++++++++++++---------------
> >>  1 file changed, 30 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 0980d73..0e8d8d1 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2569,20 +2569,6 @@ static void spapr_memory_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
> >>      uint64_t align =3D memory_region_get_alignment(mr);
> >>      uint64_t size =3D memory_region_size(mr);
> >>      uint64_t addr;
> >> -    char *mem_dev;
> >> -
> >> -    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> >> -        error_setg(&local_err, "Hotplugged memory size must be a mult=
iple of "
> >> -                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE/M_BYTE);
> >> -        goto out;
> >> -    }
> >> -
> >> -    mem_dev =3D object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_=
PROP, NULL);
> >> -    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
> >> -        error_setg(&local_err, "Memory backend has bad page size. "
> >> -                   "Use 'memory-backend-file' with correct mem-path."=
);
> >> -        goto out;
> >> -    }
> >> =20
> >>      pc_dimm_memory_plug(dev, &ms->hotplug_memory, mr, align, &local_e=
rr);
> >>      if (local_err) {
> >> @@ -2603,6 +2589,33 @@ out:
> >>      error_propagate(errp, local_err);
> >>  }
> >> =20
> >> +static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, Device=
State *dev,
> >> +                                Error **errp)
> >=20
> > Indentation nit
>=20
> ok
>=20
> >=20
> >> +{
> >> +    PCDIMMDevice *dimm =3D PC_DIMM(dev);
> >> +    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> >> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> >> +    uint64_t size =3D memory_region_size(mr);
> >> +    Error *local_err =3D NULL;
> >> +    char *mem_dev;
> >> +
> >> +    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> >> +        error_setg(&local_err, "Hotplugged memory size must be a mult=
iple of "
> >> +                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
> >> +        goto out;
> >> +    }
> >> +
> >> +    mem_dev =3D object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_=
PROP, NULL);
> >> +    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
> >> +        error_setg(&local_err, "Memory backend has bad page size. "
> >> +                   "Use 'memory-backend-file' with correct mem-path."=
);
> >> +        goto out;
> >> +    }
> >> +
> >> +out:
> >> +    error_propagate(errp, local_err);
> >=20
> > As recently discussed with Markus Armbruster, it isn't necessary to hav=
e a
> > local Error * if you don't do anything else with it but propagate it.
>=20
> Yes, you are right, it's a stupid cut'n'paste.

This patch seems like a good idea regardless of the rest, so I've
fixed the minor nits Greg pointed out and merged to ppc-for-2.10.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--R7Dyui215VKdTDYA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJRGUAAoJEGw4ysog2bOSF5kP/3shY+iCViu4T2g7d6ijDuzW
ZkVQWupYvC3akcsg3MJ77167EhSa88mY2/I/cF0vMofmiP8NYPouFr9QHm0lm7CP
rZNh4Q9sZYw/2U+THHEs3ku5yfqFfMpcaGC0BBbzxZ2sqEJxOYrk6tztfnhtjfZT
07uhmYd0YnWVJmHG8Kx1n1yM/HDwcr906LTL6O92XAkJIobiW10T/pW/qoTq0Lax
zfdMzTJxiAMdB+Bz1CD2ETQpqrJ6rKywvBjmdr7UYq1qMbXm5TTJXRzr6vqimymn
UqB4KqPEnRumnUCMh2f80fcTio0+uu1FO8PvvsvItcx0SX5LckL3X9YP4058SqlQ
96kkwa2/GDydMs89MIGWxFLtusxrKmC1jC+HmHv5HspLttf3XUB39rLkL731CzBC
P3sHBEu3ZBxSJaAW+GK0fUv7oRrYzuXW3vhDr0ruasocGAQWnyS84AJLw5gXP0av
iOlFz8XuFW9F/Ecu+juyr+BHN4c90RCkvO8pHwetIUVp5DxE0s87TNeRKUe0MPL6
by5fEF4EBMsr/ch0UY+PvDKo41x1gZ6AdeaR9daknuuO5d2Jgko98hWe6OSM7wcw
LU/OITljwpRhNbOepEXVw+yEDzVKFmmf92Ma/DjmcckyyYF/w0AsXvgudsaskgHA
iwa/eOf1XyghEwdiaXZu
=N9Id
-----END PGP SIGNATURE-----

--R7Dyui215VKdTDYA--
