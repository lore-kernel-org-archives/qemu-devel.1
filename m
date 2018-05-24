Received: from eggs.gnu.org ([2001:4830:134:3::10]:36348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLpMu-0001ce-9s
	for qemu-devel@nongnu.org; Thu, 24 May 2018 08:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLpMt-0004qb-Bm
	for qemu-devel@nongnu.org; Thu, 24 May 2018 08:29:20 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLpMt-0004qF-77
	for qemu-devel@nongnu.org; Thu, 24 May 2018 08:29:19 -0400
Received: by mail-oi0-x242.google.com with SMTP id w123-v6so1261491oia.4
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 05:29:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABoDooOCO+NCjZaPVa6jFzEWztHSBDEMfsmjbJ_gOGNk3PRWNw@mail.gmail.com>
References: <20180522175629.24932-1-richard.henderson@linaro.org>
	<CABoDooOCO+NCjZaPVa6jFzEWztHSBDEMfsmjbJ_gOGNk3PRWNw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 13:28:58 +0100
Message-ID: <CAFEAcA_YoGsJ_Yuc5EFBJwnANdNXb6YQ3tV5pyDr8RD=0itXbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix helper function vs host abi for
 float16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 23 May 2018 at 06:10, Laurent Desnogues <laurent.desnogues@gmail.com> wrote:
> Some AArch64 tests I had that previously failed on a x86-64 host now pass.
>
> Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks for the testing.

> Perhaps the two occurrences of the following comment in
> target/arm/translate-a64.c could be removed along with this patch:
>
>             /* write_fp_sreg is OK here because top half of tcg_rd is zero */

I think this comment remains correct, doesn't it? At this point
we've just called a helper routine which is 'f16' return. With
this patch, that means that (by virtue of being uint16_t return
type as far as C is concerned), it will have returned a 32 bit
value into the TCGv_i32 whose bits [31:16] are zero, as the
comment says. We require that because we're using
write_fp_sreg() to update the vector register, and that function
zeroes out bits [127:32] and assumes [31:16] from its input
should all go into the vector register; but the instruction's
semantics require [127:16] to be zeroed, and it's only because
we know [31:16] are zero in the return value that we can
get away with calling write_fp_sreg() rather than requiring a
new write_fp_hreg().

thanks
-- PMM
