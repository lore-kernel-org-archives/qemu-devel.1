Received: from eggs.gnu.org ([2001:4830:134:3::10]:55185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYJ0P-0001rl-FK
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYJ0O-00057j-FL
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:29:09 -0400
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
	<d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
	<CAFEAcA8tkW2bk_O3iDO-wWpY9EUbUNkUL93OShipsvckj-jkoQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2bba3c89-e4f0-655b-c9ed-aab911beaaa7@redhat.com>
Date: Thu, 20 Jul 2017 16:29:03 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8tkW2bk_O3iDO-wWpY9EUbUNkUL93OShipsvckj-jkoQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O85mhTwOtepEwxiG6CcWot9deDBgTX3Rm"
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
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>
Cc: "patches@linaro.org" <patches@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Kamil Rytarowski <kamil@netbsd.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O85mhTwOtepEwxiG6CcWot9deDBgTX3Rm
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Cc: "patches@linaro.org" <patches@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Cornelia Huck <cohuck@redhat.com>,
 Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Kamil Rytarowski <kamil@netbsd.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <2bba3c89-e4f0-655b-c9ed-aab911beaaa7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
 <d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
 <CAFEAcA8tkW2bk_O3iDO-wWpY9EUbUNkUL93OShipsvckj-jkoQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8tkW2bk_O3iDO-wWpY9EUbUNkUL93OShipsvckj-jkoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 04:03 PM, Peter Maydell wrote:
> On 20 July 2017 at 19:26, Richard Henderson <rth@twiddle.net> wrote:
>> On 07/20/2017 06:31 AM, Peter Maydell wrote:
>>>
>>> gdbstub.c:914:13: warning: array subscript has type 'char'
>>>
>>> This reflects the fact that toupper() and tolower() give
>>> undefined behaviour if they are passed a value that isn't
>>> a valid 'unsigned char' or EOF.
>>
>>
>> Not saying we shouldn't use qemu_tolower etc, but this statement is no=
t true
>> at all.  Officially, the argument to toupper and tolower is type int.
>=20
> (I was going to quote POSIX here but I see Eric has done so already.)
>=20
>> This sounds like a bug in NetBSD -- though it may not even be that, as=
 they
>> may have done something clever and put the symbol in the middle of the=
 data.
>> A trick that worked before compiler warnings got smarter.
>=20
> https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/sys/sys/ctype_inli=
ne.h
> The implementation is
>   #define toupper(c) ((int)((_toupper_tab_ + 1)[(c)]))
>=20
> (where I assume _toupper_tab_ is the obvious array.)

In fact, if NetBSD's implementation is anything like Cygwin's, then it
is a safe bet that _toupper_tab_ is a symbol that lands in the middle of
a larger 384-byte array, such that _toupper_tab_[-1] (for (signed
char)'\xfe') happens to resolve to a valid image address, and will have
the same contents as _toupper_tab_[255] (for (unsigned char)'\xfe'),
precisely to cater to so many clueless programs have forgotten about
signed char widening to negative values (even though the standard says
the behavior is undefined, quality-of-implementation demands that you
try to do the sane thing anyway).

The table is of course only MOSTLY symmetric; there are some single-byte
locales where isspace((unsigned char)'\xff') is true but isspace(EOF) is
false (in using the magic-middle-of-array locations, _tab_[0] cannot
always match _tab_[256] in all locales).  And it is wraparound where
'\xff' collides with -1 that explains WHY C99 documents the range to be
ints corresponding to unsigned char.

Side note: NetBSD has a bug in their ctype.h.
toupper(INT64_C(0x100000001)) is supposed to be the same as toupper(1),
since POSIX requires toupper() to be available as a function (and
permits a macro as well).  A function with an int parameter must
gracefully truncate a 64-bit input down to 32-bits, so the macro must do
the same; but the NetBSD macro uses all 64 bits to dereference into
garbage memory locations.  Fortunately, no one runs into the bug in real
life because no one really tries to pass 64-bit numbers to ctype macros.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--O85mhTwOtepEwxiG6CcWot9deDBgTX3Rm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllxIJ8ACgkQp6FrSiUn
Q2rd0Qf8ChmWXpaI5CiSNi58Em0kyliT+zYnluN65o/NeUVji0ZHy7bdvYmQo4qC
leoprhcAAMi/eCygben3eWUovRc5e0KqvDvyiD0MayIVWh1V6KFCbr4FzbsBKVoJ
Ki1RePkNtyWYHDrhJHi/9H3r/Rek+24kvi+prx+/lDJrXzlLUdSrizmcgkccGJjf
uOIjeSETL9we2otnPd3rKRwhTm08T+jAiKASSaJRqTm7/N3oeKHRyLbFTt1wmEVC
sLwHWk7RyTt+VsbF1dtumag+6xaAoJaJJrz761tZhuychHfAk70x2hscBeFySPzZ
EuUY3GNbbdgqkTgUuFZQDpQD7UdgmA==
=UiQj
-----END PGP SIGNATURE-----

--O85mhTwOtepEwxiG6CcWot9deDBgTX3Rm--
