Received: from eggs.gnu.org ([2001:4830:134:3::10]:34000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ccGM5-0001fV-4x
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1ccGM4-0000ZE-41
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:55:37 -0500
References: <1486504171-26807-1-git-send-email-wei@redhat.com>
	<CAFEAcA8+3+ZwOeA0cNXF_BRs-kivTye5bj7pcRsDAsJ4S1HwTg@mail.gmail.com>
	<CAFEAcA8QFWi8-XmJyiWM15y8dUqFCbaqt9wuZ70Y7_Qgsa=CyQ@mail.gmail.com>
From: Wei Huang <wei@redhat.com>
Message-ID: <513c93db-34fc-ab17-aa12-fb956f8f1467@redhat.com>
Date: Fri, 10 Feb 2017 12:55:28 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8QFWi8-XmJyiWM15y8dUqFCbaqt9wuZ70Y7_Qgsa=CyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3 0/4] Add vPMU vPMU support under TCG mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>



On 02/10/2017 09:11 AM, Peter Maydell wrote:
> On 10 February 2017 at 15:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 7 February 2017 at 21:49, Wei Huang <wei@redhat.com> wrote:
>>> QEMU has implemented cycle count support for guest VM under TCG mode.
>>> But this feature is not complete. In fact using perf inside a
>>> 64-bit Linux guest VM (under TCG) can cause the following kernel panic
>>> because some PMU registers are not implemented.
>>>
>>> [  329.445970] [<fffffe000009e600>] armv8pmu_enable_event+0x58/0x8c
>>> [  329.446713] [<fffffe0000621e74>] armpmu_start+0x4c/0x74
>>>
>>> This patchset solves the problem by adding support for missing vPMU
>>> registers. Basic perf test can work (both ACPI and DT) now under TCG
>>> by applying this patchset.
>>>
>>> address@hidden ~]# perf stat ls
>>>  Performance counter stats for 'ls':
>>>
>>>         226.740256      task-clock (msec)         #    0.312 CPUs utilized
>>>                 76      context-switches          #    0.335 K/sec
>>>                  0      cpu-migrations            #    0.000 K/sec
>>>                 64      page-faults               #    0.282 K/sec
>>>        186,031,410      cycles                    #    0.820 GHz      (36.40%)
>>>    <not supported>      stalled-cycles-frontend
>>>    <not supported>      stalled-cycles-backend
>>>      <not counted>      instructions               (0.00%)
>>>    <not supported>      branches
>>>      <not counted>      branch-misses              (0.00%)
>>>
>>> V2->V3:
>>>  * Remove PMXEVCNTR_EL0 support
>>>  * Add read access support for PMXEVTYPER and change the CONSTRAINED
>>>    UNPREDICTABLE behavior of PMXEVTYPER to RAZ/WI.
>>>
>>> V1->V2:
>>>   * Change most PMU registers to 64bit and the behavior of PMXEVTYPER
>>>   * Add support for PMXEVCNTR_EL0
>>>   * Misc fixes (DT, ID_AA64DFR0_EL1, ...) under TCG mod
>>
>> Applied to target-arm.next, thanks.
> 
> ...though patch 1 breaks compilation of linux-user targets. I've
> fixed it up by moving the #ifndef CONFIG_USER_ONLY to the right
> place to cover the new regdefs.

My bad. I normally did compilation for all targets + "make check" before
sending patches out. But on that particular machine, qemu was configured
for aarch64-softmmu only, thus missing this compilation error ...

> 
> thanks
> -- PMM
> 
