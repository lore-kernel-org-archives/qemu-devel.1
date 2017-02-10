Received: from eggs.gnu.org ([2001:4830:134:3::10]:54822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccCrp-0003Si-Q4
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ccCro-0004Gg-Rc
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:12:09 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ccCro-0004GS-Kg
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:12:08 -0500
Received: by mail-wm0-x22b.google.com with SMTP id v77so50741770wmv.0
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 07:12:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8+3+ZwOeA0cNXF_BRs-kivTye5bj7pcRsDAsJ4S1HwTg@mail.gmail.com>
References: <1486504171-26807-1-git-send-email-wei@redhat.com>
	<CAFEAcA8+3+ZwOeA0cNXF_BRs-kivTye5bj7pcRsDAsJ4S1HwTg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 15:11:47 +0000
Message-ID: <CAFEAcA8QFWi8-XmJyiWM15y8dUqFCbaqt9wuZ70Y7_Qgsa=CyQ@mail.gmail.com>
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

On 10 February 2017 at 15:00, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 7 February 2017 at 21:49, Wei Huang <wei@redhat.com> wrote:
>> QEMU has implemented cycle count support for guest VM under TCG mode.
>> But this feature is not complete. In fact using perf inside a
>> 64-bit Linux guest VM (under TCG) can cause the following kernel panic
>> because some PMU registers are not implemented.
>>
>> [  329.445970] [<fffffe000009e600>] armv8pmu_enable_event+0x58/0x8c
>> [  329.446713] [<fffffe0000621e74>] armpmu_start+0x4c/0x74
>>
>> This patchset solves the problem by adding support for missing vPMU
>> registers. Basic perf test can work (both ACPI and DT) now under TCG
>> by applying this patchset.
>>
>> address@hidden ~]# perf stat ls
>>  Performance counter stats for 'ls':
>>
>>         226.740256      task-clock (msec)         #    0.312 CPUs utilized
>>                 76      context-switches          #    0.335 K/sec
>>                  0      cpu-migrations            #    0.000 K/sec
>>                 64      page-faults               #    0.282 K/sec
>>        186,031,410      cycles                    #    0.820 GHz      (36.40%)
>>    <not supported>      stalled-cycles-frontend
>>    <not supported>      stalled-cycles-backend
>>      <not counted>      instructions               (0.00%)
>>    <not supported>      branches
>>      <not counted>      branch-misses              (0.00%)
>>
>> V2->V3:
>>  * Remove PMXEVCNTR_EL0 support
>>  * Add read access support for PMXEVTYPER and change the CONSTRAINED
>>    UNPREDICTABLE behavior of PMXEVTYPER to RAZ/WI.
>>
>> V1->V2:
>>   * Change most PMU registers to 64bit and the behavior of PMXEVTYPER
>>   * Add support for PMXEVCNTR_EL0
>>   * Misc fixes (DT, ID_AA64DFR0_EL1, ...) under TCG mod
>
> Applied to target-arm.next, thanks.

...though patch 1 breaks compilation of linux-user targets. I've
fixed it up by moving the #ifndef CONFIG_USER_ONLY to the right
place to cover the new regdefs.

thanks
-- PMM
