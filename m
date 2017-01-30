Received: from eggs.gnu.org ([2001:4830:134:3::10]:59458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYFBg-0002nN-9B
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYFBf-0008VW-Jz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:52:16 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-9-alex.bennee@linaro.org>
	<871svlr1od.fsf@gmail.com> <87d1f47tvv.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <27a34e99-c862-a1c3-1357-9c937914ae10@twiddle.net>
Date: Mon, 30 Jan 2017 08:52:01 -0800
MIME-Version: 1.0
In-Reply-To: <87d1f47tvv.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 08/25] tcg: drop global lock during TCG
 code execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>
Cc: mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "open list:ARM cores" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>

On 01/30/2017 01:57 AM, Alex Bennée wrote:
>>> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
>>> index a9ee7fddf9..2624d8d909 100644
>>> --- a/hw/intc/arm_gicv3_cpuif.c
>>> +++ b/hw/intc/arm_gicv3_cpuif.c
>>> @@ -14,6 +14,7 @@
>>>
>>>  #include "qemu/osdep.h"
>>>  #include "qemu/bitops.h"
>>> +#include "qemu/main-loop.h"
>>>  #include "trace.h"
>>>  #include "gicv3_internal.h"
>>>  #include "cpu.h"
>>> @@ -733,6 +734,8 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
>>>      ARMCPU *cpu = ARM_CPU(cs->cpu);
>>>      CPUARMState *env = &cpu->env;
>>>
>>> +    g_assert(qemu_mutex_iothread_locked());
>>> +
>> tcg_debug_assert()?
> Depends if KVM can use this for emulation as well (which I think it can).
> 

It probably could, but it shouldn't.  Let's not leak tcg_* into hw/.


r~
