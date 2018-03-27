Received: from eggs.gnu.org ([2001:4830:134:3::10]:49291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0t8r-0005Na-Be
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0t8o-00040y-2m
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:16:17 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46629)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0t8n-00040k-Tp
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:16:14 -0400
Date: Tue, 27 Mar 2018 14:16:12 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180327181612.GG2693@flamenco>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-8-git-send-email-cota@braap.org>
	<87po3p91r7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87po3p91r7.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 07/14] fpu: introduce hostfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Tue, Mar 27, 2018 at 12:49:48 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> 
> > The appended paves the way for leveraging the host FPU for a subset
> > of guest FP operations. For most guest workloads (e.g. FP flags
> > aren't ever cleared, inexact occurs often and rounding is set to the
> > default [to nearest]) this will yield sizable performance speedups.
> >
> > The approach followed here avoids checking the FP exception flags register.
> > See the comment at the top of hostfloat.c for details.
> >
> > This assumes that QEMU is running on an IEEE754-compliant FPU and
> > that the rounding is set to the default (to nearest). The
> > implementation-dependent specifics of the FPU should not matter; things
> > like tininess detection and snan representation are still dealt with in
> > soft-fp. However, this approach will break on most hosts if we compile
> > QEMU with flags such as -ffast-math. We control the flags so this should
> > be easy to enforce though.
> 
> The thing I would avoid is generating is any x87 instructions as we can
> get weird effects if the compiler ever decides to stash a signalling NaN
> in an x87 register.

We take care not to do hardfloat on operands that might result in NaNs.
So this should not be a concern.

> Anyway perhaps -fno-fast-math should be explicit when building fpu/* code?

That's a fair suggestion. There are plenty of other flags though that could
ruin this approach, so I'm not sure how effective this would be.

Also, we should be careful not to sneak in things like
_MM_SET_FLUSH_ZERO_MODE(_MM_FLUSH_ZERO_ON) 
in the QEMU binary. Not sure we can guarantee this is avoided unless
we had a runtime check =)

> > The licensing in softfloat.h is complicated at best, so to keep things
> > simple I'm adding this as a separate, GPL'ed file.
> 
> I don't think we need to worry about this. It's fine to add GPL only
> stuff to softfloat.c and since the re-factoring (or before really) we
> "own" this code and are unlikely to upstream anything.
> 
> My preference would be to include this all in softfloat.c unless there
> is a very good reason not to.

Yes I did this in v2 after reading the license etc.

(snip)
> > +++ b/fpu/hostfloat.c
(snip)
> > +#define GEN_INPUT_FLUSH(soft_t)                                         \
> > +    static inline __attribute__((always_inline)) void                   \
> > +    soft_t ## _input_flush__nocheck(soft_t *a, float_status *s)         \
(snip)
> > +        soft_t ## _input_flush__nocheck(c, s);                          \
> > +    }
> > +
> > +GEN_INPUT_FLUSH(float32)
> > +GEN_INPUT_FLUSH(float64)
> 
> Having spent time getting rid of a bunch of macro expansions I'm wary of
> adding more in. However for these I guess it's kind of marginal.

Then you won't like v2 :-(

I don't like macros either but in this case they might be a necessary evil.
I left a lot of macros in there because it'll let us retain performance
and also easily support things like half/quad precision, if we ever want to.

Thanks,

		Emilio
