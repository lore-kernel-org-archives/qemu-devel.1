Received: from eggs.gnu.org ([2001:4830:134:3::10]:59046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ez290-0000H7-2y
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ez28w-00083w-4p
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:28:46 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1ez28v-00082w-U1
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:28:42 -0400
Date: Thu, 22 Mar 2018 11:28:40 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180322152840.GB10288@flamenco>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<87woy4ij3v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87woy4ij3v.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 00/14] fp-test + hostfloat
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

On Thu, Mar 22, 2018 at 08:56:36 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> <snip>
> > For performance numbers see the last patch.
> 
> Just another random data point as we've been using himeno for our SVE
> wor:
> 
> Master:
> 
> 8:05:45  [alex@zen:~/l/q/qemu.git] master ± ./aarch64-linux-user/qemu-aarch64 sve.demo/himeno-v80
> mimax = 129 mjmax = 65 mkmax = 65
> imax = 128 jmax = 64 kmax =64
> cpu : 33.430299 sec.
> Loop executed for 200 times
> Gosa : 1.688752e-03
> MFLOPS measured : 98.519585
> Score based on MMX Pentium 200MHz : 3.052978
> 
> Host FPU:
> 
> 08:25:03 [alex@zen:~/l/q/qemu.git] master ± ./aarch64-linux-user/qemu-aarch64 sve.demo/himeno-v80
> mimax = 129 mjmax = 65 mkmax = 65
> imax = 128 jmax = 64 kmax =64
> cpu : 15.067773 sec.
> Loop executed for 200 times
> Gosa : 1.688752e-03
> MFLOPS measured : 218.581684
> Score based on MMX Pentium 200MHz : 6.773526
> 
> Given SVE also beats v80 code thanks to avoiding marshalling overhead by
> doing bigger vectors I expect that improvement to be even better. Once
> the SVE patches are re-based I'll measure them.

This is nice to see. It is possible though that this code uses other FP
instructions that this patchset doesn't speed up; perf record/report
will point to those, if any.

> By the way I've been talking to some of the people at connect about
> tracking performance over time. I got pointed to LLVM's LNT tool
> (example: https://lnt.llvm.org/) so I might see if I can get a server
> set up that we can start pushing numbers to. Have you come across any
> other such things?

I like the idea of having a server to test for performance regressions.

Perhaps the hardest bit would be to choose what benchmarks to run.
We could start with nbench and (parallel w/ MTTCG) bootup+shutdown
tests, although having access to SPEC (it's proprietary) would be nice;
as you can see below I think SPEC has a better job than nbench at
characterizing performance.

I have scripts for automatically generating perf numbers and plots;
I could share those. With them, generating plots like the following
is trivial (if you discount the time it takes for the tests to run,
heh):
  https://imgur.com/a/5P5zj
  context:
  http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg01206.html

Thanks,

		Emilio
