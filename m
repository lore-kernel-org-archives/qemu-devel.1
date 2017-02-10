Received: from eggs.gnu.org ([2001:4830:134:3::10]:50592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccCge-0002ad-3u
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccCgd-0000pC-CJ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:00:36 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccCgc-0000ow-Tg
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:00:35 -0500
Received: by mail-wr0-x233.google.com with SMTP id 89so109880512wrr.2
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 07:00:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486504171-26807-1-git-send-email-wei@redhat.com>
References: <1486504171-26807-1-git-send-email-wei@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 15:00:13 +0000
Message-ID: <CAFEAcA8+3+ZwOeA0cNXF_BRs-kivTye5bj7pcRsDAsJ4S1HwTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH V3 0/4] Add vPMU vPMU support under TCG mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 7 February 2017 at 21:49, Wei Huang <wei@redhat.com> wrote:
> QEMU has implemented cycle count support for guest VM under TCG mode.
> But this feature is not complete. In fact using perf inside a
> 64-bit Linux guest VM (under TCG) can cause the following kernel panic
> because some PMU registers are not implemented.
>
> [  329.445970] [<fffffe000009e600>] armv8pmu_enable_event+0x58/0x8c
> [  329.446713] [<fffffe0000621e74>] armpmu_start+0x4c/0x74
>
> This patchset solves the problem by adding support for missing vPMU
> registers. Basic perf test can work (both ACPI and DT) now under TCG
> by applying this patchset.
>
> address@hidden ~]# perf stat ls
>  Performance counter stats for 'ls':
>
>         226.740256      task-clock (msec)         #    0.312 CPUs utilized
>                 76      context-switches          #    0.335 K/sec
>                  0      cpu-migrations            #    0.000 K/sec
>                 64      page-faults               #    0.282 K/sec
>        186,031,410      cycles                    #    0.820 GHz      (36.40%)
>    <not supported>      stalled-cycles-frontend
>    <not supported>      stalled-cycles-backend
>      <not counted>      instructions               (0.00%)
>    <not supported>      branches
>      <not counted>      branch-misses              (0.00%)
>
> V2->V3:
>  * Remove PMXEVCNTR_EL0 support
>  * Add read access support for PMXEVTYPER and change the CONSTRAINED
>    UNPREDICTABLE behavior of PMXEVTYPER to RAZ/WI.
>
> V1->V2:
>   * Change most PMU registers to 64bit and the behavior of PMXEVTYPER
>   * Add support for PMXEVCNTR_EL0
>   * Misc fixes (DT, ID_AA64DFR0_EL1, ...) under TCG mod

Applied to target-arm.next, thanks.

-- PMM
