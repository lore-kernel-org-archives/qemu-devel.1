Received: from eggs.gnu.org ([2001:4830:134:3::10]:45876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRLX8-0004w8-6W
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRLX2-0002Vu-Je
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:22:58 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gRLX2-0002Va-C9
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 13:22:52 -0500
Received: by mail-pl1-x644.google.com with SMTP id t13so14252947ply.13
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 10:22:52 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-7-minyard@acm.org>
	<20181126172308.GJ2547@work-vm>
From: Corey Minyard <minyard@acm.org>
Message-ID: <7055e173-6f4f-7954-69c7-47e0f26dfaf6@acm.org>
Date: Mon, 26 Nov 2018 12:22:47 -0600
MIME-Version: 1.0
In-Reply-To: <20181126172308.GJ2547@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2 06/12] boards.h: Ignore migration for
 SMBus devices on older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 11/26/18 11:23 AM, Dr. David Alan Gilbert wrote:
> * minyard@acm.org (minyard@acm.org) wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Migration capability is being added for pm_smbus and SMBus devices.
>> This change will allow backwards compatibility to be kept when
>> migrating back to an old qemu version.  Add a bool to the machine
>> class tho keep smbus migration from happening.  Future changes
>> will use this.
> So this is also going to have to be in the 3.0 and 3.1 machine options
> and maybe some other architectures?

I'm not sure why it would need to be in both the 3.0 and 3.1 machine 
options.
If this goes in, I'm assuming it's for 3.1 and it should only need to be 
there.
That's if it's too late for 3.0.

The pm_smbus device is also used by mips fulong.  From what I can tell, that
machine doesn't have any concept of backwards compatibility, so it seemed
save to no worry about it there.  If it weren't for that, this bool 
could go into the
PC specific structure.

Thanks,

-corey

> Dave
>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> ---
>>   hw/i386/pc_piix.c   | 1 +
>>   hw/i386/pc_q35.c    | 1 +
>>   include/hw/boards.h | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index cb28227cc3..3d1ccb1af1 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -443,6 +443,7 @@ static void pc_i440fx_2_12_machine_options(MachineClass *m)
>>       pc_i440fx_3_0_machine_options(m);
>>       m->is_default = 0;
>>       m->alias = NULL;
>> +    m->smbus_no_migration_support = true;
>>       SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
>>   }
>>   
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 90e88c9b28..0c6fca6a40 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -324,6 +324,7 @@ static void pc_q35_2_12_machine_options(MachineClass *m)
>>   {
>>       pc_q35_3_0_machine_options(m);
>>       m->alias = NULL;
>> +    m->smbus_no_migration_support = true;
>>       SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
>>   }
>>   
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index f82f28468b..65314fbe2a 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -207,6 +207,7 @@ struct MachineClass {
>>       void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
>>                                    int nb_nodes, ram_addr_t size);
>>       bool ignore_boot_device_suffixes;
>> +    bool smbus_no_migration_support;
>>   
>>       HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
>>                                              DeviceState *dev);
>> -- 
>> 2.17.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
