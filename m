Received: from eggs.gnu.org ([2001:4830:134:3::10]:53707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1ckbGq-0004EV-KD
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 13:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1ckbGp-0001vw-Fp
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 13:52:40 -0500
Date: Sun, 5 Mar 2017 20:52:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170305185226.mhyz6cqpmcz5wrxv@kozik-lap>
References: <20170301182618.22395-1-krzk@kernel.org>
	<CAFEAcA-A1FFRnbuU8ev_oEF3rdtSY-ewQixSKr4+G1Op-eYSJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-A1FFRnbuU8ev_oEF3rdtSY-ewQixSKr4+G1Op-eYSJQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 0/5] hw: arm: exynos: Bring up secondary CPU
 + CPUIDLE issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>

On Thu, Mar 02, 2017 at 04:56:22PM +0000, Peter Maydell wrote:
> On 1 March 2017 at 18:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Overview of the problem
> > =======================
> > On Exynos4210, by default Linux kernel uses cpuidle driver which tries
> > to enter low power mode, called AFTR (Arm Off, Top Running).  On real
> > hardware this brings some power savings.  This AFTR mode requires second
> > CPU to be off, so the driver (coupled cpuidle driver) when system is idle:
> > 1. Turns off second CPU,
> > 2. Enters AFTR on CPU0.
> >
> > However the QEMU system is then totally unresponsive (e.g. on serial console)
> > and RCU stalls appear from time to time.  I spent some time on it and did not
> > find the real cause behind the lag.  Maybe it is because the second CPU
> > does not really power down itself and system just burns the cycles under spin
> > locks?
> 
> Possibly so. You might check whether it still has this behaviour with
> current head of git now that the multi-threaded TCG support has landed.

No changes.

> > I am quite new to QEMU.  I do not know the internals (yet), nor the design
> > how hardware should be emulated in such subtle details.
> >
> > The questions I have are:
> > 1. What is the preferred way to solve it? Maybe some a QEMU
> >    workaround to disable the cpuidle is okay?
> > 2. Is it worth implementing a proper secondary CPU power down and
> >    at the end proper AFTR cpuidle? It might be quite difficult...
> > 3. How such issues with deep sleep modes were solved for other
> >    ARM targets?
> 
> The general answer to 3 is "we don't bother implementing deep sleep
> and mostly this hasn't caused problems, but more by luck than
> judgement". Most of our boards aren't SMP; until now SMP TCG guests
> have been slower than single core so even on a nominally SMP guest
> board most users probably use (the default) -smp 1.
> 
>  The SMP board that gets most use is the "virt" board whose
> power-down functionality works through our PSCI implementation.
> The other board we have which has power-down is the imx6 one:
> hw/misc/imx6_src.c is the system reset controller model which
> does this. Basically the model of the whatever-it-is that
> causes the CPU to be powered down does it via the APIs in
> target/arm/arm-powerctl.h, which lets you turn CPUs off and on.
> When a CPU is off then we don't try to let it execute instructions,
> so it shouldn't chew host CPU at the expense of other guest CPUs.
> 
> Minor caution with that API: arm_set_cpu_on() is asynchronous,
> so if you need to tell the guest "CPU now actually booted" then
> you'll need to use an async_run_on_cpu() callback the way the
> imx6_src.c code does.
> 
> If the "CPU on" behaviour you need is "CPU powers on as if
> starting up in standard reset" rather than "CPU powers up
> and appears to start execution at given address", then it's
> probably best to improve the arm_powerctl APIs rather than
> fudge it by trying to work out the arguments to pass to
> arm_set_cpu_on() to make its "and now go to this address"
> code not do anything. (The APIs are targeted at the current
> users which both want "do things which are done in the guest
> firmware or real hardware".)

Thanks for the hints! Especially the existing implementations might be
quite useful.

The cpuidle driver expects the CPU to come up to the same resume
address. I'll see what others are doing and learn from that. 

As I mentioned before, on current master thish patchset makes everything
more laggish and unresponsive (because of cpuidle) so actually I think
the first commit could be postponed for now. At least till I figure out
solution for the cpuidle problem.


Best regards,
Krzysztof
