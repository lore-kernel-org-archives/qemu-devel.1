Received: from eggs.gnu.org ([2001:4830:134:3::10]:52930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1ennGD-00042w-DJ
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1ennGB-0000ul-Gg
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:21:45 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:36582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatoly.trosinenko@gmail.com>)
	id 1ennGB-0000uG-A6
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:21:43 -0500
Received: by mail-ot0-x242.google.com with SMTP id b15so2801213otf.3
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 07:21:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE5jQCfxjM9ykBCes0oDhrc0B6g8AC5Se39sXBsbZo=-dKQpyg@mail.gmail.com>
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
	<20180127134908.24095-2-anatoly.trosinenko@gmail.com>
	<aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
	<CAE5jQCfxjM9ykBCes0oDhrc0B6g8AC5Se39sXBsbZo=-dKQpyg@mail.gmail.com>
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Mon, 19 Feb 2018 17:26:45 +0300
Message-ID: <CAE5jQCcceAQ9qMVAATOc+yYp2gAGXwec5kegs2sX74efVVuirg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Richard Henderson <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>

Ping.
Patchwork link: http://patchwork.ozlabs.org/patch/866732/
Patchew link: http://patchew.org/QEMU/20180127134908.24095-1-
anatoly.trosinenko@gmail.com/

Original cover letter:
The code in tcg/tci.c reads some data from TCI bytecode through
pointer dereferencing. As far as I know unaligned reads in such a way are
undefined behavior and compiling with -fsanitize=undefined enumerated
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


2018-01-28 9:42 GMT+03:00 Anatoly Trosinenko <anatoly.trosinenko@gmail.com>:

> My patch is kind of trivial quick fix that just eliminates these unaligned
> reads and doesn't seem to require complicated testing supposing my code
> properly handles integer promotion (and hope it will not slow the
> interpreter down).
>
> Aligning everything, on the other hand, can not only remove the UB but
> also speed things up, but if I get it right, requires O(opcode count)
> manual work and subsequent less trivial testing that every opcode's
> argument layout match on generation and interpretation side (errors should
> be significantly localized due to present assertion on operation size,
> though). So my patch may be considered as temporary solution.
>
> In fact, I had to similarly make these unaligned reads explicit when
> porting QEMU to JavaScript because Emscripten hugely relies on absence of
> some kinds of UB such as "implicit" unaligned accesses, and such fix seemed
> to resolve this issue for me on "host with special alignment requirement".
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
