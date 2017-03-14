Received: from eggs.gnu.org ([2001:4830:134:3::10]:47015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnpjF-0002Fj-O4
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cnpjC-0000gW-Mw
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:55:21 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cnpjC-0000fT-G5
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:55:18 -0400
Received: by mail-wr0-x235.google.com with SMTP id g10so128205671wrg.2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:55:18 -0700 (PDT)
References: <20170313180432.7067-1-krzk@kernel.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170313180432.7067-1-krzk@kernel.org>
Date: Tue, 14 Mar 2017 16:55:34 +0000
Message-ID: <87mvcnpzll.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 0/5] hw: arm: exynos: Bring
 up secondary CPU + CPUIDLE issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>


Krzysztof Kozlowski <krzk@kernel.org> writes:

> Hi,
>
<snip>
>
> Overview of the problem
> =======================
> On Exynos4210, by default Linux kernel uses cpuidle driver which tries
> to enter low power mode, called AFTR (Arm Off, Top Running).  On real
> hardware this brings some power savings.  This AFTR mode requires second
> CPU to be off, so the driver (coupled cpuidle driver) when system is idle:
> 1. Turns off second CPU,
> 2. Enters AFTR on CPU0.
>
> However the QEMU system is then totally unresponsive (e.g. on serial console)
> and RCU stalls appear from time to time.  I spent some time on it and did not
> find the real cause behind the lag.  Maybe it is because the second CPU
> does not really power down itself and system just burns the cycles under spin
> locks?

Was this tested post the MTTCG merge? Maybe there is an interaction
between power saving/halting the vCPU?

I mention this because I already made some minor tweaks for handing the
WFI instruction in MTTCG. See commit c22edfebff. You can test this by
forcing the original behaviour by adding:

  -accel tcg,thread=single

to your command line.

>
> Looking at recent stable kernels:
>  - 3.10, 3.16 - works fine with two CPUs (no CPUIDLE driver),
>  - 4.1 and newer - stalls and are unresponsive due to CPUIDLE being enabled.
>
> The cpuidle driver is not relying on DTS. It is just enabled in exynos_defconfig
> and works.
>
> Workarounds
> ===========
> 1. Boot with only 1 cpu
> 2. Build a kernel with disabled CONFIG_CPU_IDLE
>
>
>
> Best regards,
> Krzysztof
>
> Krzysztof Kozlowski (5):
>   hw/intc/exynos4210_gic: Fix GIC memory mappings for secondary CPU
>   hw/intc/exynos4210_gic: Use more meaningful name for local variable
>   hw/timer/exynos4210_mct: Fix checkpatch style errors
>   hw/timer/exynos4210_mct: Cleanup indentation and empty new lines
>   hw/timer/exynos4210_mct: Remove unused defines
>
>  hw/intc/exynos4210_gic.c  | 33 +++++++++++++++++++------------
>  hw/timer/exynos4210_mct.c | 50 ++++++++++++++++++++---------------------------
>  2 files changed, 41 insertions(+), 42 deletions(-)


--
Alex Bennée
