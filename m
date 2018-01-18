Received: from eggs.gnu.org ([2001:4830:134:3::10]:46237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCnA-0006EQ-1v
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCn6-0000IU-2s
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:11:52 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:45412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecCn5-0000IL-TN
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:11:48 -0500
Received: by mail-qt0-x243.google.com with SMTP id x27so23442599qtm.12
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 08:11:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180118123219.19410-1-f4bug@amsat.org>
	<20180118123219.19410-7-f4bug@amsat.org>
	<16165fc9-6593-8ee9-1dd9-a28400876e66@amsat.org>
	<2ee34e45-eeec-48e7-3f1f-a5e798a0fc4e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <09c94c5f-38d9-07f8-ff59-506702db7fc7@amsat.org>
Date: Thu, 18 Jan 2018 13:11:42 -0300
MIME-Version: 1.0
In-Reply-To: <2ee34e45-eeec-48e7-3f1f-a5e798a0fc4e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 06/16] sdhci: add
 init_readonly_registers() to initialize the CAPAB register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>

On 01/18/2018 12:47 PM, Marcel Apfelbaum wrote:
> On 18/01/2018 17:44, Philippe Mathieu-Daudé wrote:
>> On 01/18/2018 09:32 AM, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>   hw/sd/sdhci.c | 17 ++++++++++++++---
>>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
>>> index f9264d3be5..08b85558f1 100644
>>> --- a/hw/sd/sdhci.c
>>> +++ b/hw/sd/sdhci.c
>>> @@ -1174,12 +1174,19 @@ static inline unsigned int
>>> sdhci_get_fifolen(SDHCIState *s)
>>>       }
>>>   }
>>>   +static void sdhci_init_readonly_registers(SDHCIState *s, Error
>>> **errp)
>>> +{
>>> +    if (s->capareg == UINT64_MAX) {
>>> +        s->capareg = SDHC_CAPAB_REG_DEFAULT;
>>> +    }
>>> +}
>>> +
>>>   /* --- qdev common --- */
>>>     #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
>>> -    /* Capabilities registers provide information on supported features
>>> -     * of this specific host controller implementation */ \
>>> -    DEFINE_PROP_UINT64("capareg", _state, capareg,
>>> SDHC_CAPAB_REG_DEFAULT), \
>>> +    /* deprecated: Capabilities registers provide information on
>>> supported
>>> +     * features of this specific host controller implementation */ \
>>> +    DEFINE_PROP_UINT64("capareg", _state, capareg, UINT64_MAX), \
>>>       DEFINE_PROP_UINT64("maxcurr", _state, maxcurr, 0)
>>>     static void sdhci_initfn(SDHCIState *s)
>>> @@ -1204,6 +1211,10 @@ static void sdhci_uninitfn(SDHCIState *s)
>>>     static void sdhci_common_realize(SDHCIState *s, Error **errp)
>>>   {
>>> +    sdhci_init_readonly_registers(s, errp);
>>> +    if (errp && *errp) {
>>
> 
> Hi Phillipe,
> 
>> Paolo said this is wrong (as in bad pattern?).
>>
>> I will respin probably using 'bool sdhci_init_readonly_registers()'
>> instead.
>>
> 
> I always use the explanations in include/qapi/error.h
> as guidelines.

I'll read them more carefully ;)

Just checking with this cocci script,

@@
Error **errp;
@@
*if (errp && *errp) {
    ...
 }

we get:

+++ ./hw/sd/sdhci.c
@@ -1303,7 +1303,6 @@ static void sdhci_pci_realize(PCIDevice

     sdhci_initfn(s);
     sdhci_common_realize(s, errp);
-    if (errp && *errp) {
         return;
     }

@@ -1383,7 +1382,6 @@ static void sdhci_sysbus_realize(DeviceS
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);

     sdhci_common_realize(s, errp);
-    if (errp && *errp) {
         return;
     }

+++ ./hw/mem/pc-dimm.c
@@ -138,7 +138,6 @@ static int pc_existing_dimms_capacity_in
                 cap->errp);
         }

-        if (cap->errp && *cap->errp) {
             return 1;
         }
     }
@@ -320,7 +319,6 @@ uint64_t pc_dimm_get_free_addr(uint64_t
         uint64_t dimm_size = object_property_get_uint(OBJECT(dimm),
                                                       PC_DIMM_SIZE_PROP,
                                                       errp);
-        if (errp && *errp) {
             goto out;
         }

+++ ./exec.c
@@ -1656,7 +1656,6 @@ static void *file_ram_alloc(RAMBlock *bl

     if (mem_prealloc) {
         os_mem_prealloc(fd, area, memory, smp_cpus, errp);
-        if (errp && *errp) {
             qemu_ram_munmap(area, memory);
             return NULL;
         }

not that bad.
