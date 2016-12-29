Received: from eggs.gnu.org ([2001:4830:134:3::10]:58467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMb4i-00073q-QM
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:48:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cMb4e-0008Fn-E1
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:48:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cMb4e-0008FW-5S
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 08:48:52 -0500
References: <CAJ+F1CJXGAZa5_+4jD0rP_zX28RCCu3xmF27ZHpgvhnZz686ug@mail.gmail.com>
	<20161228145344.30819-1-cov@codeaurora.org>
	<2a940dc2-05a0-2e91-afc0-eeb560f6ce32@redhat.com>
	<CAFEAcA_g5Ru2cg-D5JEhpzuUTx7=SwNg=TW3uxs-z_pp2yvqHQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49b66510-1c3f-64fa-c0b0-125547bed7ca@redhat.com>
Date: Thu, 29 Dec 2016 07:48:49 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_g5Ru2cg-D5JEhpzuUTx7=SwNg=TW3uxs-z_pp2yvqHQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2UeGibnPKdfIHmiHwaIUIjuww521tkS49"
Subject: Re: [Qemu-devel] [PATCH v2] build: include sys/sysmacros.h for
 major() and minor()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christopher Covington <cov@codeaurora.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2UeGibnPKdfIHmiHwaIUIjuww521tkS49
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christopher Covington <cov@codeaurora.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <49b66510-1c3f-64fa-c0b0-125547bed7ca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] build: include sys/sysmacros.h for
 major() and minor()
References: <CAJ+F1CJXGAZa5_+4jD0rP_zX28RCCu3xmF27ZHpgvhnZz686ug@mail.gmail.com>
 <20161228145344.30819-1-cov@codeaurora.org>
 <2a940dc2-05a0-2e91-afc0-eeb560f6ce32@redhat.com>
 <CAFEAcA_g5Ru2cg-D5JEhpzuUTx7=SwNg=TW3uxs-z_pp2yvqHQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_g5Ru2cg-D5JEhpzuUTx7=SwNg=TW3uxs-z_pp2yvqHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/28/2016 11:07 AM, Peter Maydell wrote:
> On 28 December 2016 at 16:10, Eric Blake <eblake@redhat.com> wrote:
>> On 12/28/2016 08:53 AM, Christopher Covington wrote:
>>> The definition of the major() and minor() macros are moving within gl=
ibc to
>>> <sys/sysmacros.h>. Include this header to avoid the following sorts o=
f
>>> build-stopping messages:

>> Works for glibc; but <sys/sysmacros.h> is non-standard and not present=

>> on some other systems, so this may fail to build elsewhere.  You'll
>> probably need a configure probe.  Autoconf also says that some platfor=
ms
>> have <sys/mkdev.h> instead of <sys/sysmacros.h> (per its AC_HEADER_MAJ=
OR
>> macro).
>=20
> Also this seems straightforwardly like a bug in glibc: it shouldn't
> be making this kind of breaking change. makedev(3) on my Linux box
> says nothing about needing sysmacros.h for these.

Here's the bug explaining the rationale behind the change:

https://sourceware.org/bugzilla/show_bug.cgi?id=3D19239

It IS a bug fix, but in the other direction - it is fixing namespace
pollution that was present in <sys/types.h> and breaking certain
standard-required idioms.  There HAS been warning, but system man pages
have not always been updated to track upstream development, and the plan
was that glibc 2.25 only causes a warning rather than outright failure
to compile (although with -Werror, you have to adjust right away, rather
than when the future glibc actually changes <sys/types.h> again to
completely drop the pollution).

It is CORRECT to fix any software relying on makedev() to use the
CORRECT headers for that declaration, rather than getting it for free
from <sys/types.h> pollution - the problem is that makedev() is not
portable, and therefore the spelling of the correct header is not
trivial - it requires some configure-time probing.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--2UeGibnPKdfIHmiHwaIUIjuww521tkS49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYZRRBAAoJEKeha0olJ0Nq8XcH/0ms9dJmSekfkhHK5nqBRI87
pOf6YCoDCulvRRYqSj/J08axsOWTm0/OZO4z8CSaNhfCaRSucAFgzph5BYAjj5N6
5LsOLytCzrj/y4R5muT6Yk/Q7gZVKY6NKAePxyDSaIn+VoSbv/qmKNAvhuuQyb0D
4vVOzGmSnkVZYnOKBXa8X6DVyd2Z0cCRrg+Y13+U9p06nBY2Glh68vWl4PPOYeDx
uo0PDmTJq8IgmB2MBnEw+MRkFIIDK8L7CfOuKXn9C1mbybO3UVRvny17NWSuupmb
wGhay4oaNM3By8amMWMSBfBzDvn9L9KIZSWWTmUfpTjay9FcboGONLesap8BsTk=
=06Bs
-----END PGP SIGNATURE-----

--2UeGibnPKdfIHmiHwaIUIjuww521tkS49--
