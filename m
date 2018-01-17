Received: from eggs.gnu.org ([2001:4830:134:3::10]:60389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebp93-0005I8-Mu
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebp8z-0007yP-Kl
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:56:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ebp8z-0007or-CI
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:56:49 -0500
References: <20180117131821.18700-1-f4bug@amsat.org>
	<20180117131821.18700-2-f4bug@amsat.org>
	<20180117133201.GN19227@redhat.com>
	<a38e57e4-b291-e7a1-3086-c2a1714f1b7f@amsat.org>
	<20180117143911.GQ19227@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b70d091-4131-e502-e808-2415c27b4b7b@redhat.com>
Date: Wed, 17 Jan 2018 08:56:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180117143911.GQ19227@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gHKHKGWmB5DZfdazKJA6TmZIzHopFuAlO"
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] compiler: add
 QEMU_WARN_NONNULL_ARGS()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, Luiz Capitulino <lcapitulino@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gHKHKGWmB5DZfdazKJA6TmZIzHopFuAlO
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Luiz Capitulino <lcapitulino@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b70d091-4131-e502-e808-2415c27b4b7b@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] compiler: add
 QEMU_WARN_NONNULL_ARGS()
References: <20180117131821.18700-1-f4bug@amsat.org>
 <20180117131821.18700-2-f4bug@amsat.org> <20180117133201.GN19227@redhat.com>
 <a38e57e4-b291-e7a1-3086-c2a1714f1b7f@amsat.org>
 <20180117143911.GQ19227@redhat.com>
In-Reply-To: <20180117143911.GQ19227@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 08:39 AM, Daniel P. Berrange wrote:

>>>
>>> GCC may or may not warn you about passing NULL for the 'bar'
>>> parameter, but it will none the less assume nothing passes
>>> NULL, and thus remove the 'if (!bar)' conditional during
>>> optimization. IOW, adding nonnull annotations can actually
>>> make your code less robust :-(

The gcc bug mentioned in the libvirt code says that newer gcc may be
smarter than when we added the libvirt workaround:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D17308

But I haven't played with it in a long time (the sour experience with
misoptimized code with no warning has made me wary of re-trying).


>>
>> Why do you use __attribute__(()) ? Isn't this enough:
>=20
> No idea offhand - Eric wrote this so perhaps he had a reason for that
> else branch style.
>=20
>>
>> #if defined __clang_analyzer__ || defined __COVERITY__
>> #define QEMU_STATIC_ANALYSIS 1
>> +#define QEMU_WARN_NONNULL_ARGS(args...) __attribute__((nonnull(args))=
)
>> +#else
>> +#define QEMU_WARN_NONNULL_ARGS(args...)
>> #endif

My reasoning for using the empty attribute was to at least ensure that
the gcc compilation agrees that the annotation is syntactically valid
(nothing worse than sticking an __attribute__ code in a place that gcc
doesn't like, but only for static checker builds, so you don't learn
about it right away).  Defining the macro to nothing, rather than an
empty attribute, makes it harder for the common-case compilation to
detect placement problems.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gHKHKGWmB5DZfdazKJA6TmZIzHopFuAlO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfZBcACgkQp6FrSiUn
Q2ouXAf/V84pX0ZseUU8s/a9sG6g03jws04AbtED1lFcz75YjaF1JbGhRyLVRD7L
Qd6RhObXY+BiK71wtshlvwsjU+tpxMGVGKugJVdQSV2Y/qOZpnURSzDgSwphb3iM
/163jfJBFj+845Tu4TTsF0W44q1MjspXtKyqdzYcTEIvBgDZM/7dH2Uud+Eu3gRI
+53byVtVFdYA6XP9TK39v46gXrANomWU/5/9AmhwCjFacZO/2Wxerws9b4/d9X1g
qeWMpOoO1gNltQwEGb95FDekHIeac6+LF1ciLH0sLYi/GCENpsge7MhwOdNeU2r2
St+r5BaSjiv5Hi2b0WTLYiTkH4eGnA==
=tCV2
-----END PGP SIGNATURE-----

--gHKHKGWmB5DZfdazKJA6TmZIzHopFuAlO--
