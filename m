Received: from eggs.gnu.org ([2001:4830:134:3::10]:35282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0sHs-0000Dx-1F
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0sHo-0003mr-D6
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:21:32 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0sHo-0003mc-3y
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 13:21:28 -0400
Date: Tue, 27 Mar 2018 13:21:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180327172126.GB2693@flamenco>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-2-git-send-email-cota@braap.org>
	<871sg5aov9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871sg5aov9.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 01/14] tests: add fp-bench,
 a collection of simple floating-point microbenchmarks
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

On Tue, Mar 27, 2018 at 09:45:14 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
(snip)
> > +/*
> > + * Disable optimizations (e.g. "a OP b" outside of the inner loop) with
> > + * volatile.
> > + */
> > +#define GEN_BENCH_1OPF(NAME, FUNC, PRECISION)                           \
> > +    static void NAME(volatile PRECISION *res)                           \
> > +    {                                                                   \
> > +        uint64_t ra = SEED_A;                                           \
> > +        uint64_t i, j;                                                  \
> > +                                                                        \
> > +        for (i = 0; i < n_ops; i += OPS_PER_ITER) {                     \
> > +            volatile PRECISION a = glue(get_random_, PRECISION)(&ra);   \
> > +                                                                        \
> > +            for (j = 0; j < OPS_PER_ITER; j++) {                        \
> > +                *res = FUNC(a);                                         \
> > +            }                                                           \
> > +        }                                                               \
> > +    }
> > +
> 
> Have you had a chance to look at if this will vectorise? I have a
> similar benchmark which I compile with multiple options to test normal,
> NEON/AdvSIMD and SVE enabled loops.

It does not. I'm pretty sure the volatile there prevents the compiler
from doing anything smart. In this case I don't want the compiler
to vectorise though, but I can see how that would be a nice
benchmark to have in addition to the above.

> > +        case 'p':
> > +            precision = optarg;
> > +            if (strcmp(precision, "float") &&
> > +                strcmp(precision, "single") &&
> > +                strcmp(precision, "double")) {
> > +                fprintf(stderr, "Unsupported precision '%s'\n", precision);
> > +                exit(EXIT_FAILURE);
> 
> Supporting half-precision if the compiler does would also be useful here.

I wasn't speeding those up so didn't care to test them. But yes I can see how
that could be useful for arm/aarch64; we can add it later.

> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index ef9b88c..f6121ee 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -587,7 +587,7 @@ test-obj-y = tests/check-qnum.o tests/check-qstring.o tests/check-qdict.o \
> >  	tests/rcutorture.o tests/test-rcu-list.o \
> >  	tests/test-qdist.o tests/test-shift128.o \
> >  	tests/test-qht.o tests/qht-bench.o tests/test-qht-par.o \
> > -	tests/atomic_add-bench.o
> > +	tests/atomic_add-bench.o tests/fp-bench.o
> 
> Not sure why but "make check" didn't build this. I had to explicitly
> "make tests/fp-bench". I guess along with atomic_add_bench though these
> are explicitly guest facing tests so maybe we should move them once
> tests/tcg is working again. I'll have another run at that this week.

That was intentional; these are benchmarks rather than tests so I
wouldn't expect make check to build them or run them at all. So that was 


> >  $(test-obj-y): QEMU_INCLUDES += -Itests
> >  QEMU_CFLAGS += -I$(SRC_PATH)/tests
> > @@ -639,6 +639,7 @@ tests/test-qht-par$(EXESUF): tests/test-qht-par.o tests/qht-bench$(EXESUF) $(tes
> >  tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)
> >  tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
> >  tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
> > +tests/fp-bench$(EXESUF): tests/fp-bench.o $(test-util-obj-y)
> >
> >  tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
> >  	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
> 
> Anyway for this version:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks! I'll keep this for v3 (I sent v2 yesterday), since not
much changed.

If I had more time to work on this I'd like to have a -t soft/host flag
like in fp-test. Right now there is no such flag so we default to "host";
IOW, we end up testing the performance of the whole sausage, i.e. guest
compiler + QEMU. This is useful because it represents real-life
scenarios. However, if we tested the functions in fpu/ directly,
we'd get benchmarking that (1) would be more sensitive to the functions
we want to benchmark, and (2) would not depend on the particular
implementation of the QEMU target (e.g. i386 does not emit fma
at all!).

Thanks,

		Emilio
