Received: from eggs.gnu.org ([2001:4830:134:3::10]:43167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cXBJ9-0003RE-3q
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cXBJ8-0005Hf-6D
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:31:35 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <a3509663-3b80-3eab-73ac-f31027d68c87@redhat.com>
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
	<1485443388-27253-5-git-send-email-armbru@redhat.com>
	<a3509663-3b80-3eab-73ac-f31027d68c87@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 27 Jan 2017 10:31:02 -0800
Message-ID: <CAKmqyKO5AVnTe0tSQzx_j6wa46spbYD_HVbmqJJxeEQsJRbFWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 4/8] hw: Default -drive to if=none
 instead of scsi when scsi cannot work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>

On Thu, Jan 26, 2017 at 9:59 AM, Thomas Huth <thuth@redhat.com> wrote:
> On 26.01.2017 16:09, Markus Armbruster wrote:
>> Block backends defined with -drive if=scsi are meant to be picked up
>> by machine initialization code: a suitable frontend gets created and
>> wired up automatically.
>>
>> if=scsi drives not picked up that way can still be used with -device
>> as if they had if=none, but that's unclean and best avoided.  Unused
>> ones produce an "Orphaned drive without device" warning.
>>
>> A few machine types default to if=scsi, even though they don't
>> actually have a SCSI HBA.  This makes no sense.  Change their default
>> to if=none.  Affected machines:
>>
>> * aarch64/arm: realview-pbx-a9 vexpress-a9 vexpress-a15 xilinx-zynq-a9
>>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
>> Cc: Alistair Francis <alistair.francis@xilinx.com>
>> Cc: qemu-arm@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/arm/realview.c    | 1 -
>>  hw/arm/vexpress.c    | 1 -
>>  hw/arm/xilinx_zynq.c | 1 -
>>  3 files changed, 3 deletions(-)
>>
>> diff --git a/hw/arm/realview.c b/hw/arm/realview.c
>> index 8eafcca..8c11c7a 100644
>> --- a/hw/arm/realview.c
>> +++ b/hw/arm/realview.c
>> @@ -443,7 +443,6 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
>>
>>      mc->desc = "ARM RealView Platform Baseboard Explore for Cortex-A9";
>>      mc->init = realview_pbx_a9_init;
>> -    mc->block_default_type = IF_SCSI;
>>      mc->max_cpus = 4;
>>  }
>>
>> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
>> index 58760f4..5756470 100644
>> --- a/hw/arm/vexpress.c
>> +++ b/hw/arm/vexpress.c
>> @@ -751,7 +751,6 @@ static void vexpress_class_init(ObjectClass *oc, void *data)
>>
>>      mc->desc = "ARM Versatile Express";
>>      mc->init = vexpress_common_init;
>> -    mc->block_default_type = IF_SCSI;
>>      mc->max_cpus = 4;
>>  }
>>
>> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
>> index 7dac20d..3985356 100644
>> --- a/hw/arm/xilinx_zynq.c
>> +++ b/hw/arm/xilinx_zynq.c
>> @@ -323,7 +323,6 @@ static void zynq_machine_init(MachineClass *mc)
>>  {
>>      mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
>>      mc->init = zynq_init;
>> -    mc->block_default_type = IF_SCSI;
>>      mc->max_cpus = 1;
>>      mc->no_sdcard = 1;
>>  }
>
> Right, that looks like old copy-n-paste bugs from other machine types.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Yeah, I agree. This looks good to me.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

>
>
