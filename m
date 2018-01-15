Received: from eggs.gnu.org ([2001:4830:134:3::10]:41518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb5jR-0007Ov-Nk
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:27:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb5jN-0005rU-NS
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:27:25 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb5jN-0005qn-I7
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:27:21 -0500
Received: by mail-ot0-x244.google.com with SMTP id p16so10773897otf.1
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 06:27:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515562748-32287-1-git-send-email-rth@twiddle.net>
References: <1515562748-32287-1-git-send-email-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 14:27:00 +0000
Message-ID: <CAFEAcA8TxNTjvsqeHss=7BEm6SzwLHZ54UqDmOPMWA5z0oTsUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg/arm: Fix double-word comparisons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 10 January 2018 at 05:39, Richard Henderson <rth@twiddle.net> wrote:
> The code sequence we were generating was only good for unsigned
> comparisons.  For signed comparisions, use the sequence from gcc.
>
> Fixes booting of ppc64 firmware, with a patch changing the code
> sequence for ppc comparisons.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/arm/tcg-target.inc.c | 112 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 80 insertions(+), 32 deletions(-)
>
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 98a1253..b9890c8 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -239,10 +239,11 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int type,
>      }
>  }
>
> -#define TCG_CT_CONST_ARM  0x100
> -#define TCG_CT_CONST_INV  0x200
> -#define TCG_CT_CONST_NEG  0x400
> -#define TCG_CT_CONST_ZERO 0x800
> +#define TCG_CT_CONST_ARM     0x0100
> +#define TCG_CT_CONST_INV     0x0200
> +#define TCG_CT_CONST_NEG     0x0400
> +#define TCG_CT_CONST_INVNEG  0x0800
> +#define TCG_CT_CONST_ZERO    0x1000
>
>  /* parse target specific constraints */
>  static const char *target_parse_constraint(TCGArgConstraint *ct,
> @@ -258,6 +259,9 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
>      case 'N': /* The gcc constraint letter is L, already used here.  */
>          ct->ct |= TCG_CT_CONST_NEG;
>          break;
> +    case 'M':
> +        ct->ct |= TCG_CT_CONST_INVNEG;
> +        break;

In GCC constraint "M" is "integer in the range 0 to 32", which this clearly
isn't. Can we have a comment saying what it is? (may be worth mentioning
in particular how "rIM" differs from "rINK" -- I think the answer is that
we want to say "valid-immediate OR (valid-if-inverted AND valid-if-negated)",
whereas 'rINK' is "valid-immediate OR valid-if-inverted OR valid-if-negated".)

The code looks OK to me. I'm guessing the sparc guest failure is
just because we now generate more code for some of the comparison
cases and that doesn't fit in the buffer...

We could avoid the annoying "load LE/GE immediates to tempreg"
extra code by having tcg_out_cmp2() return a flag to tell
the caller which way round to put the conditions for its two
conditional ARITH_MOV insns (for setcond2) or which condition
to use for the branch (brcond2), right?

thanks
-- PMM
