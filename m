Received: from eggs.gnu.org ([2001:4830:134:3::10]:43368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0stU-0005B7-Kq
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0stQ-0004Fu-KX
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:00:24 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0stQ-0004FZ-BL
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:00:20 -0400
Date: Tue, 27 Mar 2018 14:00:18 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180327180018.GC2693@flamenco>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-3-git-send-email-cota@braap.org>
	<87zi2t968i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zi2t968i.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 02/14] tests: add fp-test,
 a floating point test suite
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

On Tue, Mar 27, 2018 at 11:13:01 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > This will allow us to run correctness tests against our
> > FP implementation. The test can be run in two modes (called
> > "testers"): host and soft. With the former we check the results
> > and FP flags on the host machine against the model.
> > With the latter we check QEMU's fpu primitives against the
> > model. Note that in soft mode we are not instantiating any
> > particular CPU (hence the HW_POISON_H hack to avoid macro poisoning);
> > for that we need to run the test in host mode under QEMU.
> >
> > The input files are taken from IBM's FPGen test suite:
> > https://www.research.ibm.com/haifa/projects/verification/fpgen/
> >
> > I see no license file in there so I am just downloading them
> > with wget. We might want to keep a copy on a qemu server though,
> > in case IBM takes those files down in the future.
> 
> Hmm the files themselves have:
> 
>   Copyright of IBM Corp. 2005
> 
> So I'm not sure we can take them into any of our source trees.

Yes I don't think committing these would be appropriate. I guess keeping
our own copy of the tarball somewhere would be OK, though. My worry is
that at some point IBM's server will die and we'll have no more test
files.

> However what are we testing here?

fp-test allows you to test against a model. This model can be anything;
for now, I grabbed model files from IBM's fpgen, which tests for
IEEE compliance.

We can add more model files; the muladd tests are an example of that.

> Do we just want to test our implementation is IEEE compliant or should
> we generate our own test cases on validated hardware to check that our
> emulation of a guest is correct (e.g. correct modulo the valid
> variations in the standard)?

I think what we want is a large core of tests that test the standard,
plus a smaller set of tests that cover ISA particularities. I think
the IBM models are a good starting point for the former -- note
though that some operations are not covered in the models (despite
the syntax description specifying an op for them, e.g. int-to-float
conversions.)

> > The "IBM" syntax of those files (for now the only syntax supported
> > in fp-test) is documented here:
> > https://www.research.ibm.com/haifa/projects/verification/fpgen/papers/ieee-test-suite-v2.pdf
> >
> > Note that the syntax document has some inaccuracies; the appended
> > parsing code works around some of those.
> >
> > The exception flag (-e) is important: many of the optimizations
> > included in the following commits assume that the inexact flag
> > is set, so "-e x" is necessary in order to test those code paths.
> >
> > The whitelist flag (-w) points to a file with test cases to be ignored.
> > I have put some whitelist files online, but we should have them
> > on a QEMU-related server.
> >
> > Thus, a typical of fp-test is as follows:
> >
> >   $ cd qemu/build/tests/fp-test
> >   $ make -j && \
> > 	./fp-test -t soft ibm/*.fptest \
> > 	-w whitelist.txt \
> > 	-e x
> 
> So this is a unit test of our code rather than a test program running
> under QEMU?

Having the -t host/soft flags allows you flexibility in what to test.

With "host" mode, you're generating a binary that knows nothing
about QEMU, i.e. all its FP operations are native. You can use this
to (1) figure out whether your host diverts from the model [hopefully
it doesn't in anything substantial], and (2) test whether QEMU mimics
the corresponding host by running the binary under *-linux-user.

With "soft" mode, you're testing QEMU's soft-fp implementation. This
allows you to check it against the model. Note that it doesn't let
you check anything specific about a target CPU (hence the HW_POISON_H
hack); for this you'd have to go to point (2) above. Here instead we're
checking QEMU's FP implementation directly against the models.

>  I noted running under x86-64-linux-user fails pretty quick.

As I wrote below, I think this is due to bugs in the i386 target.

On a host x86_64 machine:
$ ./fp-test -t host ibm/* -w whitelist.txt -w whitelist-tininess-after.txt
All tests OK.
Tests passed: 74426. Not handled: 53297, whitelisted: 2748

$ ../../x86_64-linux-user/qemu-x86_64 ./fp-test -t host \
	ibm/* -w whitelist.txt -w whitelist-tininess-after.txt -n 2>/dev/null
Tests failed: 57479. Parsing: 0, result:14, flags:57465
Tests passed: 16947. Not handled: 53297, whitelisted: 2748

The results are different when run under QEMU, which means
this target is not doing things correctly (despite -t soft
passing).

> If so we really should be building this automatically in make check.

Yes, passing -soft mode would certainly be valuable and trivial
to integrate since there is nothing built that is target-dependent.

(snip)
> > --- /dev/null
> > +++ b/tests/fp-test/fp-test.c
(snip)
> > +enum precision {
> > +    PREC_FLOAT,
> > +    PREC_DOUBLE,
> > +    PREC_QUAD,
> > +    PREC_FLOAT_TO_DOUBLE,
> > +};
> 
> Again we will want to include half-precision.

Sure. We'll need to come up with model files for that though.

(snip)
> > +    }
> > +    if (unlikely(!strcmp("-inf", p) || !strcmp("-Inf", p))) {
> > +        ret->val = fp_choose(prec, 0xff800000, 0xfff0000000000000);
> > +        return 0;
> > +    }
> > +
> > +    len = strlen(p);
> > +
> > +    if (strchr(p, 'P')) {
> 
> Given we have already strlen'ed should we use memchr(p, 'P', len) or
> even strchrnul(p,'P') with a check we haven't run over the end? OR maybe
> use glib's string stuff instead.

I think in this case strchr is warranted; p points to a valid string
(otherwise strlen would also be dangerous).

(snip)
> > +/* Syntax of IBM FP test cases:
> > + * https://www.research.ibm.com/haifa/projects/verification/fpgen/syntax.txt
> > + */
> > +static enum error ibm_test_line(const char *line)
> > +{
> > +    struct test_op t;
> > +    /* at most nine fields; this should be more than enough for each field */
> > +    char s[9][64];
> > +    char *p;
> > +    int n, field;
> > +    int i;
> > +
> > +    /* data lines start with either b32 or d(64|128) */
> > +    if (unlikely(line[0] != 'b' && line[0] != 'd')) {
> > +        return ERROR_COMMENT;
> > +    }
> > +    n = sscanf(line, "%63s %63s %63s %63s %63s %63s %63s %63s %63s",
> > +               s[0], s[1], s[2], s[3], s[4], s[5], s[6], s[7], s[8]);
> > +    if (unlikely(n < 5 || n > 9)) {
> > +        return ERROR_INPUT;
> > +    }
> 
> Personally I find g_strsplit(line, " ", 9) and g_strfreev() handy for
> this sort of parsing.

I figured the above might be simpler since I wouldn't have to worry
about freeing memory. Also, scanf directly returns n, which is used
later.

Thanks,

		E.
