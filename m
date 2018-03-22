Received: from eggs.gnu.org ([2001:4830:134:3::10]:52970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ez6L0-0004nA-Pd
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ez6Kx-0000zI-LK
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:57:26 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59571)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1ez6Kx-0000ys-E2
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:57:23 -0400
Date: Thu, 22 Mar 2018 15:57:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180322195721.GA22594@flamenco>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-9-git-send-email-cota@braap.org>
	<67b8c0f8-3fd9-ba7c-a666-d0715b5a3329@linaro.org>
	<20180322055710.GA22376@flamenco>
	<959d13eb-498e-0bd6-2553-1b621a87f1bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <959d13eb-498e-0bd6-2553-1b621a87f1bd@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 08/14] hostfloat: support float32/64
 addition and subtraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Thu, Mar 22, 2018 at 14:41:05 +0800, Richard Henderson wrote:
(snip)
> Another thought re all of the soft_is_normal || soft_is_zero checks that you're
> performing.  I think it would be nice if we could work with
> float*_unpack_canonical so that we don't have to duplicate work.  E.g.
> 
> /* Return true for float_class_normal && float_class_zero.  */
> static inline bool is_finite(FloatClass c) { return c <= float_class_zero; }
> 
> float32 float32_add(float32 a, float32 b, float_status *s)
> {
>   FloatClass a_cls = float32_classify(a);
>   FloatClass b_cls = float32_classify(b);

Just looked at this. It can be done, although it comes at the
price of some performance for fp-bench -o add:
180 Mflops vs. 196 Mflops, i.e. a 8% slowdown. That is with
adequate inlining etc., otherwise perf is worse.

I'm not convinced that we can gain much in simplicity to
justify the perf impact. Yes, we'd simplify canonicalize(),
but we'd probably need a float_class_denormal[*], which
would complicate everything else.

I think it makes sense to keep some inlines that work on
the float32/64's directly.

>   if (is_finite(a_cls) && is_finite(b_cls) && ...) {
>       /* do hardfp thing */
>   }

[*] Taking 0, denormals and normals would be OK from correctness,
but we really don't want to compute ops with denormal inputs on
the host; it is very likely that the output will also be denormal,
and we'll end up deferring to soft-fp anyway to avoid
computing whether the underflow exception has occurred,
which is expensive.

>   pa = float32_unpack(a, ca, s);
>   pb = float32_unpack(b, cb, s);
>   pr = addsub_floats(pa, pb, s, false);
>   return float32_round_pack(pr, s);
> }

It pays off to have two separate functions (add & sub) for the
slow path. With soft_f32_add/sub factored out:

$ taskset -c 0 x86_64-linux-user/qemu-x86_64 tests/fp-bench -o add
197.53 MFlops

With the above four lines (pa...return) as an else branch:
169.16 MFlops

BTW flattening makes things worse (150.63 MFlops).

Note that fp-bench only tests normal numbers. But I think it's fair
to assume that this is the path we want to speed up.

Thanks,

		E.
