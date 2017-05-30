Received: from eggs.gnu.org ([2001:4830:134:3::10]:43494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFfXM-0004RL-Oj
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFfXJ-0002K0-HR
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:42:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dFfXJ-0002Jw-8N
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:42:05 -0400
References: <1494430493-23119-1-git-send-email-thuth@redhat.com>
	<40588676-2a57-c17f-1f05-00c017da18ba@redhat.com>
	<1496140501.4100.5.camel@redhat.com>
	<20170530130207.249299e7@nial.brq.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ea0b4874-61a7-4ea8-f381-41ebc232ce02@redhat.com>
Date: Tue, 30 May 2017 13:41:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170530130207.249299e7@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, dgilbert@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On 30.05.2017 13:02, Igor Mammedov wrote:
> On Tue, 30 May 2017 12:35:01 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
>>   Hi,
>>
>>>>  v2:
>>>>  - Deprecate machines up to pc-1.2
>>>>
>>>>  hw/i386/pc_piix.c | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>> index 9f102aa..aace378 100644
>>>> --- a/hw/i386/pc_piix.c
>>>> +++ b/hw/i386/pc_piix.c
>>>> @@ -38,6 +38,7 @@
>>>>  #include "sysemu/kvm.h"
>>>>  #include "hw/kvm/clock.h"
>>>>  #include "sysemu/sysemu.h"
>>>> +#include "sysemu/qtest.h"
>>>>  #include "hw/sysbus.h"
>>>>  #include "sysemu/arch_init.h"
>>>>  #include "sysemu/block-backend.h"
>>>> @@ -84,6 +85,14 @@ static void pc_init1(MachineState *machine,
>>>>      MemoryRegion *pci_memory;
>>>>      MemoryRegion *rom_memory;
>>>>      ram_addr_t lowmem;
>>>> +    char *mc_name = MACHINE_CLASS(pcmc)->name;
>>>> +
>>>> +    /* Machines pc-0.10 up to pc-1.2 are considered as deprecated
>>>> */
>>>> +    if (!qtest_enabled() && (!strncmp(mc_name, "pc-0.", 5)
>>>> +        || (!strncmp(mc_name, "pc-1.", 5) && mc_name[5] < '3'))) {
>>>> +        error_report("Machine type '%s' is deprecated, "
>>>> +                     "please use a newer type instead", mc_name);
>>>> +    }
>>>>  
>>>>      /*
>>>>       * Calculate ram split, for memory below and above 4G.  It's a
>>>> bit
>>>>   
>>>
>>> Ping! Any comments on this version of the patch?  
>>
>> Does it make sense to build some infrastructure for this, so we don't
>> have ad-hoc code to print deprecation warnings everywhere?
> we are deprecating incomplete numa mapping but it uses 'obsoleted' word
> somewhere in warning message (in machine_numa_finish_init).
> 
> it could be better if if we had error_report_depricated()
> which would add prefix deprecated prefix consistently
> something like: "DEPRECATED: "

I don't mind the exact wording as long as we present a message to the
users to inform them that the interface might get removed soon... But if
you feel that we need to unify all these spots with an
error_report_deprecated() function, feel free to suggest a patch on the
list!

 Thomas
