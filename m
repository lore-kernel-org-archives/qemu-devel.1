Received: from eggs.gnu.org ([2001:4830:134:3::10]:44120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyrQi-000518-Em
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 00:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyrQf-0005hL-CV
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 00:02:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54483)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyrQf-0005h1-2V
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 00:02:17 -0400
Date: Thu, 22 Mar 2018 00:02:15 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180322040215.GA21661@flamenco>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-13-git-send-email-cota@braap.org>
	<871sgckido.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871sgckido.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 12/14] hostfloat: support float32/64
 square root
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

On Thu, Mar 22, 2018 at 01:29:23 +0000, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Performance results for fp-bench run under aarch64-linux-user
> > on an Intel(R) Core(TM) i7-4790K CPU @ 4.00GHz host:
> >
> > - before:
> > sqrt-single: 13.23 MFlops
> > sqrt-double: 13.24 MFlops
> >
> > - after:
> > sqrt-single: 15.02 MFlops
> > sqrt-double: 15.07 MFlops
> >
> > Note that sqrt in soft-ft is relatively fast, which means
> > that fp-bench is not very sensitive to changes to sqrt's
> > emulation speed.
> 
> Weird, I thought we had slowed it down quite a bit in the re-factor as
> we eschewed the estimate step for an easier to read but slower iterative
> process. That's why I chose sqrt for my hostfp hack experiment.

Yes, my first statement ("soft-ft is relatively fast") is
wrong. Sorry about that, I thought I had deleted it but it
slipped through.

What I should have said (but decided against to keep the commit log
short) is that fp-bench doesn't do a good job in being sensitive
to the performance of the sqrt instruction, so even if got it
to take 0 time we'd still get a small speedup.

Just realised that this happens because ~50% of the inputs are
negative, which will go through some very slow paths. This ends
up showing in perf like this:

# Overhead  Command   Shared Object      Symbol
# ........  ........  .................  ...........................
#
    61.74%  fp-bench  fp-bench           [.] main
    22.58%  fp-bench  libm-2.23.so       [.] __kernel_standard
     6.22%  fp-bench  libm-2.23.so       [.] __kernel_standard_f
     5.21%  fp-bench  libm-2.23.so       [.] __sqrtf
     2.17%  fp-bench  fp-bench           [.] _init
     1.91%  fp-bench  [kernel.kallsyms]  [k] __call_rcu.constprop.70
     0.18%  fp-bench  [kernel.kallsyms]  [k] cpumask_any_but
     0.01%  perf      [kernel.kallsyms]  [k] native_iret
     0.00%  perf      [kernel.kallsyms]  [k] native_write_msr_safe

__sqrtf (which does 'sqrtss %xmm0,%xmm0') only takes 5% of the time!

I just fixed fp-bench to discard negative inputs. This looks
much better: (Note that this is fp-test-x86_64 instead of -aarch64,
which explains why the "before" throughput is different than
the one reported above)

[...]
+fma: (patch 11, i.e. sqrt still in soft-fp)
sqrt-single: 27.11 MFlops
sqrt-double: 27.17 MFlops
+sqrt: (12)
sqrt-single: 66.67 MFlops
sqrt-double: 66.79 MFlops
+cmp: (13)
sqrt-single: 126.46 MFlops
sqrt-double: 126.06 MFlops
+f32f64: (patch 14)
sqrt-single: 122.75 MFlops
sqrt-double: 126.57 MFlops

We get a >2x speedup, which is consistent with the fact
that now perf shows that sqrt takes ~60% of execution time.

Compare does matter here as well because libm is checking
sqrt's result against NaN.

I'll include this fix to fp-bench in v2.

Thanks,

		E.
