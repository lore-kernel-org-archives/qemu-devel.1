Received: from eggs.gnu.org ([2001:4830:134:3::10]:35992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddLIk-0007cE-Hb
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddLIh-0002ju-8N
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:56:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddLIh-0002hP-0D
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 14:56:51 -0400
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
	<dd0512d5-0d7e-3b66-382d-47ee4d1a2de2@amsat.org>
	<48882fff-563a-52cc-c215-12f0808857cd@redhat.com>
	<5065c286-ad67-697e-bc02-84d66ad0682d@amsat.org>
	<20170803203805.141d0708@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e11535cd-242f-bfc2-d854-af3cc9044665@redhat.com>
Date: Thu, 3 Aug 2017 13:56:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170803203805.141d0708@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KrAVHha6TIJcG0Mc5FgENAtbXi0Ufe4bQ"
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KrAVHha6TIJcG0Mc5FgENAtbXi0Ufe4bQ
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Message-ID: <e11535cd-242f-bfc2-d854-af3cc9044665@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] kvm: workaround build break on gcc-7.1.1 /
 fedora26
References: <150168523493.31663.3716600121804656211.stgit@bahia.lan>
 <dd0512d5-0d7e-3b66-382d-47ee4d1a2de2@amsat.org>
 <48882fff-563a-52cc-c215-12f0808857cd@redhat.com>
 <5065c286-ad67-697e-bc02-84d66ad0682d@amsat.org>
 <20170803203805.141d0708@bahia.lan>
In-Reply-To: <20170803203805.141d0708@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 01:38 PM, Greg Kurz wrote:
> The following code snippet spits a warning with gcc-7.1.1-3.fc26 and -W=
all on
> ppc64le AND x86_64:
>=20
> int foo(void)
> {
>     char empty_array[] =3D { };
>     int i, ret =3D 0;
>=20
>     for (i =3D 0; i < (int) (sizeof(empty_array) / sizeof(empty_array[0=
])); i++) {
>         ret =3D empty_array[i];
>     }
>=20
>     return ret;
> }

Confirmed.  No idea why the cast makes gcc think i is uninitialized.

>=20
> If I drop the (int), the warning goes away... and so does the build bre=
ak
> of qemu-system-ppc64 on my ppc64le host.
>=20
> I don't have 4.7.1 or 4.6 compilers around but I could check 4.8.5
> is okay with that change FWIW.

I tested with gcc 4.4.7 on RHEL 6, but -Wtype-limits there didn't warn
whether or not the (int) was present; it's possible that we still need
to test with 4.6 or 4.7.1 to see whether it makes a difference.

>=20
>> Ok so let's stop losing time about compiler incoherent warnings, using=
=20
>> -Wno-type-limits for GCC < 5...
>> So we can keep a sane/understandable codebase, using size_t and no (in=
t)=20
>> cast.

That's also a possibility, if we still hit old compilers that require
the (int).

>>
>=20
> If I also convert 'int i' to 'size_t i' then I get the same error as
> in commit 61c7bbd2:
>=20
> error: comparison of unsigned expression < 0 is always
>  false [-Werror=3Dtype-limits]

Confirmed with newer gcc, whether or not the (int) cast is present.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KrAVHha6TIJcG0Mc5FgENAtbXi0Ufe4bQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmDce0ACgkQp6FrSiUn
Q2oW4Qf/WqD8029ZlF0ySuL4CnDyEUsVdFYSxKjVRSH1PsBUnmRvszsQeD+bvkNe
8h5lkT4Y2B9kh9DARVLDF6K9sPzqtutvVk/i1NDDVnTp9LegJy2pa0THwBKzJlLM
j3XpUNCadApv/obKJiupNeNdWRLnsPCB6NhKg6glhl0f5Gg+jYs6hazfS2+QDZOQ
xbtJ3i87PylSvwXXq/khJ/2XzxKO/T152J/C7XfPw8C4P3teKDnyAJQz36UXSa6k
D+laDlgX+q4An/YQSeAgXSCMJi9NRdIndxJpTfS3XlhehlPcSWHSmo8HAXOj7tdu
iaujFVbBTlDagYuE0JdSCT4AXdMC+A==
=gBh8
-----END PGP SIGNATURE-----

--KrAVHha6TIJcG0Mc5FgENAtbXi0Ufe4bQ--
