Received: from eggs.gnu.org ([2001:4830:134:3::10]:56482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1efgfY-0006VR-Vf
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 01:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1efgfX-0008Qd-Nd
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 01:42:25 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatoly.trosinenko@gmail.com>)
	id 1efgfX-0008Q5-G5
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 01:42:23 -0500
Received: by mail-oi0-x244.google.com with SMTP id t78so2915933oih.4
	for <qemu-devel@nongnu.org>; Sat, 27 Jan 2018 22:42:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
	<20180127134908.24095-2-anatoly.trosinenko@gmail.com>
	<aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Sun, 28 Jan 2018 09:42:22 +0300
Message-ID: <CAE5jQCfxjM9ykBCes0oDhrc0B6g8AC5Se39sXBsbZo=-dKQpyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] tci: eliminate UB due to unaligned
 reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org

My patch is kind of trivial quick fix that just eliminates these unaligned
reads and doesn't seem to require complicated testing supposing my code
properly handles integer promotion (and hope it will not slow the
interpreter down).

Aligning everything, on the other hand, can not only remove the UB but also
speed things up, but if I get it right, requires O(opcode count) manual
work and subsequent less trivial testing that every opcode's argument
layout match on generation and interpretation side (errors should be
significantly localized due to present assertion on operation size,
though). So my patch may be considered as temporary solution.

In fact, I had to similarly make these unaligned reads explicit when
porting QEMU to JavaScript because Emscripten hugely relies on absence of
some kinds of UB such as "implicit" unaligned accesses, and such fix seemed
to resolve this issue for me on "host with special alignment requirement".


2018-01-27 19:38 GMT+03:00 Stefan Weil <sw@weilnetz.de>:

> Am 27.01.2018 um 14:49 schrieb Anatoly Trosinenko:
> > Use ldl_he_p / ldq_he_p functions instead of a plain memory access
> > through pointer.
> >
> > Signed-off-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
> > ---
> >  tcg/tci.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
>
> A better alternative might be aligning the relevant data when generating
> the bytecode. See also my comment on alignment in tcg/tci/README.
>
> Stefan
>
>


--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=90=D0=BD=D0=B0=D1=82=D0=BE=D0=BB=D0=B8=D0=B9 =D0=A2=D1=80=D0=BE=D1=81=
=D0=B8=D0=BD=D0=B5=D0=BD=D0=BA=D0=BE
e-mail: anatoly.trosinenko@gmail.com
