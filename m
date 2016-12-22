Received: from eggs.gnu.org ([2001:4830:134:3::10]:33215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cK4sL-0000ak-RU
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cK4sI-0006yl-N3
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:01:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cK4sI-0006xd-FD
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:01:42 -0500
References: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
	<1482417047-15588-1-git-send-email-minyard@acm.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b9a532a5-2527-0e6e-6c16-c4d23b62b8ef@redhat.com>
Date: Thu, 22 Dec 2016 09:01:39 -0600
MIME-Version: 1.0
In-Reply-To: <1482417047-15588-1-git-send-email-minyard@acm.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XmfDDt5Xoeo4scdkCMScSe1SC8djh7kmp"
Subject: Re: [Qemu-devel] [PATCH] ipmi: Add parenthesis around some macro
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, Bug 1651167 <1651167@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XmfDDt5Xoeo4scdkCMScSe1SC8djh7kmp
From: Eric Blake <eblake@redhat.com>
To: minyard@acm.org, Bug 1651167 <1651167@bugs.launchpad.net>,
 qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>
Message-ID: <b9a532a5-2527-0e6e-6c16-c4d23b62b8ef@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ipmi: Add parenthesis around some macro
 parameters
References: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
 <1482417047-15588-1-git-send-email-minyard@acm.org>
In-Reply-To: <1482417047-15588-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/22/2016 08:30 AM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> Macro parameters should almost always have () around them when used.
> llvm reported an error on this.
>=20
> Reported in https://bugs.launchpad.net/bugs/1651167
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/ipmi/isa_ipmi_bt.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index f036617..8a97314 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -40,37 +40,37 @@
>  #define IPMI_BT_CLR_WR_MASK        (1 << IPMI_BT_CLR_WR_BIT)
>  #define IPMI_BT_GET_CLR_WR(d)      (((d) >> IPMI_BT_CLR_WR_BIT) & 0x1)=

>  #define IPMI_BT_SET_CLR_WR(d, v)   (d) =3D (((d) & ~IPMI_BT_CLR_WR_MAS=
K) | \

Still under-parenthesized, if the result of IPMI_BT_SET_CLR_WR() is used
in any larger expression;

> -                                       (((v & 1) << IPMI_BT_CLR_WR_BIT=
)))
> +                                       ((((v) & 1) << IPMI_BT_CLR_WR_B=
IT)))

and at the same time, you (still) have a redundant set on the second line=
=2E

Better would be:

((d) =3D (((d) & ~IPMI_BD_CLR_WR_MASK) | \
        (((v) & 1) << IPMI_BT_CLR_WR_BIT)))

> =20
>  #define IPMI_BT_CLR_RD_MASK        (1 << IPMI_BT_CLR_RD_BIT)
>  #define IPMI_BT_GET_CLR_RD(d)      (((d) >> IPMI_BT_CLR_RD_BIT) & 0x1)=

>  #define IPMI_BT_SET_CLR_RD(d, v)   (d) =3D (((d) & ~IPMI_BT_CLR_RD_MAS=
K) | \
> -                                       (((v & 1) << IPMI_BT_CLR_RD_BIT=
)))
> +                                       ((((v) & 1) << IPMI_BT_CLR_RD_B=
IT)))

and again, throughout the patch.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XmfDDt5Xoeo4scdkCMScSe1SC8djh7kmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYW+rTAAoJEKeha0olJ0Nq2+IH/jU4O4MjrrPH3IQAjwj35GOe
oX9X0/LMeL9003C2Du6tTddM/MG2eDQg/PR+n7UOvZnmT/5E+638dH6AvzC6A5Pu
9wo8+JzuELe3CzdKzufmnpTE7FC6UUliQMOO0LaaDbW39nYqKOh1VLTA1nU3MrE7
SjbjVTtJpdQwz51zABSMer4YVxAtQZ80XU/a/49iogD2OgF96VNvfqAmwGc4cnom
36DxQDD4ERW1U9kAkqS+MpUAeUf8B3TEsd8bClL4hP7sclvF25AwUUGLAdbvstAN
anPqqa7TkNRqgE2vYxnbUjlsBprEeLFrpc6xrzA5I+WgsWmgeW49VLz7Yxoyf+M=
=wlyx
-----END PGP SIGNATURE-----

--XmfDDt5Xoeo4scdkCMScSe1SC8djh7kmp--
