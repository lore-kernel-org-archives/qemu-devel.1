Received: from eggs.gnu.org ([209.51.188.92]:60178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2DDf-0001Ri-FQ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2DDb-0005QQ-FP
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:59:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2DDa-0005Ke-6a
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:59:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id q187so12222323wme.5
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 02:59:08 -0800 (PST)
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-5-philmd@redhat.com>
	<599de4a4-9754-5e93-17df-9f3bffc366e8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f567c4dc-555d-0ad3-d7b3-76018771c1f8@redhat.com>
Date: Fri, 8 Mar 2019 11:59:05 +0100
MIME-Version: 1.0
In-Reply-To: <599de4a4-9754-5e93-17df-9f3bffc366e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 04/18] hw/nvram/fw_cfg: Add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

Hi Laszlo,

On 3/8/19 10:57 AM, Laszlo Ersek wrote:
> Hi Phil,
> 
> On 03/08/19 02:32, Philippe Mathieu-Daudé wrote:
>> Add fw_cfg_arch_key_name() to be able to resolve architecture
>> specific keys. All architectures do have specific keys, thus
>> implement this function. Architectures that don't use the fw_cfg
>> device don't have to implement this function, however to ease
>> the Makefile rules and satisfy the linking, we provide a stub.
>>
>> Now than we can resolve keys into "well know numeric", add
>> trace events to display more information when keys are added
>> (and dump the key content when possible).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> v2: Added fw_cfg_arch_key_name() -> reset R-b
>> ---
> 
> This is not a small patch, and Michael and I reviewed v1 three months ago:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01616.html
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01947.html
> 
> I'm not keen on re-reviewing the patch from zero (after three months)
> just because of fw_cfg_arch_key_name().
> 
> Is it possible to split fw_cfg_arch_key_name() to a separate patch first
> (which we could review in isolation -- it affects multiple arches), and
> rebase the original (v1) patch to it, with minimal updates (keeping the
> R-b's, or at least pointing out the minimal change for incremental review)?

Sure it is, this is what I first did, then expected a comment "this is
not used until the next patch, why not squash it?" and I squashed both.
The series respin will have this patch split as you suggested.

> 
> Thanks
> Laszlo
> 
>>  MAINTAINERS               |  1 +
>>  hw/i386/pc.c              | 21 +++++++++++++
>>  hw/nvram/fw_cfg.c         | 63 ++++++++++++++++++++++++++++++++++++++-
>>  hw/nvram/trace-events     |  7 ++++-
>>  hw/ppc/Makefile.objs      |  2 +-
>>  hw/ppc/fw_cfg.c           | 31 +++++++++++++++++++
>>  hw/sparc/sun4m.c          | 19 ++++++++++++
>>  hw/sparc64/sun4u.c        | 19 ++++++++++++
>>  include/hw/nvram/fw_cfg.h | 11 +++++++
>>  stubs/Makefile.objs       |  1 +
>>  stubs/fw_cfg.c            | 19 ++++++++++++
>>  11 files changed, 191 insertions(+), 3 deletions(-)
>>  create mode 100644 hw/ppc/fw_cfg.c
>>  create mode 100644 stubs/fw_cfg.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 074ad46d47..306fc2aefa 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1659,6 +1659,7 @@ R: Gerd Hoffmann <kraxel@redhat.com>
>>  S: Supported
>>  F: docs/specs/fw_cfg.txt
>>  F: hw/nvram/fw_cfg.c
>> +F: stubs/fw_cfg.c
>>  F: include/hw/nvram/fw_cfg.h
>>  F: include/standard-headers/linux/qemu_fw_cfg.h
>>  F: tests/libqos/fw_cfg.c
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 42128183e9..0848cdc18f 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -349,6 +349,27 @@ GlobalProperty pc_compat_1_4[] = {
>>  };
>>  const size_t pc_compat_1_4_len = G_N_ELEMENTS(pc_compat_1_4);
>>  
>> +const char *fw_cfg_arch_key_name(uint16_t key)
>> +{
>> +    static const struct {
>> +        uint16_t key;
>> +        const char *name;
>> +    } fw_cfg_arch_wellknown_keys[] = {
>> +        {FW_CFG_ACPI_TABLES, "acpi_tables"},
>> +        {FW_CFG_SMBIOS_ENTRIES, "smbios_entries"},
>> +        {FW_CFG_IRQ0_OVERRIDE, "irq0_override"},
>> +        {FW_CFG_E820_TABLE, "e820_tables"},
>> +        {FW_CFG_HPET, "hpet"},
>> +    };
>> +
>> +    for (size_t i = 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++) {
>> +        if (fw_cfg_arch_wellknown_keys[i].key == key) {
>> +            return fw_cfg_arch_wellknown_keys[i].name;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>>  void gsi_handler(void *opaque, int n, int level)
>>  {
>>      GSIState *s = opaque;
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 7fdf04adc9..684c2cf00a 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -60,6 +60,62 @@ struct FWCfgEntry {
>>      FWCfgWriteCallback write_cb;
>>  };
>>  
>> +/**
>> + * key_name:
>> + *
>> + * @key: The uint16 selector key.
>> + *
>> + * Returns: The stringified name if the selector refers to a well-known
>> + *          numerically defined item, or NULL on key lookup failure.
>> + */
>> +static const char *key_name(uint16_t key)
>> +{
>> +    static const char *fw_cfg_wellknown_keys[FW_CFG_FILE_FIRST] = {
>> +        [FW_CFG_SIGNATURE] = "signature",
>> +        [FW_CFG_ID] = "id",
>> +        [FW_CFG_UUID] = "uuid",
>> +        [FW_CFG_RAM_SIZE] = "ram_size",
>> +        [FW_CFG_NOGRAPHIC] = "nographic",
>> +        [FW_CFG_NB_CPUS] = "nb_cpus",
>> +        [FW_CFG_MACHINE_ID] = "machine_id",
>> +        [FW_CFG_KERNEL_ADDR] = "kernel_addr",
>> +        [FW_CFG_KERNEL_SIZE] = "kernel_size",
>> +        [FW_CFG_KERNEL_CMDLINE] = "kernel_cmdline",
>> +        [FW_CFG_INITRD_ADDR] = "initrd_addr",
>> +        [FW_CFG_INITRD_SIZE] = "initdr_size",
>> +        [FW_CFG_BOOT_DEVICE] = "boot_device",
>> +        [FW_CFG_NUMA] = "numa",
>> +        [FW_CFG_BOOT_MENU] = "boot_menu",
>> +        [FW_CFG_MAX_CPUS] = "max_cpus",
>> +        [FW_CFG_KERNEL_ENTRY] = "kernel_entry",
>> +        [FW_CFG_KERNEL_DATA] = "kernel_data",
>> +        [FW_CFG_INITRD_DATA] = "initrd_data",
>> +        [FW_CFG_CMDLINE_ADDR] = "cmdline_addr",
>> +        [FW_CFG_CMDLINE_SIZE] = "cmdline_size",
>> +        [FW_CFG_CMDLINE_DATA] = "cmdline_data",
>> +        [FW_CFG_SETUP_ADDR] = "setup_addr",
>> +        [FW_CFG_SETUP_SIZE] = "setup_size",
>> +        [FW_CFG_SETUP_DATA] = "setup_data",
>> +        [FW_CFG_FILE_DIR] = "file_dir",
>> +    };
>> +
>> +    if (key & FW_CFG_ARCH_LOCAL) {
>> +        return fw_cfg_arch_key_name(key);
>> +    }
>> +    if (key < FW_CFG_FILE_FIRST) {
>> +        return fw_cfg_wellknown_keys[key];
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static inline const char *trace_key_name(uint16_t key)
>> +{
>> +    const char *name = key_name(key);
>> +
>> +    return name ? name : "unknown";
>> +}
>> +
>>  #define JPG_FILE 0
>>  #define BMP_FILE 1
>>  
>> @@ -234,7 +290,7 @@ static int fw_cfg_select(FWCfgState *s, uint16_t key)
>>          }
>>      }
>>  
>> -    trace_fw_cfg_select(s, key, ret);
>> +    trace_fw_cfg_select(s, key, trace_key_name(key), ret);
>>      return ret;
>>  }
>>  
>> @@ -617,6 +673,7 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, uint16_t key,
>>  
>>  void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t len)
>>  {
>> +    trace_fw_cfg_add_bytes(key, trace_key_name(key), len);
>>      fw_cfg_add_bytes_callback(s, key, NULL, NULL, NULL, data, len, true);
>>  }
>>  
>> @@ -624,6 +681,7 @@ void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value)
>>  {
>>      size_t sz = strlen(value) + 1;
>>  
>> +    trace_fw_cfg_add_string(key, trace_key_name(key), value);
>>      fw_cfg_add_bytes(s, key, g_memdup(value, sz), sz);
>>  }
>>  
>> @@ -633,6 +691,7 @@ void fw_cfg_add_i16(FWCfgState *s, uint16_t key, uint16_t value)
>>  
>>      copy = g_malloc(sizeof(value));
>>      *copy = cpu_to_le16(value);
>> +    trace_fw_cfg_add_i16(key, trace_key_name(key), value);
>>      fw_cfg_add_bytes(s, key, copy, sizeof(value));
>>  }
>>  
>> @@ -652,6 +711,7 @@ void fw_cfg_add_i32(FWCfgState *s, uint16_t key, uint32_t value)
>>  
>>      copy = g_malloc(sizeof(value));
>>      *copy = cpu_to_le32(value);
>> +    trace_fw_cfg_add_i32(key, trace_key_name(key), value);
>>      fw_cfg_add_bytes(s, key, copy, sizeof(value));
>>  }
>>  
>> @@ -661,6 +721,7 @@ void fw_cfg_add_i64(FWCfgState *s, uint16_t key, uint64_t value)
>>  
>>      copy = g_malloc(sizeof(value));
>>      *copy = cpu_to_le64(value);
>> +    trace_fw_cfg_add_i64(key, trace_key_name(key), value);
>>      fw_cfg_add_bytes(s, key, copy, sizeof(value));
>>  }
>>  
>> diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
>> index 6b55ba7a09..4d8fa992fe 100644
>> --- a/hw/nvram/trace-events
>> +++ b/hw/nvram/trace-events
>> @@ -5,6 +5,11 @@ nvram_read(uint32_t addr, uint32_t ret) "read addr %d: 0x%02x"
>>  nvram_write(uint32_t addr, uint32_t old, uint32_t val) "write addr %d: 0x%02x -> 0x%02x"
>>  
>>  # hw/nvram/fw_cfg.c
>> -fw_cfg_select(void *s, uint16_t key, int ret) "%p key %d = %d"
>> +fw_cfg_select(void *s, uint16_t key_value, const char *key_name, int ret) "%p key 0x%04" PRIx16 " '%s', ret: %d"
>>  fw_cfg_read(void *s, uint64_t ret) "%p = 0x%"PRIx64
>> +fw_cfg_add_bytes(uint16_t key_value, const char *key_name, size_t len) "key 0x%04" PRIx16 " '%s', %zu bytes"
>>  fw_cfg_add_file(void *s, int index, char *name, size_t len) "%p #%d: %s (%zd bytes)"
>> +fw_cfg_add_string(uint16_t key_value, const char *key_name, const char *value) "key 0x%04" PRIx16 " '%s', value '%s'"
>> +fw_cfg_add_i16(uint16_t key_value, const char *key_name, uint16_t value) "key 0x%04" PRIx16 " '%s', value 0x%" PRIx16
>> +fw_cfg_add_i32(uint16_t key_value, const char *key_name, uint32_t value) "key 0x%04" PRIx16 " '%s', value 0x%" PRIx32
>> +fw_cfg_add_i64(uint16_t key_value, const char *key_name, uint64_t value) "key 0x%04" PRIx16 " '%s', value 0x%" PRIx64
>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>> index 1111b218a0..ae94098155 100644
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
>> index 0000000000..0e7616b78a
>> --- /dev/null
>> +++ b/hw/ppc/fw_cfg.c
>> @@ -0,0 +1,31 @@
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
>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index ca1e3825d5..49251d62b3 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -97,6 +97,25 @@ struct sun4m_hwdef {
>>      uint8_t nvram_machine_id;
>>  };
>>  
>> +const char *fw_cfg_arch_key_name(uint16_t key)
>> +{
>> +    static const struct {
>> +        uint16_t key;
>> +        const char *name;
>> +    } fw_cfg_arch_wellknown_keys[] = {
>> +        {FW_CFG_SUN4M_DEPTH, "depth"},
>> +        {FW_CFG_SUN4M_WIDTH, "width"},
>> +        {FW_CFG_SUN4M_HEIGHT, "height"},
>> +    };
>> +
>> +    for (size_t i = 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++) {
>> +        if (fw_cfg_arch_wellknown_keys[i].key == key) {
>> +            return fw_cfg_arch_wellknown_keys[i].name;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>>  static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>>                              Error **errp)
>>  {
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index 399f2d73c8..4230b17b87 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -91,6 +91,25 @@ typedef struct EbusState {
>>  #define TYPE_EBUS "ebus"
>>  #define EBUS(obj) OBJECT_CHECK(EbusState, (obj), TYPE_EBUS)
>>  
>> +const char *fw_cfg_arch_key_name(uint16_t key)
>> +{
>> +    static const struct {
>> +        uint16_t key;
>> +        const char *name;
>> +    } fw_cfg_arch_wellknown_keys[] = {
>> +        {FW_CFG_SPARC64_WIDTH, "width"},
>> +        {FW_CFG_SPARC64_HEIGHT, "height"},
>> +        {FW_CFG_SPARC64_DEPTH, "depth"},
>> +    };
>> +
>> +    for (size_t i = 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++) {
>> +        if (fw_cfg_arch_wellknown_keys[i].key == key) {
>> +            return fw_cfg_arch_wellknown_keys[i].name;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>>  static void fw_cfg_boot_set(void *opaque, const char *boot_device,
>>                              Error **errp)
>>  {
>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
>> index f5a6895a74..828ad9dedc 100644
>> --- a/include/hw/nvram/fw_cfg.h
>> +++ b/include/hw/nvram/fw_cfg.h
>> @@ -226,4 +226,15 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>>  FWCfgState *fw_cfg_find(void);
>>  bool fw_cfg_dma_enabled(void *opaque);
>>  
>> +/**
>> + * fw_cfg_arch_key_name:
>> + *
>> + * @key: The uint16 selector key.
>> + *
>> + * Returns: The stringified architecture-specific name if the selector
>> + *          refers to a well-known numerically defined item, or NULL on
>> + *          key lookup failure.
>> + */
>> +const char *fw_cfg_arch_key_name(uint16_t key);
>> +
>>  #endif
>> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
>> index 269dfa5832..73452ad265 100644
>> --- a/stubs/Makefile.objs
>> +++ b/stubs/Makefile.objs
>> @@ -39,3 +39,4 @@ stub-obj-y += xen-hvm.o
>>  stub-obj-y += pci-host-piix.o
>>  stub-obj-y += ram-block.o
>>  stub-obj-y += ramfb.o
>> +stub-obj-y += fw_cfg.o
>> diff --git a/stubs/fw_cfg.c b/stubs/fw_cfg.c
>> new file mode 100644
>> index 0000000000..2b886c94d6
>> --- /dev/null
>> +++ b/stubs/fw_cfg.c
>> @@ -0,0 +1,19 @@
>> +/*
>> + * fw_cfg stubs
>> + *
>> + * Copyright (c) 2019 Red Hat, Inc.
>> + *
>> + * Author:
>> + *   Philippe Mathieu-Daudé <philmd@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/nvram/fw_cfg.h"
>> +
>> +const char *fw_cfg_arch_key_name(uint16_t key)
>> +{
>> +    return NULL;
>> +}
>>
> 
