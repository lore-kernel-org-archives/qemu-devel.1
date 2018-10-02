Received: from eggs.gnu.org ([2001:4830:134:3::10]:35251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7JSf-0000AQ-1R
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 08:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7JJz-0003R9-Jk
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:58:36 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7JJz-0003QY-5D
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 07:58:35 -0400
Received: by mail-oi1-x243.google.com with SMTP id l197-v6so1245704oib.8
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 04:58:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <35ffbd68-f783-b6f4-18a2-dd995819c046@redhat.com>
References: <20181001115704.701-1-luc.michel@greensocs.com>
	<20181001115704.701-16-luc.michel@greensocs.com>
	<35ffbd68-f783-b6f4-18a2-dd995819c046@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 12:58:13 +0100
Message-ID: <CAFEAcA9vHi=qrV-Aj5ptgBQntafLGwL6VezxnmOuuR=6=Pr8cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Luc Michel <luc.michel@greensocs.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>

On 2 October 2018 at 12:33, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>=
 wrote:
> Cc'ing more QOM involved people.
>
> On 01/10/2018 13:57, Luc Michel wrote:
>> Create two separate QOM containers for APUs and RPUs to indicate to the
>> GDB stub that those CPUs should be put in different processes.
>>
>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>> ---
>>  hw/arm/xlnx-zynqmp.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
>> index c195040350..5e92adbc71 100644
>> --- a/hw/arm/xlnx-zynqmp.c
>> +++ b/hw/arm/xlnx-zynqmp.c
>> @@ -22,10 +22,11 @@
>>  #include "hw/arm/xlnx-zynqmp.h"
>>  #include "hw/intc/arm_gic_common.h"
>>  #include "exec/address-spaces.h"
>>  #include "sysemu/kvm.h"
>>  #include "kvm_arm.h"
>> +#include "exec/gdbstub.h"
>>
>>  #define GIC_NUM_SPI_INTR 160
>>
>>  #define ARM_PHYS_TIMER_PPI  30
>>  #define ARM_VIRT_TIMER_PPI  27
>> @@ -175,17 +176,18 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState=
 *s, const char *boot_cpu,
>>                                     Error **errp)
>>  {
>>      Error *err =3D NULL;
>>      int i;
>>      int num_rpus =3D MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQ=
MP_NUM_RPU_CPUS);
>> +    Object *rpu_group =3D gdb_cpu_group_container_get(OBJECT(s));
>
> I'd rather keep this generic: not involve 'gdb' container name.

Yes, I agree. We should structure how we construct our
model to follow what the hardware has (two CPU clusters
with 4 cores each), and then the gdb code should introspect
the system later to decide how it exposes things to the gdb
user. GDB specifics should (as far as possible) be kept out
of the board code.

The fact that there are two clusters here also
affects other things, like whether they have the
same view of memory, whether they can share translated
code (they shouldn't but do at the moment), and so on --
it's not just a GDB-relevant distinction. So we should
be modelling it somehow, definitely. I don't have a clear
view how just yet.

This probably ties into the stuff I have somewhere on
my todo list about supporting multiple heterogenous
systems. The problem with this xilinx board is that it
is trying to model that kind of system but we don't actually
properly support that in QEMU yet.

thanks
-- PMM
