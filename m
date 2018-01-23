Received: from eggs.gnu.org ([2001:4830:134:3::10]:40906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ee4Ai-0005UL-6m
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 14:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ee4Ad-0002oJ-Ih
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 14:23:52 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-5-git-send-email-walling@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a6618d7-566b-bec7-c267-26e4e7acb1a2@redhat.com>
Date: Tue, 23 Jan 2018 13:23:38 -0600
MIME-Version: 1.0
In-Reply-To: <1516732013-18272-5-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZLdFBcUDMT39MGtcT73pVIPfGmA6GBs59"
Subject: Re: [Qemu-devel] [PATCH v4 04/10] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZLdFBcUDMT39MGtcT73pVIPfGmA6GBs59
From: Eric Blake <eblake@redhat.com>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com
Message-ID: <2a6618d7-566b-bec7-c267-26e4e7acb1a2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 04/10] s390-ccw: update libc
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
 <1516732013-18272-5-git-send-email-walling@linux.vnet.ibm.com>
In-Reply-To: <1516732013-18272-5-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2018 12:26 PM, Collin L. Walling wrote:
> Moved:
>   memcmp from bootmap.h to libc.h (renamed from _memcmp)
>   strlen from sclp.c to libc.h (renamed from _strlen)
>=20
> Added C standard functions:
>   atoi
>   isdigit
>=20
> Added non C-standard function:
>   itostr
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---

> +/**
> + * atoi:
> + * @str: the string to be converted.
> + *
> + * Given a string @str, convert it to an integer. Leading whitespace i=
s
> + * ignored. The first character (after any whitespace) is checked for =
the
> + * negative sign. Any other non-numerical value will terminate the
> + * conversion.
> + *
> + * Returns: an integer converted from the string @str.
> + */
> +int atoi(const char *str)
> +{
> +    int val =3D 0;
> +    int sign =3D 1;
> +
> +    if (!str || !str[0]) {
> +        return 0;
> +    }
> +
> +    while (*str =3D=3D ' ') {
> +        str++;
> +    }

That's not "any whitespace", but only spaces.  A fully compliant
implementation would be checking isspace(), but I don't expect you to
implement that; at a minimum, also checking '\t' would get you closer
(but not all the way to) compliance.


> +static char *_itostr(int num, char *str, size_t len)
> +{
> +    int num_idx =3D 0;
> +    int tmp =3D num;
> +    char sign =3D 0;
> +
> +    if (!str) {
> +        return NULL;
> +    }
> +
> +    /* Get index to ones place */
> +    while ((tmp /=3D 10) !=3D 0) {
> +        num_idx++;
> +    }
> +
> +    if (num < 0) {
> +        num *=3D -1;
> +        sign =3D 1;
> +    }

If num =3D=3D INT_MIN, then num is still negative at this point...

> +
> +    /* Check if we have enough space for num, sign, and null */
> +    if (len <=3D num_idx + sign + 1) {
> +        return NULL;
> +    }
> +
> +    str[num_idx + sign + 1] =3D '\0';
> +
> +    /* Convert int to string */
> +    while (num_idx >=3D 0) {
> +        str[num_idx + sign] =3D num % 10 + '0';

=2E..which breaks this.

Either make it work, or document the corner case as unsupported.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ZLdFBcUDMT39MGtcT73pVIPfGmA6GBs59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpni7oACgkQp6FrSiUn
Q2p4vQf/ZN19dtV1/wSv8VC1wzoVGM5/gZYTYz8RkdCjLTODBp9uAUYUaIEsPsgc
7xxM/lrVThTM/hd3J3gaqJa4b0mw9BItO1yHpL1bqQLGdswpGSvrLSNfe/kpkQVA
Bb/8VG3uT61pgxUmTnN2Y3bEctrE4m1iD5QFWZNpyLWRzp7AYJwHz/bRWZz33049
aVjdtCktEUzSTMsc/qXsD0njkU3JavQRH+zWemrKVLnOtV5DbKSrVNy+3GCGkt4R
9l5lY3t1dxBX4KLoBPiDhnQVgoAVR7MzpxjZXQ97bGCEeMXhatvqGt28nfXP/+HK
Ej3/HolqmUo1HJU8wUB6sqszHa2o4Q==
=oPqs
-----END PGP SIGNATURE-----

--ZLdFBcUDMT39MGtcT73pVIPfGmA6GBs59--
