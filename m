Received: from eggs.gnu.org ([2001:4830:134:3::10]:57996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYXRb-00027N-Iu
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYXRW-0001KM-SE
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:54:11 -0400
References: <1500568341-8389-1-git-send-email-peter.maydell@linaro.org>
	<eec67af4-3f8e-bb85-0854-61f4d450f627@redhat.com>
	<CAFEAcA_mOeR2jTGuik6Jig972vMW5JTqQFaoZzt5_9oaG7D+aA@mail.gmail.com>
	<9b0800b8-b13f-67b3-a21f-96a6ba8d0a99@gmx.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0b389a73-243c-71fa-8a3f-f8af79f487b0@redhat.com>
Date: Fri, 21 Jul 2017 07:54:03 -0500
MIME-Version: 1.0
In-Reply-To: <9b0800b8-b13f-67b3-a21f-96a6ba8d0a99@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qLd2NksO1XpjvcoWfNgtViGGsLSLB6hiP"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-2.10]
 util/oslib-posix.c: Avoid warning on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, "patches@linaro.org" <patches@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qLd2NksO1XpjvcoWfNgtViGGsLSLB6hiP
From: Eric Blake <eblake@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 "patches@linaro.org" <patches@linaro.org>
Message-ID: <0b389a73-243c-71fa-8a3f-f8af79f487b0@redhat.com>
Subject: Re: [Qemu-trivial] [Qemu-devel] [PATCH for-2.10] util/oslib-posix.c:
 Avoid warning on NetBSD
References: <1500568341-8389-1-git-send-email-peter.maydell@linaro.org>
 <eec67af4-3f8e-bb85-0854-61f4d450f627@redhat.com>
 <CAFEAcA_mOeR2jTGuik6Jig972vMW5JTqQFaoZzt5_9oaG7D+aA@mail.gmail.com>
 <9b0800b8-b13f-67b3-a21f-96a6ba8d0a99@gmx.com>
In-Reply-To: <9b0800b8-b13f-67b3-a21f-96a6ba8d0a99@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 07:18 AM, Kamil Rytarowski wrote:
> On 21.07.2017 12:22, Peter Maydell wrote:
>> On 20 July 2017 at 19:26, Eric Blake <eblake@redhat.com> wrote:
>>> On 07/20/2017 11:32 AM, Peter Maydell wrote:
>>>> On NetBSD the compiler warns:
>>>> util/oslib-posix.c: In function 'sigaction_invoke':
>>>> util/oslib-posix.c:589:5: warning: missing braces around initializer=
 [-Wmissing-braces]
>>>>      siginfo_t si =3D { 0 };
>>>>      ^
>>>
>>> Uggh. That is a broken compiler.  C99 declares that 'anything =3D {0}=
' is
>>> supposed to be a valid way to zero-initialize anything.
>>>
>=20
> Not necessarily broken compiler. According to strict C standard we need=

> to initialize it in this case with "{{0}}"... which is ugly.

No, the C standard SPECIFICALLY allows for missing {}, so that {0} is
the universal zero-initializer.

  typedef union siginfo {
          char    si_pad[128];    /* Total size; for future expansion */
          struct _ksiginfo _info;
  } siginfo_t;

C99 6.7.8 Initialization paragraph 20

> If the aggregate or union contains elements or members that are aggrega=
tes or unions,
> these rules apply recursively to the subaggregates or contained unions.=
 If the initializer of
> a subaggregate or contained union begins with a left brace, the initial=
izers enclosed by
> that brace and its matching right brace initialize the elements or memb=
ers of the
> subaggregate or the contained union. Otherwise, only enough initializer=
s from the list are
> taken to account for the elements or members of the subaggregate or the=
 first member of
> the contained union; any remaining initializers are left to initialize =
the next element or
> member of the aggregate of which the current subaggregate or contained =
union is a part.

and also gives an example of missing braces being valid, in paragraph 28:=


> EXAMPLE 5
> The declaration
> struct { int a[3], b; } w[] =3D { { 1 }, 2 };
> is a definition with an inconsistently bracketed initialization. It def=
ines an array with two element
> structures: w[0].a[0] is 1 and w[1].a[0] is 2; all the other elements a=
re zero.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qLd2NksO1XpjvcoWfNgtViGGsLSLB6hiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllx+WsACgkQp6FrSiUn
Q2obrwf+Pwdxm+FhFfdFDWdwgPOBeeUVY+7indwtu6oyHiPkHyjRqB0Ghn5ufp78
7FDy+98pxz34BdzNzGUc7WwZEkLOsglkSqXU3gsAufdzHe5iebpEaqtsWpLKSuen
7JxNu1JV9Y+WUlg3ZLeGN3vIaGQ8QuKHg1QEqzfcjr1C6rxy8AAmn0Mvz+EqwcWt
8GyZjl3z9Fdade8RXX4CXgfXJS63ymku178xjcSAkeyllc9WyZAsXiGzXvsgtYLq
WAfvFZpIe2RsicyQfqCK+fGrX4WoqvBJCA5YfgMWJC2AKdThYiS5gCY3IbjNR2an
rywfU54+3R+rGdkyQY4D10tQ6Ocadw==
=QCeQ
-----END PGP SIGNATURE-----

--qLd2NksO1XpjvcoWfNgtViGGsLSLB6hiP--
