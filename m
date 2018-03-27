Received: from eggs.gnu.org ([2001:4830:134:3::10]:45890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0t1n-0002QL-CQ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0t1j-0008U0-Cl
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:08:59 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55353)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0t1j-0008Tt-7q
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:08:55 -0400
Date: Tue, 27 Mar 2018 14:08:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180327180853.GF2693@flamenco>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-9-git-send-email-cota@braap.org>
	<67b8c0f8-3fd9-ba7c-a666-d0715b5a3329@linaro.org>
	<20180322055710.GA22376@flamenco>
	<959d13eb-498e-0bd6-2553-1b621a87f1bd@linaro.org>
	<20180322195721.GA22594@flamenco> <87r2o5925d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r2o5925d.fsf@linaro.org>
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
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Tue, Mar 27, 2018 at 12:41:18 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > On Thu, Mar 22, 2018 at 14:41:05 +0800, Richard Henderson wrote:
> > (snip)
> >> Another thought re all of the soft_is_normal || soft_is_zero checks that you're
> >> performing.  I think it would be nice if we could work with
> >> float*_unpack_canonical so that we don't have to duplicate work.  E.g.
> >>
> >> /* Return true for float_class_normal && float_class_zero.  */
> >> static inline bool is_finite(FloatClass c) { return c <= float_class_zero; }
> >>
> >> float32 float32_add(float32 a, float32 b, float_status *s)
> >> {
> >>   FloatClass a_cls = float32_classify(a);
> >>   FloatClass b_cls = float32_classify(b);
> >
> > Just looked at this. It can be done, although it comes at the
> > price of some performance for fp-bench -o add:
> > 180 Mflops vs. 196 Mflops, i.e. a 8% slowdown. That is with
> > adequate inlining etc., otherwise perf is worse.
> >
> > I'm not convinced that we can gain much in simplicity to
> > justify the perf impact. Yes, we'd simplify canonicalize(),
> > but we'd probably need a float_class_denormal[*], which
> > would complicate everything else.
> >
> > I think it makes sense to keep some inlines that work on
> > the float32/64's directly.
> >
> >>   if (is_finite(a_cls) && is_finite(b_cls) && ...) {
> >>       /* do hardfp thing */
> >>   }
> >
> > [*] Taking 0, denormals and normals would be OK from correctness,
> > but we really don't want to compute ops with denormal inputs on
> > the host; it is very likely that the output will also be denormal,
> > and we'll end up deferring to soft-fp anyway to avoid
> > computing whether the underflow exception has occurred,
> > which is expensive.
> >
> >>   pa = float32_unpack(a, ca, s);
> >>   pb = float32_unpack(b, cb, s);
> >>   pr = addsub_floats(pa, pb, s, false);
> >>   return float32_round_pack(pr, s);
> >> }
> >
> > It pays off to have two separate functions (add & sub) for the
> > slow path. With soft_f32_add/sub factored out:
> >
> > $ taskset -c 0 x86_64-linux-user/qemu-x86_64 tests/fp-bench -o add
> > 197.53 MFlops
> >
> > With the above four lines (pa...return) as an else branch:
> > 169.16 MFlops
> >
> > BTW flattening makes things worse (150.63 MFlops).
> 
> That's disappointing. Did you look at the generated code? Because the
> way we are abusing __flatten__ to effectively make a compile time
> template you would hope it could pull the relevant classify bits to
> before the hard float branch and do the rest later if needed.
> 
> Everything was inline or in softfloat.c for this test right?

Yes. It's just that the classify bits are more expensive than
the alternative. This is fair enough when you look at classify().

		E.
