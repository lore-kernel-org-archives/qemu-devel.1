Received: from eggs.gnu.org ([2001:4830:134:3::10]:39704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1daOF5-0007vr-F1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1daOF2-0002kT-3S
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:28:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1daOF1-0002jZ-R5
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:28:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EA266E78F
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 15:28:50 +0000 (UTC)
References: <20170726150446.20381-1-otubo@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <4339cf29-69cd-773d-2912-741cf9bd4da7@redhat.com>
Date: Wed, 26 Jul 2017 11:28:43 -0400
MIME-Version: 1.0
In-Reply-To: <20170726150446.20381-1-otubo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j2oRr75dv1q7Ll41rrTXWp3J7kjalG6j9"
Subject: Re: [Qemu-devel] [PATCH] fix qemu-system-unicore32 crashing when
 calling without -kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j2oRr75dv1q7Ll41rrTXWp3J7kjalG6j9
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
Message-ID: <4339cf29-69cd-773d-2912-741cf9bd4da7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fix qemu-system-unicore32 crashing when
 calling without -kernel
References: <20170726150446.20381-1-otubo@redhat.com>
In-Reply-To: <20170726150446.20381-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/26/2017 11:04 AM, Eduardo Otubo wrote:
> Starting qemu-system-unicore32 without the -kernel parameter results in=

> an assert() returns false and aborts qemu. This patch replaces it with =
a
> proper error message followed by exit(1).
>=20
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  hw/unicore32/puv3.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index e9d1a60b6f..ff62efb4df 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -92,7 +92,10 @@ static void puv3_load_kernel(const char *kernel_file=
name)
>      if (kernel_filename =3D=3D NULL && qtest_enabled()) {
>          return;
>      }
> -    assert(kernel_filename !=3D NULL);
> +    if (kernel_filename =3D=3D NULL) {
> +        error_report("kernel parameter cannot be empty");
> +        exit(1);
> +    }
> =20

How do you actually trigger this?  There's already appropriate command
line options handling in vl.c, which all targets (I tried) incorporate.
For unicore32:

$ ./unicore32-softmmu/qemu-system-unicore32 -kernel
qemu-system-unicore32: -kernel: requires an argument

I also see what I believe is proper handling with invalid kernels (or
empty options):

$ ./unicore32-softmmu/qemu-system-unicore32 -kernel ''
qemu-system-unicore32: Load kernel error: ''

Regards,
- Cleber.

>      /* only zImage format supported */
>      size =3D load_image_targphys(kernel_filename, KERNEL_LOAD_ADDR,
>=20

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]


--j2oRr75dv1q7Ll41rrTXWp3J7kjalG6j9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZeLUrAAoJEGV+jTOl8gnzcuIP/iFgIv8IljxKZPQFLMV4TyZo
ZUQ1Oa+AbXVgecbr6s9FqPMb2sf9JxO/g4kXRUUlsav+Ul8NNINsHmn1Lc5ZCmYB
PZy1WoSs36+B7FER/TKQt4rhZUc8PGptmbT7uKJOKPzkrAxbU02VHsCZZN4c6H6W
O1FUhgeytS615iaduTdRJBlIfYpB3Q19nbttbbNG1wlAseXqr7ug07UFwYJ30JoW
VhI0PEvflvIOsIkeI5GrF8n5HpKGOWpnYy3wGMdzM6VplpeeOhb9qvY4ZoHLKtzP
PhLvq83LPxZJgpqBamNIiYW/sOwwrPLEofqnZSy8JzKqhJCtFlRUrVygvYtJwfIu
HKVOobiChS7f9otdXbvqSSqrnPDH7QSgklPSE7KgF1ZVW8WC3hpPCi7oWpmnPmBf
tqBK3orLNy9e5IIZz8V75wudYbDsnjAD5kRKxA4LZVyxs3fha2cnXRzMPktTP+0g
Mwtq0y01uxvzjHYmSR6BJ3w8k6FMrtz6fTk/iDXQnhA1q7Vt2vZS1ahb5hoi0sKv
Yo23fWke0PAPXmZVy+xPlTLCnmCpdicX5OSuAL8IH7z+rwnvUbcfH+ySKteIzgT2
4GjuTZXuMMz6RgvC6IJ9BwqSLPzfNBhuFB9H/iwNdKzrdQLsJI/ZvrZC3P2shQ1m
H9Q4Vds8R8qvwO4pZIeD
=a75X
-----END PGP SIGNATURE-----

--j2oRr75dv1q7Ll41rrTXWp3J7kjalG6j9--
