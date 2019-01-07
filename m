Received: from eggs.gnu.org ([209.51.188.92]:60588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggVuH-0005AT-RZ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggVuF-00037b-Kn
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:29:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ggVuA-00035W-OJ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:29:27 -0500
References: <20190106013802.3645-1-eblake@redhat.com>
	<657598d6-0cea-91dc-a975-f716522a49b9@twiddle.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <80396f87-87d0-5ba9-3efc-405a8dce16d8@redhat.com>
Date: Mon, 7 Jan 2019 08:22:16 -0600
MIME-Version: 1.0
In-Reply-To: <657598d6-0cea-91dc-a975-f716522a49b9@twiddle.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XZLuUQqsRgI8Affcf0Dv0MBiOBDS47mx3"
Subject: Re: [Qemu-devel] [PATCH v2] osdep: Make MIN/MAX evaluate arguments
 only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: dirty.ice.hu@gmail.com, f4bug@amsat.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XZLuUQqsRgI8Affcf0Dv0MBiOBDS47mx3
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: dirty.ice.hu@gmail.com, f4bug@amsat.org, Gerd Hoffmann
 <kraxel@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <80396f87-87d0-5ba9-3efc-405a8dce16d8@redhat.com>
Subject: Re: [PATCH v2] osdep: Make MIN/MAX evaluate arguments only once
References: <20190106013802.3645-1-eblake@redhat.com>
 <657598d6-0cea-91dc-a975-f716522a49b9@twiddle.net>
In-Reply-To: <657598d6-0cea-91dc-a975-f716522a49b9@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/6/19 2:32 AM, Richard Henderson wrote:
> On 1/6/19 11:38 AM, Eric Blake wrote:
>> +/*
>> + * Automatic type deduction, to be used as:
>> + * QEMU_TYPEOF(expr) name =3D expr;
>> + */
>> +#if QEMU_GNUC_PREREQ(4, 9)
>> +# define QEMU_TYPEOF(a) __auto_type
>> +#else
>> +# define QEMU_TYPEOF(a) typeof(a)
>> +#endif
>=20
> What's wrong with always using typeof?  This seems like it leaves poten=
tial odd
> bugs affecting gcc-4.8.

Always using typeof is an option, but gcc documents that __auto_type is
nicer than typeof:

>  Using '__auto_type' instead of 'typeof' has two advantages:
>=20
>    * Each argument to the macro appears only once in the expansion of
>      the macro.  This prevents the size of the macro expansion growing
>      exponentially when calls to such macros are nested inside argument=
s
>      of such macros.
>=20
>    * If the argument to the macro has variably modified type, it is
>      evaluated only once when using '__auto_type', but twice if 'typeof=
'
>      is used.

We don't use variably modified types (at least, I don't think we do), so
the latter is moot (but WOULD be the spot where we are most likely to be
bitten on 4.8 compilers lacking __auto_type); the former point is a
minor speed win in favor of __auto_type.

>=20
>> +#undef MIN
>> +#define MIN(a, b)                            \
>> +    ({                                       \
>> +        QEMU_TYPEOF((a) + 0) _a =3D (a) + 0;   \
>> +        QEMU_TYPEOF((b) + 0) _b =3D (b) + 0;   \
>=20
> If you're promoting the type, why don't you want to promote to the comm=
on type
> between A and B?  E.g.
>=20
>   __typeof((a) + (b)) _a =3D (a), _b =3D (b);
>=20
> After all, that's what the result type of (p ? _a : _b) will be.

That formulation should work as well, if anyone likes it better (but it
does NOT work with __auto_type).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--XZLuUQqsRgI8Affcf0Dv0MBiOBDS47mx3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwzYJgACgkQ3g5py3or
ov0mtAf8DaSlbgSMvvDGu7V9T0eF2zN39aguyJujI/ELif15xUc1eyipqVCsevJz
67RYaw2RQmr08iavtgtYjF9hZYaJqDRlAUtHighsjcQTxLHWtxJE3gqrv0pIkMXH
UOKlofsz5VxwhWTuRrYETyNLTww7NCK5tqf8IIt3zexIIlZR+0rQMHxGz0FtxpBs
+uczQTvuGlWEUvrFEZn1aYaGYtPD5VkDE6+vNHxTD7dJU9IH4bnVDb431RzO03W+
OJAodwj21xdxLfcZYzIaOpdqrWo39VsYFwE96UiG7T+ytk5AND2lWfbEjzTeWzfC
FJ1IgwzfWEVh8q6PQ+a5N++yS1Rnhg==
=vDuV
-----END PGP SIGNATURE-----

--XZLuUQqsRgI8Affcf0Dv0MBiOBDS47mx3--
