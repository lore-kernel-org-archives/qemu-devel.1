Received: from eggs.gnu.org ([2001:4830:134:3::10]:45700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQvq8-0004Id-KW
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQvq4-0001P9-0e
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:20:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQvq3-0001Oa-N8
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:19:59 -0400
References: <CAGKXQyct2Y0DTbSRxCjyDJpR0eSZg3L245mce6QvmtPNJexcrw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <715c7cf5-0311-425a-9ea0-9a9986b3655b@redhat.com>
Date: Fri, 30 Jun 2017 08:19:56 -0500
MIME-Version: 1.0
In-Reply-To: <CAGKXQyct2Y0DTbSRxCjyDJpR0eSZg3L245mce6QvmtPNJexcrw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xdah3nC3l6c2bCsFJmjhRhuRFjpHuv7in"
Subject: Re: [Qemu-devel] BIT_WORD(start >> TARGET_PAGE_BITS)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xdah3nC3l6c2bCsFJmjhRhuRFjpHuv7in
From: Eric Blake <eblake@redhat.com>
To: ali saeedi <ali.saeedi56@gmail.com>, qemu-devel@nongnu.org
Message-ID: <715c7cf5-0311-425a-9ea0-9a9986b3655b@redhat.com>
Subject: Re: [Qemu-devel] BIT_WORD(start >> TARGET_PAGE_BITS)
References: <CAGKXQyct2Y0DTbSRxCjyDJpR0eSZg3L245mce6QvmtPNJexcrw@mail.gmail.com>
In-Reply-To: <CAGKXQyct2Y0DTbSRxCjyDJpR0eSZg3L245mce6QvmtPNJexcrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/30/2017 08:02 AM, ali saeedi wrote:
> Hello
> what does the following code do?
> 'unsigned long page =3D BIT_WORD(start >> TARGET_PAGE_BITS)' ?

I've noticed you've been asking a lot of questions (each as a new
thread, rather than replying to previous answers), that seem like you
are not trying very hard to read the code and find an answer for
yourself.  Rather than just answer you, I'm going to try to teach you
how to read the source and answer the question yourself.  You may also
get better answers to your future questions if you ask in the form of
"this code is confusing me, I think it means this, based on what I read
at xyz, but would like confirmation or correction" (showing WHAT you
have already researched) rather than just "what does this code do" (and
making it feel like you are off-loading the research work onto others).

First, figure out what BIT_WORD does:

$ git grep 'define BIT_WORD'

That should have only one hit, in include/qemu/bitops.h.  Reading it in
context doesn't have any more comments, but it looks like it is
computing the number of bits that are available in a word, and looks
like it is defining a word to be the type most efficiently operated on
for the current ABI (a long is 32 bits on a 32-bit OS, and 64 bits on a
64-bit OS).

It also looks like you are scaling a start address by the number of bits
in a target page.

So it probably means you are computing the index for which page 'start'
occurs on (depending on values, it might mean that 'start =3D=3D 0x0' is
page 0, 'start =3D=3D 0x10000' is page 1, and so on), where start is
initially in the form of the number of bits per page.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xdah3nC3l6c2bCsFJmjhRhuRFjpHuv7in
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVk/8AAoJEKeha0olJ0Nq/VkH/iBSGsEe9mcTu4A/zhe5Cayp
Wqvsk74E4XXDmwk3le2l8B8vrb5PPvUwa8ui0ZEmG91tj1VxIV/edSu6ZWeCcaHR
ZT0Vif8i1QQ/l+tRo6/84Hww35y/9vQlHRgR2dLGyy4ySSFMzJH5pqe3KMPKZ2ZM
C+eAaL2estfN6ARASyQ8ij5Qn4k+7ZnzvYZlQfmolbY1BlB5K3wnMNm9VJXu3Fcd
C1t+1niMWHLK7s6RL5dzzS1Jq9Gn2hWaxDwlvsN7Olh/YEgDWBOOYLoMGuUi0waM
kY2r4L+xqLY9gFrxQJCABHYDiDWVnNP6k4rVS5iez9Y1MTpIhEXhA1/hhxnTuY4=
=HLNb
-----END PGP SIGNATURE-----

--xdah3nC3l6c2bCsFJmjhRhuRFjpHuv7in--
