Received: from eggs.gnu.org ([2001:4830:134:3::10]:48777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezLDQ-0003wd-Pa
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 07:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezLDP-0008RQ-PI
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 07:50:36 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezLDP-0008QP-G4
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 07:50:35 -0400
Received: by mail-oi0-x242.google.com with SMTP id f186-v6so10069416oig.4
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 04:50:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521777509-22896-1-git-send-email-onursahin08@gmail.com>
References: <1521777509-22896-1-git-send-email-onursahin08@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 11:50:14 +0000
Message-ID: <CAFEAcA9G3xVjmjys2R4-NXRHiZwLVLRO7ZQDZ0AhNMHHFhHV8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target-arm: Check undefined
 opcodes for SWP in A32 decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Onur Sahin <onursahin08@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 23 March 2018 at 03:58, Onur Sahin <onursahin08@gmail.com> wrote:
> Hi all,
>
> I have noticed that the decoding part in ARM/A32 does not verify the
> opcodes for SWP instructions. The opcode field ([23:20]) for SWP
> instructions should be 0 or 4, and QEMU does not check against these
> values.
>
> Other opcode values less than 8 are Undefined within the encoding
> space of sychronization primitives (e.g., SWP, LDREX*). See section
> A5.2.10 of ARMv7-A manual for reference. Because of the missing opcode
> check, QEMU happily executes these Undefined cases as a SWP instruction.
>
> The following fix adds proper opcode checks before assuming a valid SWP.
>
> Best,
> Onur
>
> Signed-off-by: Onur Sahin <onursahin08@gmail.com>

Yes, we've been historically a bit lax with our arm decoding.
It's good to tighten it up, I think. Thanks for sending this patch;
I have some review comments below.

> ---
>  target-arm/translate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target-arm/translate.c b/target-arm/translate.c
> index bd5d5cb..fb31c12 100644
> --- a/target-arm/translate.c
> +++ b/target-arm/translate.c
> @@ -8831,7 +8831,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                              }
>                          }
>                          tcg_temp_free_i32(addr);
> -                    } else {
> +                    } else if (!(insn & 0x00B00000)) {

I think we have already checked bit 23, so we don't need to check it again
(this is the else case of the "if (insn & (1 << 23))" condition).
I think we should also be checking bits [11:8] are zeroes. These are
"(0)" in the instruction description, which means that the instruction
is UNPREDICTABLE if those are not zero (see A5.1.2 "UNDEFINED and
UNPREDICTABLE instruction set space"). It's architecturally permitted
to not check those bits, but elsewhere in the decoder we generally
prefer to UNDEF on the UNPREDICTABLE cases.

So I would make this condition
    } else if ((insn & 0x00300f00) == 0) {

I have been adding comments to the decoder as I modify it which
indicate what bits have been decoded at various points. In this case
I think we should add
       /* 0bcccc_0001_0x00_xxxx_xxxx_0000_1001_xxxx
        *  - SWP, SWPB
        */

just inside this else if () { ...} block.

(and then you can delete the "SWP instruction" comment.)

>                          /* SWP instruction */

What version of QEMU did you make this patch against? The current
git master has some other lines between the '} else {' and this
comment. Generally patches should be against git master, as that's
where all our development happens.

>                          rm = (insn) & 0xf;
>
> @@ -8852,6 +8852,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                          tcg_temp_free_i32(addr);
>                          store_reg(s, rd, tmp2);
>                      }
> +                    else {

Minor style nit: the "else {" should go on the same line as the
preceding "}".

> +                        goto illegal_op;
> +                    }
>                  }
>              } else {
>                  int address_offset;
> --
> 1.8.3.1

thanks
-- PMM
