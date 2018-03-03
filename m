Received: from eggs.gnu.org ([2001:4830:134:3::10]:49495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1es7UN-0005Zg-3x
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 08:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1es7UL-0006JH-LC
	for qemu-devel@nongnu.org; Sat, 03 Mar 2018 08:46:15 -0500
MIME-Version: 1.0
In-Reply-To: <CAE5jQCfxjM9ykBCes0oDhrc0B6g8AC5Se39sXBsbZo=-dKQpyg@mail.gmail.com>
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
	<20180127134908.24095-2-anatoly.trosinenko@gmail.com>
	<aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
	<CAE5jQCfxjM9ykBCes0oDhrc0B6g8AC5Se39sXBsbZo=-dKQpyg@mail.gmail.com>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Sat, 3 Mar 2018 11:54:50 +0300
Message-ID: <CAE5jQCe8O3BT=6SDdm2p7J_wxgzZTcqhyS1mfnEr=4tci9fipg@mail.gmail.com>
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
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org

Ping.
Patchwork link: http://patchwork.ozlabs.org/patch/866732/
Patchew link: http://patchew.org/QEMU/20180127134908.24095-1-anatoly.
trosinenko@gmail.com/

The code in tcg/tci.c reads some data from TCI bytecode through
pointer dereferencing. As far as I know unaligned reads in such a way are
undefined behavior and compiling with -fsanitize=3Dundefined enumerated
them as such at run-time.

I have replaced such reads with invocations of ld{l,q}_he_p.
A comment in include/qemu/bswap.h:310 suggests they should be properly
translated by the compiler. I didn't added signed/unsigned casts
since bswap.h does contain separate signed/unsigned versions
for 16-bit integers but does not for 32- and 64-bit ones, so I supposed
the developers of the bswap.h already arranged everything so
integer promotions don't mess things up. I can add casts in case I'm
not right about it.
http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg06516.html

2018-01-28 9:42 GMT+03:00 Anatoly Trosinenko <anatoly.trosinenko@gmail.com>=
:

> My patch is kind of trivial quick fix that just eliminates these unaligne=
d
> reads and doesn't seem to require complicated testing supposing my code
> properly handles integer promotion (and hope it will not slow the
> interpreter down).
>
> Aligning everything, on the other hand, can not only remove the UB but
> also speed things up, but if I get it right, requires O(opcode count)
> manual work and subsequent less trivial testing that every opcode's
> argument layout match on generation and interpretation side (errors shoul=
d
> be significantly localized due to present assertion on operation size,
> though). So my patch may be considered as temporary solution.
>
> In fact, I had to similarly make these unaligned reads explicit when
> porting QEMU to JavaScript because Emscripten hugely relies on absence of
> some kinds of UB such as "implicit" unaligned accesses, and such fix seem=
ed
> to resolve this issue for me on "host with special alignment requirement"=
.
>
>
> 2018-01-27 19:38 GMT+03:00 Stefan Weil <sw@weilnetz.de>:
>
>> Am 27.01.2018 um 14:49 schrieb Anatoly Trosinenko:
>> > Use ldl_he_p / ldq_he_p functions instead of a plain memory access
>> > through pointer.
>> >
>> > Signed-off-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
>> > ---
>> >  tcg/tci.c | 16 +++++++++++-----
>> >  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> A better alternative might be aligning the relevant data when generating
>> the bytecode. See also my comment on alignment in tcg/tci/README.
>>
>> Stefan
>>
>>
>
>
> --
> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
> =D0=90=D0=BD=D0=B0=D1=82=D0=BE=D0=BB=D0=B8=D0=B9 =D0=A2=D1=80=D0=BE=D1=81=
=D0=B8=D0=BD=D0=B5=D0=BD=D0=BA=D0=BE
> e-mail: anatoly.trosinenko@gmail.com
>



--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=90=D0=BD=D0=B0=D1=82=D0=BE=D0=BB=D0=B8=D0=B9 =D0=A2=D1=80=D0=BE=D1=81=
=D0=B8=D0=BD=D0=B5=D0=BD=D0=BA=D0=BE
e-mail: anatoly.trosinenko@gmail.com
