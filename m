Received: from eggs.gnu.org ([2001:4830:134:3::10]:45597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMHOM-0001Qe-Ji
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 13:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMHOG-00031s-TE
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 13:56:57 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMHOB-0002zF-6e
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 13:56:48 -0500
Received: by mail-yb1-f194.google.com with SMTP id p144-v6so4305965yba.11
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 10:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-6-f4bug@amsat.org>
	<20181112170351.GU12503@habkost.net>
	<CAAdtpL4234FKt685azMs_iWYNGzvhp8Mo6dJsah_Sq=JWJUaJA@mail.gmail.com>
In-Reply-To: <CAAdtpL4234FKt685azMs_iWYNGzvhp8Mo6dJsah_Sq=JWJUaJA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 19:56:29 +0100
Message-ID: <CAAdtpL5k5MiDuVggf6_HcMY08gxDHdvzSBy05L9_72pt-+BLyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, peer.adelt@hni.uni-paderborn.de, Richard Henderson <rth@twiddle.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>

> On Mon, Nov 12, 2018 at 6:03 PM Eduardo Habkost <ehabkost@redhat.com> wro=
te:
> > On Mon, Nov 12, 2018 at 12:36:16AM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > > Python internal representation is signed, so unsigned values
> > > bigger than 31-bit are interpreted as signed (and printed with
> > > a '-' signed).
> > > Mask out to force unsigned values.
> >
> > I don't understand this commit description. Python surely
> > supports integers larger than 2^31, and its internal
> > representation shouldn't matter at all:
> >
> >   >>> '0x{0:08x}'.format(0xffffffffffffffffffffffffffffffffffffffffffff=
ffffffffffffffffffffffffffffffffffffff)
> >   '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff=
ffffffffffffffff'

  >>> '0x{0:08x}'.format(-1)
  '0x-0000001'

> >
> > Can you explain how the code ends up with a negative value in the
> > `self.thismask` or `b` variables?  If `self.subs` contains
> > negative values, this is likely to break other parts of the code.
>
> I guess I misunderstood the error, thus the description is invalid.
>
> >
> > >
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > > ---
> > > TODO: display error encountered:
> > >
> > >    case 0x-1:
> > >        ....
> >
> > How can I reproduce it?
>
> $ scripts/decodetree.py /dev/null
>
>     switch (insn & 0x-0000001) {
>     }
>
> main() ->
>   build_tree(patterns, 0, outermask =3D 0) ->
>        innermask =3D ~outermask # =3D -1
>       Tree(fullmask, innermask =3D -1) ->
>         __init__(self, fm, tm =3D -1) ->
>           self.thismask =3D tm # -1
>   t.output_code(4, False, 0, 0) ->
>     sh =3D is_contiguous(self.thismask) # -1
>         output(ind, 'switch (', str_switch(self.thismask), ') {\n')
>
>         with:
>
>             def str_switch(b):
>                 return 'insn & 0x{0:08x}'.format(b)
>
> So the fix is rather:
>
> -- >8 --
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> @@ -916,7 +916,7 @@ class Tree:
>
> def build_tree(pats, outerbits, outermask):
>      # Find the intersection of all remaining fixedmask.
> -    innermask =3D ~outermask
> +    innermask =3D ~outermask & insnmask
>      for i in pats:
>          innermask &=3D i.fixedmask
>  ---
