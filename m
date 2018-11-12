Received: from eggs.gnu.org ([2001:4830:134:3::10]:36043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1gMIt3-0006Ff-Kj
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1gMIsy-0006GV-A4
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:32:45 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1gMIsy-0006E3-0v
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:32:40 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so8676979ota.12
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 12:32:33 -0800 (PST)
References: <20181107155405.24013-1-minyard@acm.org>
	<20181107155405.24013-2-minyard@acm.org>
	<20181112174719.GI2293@work-vm>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <59507412-ed50-b9a9-0e4a-829b34a4e821@mvista.com>
Date: Mon, 12 Nov 2018 14:32:30 -0600
MIME-Version: 1.0
In-Reply-To: <20181112174719.GI2293@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 1/3] i2c:pm_smbus: Fix state transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, minyard@acm.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 11/12/18 11:47 AM, Dr. David Alan Gilbert wrote:
> * minyard@acm.org (minyard@acm.org) wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Transfer the state information for the SMBus registers and
>> internal data so it will work on a VM transfer.
> Weren't the comments from August were that we'd prefer to see this in
> a subsection so we didn't break migration compatibility.


Yeah, I screwed up here, but I realized what happened.  I started working
this some more and discovered that the eeprom didn't work on q35 at all,
and while working on that I found some other issues, and then I had
another critical thing come up and this got lost.  I apologize, I should 
have
looked back.

I will go back and address your comments from the previous emails
once I get everything sorted out.

Thanks,

-corey


> Dave
>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/acpi/piix4.c           |  3 ++-
>>   hw/i2c/pm_smbus.c         | 20 ++++++++++++++++++++
>>   hw/i2c/smbus_ich9.c       |  5 +++--
>>   include/hw/i2c/pm_smbus.h |  2 ++
>>   4 files changed, 27 insertions(+), 3 deletions(-)
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
>> index 685a2378ed..4d021bb017 100644
>> --- a/hw/i2c/pm_smbus.c
>> +++ b/hw/i2c/pm_smbus.c
>> @@ -402,6 +402,26 @@ static const MemoryRegionOps pm_smbus_ops = {
>>       .endianness = DEVICE_LITTLE_ENDIAN,
>>   };
>>   
>> +const VMStateDescription pmsmb_vmstate = {
>> +    .name = "pmsmb",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
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
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk)
>>   {
>>       smb->op_done = true;
>> diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
>> index 2a8b49e02f..4202b71da5 100644
>> --- a/hw/i2c/smbus_ich9.c
>> +++ b/hw/i2c/smbus_ich9.c
>> @@ -47,10 +47,11 @@ typedef struct ICH9SMBState {
>>   
>>   static const VMStateDescription vmstate_ich9_smbus = {
>>       .name = "ich9_smb",
>> -    .version_id = 1,
>> +    .version_id = 2,
>>       .minimum_version_id = 1,
>>       .fields = (VMStateField[]) {
>> -        VMSTATE_PCI_DEVICE(dev, struct ICH9SMBState),
>> +        VMSTATE_PCI_DEVICE(dev, ICH9SMBState),
>> +        VMSTATE_STRUCT(smb, ICH9SMBState, 2, pmsmb_vmstate, PMSMBus),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>> diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
>> index 060d3c6ac0..471345eaa2 100644
>> --- a/include/hw/i2c/pm_smbus.h
>> +++ b/include/hw/i2c/pm_smbus.h
>> @@ -35,4 +35,6 @@ typedef struct PMSMBus {
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
