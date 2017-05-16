Received: from eggs.gnu.org ([2001:4830:134:3::10]:45561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAU2v-00025y-I8
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAU2u-0007V1-CF
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:25:17 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dAU2s-0007Rj-Fg
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:25:16 -0400
Date: Tue, 16 May 2017 12:53:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170516025300.GA30022@umbus.fritz.box>
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
	<1494838260-30439-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <1494838260-30439-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] exec: simplify phys_page_find() params
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 04:50:57PM +0800, Peter Xu wrote:
> It really only plays with the dispatchers, so the parameter list does
> not need that complexity. This helps for readability at least.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  exec.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index eac6085..1d76c63 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -371,10 +371,11 @@ static inline bool section_covers_addr(const Memory=
RegionSection *section,
>                               int128_getlo(section->size), addr);
>  }
> =20
> -static MemoryRegionSection *phys_page_find(PhysPageEntry lp, hwaddr addr,
> -                                           Node *nodes, MemoryRegionSect=
ion *sections)
> +static MemoryRegionSection *phys_page_find(AddressSpaceDispatch *d, hwad=
dr addr)
>  {
> -    PhysPageEntry *p;
> +    PhysPageEntry lp =3D d->phys_map, *p;
> +    Node *nodes =3D d->map.nodes;
> +    MemoryRegionSection *sections =3D d->map.sections;
>      hwaddr index =3D addr >> TARGET_PAGE_BITS;
>      int i;
> =20
> @@ -412,8 +413,7 @@ static MemoryRegionSection *address_space_lookup_regi=
on(AddressSpaceDispatch *d,
>          section_covers_addr(section, addr)) {
>          update =3D false;
>      } else {
> -        section =3D phys_page_find(d->phys_map, addr, d->map.nodes,
> -                                 d->map.sections);
> +        section =3D phys_page_find(d, addr);
>          update =3D true;
>      }
>      if (resolve_subpage && section->mr->subpage) {
> @@ -1246,8 +1246,7 @@ static void register_subpage(AddressSpaceDispatch *=
d, MemoryRegionSection *secti
>      subpage_t *subpage;
>      hwaddr base =3D section->offset_within_address_space
>          & TARGET_PAGE_MASK;
> -    MemoryRegionSection *existing =3D phys_page_find(d->phys_map, base,
> -                                                   d->map.nodes, d->map.=
sections);
> +    MemoryRegionSection *existing =3D phys_page_find(d, base);
>      MemoryRegionSection subsection =3D {
>          .offset_within_address_space =3D base,
>          .size =3D int128_make64(TARGET_PAGE_SIZE),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZGmmHAAoJEGw4ysog2bOSWP4QAISK2HJ4E+HYjnNxypXGui1U
IoQf+WufVyvstbtpTWCTCdyC04R8xiSfhhEalAz34MIEl/RIXXNZqIYv8xemFHSb
DeOwLOVvVNw6e+dBfrSkcVxoFUTNHZ2+S3VYF+VCc43Ts/tKBTY+z9sAqIjrWwBM
IF0ksVt2CVAFT+slF9TtIsOXH68Wwq3qxdScEo1j8eBA/h8ZQX6mMKobGuMzR2In
OpldxWSNZmhs+FxdkEeYbBLPutEMenanrTVmZ9ROu8EIrpyqP8Cd41QlbM6KzxEy
s9xcSqIoxs0f0Qr99Km2WnMzjsuFMTATuvukBdL2IExRH8aP8Bb5semII6HLWTA6
QegqTM4lUtyt06aNwlq+2X2Oml9Z6fCsSihg+g/eWdgEQ/q4A3W5X/70RXLDdIL5
RllaDhsbUrzbboNlQwwexSeCzZ8vvJCn0y2I+GjchH9jHpc5HFtVd0XYgMVoTM8M
q1CIhXYRnF6pp53csW1Gyeliiiy3KJiaycRnY7C0nhHWS/3xp/qItk5mBHTEvv20
zBSmoDmRgY92yQCZ8ePwHOMddqNxd5mse/UlJl221jRpuN6mLoGZzQYR84J1Ojuy
8z306MToWjxI/UF23iQYD+HAhjAuF/o4RKsYVrUQ3bRvZLb4uMWgcImtMMFve2e5
ykg2fRGdmK+owdhOCnv7
=XGe0
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
