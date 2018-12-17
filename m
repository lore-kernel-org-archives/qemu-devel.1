Received: from eggs.gnu.org ([2001:4830:134:3::10]:35842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYxxx-0008Fh-TO
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYxxu-00045v-4w
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:50:09 -0500
References: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
	<2d7d128f-6cdc-11bf-af7d-8ba8ffa4d3fb@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <143f049f-1d0f-f0d8-f9d0-23bcf015444b@ilande.co.uk>
Date: Mon, 17 Dec 2018 18:49:47 +0000
MIME-Version: 1.0
In-Reply-To: <2d7d128f-6cdc-11bf-af7d-8ba8ffa4d3fb@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/9] target/ppc: convert VMX
 instructions to use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

On 17/12/2018 17:39, Richard Henderson wrote:

> On 12/17/18 4:23 AM, Mark Cave-Ayland wrote:
>> NOTE: there are a lot of instructions that cannot (yet) be optimised to use TCG vector
>> operations, however it struck me that there may be some potential for converting
>> saturating add/sub and cmp instructions if there were a mechanism to return a set of
>> flags indicating the result of the saturation/comparison.
> 
> There are also a lot of instructions that can be converted, but aren't:
> 
> * vspltis[bhw] can use tcg_gen_gvec_dup{8,16,32}i.
> 
> * vsplt{b,h,w} can use tcg_gen_gvec_dup_mem.
> 
>   Note that you'll need something like vec_reg_offset from
>   target/arm/translate-a64.h to compute the offset of the
>   specific byte/word/long from which we are to splat.

Oh okay, thanks for the hints - I remember thinking that I couldn't much with splat,
but I'll go and look again.

> * vmr should be handled by having tcg_gen_gvec_or notice aofs == bofs.
>   For ARM, we do special case this during translation.
>   But since tcg/tcg-op.c does these things for tcg_gen_or_i64,
>   we should probably handle the same set of transformations.
> 
> * vnot would need to be handled by actually adding a tcg_gen_gvec_nor
>   and then also noticing aofs == bofs.

And I'll revisit these ones too.

> For saturation, I think the easiest thing to do is represent SAT as a
> ppc_avr_t.  We notice saturation by also computing normal arithmetic and
> comparing to see if they differ.  E.g.
> 
>     tcg_gen_gvec_add(vece, offsetof_avr_tmp,
>                      offsetof(ra), offsetof(rb), 16, 16);
>     tcg_gen_gvec_ssadd(vece, offsetof(rt),
>                        offsetof(ra), offsetof(rb), 16, 16);
>     tcg_gen_gvec_cmp(TCG_COND_NE, vece, offsetof_avr_tmp,
>                      offsetof_avr_tmp, offsetof(rt), 16, 16);
>     tcg_gen_gvec_or(vece, offsetof_avr_sat, offsetof_avr_sat,
>                     offsetof_avr_tmp, 16, 16);
> 
> You only need to convert the ppc_avr_t to a single bit when reading VSCR.

I actually had a PoC that looked somewhat similar to this, except that I abandoned
the idea as I thought that the penalty of doing the add twice (plus comparison) would
slow down everything by several orders of magnitude for backends that didn't support
vector instructions. What's the best way to handle this?

> For comparisons... that's tricky.  I wonder if there's anything better than
> 
>     tcg_gen_gvec_cmp(TCG_COND_FOO, vece, offsetof(rt),
>                      offsetof(ra), offsetof(rb), 16, 16);
>     if (rc) {
>         TCGv_i64 hi, lo, t, f;
> 
>         tcg_gen_ld_i64(hi, cpu_env, offsetof(rt));
>         tcg_gen_ld_i64(lo, cpu_env, offsetof(rt) + 8);
> 
>         tcg_gen_and_i64(t, hi, lo);
>         tcg_gen_or_i64(f, hi, lo);
>         tcg_gen_setcondi_i64(TCG_COND_EQ, t, t, -1);
>         tcg_gen_setcondi_i64(TCG_COND_EQ, f, f, 0);
> 
>         // truncate to i32, shift, or, and set to cr6.
>     }

Certainly I can look at this approach, but again my concern is that we end up heavily
penalising the backends without vector instruction support :/


ATB,

Mark.
