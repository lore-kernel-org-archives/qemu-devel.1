Received: from eggs.gnu.org ([2001:4830:134:3::10]:50050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYGV3-0004Fb-9N
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYGUz-0003bX-8T
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:48:37 -0400
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
	<d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1526558-db87-734b-c1dd-7601ceaa682c@redhat.com>
Date: Thu, 20 Jul 2017 13:48:27 -0500
MIME-Version: 1.0
In-Reply-To: <d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ptnBeRnfV2VN8mJbelkq3ISvi7tKo6Lm6"
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ptnBeRnfV2VN8mJbelkq3ISvi7tKo6Lm6
From: Eric Blake <eblake@redhat.com>
To: Richard Henderson <rth@twiddle.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: patches@linaro.org, Cornelia Huck <cohuck@redhat.com>,
 Alexander Graf <agraf@suse.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <c1526558-db87-734b-c1dd-7601ceaa682c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
 <d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
In-Reply-To: <d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 01:26 PM, Richard Henderson wrote:
> On 07/20/2017 06:31 AM, Peter Maydell wrote:
>> gdbstub.c:914:13: warning: array subscript has type 'char'
>>
>> This reflects the fact that toupper() and tolower() give
>> undefined behaviour if they are passed a value that isn't
>> a valid 'unsigned char' or EOF.
>=20
> Not saying we shouldn't use qemu_tolower etc, but this statement is not=

> true at all.  Officially, the argument to toupper and tolower is type i=
nt.

Correct. Officially, the argument to toupper is an int, but
range-constrained to the set of ints that represent either EOF or an
unsigned char value.  Calling toupper(char) (on platforms where char is
signed) is thus undefined behavior for chars < 0 (and which happen to
not coincide with EOF).

>=20
> This sounds like a bug in NetBSD -- though it may not even be that, as
> they may have done something clever and put the symbol in the middle of=

> the data.  A trick that worked before compiler warnings got smarter.

No, it is intentional of NetBSD.  In fact, the Cygwin environment also
INTENTIONALLY uses C99 magic to make gcc complain about calling
toupper(char) while being silent on toupper(int) and toupper(unsigned
char).  Because you really DO have portability problems (even if
toupper(char) _happens_ to work on most platforms, even where char is
signed, does not make it portable).  In fact, I'd love it if glibc would
also adopt the appropriate gcc magic to warn about nonportable usage of
ctype functions on signed char.

=46rom Cygwin's ctype.h:

/* These macros are intentionally written in a manner that will trigger
   a gcc -Wall warning if the user mistakenly passes a 'char' instead
   of an int containing an 'unsigned char'.  Note that the sizeof will
   always be 1, which is what we want for mapping EOF to __CTYPE_PTR[0];
   the use of a raw index inside the sizeof triggers the gcc warning if
   __c was of type char, and sizeof masks side effects of the extra __c.
   Meanwhile, the real index to __CTYPE_PTR+1 must be cast to int,
   since isalpha(0x100000001LL) must equal isalpha(1), rather than being
   an out-of-bounds reference on a 64-bit machine.  */
#define __ctype_lookup(__c) ((__CTYPE_PTR+sizeof(""[__c]))[(int)(__c)])

#define isalpha(__c)    (__ctype_lookup(__c)&(_U|_L))

>=20
> Anyway, should we poison the iso name so this doesn't creep in again?

Yes, for ALL of the ctype names where we work around the issue (and
maybe we should work around the issue in more places?)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ptnBeRnfV2VN8mJbelkq3ISvi7tKo6Lm6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllw+vsACgkQp6FrSiUn
Q2pe1QgAiQbxtPnwzrSr+84yT1L6lI5OLFZ/9pvI69zgw6c4IH1/PTYuLtxe7wy6
eOWZUFxh0hU8oWTPdMzaIsb9oFsmv/5KpLhLq9W5ouKlFBjmqmXEbrvdHE1bDJZk
KP1wpGSug7zfOXZOCchpEB03c3BNX2qDGOqRgA4xv1cCD/Cgv2sEFaRi83+nu2fe
l9TaYAxEGxLJCBebMMwOxT1uHrvRRq0KO461IjgH8PfmGVrlpHs4mB7a/HES61Dj
YKVIwh+e6hkQ5GaBSSwneGjZ10Ly9lsOFwVWYkLLxhWeXNvW1dlM/i9LNmuTk/kk
8PyFC88YANb3F7ztLbOS3M6yvKZeOg==
=QhC7
-----END PGP SIGNATURE-----

--ptnBeRnfV2VN8mJbelkq3ISvi7tKo6Lm6--
