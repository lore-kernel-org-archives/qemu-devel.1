Received: from eggs.gnu.org ([2001:4830:134:3::10]:58492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.vnet.ibm.com>) id 1ew855-0003ps-3b
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.vnet.ibm.com>) id 1ew850-00031z-4y
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:12:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41454
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.vnet.ibm.com>)
	id 1ew84z-000310-VL
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:12:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2EFAPa6082503
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:12:35 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gq5fk29tb-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:12:35 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.vnet.ibm.com>;
	Wed, 14 Mar 2018 15:12:33 -0000
References: <20180314142133.14166-1-drjones@redhat.com>
From: Janosch Frank <frankja@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 16:12:21 +0100
MIME-Version: 1.0
In-Reply-To: <20180314142133.14166-1-drjones@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IgrKN0q9G8m3HNdwWl1FL2KUmeqpo7Ib4"
Message-Id: <203683e2-773b-d23c-423b-598ea98a98d5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] dump-guest-memory: more descriptive
 lookup_type failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, lersek@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IgrKN0q9G8m3HNdwWl1FL2KUmeqpo7Ib4
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, lersek@redhat.com
Message-ID: <203683e2-773b-d23c-423b-598ea98a98d5@linux.vnet.ibm.com>
Subject: Re: [PATCH] dump-guest-memory: more descriptive lookup_type failure
References: <20180314142133.14166-1-drjones@redhat.com>
In-Reply-To: <20180314142133.14166-1-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.03.2018 15:21, Andrew Jones wrote:
> We've seen a few reports of
>=20
>  (gdb) source /usr/share/qemu-kvm/dump-guest-memory.py
>  Traceback (most recent call last):
>    File "/usr/share/qemu-kvm/dump-guest-memory.py", line 19, in <module=
>
>      UINTPTR_T =3D gdb.lookup_type("uintptr_t")
>  gdb.error: No type named uintptr_t.

Oh yeah, I remember that particular error.
Acked-by: Janosch Frank <frankja@linux.vnet.ibm.com>

>=20
> This occurs when symbols haven't been loaded first, i.e. neither a
> QEMU binary was loaded nor a QEMU process was attached first. Let's
> better inform the user of how to fix the issue themselves in order
> to avoid more reports.
>=20
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  scripts/dump-guest-memory.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.p=
y
> index 51acfcd0c053..e56fff6d7e82 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -16,7 +16,11 @@ the COPYING file in the top-level directory.
>  import ctypes
>  import struct
>=20
> -UINTPTR_T =3D gdb.lookup_type("uintptr_t")
> +try:
> +    UINTPTR_T =3D gdb.lookup_type("uintptr_t")
> +except Exception as inst:
> +    raise gdb.GdbError("Symbols must be loaded prior to sourcing dump-=
guest-memory.\n"
> +                       "Symbols may be loaded by first 'attach'ing a Q=
EMU process id or by 'load'ing a QEMU binary.")>
>  TARGET_PAGE_SIZE =3D 0x1000
>  TARGET_PAGE_MASK =3D 0xFFFFFFFFFFFFF000
>=20



--IgrKN0q9G8m3HNdwWl1FL2KUmeqpo7Ib4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaqTvVAAoJEBcO/8Q8ZEV5TL8P/31pYw0KCm9djhIIQ+oKKaRD
2UBpavilwYHIfn7QFHygXOVWx9iu06uM/juJ9+D9jlFkItHaLaZM/U5lbgLIo6XC
SaZQ3UliKvppRK6ZW6XJMGWWIv+5QFFIDXvuMvObmMWxp+VT7lNTlYINrkR1+z0v
KOVtvdDm4vN6mzYyUb8F+bUThd3c1RthtO18KdUffRgLXTDOIaPr+ZqntXB3THBr
LmxNxarJFJn5udyJruZhhs7g8zZB7jY2MElGA4A4WEuVfCX2km3McJM4cDJpsYJc
XRe05z1oJQWjLuGlDl8t4u4ZnJNTXhw4xR6VSTlZD0PlUT2uTOkeliPsAmInFbAK
6NjLCPxzwSII8QZeP3T3blaYW/GaD6xxUja9s+1revv4x/r8xjSh1ozBlxLU0u+H
tn5H4a1VbQnykWiJ5EWW9HsjQAJm+r0SRLo6BAcbCbnFsR7SNwdAxLNdrh9hSGSL
EttbnNnw3sze8Q7aObhElJ5BsqwgLp58SmCobHV2oZqY9gOVahPsst/GrmVCcS1P
l40vV8EK/t4vuWYwUesE4Jfpnc6OqwtfQs/ftfi06PZgTpq3x4KGGxRdoVhFdcwf
PFi2e1kakf+oua3K2/6z4eBxHpwE4cUSYiEWZ4jQI2CiJyQRBd025Shv+wp58p9a
32A0y3gS8REP+yjboCiK
=/6Xy
-----END PGP SIGNATURE-----

--IgrKN0q9G8m3HNdwWl1FL2KUmeqpo7Ib4--
