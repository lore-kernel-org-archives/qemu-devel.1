Received: from eggs.gnu.org ([209.51.188.92]:44150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDuNL-0004jd-8W
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDuNH-00076b-IW
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:17:33 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDuNF-00072n-G6
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:17:30 -0400
Received: by mail-oi1-x243.google.com with SMTP id a6so14237904oie.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 10:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190409060435.22801-1-sw@weilnetz.de>
	<4a16a810-9806-3a76-7d17-1b6282296502@linaro.org>
	<69be6fec-e9b5-d72b-d626-cf3d4b9f3720@weilnetz.de>
In-Reply-To: <69be6fec-e9b5-d72b-d626-cf3d4b9f3720@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 18:17:15 +0100
Message-ID: <CAFEAcA8=uuxAOS5PxXmuEGYqiXA+CAto-AZHSnBsQr6fbtwMYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tci: Fix some unaligned memory accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Tue, 9 Apr 2019 at 18:04, Stefan Weil <sw@weilnetz.de> wrote:
>
> On 09.04.19 08:58, Richard Henderson wrote:
> > On 4/8/19 8:04 PM, Stefan Weil wrote:
> >>  static tcg_target_ulong tci_read_i(uint8_t **tb_ptr)
> >>  {
> >> -    tcg_target_ulong value = *(tcg_target_ulong *)(*tb_ptr);
> >> +    tcg_target_ulong value;
> >
> > Ideally these would use the helpers from "qemu/bswap.h", ldl_he_p(), etc.

> That would require adding a helper for tcg_target_ulong to qemu/bswap.h.
> Or tci.c would need conditional code for reading a tcg_target_ulong.
>
> Those helpers in qemu/bswap.h are also a little bit strange:
>
> - Why does lduw_he_p return an int instead of an uint16_t?
> - Why does ldsw_he_p return an int instead of an int16_t?
> - Why does ldl_he_p return an int instead of an int32_t?

Some of these are for historical reasons (ie their API was
designed in a world where the callers were typically throwing
values around in "int"s rather than carefully using exact
right-sized types). If you want to assign the results to a
uint16_t/int16_t/int32_t this will work fine (and no cast is
required).

> - Should ldl_he_p be renamed into ldsl_he_p?
>   And why is ldul_he_p missing?

The assumption is that for 32-bit accesses there is no need
to care about the signedness of the load because the result
is going into a 32-bit variable anyway and so there is no
extension of any kind to be done.

> - Should ldq_he_p be renamed into lduq_he_p?
>   And why is ldsq_he_p missing?

Similarly here the value is being returned as a 64-bit
quantity, so there is no question of whether it should
be sign or zero extended as it isn't being extended at all.

> Using the helpers might require nasty type casts to avoid compiler
> warnings because of signed / unsigned and size mismatches.
>
> Aren't the few memcpy statements in the TCI helpers much more direct and
> understandable?

In general, no. "memcpy is a way to do an efficient possibly-unaligned
access" is an obscure bit of knowledge. We deliberately abstract this
away into these helper functions which provide APIs which are more
clearly "we need to perform a possibly-unaligned load of a specified
endianness". (It also means that if it turns out that we would
rather use __builtin_memcpy() rather than memcpy(), as we've just
discovered we need to, then there's only one file to change rather
than many.)

thanks
-- PMM
