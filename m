Received: from eggs.gnu.org ([209.51.188.92]:60802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIq6y-0000TF-Um
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIptn-00020n-Ue
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:31:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIptn-00020W-ON
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:31:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id c6so13085558wrm.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 00:31:27 -0700 (PDT)
References: <20190422195020.1494-1-philmd@redhat.com>
	<20190422195020.1494-6-philmd@redhat.com>
	<20190423012057.GA31496@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c082036d-9bac-8c4c-ddf8-02f3852ebb99@redhat.com>
Date: Tue, 23 Apr 2019 09:31:08 +0200
MIME-Version: 1.0
In-Reply-To: <20190423012057.GA31496@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hw/ppc: Implement
 fw_cfg_arch_key_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-ppc@nongnu.org

Hi David,

On 4/23/19 3:20 AM, David Gibson wrote:
> On Mon, Apr 22, 2019 at 09:50:18PM +0200, Philippe Mathieu-Daudé wrote:
>> Implement fw_cfg_arch_key_name(), which returns the name of a
>> ppc-specific key.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> What ppc machines actually use fw_cfg?  I know pseries and powernv
> don't.

I see:

- 40p
- g3beige (newworld)
- mac99 (oldworld)

I guess it is because they use OpenBIOS.

>> ---
>>  hw/ppc/Makefile.objs |  2 +-
>>  hw/ppc/fw_cfg.c      | 45 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 46 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/ppc/fw_cfg.c
>>
>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>> index 1111b218a04..ae940981553 100644
>> --- a/hw/ppc/Makefile.objs
>> +++ b/hw/ppc/Makefile.objs
>> @@ -1,5 +1,5 @@
>>  # shared objects
>> -obj-y += ppc.o ppc_booke.o fdt.o
>> +obj-y += ppc.o ppc_booke.o fdt.o fw_cfg.o
>>  # IBM pSeries (sPAPR)
>>  obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
>>  obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
>> diff --git a/hw/ppc/fw_cfg.c b/hw/ppc/fw_cfg.c
>> new file mode 100644
>> index 00000000000..a88b5c4bde2
>> --- /dev/null
>> +++ b/hw/ppc/fw_cfg.c
>> @@ -0,0 +1,45 @@
>> +/*
>> + * fw_cfg helpers (PPC specific)
>> + *
>> + * Copyright (c) 2019 Red Hat, Inc.
>> + *
>> + * Author:
>> + *   Philippe Mathieu-Daudé <philmd@redhat.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/ppc/ppc.h"
>> +#include "hw/nvram/fw_cfg.h"
>> +
>> +const char *fw_cfg_arch_key_name(uint16_t key)
>> +{
>> +    static const struct {
>> +        uint16_t key;
>> +        const char *name;
>> +    } fw_cfg_arch_wellknown_keys[] = {
>> +        {FW_CFG_PPC_WIDTH, "width"},
>> +        {FW_CFG_PPC_HEIGHT, "height"},
>> +        {FW_CFG_PPC_DEPTH, "depth"},
>> +        {FW_CFG_PPC_TBFREQ, "tbfreq"},
>> +        {FW_CFG_PPC_CLOCKFREQ, "clockfreq"},
>> +        {FW_CFG_PPC_IS_KVM, "is_kvm"},
>> +        {FW_CFG_PPC_KVM_HC, "kvm_hc"},
>> +        {FW_CFG_PPC_KVM_PID, "pid"},
>> +        {FW_CFG_PPC_NVRAM_ADDR, "nvram_addr"},
>> +        {FW_CFG_PPC_BUSFREQ, "busfreq"},
>> +        {FW_CFG_PPC_NVRAM_FLAT, "nvram_flat"},
>> +        {FW_CFG_PPC_VIACONFIG, "viaconfig"},
>> +    };
>> +
>> +    for (size_t i = 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++) {
>> +        if (fw_cfg_arch_wellknown_keys[i].key == key) {
>> +            return fw_cfg_arch_wellknown_keys[i].name;
>> +        }
>> +    }
>> +    return NULL;
>> +}
> 
