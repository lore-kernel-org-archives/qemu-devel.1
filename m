Received: from eggs.gnu.org ([2001:4830:134:3::10]:46641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRLYP-0005yb-0o
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRLYL-00037O-20
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:24:17 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gRLYK-00037F-Tt
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:24:13 -0500
Received: by mail-oi1-x243.google.com with SMTP id j21so16750293oii.8
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 10:24:12 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-8-minyard@acm.org>
	<20181126172058.GI2547@work-vm>
From: Corey Minyard <minyard@acm.org>
Message-ID: <9d4437e4-c9ab-913d-5ac6-e9338b26a0a8@acm.org>
Date: Mon, 26 Nov 2018 12:24:09 -0600
MIME-Version: 1.0
In-Reply-To: <20181126172058.GI2547@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2 07/12] i2c:pm_smbus: Fix state transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

On 11/26/18 11:20 AM, Dr. David Alan Gilbert wrote:
> * minyard@acm.org (minyard@acm.org) wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Transfer the state information for the SMBus registers and
>> internal data so it will work on a VM transfer.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/acpi/piix4.c           |  3 ++-
>>   hw/i2c/pm_smbus.c         | 31 +++++++++++++++++++++++++++++++
>>   hw/i2c/smbus_ich9.c       |  6 ++++--
>>   include/hw/i2c/pm_smbus.h |  2 ++
>>   4 files changed, 39 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>> index e330f24c71..313305f5a0 100644
>> --- a/hw/acpi/piix4.c
>> +++ b/hw/acpi/piix4.c
>> @@ -309,7 +309,7 @@ static const VMStateDescription vmstate_cpuhp_state = {
>>    */
>>   static const VMStateDescription vmstate_acpi = {
>>       .name = "piix4_pm",
>> -    .version_id = 3,
>> +    .version_id = 4,
> OK, so do we need to bump this version ?  Ideally you'd keep the version
> as is and let the needed do the work.


Got it, that makes sense.  Same for the comments below, I'll get all those.

Thanks,

-corey


>>       .minimum_version_id = 3,
>>       .minimum_version_id_old = 1,
>>       .load_state_old = acpi_load_old,
>> @@ -320,6 +320,7 @@ static const VMStateDescription vmstate_acpi = {
>>           VMSTATE_UINT16(ar.pm1.evt.en, PIIX4PMState),
>>           VMSTATE_UINT16(ar.pm1.cnt.cnt, PIIX4PMState),
>>           VMSTATE_STRUCT(apm, PIIX4PMState, 0, vmstate_apm, APMState),
>> +        VMSTATE_STRUCT(smb, PIIX4PMState, 4, pmsmb_vmstate, PMSMBus),
>>           VMSTATE_TIMER_PTR(ar.tmr.timer, PIIX4PMState),
>>           VMSTATE_INT64(ar.tmr.overflow_time, PIIX4PMState),
>>           VMSTATE_STRUCT(ar.gpe, PIIX4PMState, 2, vmstate_gpe, ACPIGPE),
>> diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
>> index 8793113c25..75907e1c22 100644
>> --- a/hw/i2c/pm_smbus.c
>> +++ b/hw/i2c/pm_smbus.c
>> @@ -19,6 +19,7 @@
>>    */
>>   #include "qemu/osdep.h"
>>   #include "hw/hw.h"
>> +#include "hw/boards.h"
>>   #include "hw/i2c/pm_smbus.h"
>>   #include "hw/i2c/smbus_master.h"
>>   
>> @@ -450,6 +451,36 @@ static const MemoryRegionOps pm_smbus_ops = {
>>       .endianness = DEVICE_LITTLE_ENDIAN,
>>   };
>>   
>> +static bool pm_smbus_vmstate_needed(void *opaque)
>> +{
>> +    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
>> +
>> +    return !mc->smbus_no_migration_support;
>> +}
> OK
>
>> +const VMStateDescription pmsmb_vmstate = {
>> +    .name = "pmsmb",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = pm_smbus_vmstate_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT8(smb_stat, PMSMBus),
>> +        VMSTATE_UINT8(smb_ctl, PMSMBus),
>> +        VMSTATE_UINT8(smb_cmd, PMSMBus),
>> +        VMSTATE_UINT8(smb_addr, PMSMBus),
>> +        VMSTATE_UINT8(smb_data0, PMSMBus),
>> +        VMSTATE_UINT8(smb_data1, PMSMBus),
>> +        VMSTATE_UINT32(smb_index, PMSMBus),
>> +        VMSTATE_UINT8_ARRAY(smb_data, PMSMBus, PM_SMBUS_MAX_MSG_SIZE),
>> +        VMSTATE_UINT8(smb_auxctl, PMSMBus),
>> +        VMSTATE_BOOL(i2c_enable, PMSMBus),
>> +        VMSTATE_BOOL(op_done, PMSMBus),
>> +        VMSTATE_BOOL(in_i2c_block_read, PMSMBus),
>> +        VMSTATE_BOOL(start_transaction_on_status_read, PMSMBus),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk)
>>   {
>>       smb->op_done = true;
>> diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
>> index e6d8d28194..c9b7482a54 100644
>> --- a/hw/i2c/smbus_ich9.c
>> +++ b/hw/i2c/smbus_ich9.c
>> @@ -45,10 +45,12 @@ typedef struct ICH9SMBState {
>>   
>>   static const VMStateDescription vmstate_ich9_smbus = {
>>       .name = "ich9_smb",
>> -    .version_id = 1,
>> +    .version_id = 2,
> Again, do we need to bump this?
>
>>       .minimum_version_id = 1,
>>       .fields = (VMStateField[]) {
>> -        VMSTATE_PCI_DEVICE(dev, struct ICH9SMBState),
>> +        VMSTATE_PCI_DEVICE(dev, ICH9SMBState),
>> +        VMSTATE_BOOL_V(irq_enabled, ICH9SMBState, 2),
> Can we make this a VMSTATE_BOOL_TEST (see VMSTATE_UINT64_TEST for the
> pattern) tied to the same .neede, and again we don't need to bump the
> version.
>
>> +        VMSTATE_STRUCT(smb, ICH9SMBState, 2, pmsmb_vmstate, PMSMBus),
> So that's taken care of by the .needed.
>
> Dave
>
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>> diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
>> index 7bcca97672..5075fc64fa 100644
>> --- a/include/hw/i2c/pm_smbus.h
>> +++ b/include/hw/i2c/pm_smbus.h
>> @@ -43,4 +43,6 @@ typedef struct PMSMBus {
>>   
>>   void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk);
>>   
>> +extern const VMStateDescription pmsmb_vmstate;
>> +
>>   #endif /* PM_SMBUS_H */
>> -- 
>> 2.17.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
