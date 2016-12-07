Received: from eggs.gnu.org ([2001:4830:134:3::10]:49058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cEek5-0004BF-Uj
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cEek5-00076o-52
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 11:06:49 -0500
MIME-Version: 1.0
In-Reply-To: <CALicx6t=C9dmXY_nQgumgr11qAydr1Q6VseWCBBNy9uEFXaCGA@mail.gmail.com>
References: <1479904764-15532-1-git-send-email-vijay.kilari@gmail.com>
	<1479904764-15532-5-git-send-email-vijay.kilari@gmail.com>
	<CAFEAcA_O+72r2aMdMiVD-mnH41Y9YMaLRvcj1hxrbj_CNRk1Sw@mail.gmail.com>
	<CALicx6tkFEADfEK80gbbB5s6fM5xAvCUwoG26AqMyn2stQcj2A@mail.gmail.com>
	<CAFEAcA9j12HCoZNCpTt+07=+sSz6vM=Zu7rR6EN-SCq1h9GMww@mail.gmail.com>
	<CALicx6tPXCyxF_2d6oVzQrmc5W8C4R+8i4gPZWWYBGY9PWdJeA@mail.gmail.com>
	<CAFEAcA82q1jRrNwR_7Nya3Dm2knOCsx54kovaN3NS8J_9eQFeA@mail.gmail.com>
	<CALicx6t=C9dmXY_nQgumgr11qAydr1Q6VseWCBBNy9uEFXaCGA@mail.gmail.com>
From: Vijay Kilari <vijay.kilari@gmail.com>
Date: Wed, 7 Dec 2016 21:35:17 +0530
Message-ID: <CALicx6voxE6Bwz50dHuPhB-ErfAw0kKu6L3KBJKidDtS5Z0+qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v6 4/4] hw/intc/arm_gicv3_kvm: Reset GICv3
 cpu interface registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

Hi Peter,

On Thu, Dec 1, 2016 at 3:40 PM, Vijay Kilari <vijay.kilari@gmail.com> wrote:
> On Wed, Nov 30, 2016 at 10:29 PM, Peter Maydell
> <peter.maydell@linaro.org> wrote:
>> On 30 November 2016 at 16:23, Vijay Kilari <vijay.kilari@gmail.com> wrote:
>>> On Mon, Nov 28, 2016 at 10:05 PM, Peter Maydell
>>> <peter.maydell@linaro.org> wrote:
>>>> Still I would prefer it if we did this with the same
>>>> mechanism for both TCG and KVM. A generic mechanism for
>>>> "let the CPU reset trigger reset of many other devices in the
>>>> system" isn't widely useful because real hardware doesn't
>>>> have that kind of action-at-a-distance behaviour.
>>>
>>> To make direct call from arm_cpu_reset() to reset CPUIF,
>>> I could not find a way to get GICv3CPUState from CPUARMState or
>>> ARMCPU struct.
>>
>> You don't want to directly call from arm_cpu_reset().
>> Coprocessor regs registered via cpregs can have
>> reset functions, which get called automatically.
>> This is what the TCG gicv3 code already does to reset
>> the CPU i/f, the relevant code just needs to be
>> arranged so it's used for KVM too.
>
> Yes, the reset functions of cpregs get CPUARMState as parameter
> and still we cannot fetch GICv3CPUState from it.

I propose to add new variable to CPUARMState to store
GICV3CPUState to able to access when cpregs reset is called.
Is it ok?

>
> The TCG code in arm_gicv3_cpuif.c is rely on el_hook to get
> GICv3CPUState.
>>
>>> Any idea how to get GICv3CPUState?
>>>
>>> In  hw/intc/arm_gicv3_cpuif.c implementation,
>>> el_hook function is registered to fetch GICv3CPUState
>>> from CPUARMState struct, but it is for TCG
>>
>> Yes, you don't need the el hook.
>
> Without this is there a way to get GICv3CPUState for KVM?
> I am not familiar with this code.
>
>>
>> thanks
>> -- PMM
