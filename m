Received: from eggs.gnu.org ([2001:4830:134:3::10]:45882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXBu1-00024F-Ub
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXBu1-00056H-8S
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:18:45 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXBu1-000567-3X
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:18:45 -0500
Received: by mail-oi1-x241.google.com with SMTP id t204so16266861oie.7
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 13:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-12-richard.henderson@linaro.org>
	<CAFEAcA_rRBJNoSkVQXj=+-69aBOk7OAZyzUUKyvf4NQjg=g3iA@mail.gmail.com>
	<72ccb583-108e-3fe8-7064-85db93673ff9@linaro.org>
In-Reply-To: <72ccb583-108e-3fe8-7064-85db93673ff9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Dec 2018 21:18:33 +0000
Message-ID: <CAFEAcA8AfaZhEO3SUFDfr0dvAHVWZETp8tdkyxPspWx09=60wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 11/26] target/arm: Rearrange decode in
 disas_uncond_b_reg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Wed, 12 Dec 2018 at 19:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/11/18 9:40 AM, Peter Maydell wrote:
> > On Fri, 7 Dec 2018 at 10:36, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> This will enable PAuth decode in a subsequent patch.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> > This decode check should go before any code has been
> > emittede (ie before the tcg_gen_ld_i64 above it).
>
> Well, it could, but only if we duplicate the ld_i64 in the various branches
> that require it.  E.g.
>
>   if (op3 == 0 && op4 == 0) {
>       tcg_gen_ld_i64(...);
>   } else if (dc_ir_feature(aa64_pauth, s) && ...) {
>       tcg_gen_ld_i64(...);
>       if (s->pauth_active) {
>           gen_helper_auti*(...);
>       }
>   } else {
>       goto do_unallocated;
>   }
>
> which I suppose isn't so bad.
>
> What I have isn't an error because the ld_i64 will simply be deleted as dead
> code by the tcg optimizer.  But I'll rearrange anyway.

You'd also need to manually free the 'dst' TCG temp before the goto.
The A32/T32 decoder is full of (harmless) "leaked" TCG temps in
error-exit paths, which is one reason I think it's nicer to
fully decode before proceeding to codegen.

thanks
-- PMM
