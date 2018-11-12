Received: from eggs.gnu.org ([2001:4830:134:3::10]:52531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMJy3-0004RO-5A
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMJxz-0001xN-4y
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:41:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gMJxy-0001fN-Ot
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:41:54 -0500
Date: Mon, 12 Nov 2018 19:41:14 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181112214114.GV12503@habkost.net>
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-6-f4bug@amsat.org>
	<20181112170351.GU12503@habkost.net>
	<CAAdtpL4234FKt685azMs_iWYNGzvhp8Mo6dJsah_Sq=JWJUaJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAAdtpL4234FKt685azMs_iWYNGzvhp8Mo6dJsah_Sq=JWJUaJA@mail.gmail.com>
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, peer.adelt@hni.uni-paderborn.de, Richard Henderson <rth@twiddle.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>

On Mon, Nov 12, 2018 at 07:52:28PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On Mon, Nov 12, 2018 at 6:03 PM Eduardo Habkost <ehabkost@redhat.com> w=
rote:
> > On Mon, Nov 12, 2018 at 12:36:16AM +0100, Philippe Mathieu-Daud=E9 wr=
ote:
> > > Python internal representation is signed, so unsigned values
> > > bigger than 31-bit are interpreted as signed (and printed with
> > > a '-' signed).
> > > Mask out to force unsigned values.
> >
> > I don't understand this commit description. Python surely
> > supports integers larger than 2^31, and its internal
> > representation shouldn't matter at all:
> >
> >   >>> '0x{0:08x}'.format(0xffffffffffffffffffffffffffffffffffffffffff=
ffffffffffffffffffffffffffffffffffffffff)
> >   '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
ffffffffffffffffff'
> >
> > Can you explain how the code ends up with a negative value in the
> > `self.thismask` or `b` variables?  If `self.subs` contains
> > negative values, this is likely to break other parts of the code.
>=20
> I guess I misunderstood the error, thus the description is invalid.
>=20
> >
> > >
> > > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > > ---
> > > TODO: display error encountered:
> > >
> > >    case 0x-1:
> > >        ....
> >
> > How can I reproduce it?
>=20
> $ scripts/decodetree.py /dev/null
>=20
>     switch (insn & 0x-0000001) {
>     }
>=20
> main() ->
>   build_tree(patterns, 0, outermask =3D 0) ->
>        innermask =3D ~outermask # =3D -1
>       Tree(fullmask, innermask =3D -1) ->
>         __init__(self, fm, tm =3D -1) ->
>           self.thismask =3D tm # -1
>   t.output_code(4, False, 0, 0) ->
>     sh =3D is_contiguous(self.thismask) # -1
>         output(ind, 'switch (', str_switch(self.thismask), ') {\n')
>=20
>         with:
>=20
>             def str_switch(b):
>                 return 'insn & 0x{0:08x}'.format(b)
>=20
> So the fix is rather:
>=20
> -- >8 --
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> @@ -916,7 +916,7 @@ class Tree:
>=20
> def build_tree(pats, outerbits, outermask):
>      # Find the intersection of all remaining fixedmask.
> -    innermask =3D ~outermask
> +    innermask =3D ~outermask & insnmask
>      for i in pats:
>          innermask &=3D i.fixedmask

Nice.  Thanks for the explanation.

This really seems to be the only place in the code where the bit
operations may generate a negative number.  All remaining usage
of the ~ operator in the code is already inside & expressions
that will ensure the result is positive.

To the alternative fix above:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
