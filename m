Received: from eggs.gnu.org ([2001:4830:134:3::10]:43045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFfUh-0002t4-Aa
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFfUd-0001vC-AI
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:39:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dFfUd-0001v4-3l
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:39:19 -0400
References: <1494430493-23119-1-git-send-email-thuth@redhat.com>
	<40588676-2a57-c17f-1f05-00c017da18ba@redhat.com>
	<1496140501.4100.5.camel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d59a1024-05c5-a041-4fb3-7e9411aa32a0@redhat.com>
Date: Tue, 30 May 2017 13:39:09 +0200
MIME-Version: 1.0
In-Reply-To: <1496140501.4100.5.camel@redhat.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 30.05.2017 12:35, Gerd Hoffmann wrote:
>   Hi,
> 
>>>  v2:
>>>  - Deprecate machines up to pc-1.2
>>>
>>>  hw/i386/pc_piix.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>> index 9f102aa..aace378 100644
>>> --- a/hw/i386/pc_piix.c
>>> +++ b/hw/i386/pc_piix.c
>>> @@ -38,6 +38,7 @@
>>>  #include "sysemu/kvm.h"
>>>  #include "hw/kvm/clock.h"
>>>  #include "sysemu/sysemu.h"
>>> +#include "sysemu/qtest.h"
>>>  #include "hw/sysbus.h"
>>>  #include "sysemu/arch_init.h"
>>>  #include "sysemu/block-backend.h"
>>> @@ -84,6 +85,14 @@ static void pc_init1(MachineState *machine,
>>>      MemoryRegion *pci_memory;
>>>      MemoryRegion *rom_memory;
>>>      ram_addr_t lowmem;
>>> +    char *mc_name = MACHINE_CLASS(pcmc)->name;
>>> +
>>> +    /* Machines pc-0.10 up to pc-1.2 are considered as deprecated
>>> */
>>> +    if (!qtest_enabled() && (!strncmp(mc_name, "pc-0.", 5)
>>> +        || (!strncmp(mc_name, "pc-1.", 5) && mc_name[5] < '3'))) {
>>> +        error_report("Machine type '%s' is deprecated, "
>>> +                     "please use a newer type instead", mc_name);
>>> +    }
>>>  
>>>      /*
>>>       * Calculate ram split, for memory below and above 4G.  It's a
>>> bit
>>>
>>
>> Ping! Any comments on this version of the patch?
> 
> Does it make sense to build some infrastructure for this, so we don't
> have ad-hoc code to print deprecation warnings everywhere?
> 
> Something like adding a "bool deprecated" or "char *deprecated_msg"
> field to MachineClass (and possibly elsewhere too, for example
> DeviceClass).

So far we've got deprecation warnings at very different places in the
code - for command line parameters, for HMP commands, for some few
devices, ... and this time it's for the first time for old machine
types. I currently don't see a pattern yet where a "deprecated" flag in
MachineClass or DeviceClass would really help to simplify the code right
now ... maybe later if we deprecate multiple machines at the same time?

 Thomas
