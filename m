Received: from eggs.gnu.org ([2001:4830:134:3::10]:39966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g86Ce-0007M0-Rj
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g86AI-0006Zg-4t
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:07:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g86AG-0006Tb-Vq
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:07:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so9566592wme.3
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 09:07:48 -0700 (PDT)
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-16-luc.michel@greensocs.com>
	<35ffbd68-f783-b6f4-18a2-dd995819c046@redhat.com>
	<CAFEAcA9vHi=qrV-Aj5ptgBQntafLGwL6VezxnmOuuR=6=Pr8cA@mail.gmail.com>
	<33c3ea72-652a-53b2-4865-830f3d7f2c3a@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3d459f14-b701-02b6-d231-fc48c509640f@redhat.com>
Date: Thu, 4 Oct 2018 18:07:45 +0200
MIME-Version: 1.0
In-Reply-To: <33c3ea72-652a-53b2-4865-830f3d7f2c3a@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 15/15] arm/xlnx-zynqmp: put APUs and
 RPUs in separate GDB groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On 03/10/2018 13:44, Luc Michel wrote:
> On 10/2/18 1:58 PM, Peter Maydell wrote:
>> On 2 October 2018 at 12:33, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>> Cc'ing more QOM involved people.
>>>
>>> On 01/10/2018 13:57, Luc Michel wrote:
>>>> Create two separate QOM containers for APUs and RPUs to indicate to the
>>>> GDB stub that those CPUs should be put in different processes.
>>>>
>>>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>>>> ---
>>>>  hw/arm/xlnx-zynqmp.c | 7 +++++--
>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
>>>> index c195040350..5e92adbc71 100644
>>>> --- a/hw/arm/xlnx-zynqmp.c
>>>> +++ b/hw/arm/xlnx-zynqmp.c
>>>> @@ -22,10 +22,11 @@
>>>>  #include "hw/arm/xlnx-zynqmp.h"
>>>>  #include "hw/intc/arm_gic_common.h"
>>>>  #include "exec/address-spaces.h"
>>>>  #include "sysemu/kvm.h"
>>>>  #include "kvm_arm.h"
>>>> +#include "exec/gdbstub.h"
>>>>
>>>>  #define GIC_NUM_SPI_INTR 160
>>>>
>>>>  #define ARM_PHYS_TIMER_PPI  30
>>>>  #define ARM_VIRT_TIMER_PPI  27
>>>> @@ -175,17 +176,18 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>>>>                                     Error **errp)
>>>>  {
>>>>      Error *err = NULL;
>>>>      int i;
>>>>      int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
>>>> +    Object *rpu_group = gdb_cpu_group_container_get(OBJECT(s));
>>>
>>> I'd rather keep this generic: not involve 'gdb' container name.
>>
>> Yes, I agree. We should structure how we construct our
>> model to follow what the hardware has (two CPU clusters
>> with 4 cores each), and then the gdb code should introspect
>> the system later to decide how it exposes things to the gdb
>> user. GDB specifics should (as far as possible) be kept out
>> of the board code.
>>
>> The fact that there are two clusters here also
>> affects other things, like whether they have the
>> same view of memory, whether they can share translated
>> code (they shouldn't but do at the moment), and so on --
>> it's not just a GDB-relevant distinction. So we should
>> be modelling it somehow, definitely. I don't have a clear
>> view how just yet.
> 
> So for now, maybe it's better to rely on an heuristic such as the one
> suggested by Philippe in the gdb code to group the CPUs. Once QEMU gains
> more supports for such heterogeneous architectures, we can remove the
> heuristic and put the proper QOM introspection code instead.

I'm not sure this is the best approach, just suggested because using
object_resolve_path_type("", TYPE_CPU, NULL) seemed to me the
quicker/easiest approach.

Eduardo: Do you have other thoughts on how to resolve those generic
containers, without involving any gdb-specific tag?

>> This probably ties into the stuff I have somewhere on
>> my todo list about supporting multiple heterogenous
>> systems. The problem with this xilinx board is that it
>> is trying to model that kind of system but we don't actually
>> properly support that in QEMU yet.
>>
>> thanks
>> -- PMM
>>
