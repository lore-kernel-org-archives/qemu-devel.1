Received: from eggs.gnu.org ([2001:4830:134:3::10]:58994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMFd6-0007ct-6d
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMFcy-0005eF-Cs
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:04:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gMFcy-0005dq-4W
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:03:56 -0500
Date: Mon, 12 Nov 2018 15:03:51 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181112170351.GU12503@habkost.net>
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181111233622.8976-6-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 05/11] decodetree: Force Python to
 print unsigned values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

On Mon, Nov 12, 2018 at 12:36:16AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Python internal representation is signed, so unsigned values
> bigger than 31-bit are interpreted as signed (and printed with
> a '-' signed).
> Mask out to force unsigned values.

I don't understand this commit description. Python surely
supports integers larger than 2^31, and its internal
representation shouldn't matter at all:

  >>> '0x{0:08x}'.format(0xffffffffffffffffffffffffffffffffffffffffffffff=
ffffffffffffffffffffffffffffffffffff)
  '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
ffffffffffffff'

Can you explain how the code ends up with a negative value in the
`self.thismask` or `b` variables?  If `self.subs` contains
negative values, this is likely to break other parts of the code.

>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> TODO: display error encountered:
>=20
>    case 0x-1:
>        ....

How can I reproduce it?

> ---
>  scripts/decodetree.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 5dea15e7a5..08aa52d544 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -900,12 +900,12 @@ class Tree:
>              def str_case(b):
>                  return '0x{0:08x}'.format(b)
> =20
> -        output(ind, 'switch (', str_switch(self.thismask), ') {\n')
> +        output(ind, 'switch (', str_switch(self.thismask & insnmask), =
') {\n')
>          for b, s in sorted(self.subs):
>              assert (self.thismask & ~s.fixedmask) =3D=3D 0
>              innermask =3D outermask | self.thismask
>              innerbits =3D outerbits | b
> -            output(ind, 'case ', str_case(b), ':\n')
> +            output(ind, 'case ', str_case(b & insnmask), ':\n')
>              output(ind, '    /* ',
>                     str_match_bits(innerbits, innermask), ' */\n')
>              s.output_code(i + 4, extracted, innerbits, innermask)
> --=20
> 2.17.2
>=20

--=20
Eduardo
