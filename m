Received: from eggs.gnu.org ([2001:4830:134:3::10]:33740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctcdp-000730-WE
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctcdo-0004Kp-Qi
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:09:41 -0400
References: <20170330232236.8272-1-emaste@freebsd.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c81096d0-9f81-a299-eb51-976917a5251f@redhat.com>
Date: Thu, 30 Mar 2017 11:09:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170330232236.8272-1-emaste@freebsd.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="meL790Db5xB9a2ah0JXALKrp39p87kh03"
Subject: Re: [Qemu-devel] [PATCH] ipmi: use parens to avoid unexpected macro
 var evaluation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--meL790Db5xB9a2ah0JXALKrp39p87kh03
From: Eric Blake <eblake@redhat.com>
To: Ed Maste <emaste@freebsd.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <c81096d0-9f81-a299-eb51-976917a5251f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ipmi: use parens to avoid unexpected macro
 var evaluation
References: <20170330232236.8272-1-emaste@freebsd.org>
In-Reply-To: <20170330232236.8272-1-emaste@freebsd.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 06:22 PM, Ed Maste wrote:
> Found via Clang warning: logical not is only applied to the left hand
> side of this bitwise operator [-Wlogical-not-parentheses]
>=20
>                               !IPMI_BT_GET_HBUSY(ib->control_reg));
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You just re-found bug 1651167 reported in December:
https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg02704.html

>=20
> expanded from macro 'IPMI_BT_SET_HBUSY'
>                                        (((v & 1) << IPMI_BT_HBUSY_BIT))=
)
>                                           ^ ~
>=20
> Signed-off-by: Ed Maste <emaste@freebsd.org>
> ---
>  hw/ipmi/isa_ipmi_bt.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index 1c69cb33f8..c1dea503a2 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -40,37 +40,37 @@
>  #define IPMI_BT_CLR_WR_MASK        (1 << IPMI_BT_CLR_WR_BIT)
>  #define IPMI_BT_GET_CLR_WR(d)      (((d) >> IPMI_BT_CLR_WR_BIT) & 0x1)=

>  #define IPMI_BT_SET_CLR_WR(d, v)   (d) =3D (((d) & ~IPMI_BT_CLR_WR_MAS=
K) | \
> -                                       (((v & 1) << IPMI_BT_CLR_WR_BIT=
)))
> +                                       ((((v) & 1) << IPMI_BT_CLR_WR_B=
IT)))

and still overparenthesized.  My proposal back then was:
https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg03095.html

> Better would be:
>=20
> ((d) =3D (((d) & ~IPMI_BD_CLR_WR_MASK) | \
>         (((v) & 1) << IPMI_BT_CLR_WR_BIT)))

So why didn't we ever take v3 of the patch back then?
https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg03196.html

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--meL790Db5xB9a2ah0JXALKrp39p87kh03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3S3BAAoJEKeha0olJ0NqcNYH/219WGSgvfaHK6bdR1QGciwi
yJ0Fp66YnIGiCH4QUuuA16Ng0vifvAPihRoGNFwRKH9tK7L7mTFIKfdZhCrJ5QI/
gUg+Eiyci7Wx/Y2Ah2/0wFQ8pjALME6QiPy0m/UH6H9UE7fbDqjkW2qorc/dwq1/
OMwY3Trid0YOyH4y84uFjoYNVzJ1jl7K3tsYZeFAP+wv9u7a0mdB+jXK7nEmvSgJ
BXV0dQnrbNcu8FkiOhaab6JgwZT0OWMeBo5/HOFJhClpugi/MeTxOn9e25TdU4Aq
8SVaJZt/D+jaGN4gFmvV4f9QGV3Si59XJH0GX5OUfMxAL7Pfxc2EFzpFitlavXE=
=6LzB
-----END PGP SIGNATURE-----

--meL790Db5xB9a2ah0JXALKrp39p87kh03--
