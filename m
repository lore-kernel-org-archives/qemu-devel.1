Received: from eggs.gnu.org ([2001:4830:134:3::10]:34910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZHCn-0003xz-MX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZH52-0007g0-HG
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:14:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZH52-0007fL-A0
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:14:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so16286394wra.6
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 07:14:44 -0800 (PST)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20181207170400.5129-1-philmd@redhat.com>
	<20181207170400.5129-6-philmd@redhat.com>
	<20181207124425-mutt-send-email-mst@kernel.org>
	<682e51c1-443f-4cbe-83ae-06f742d9913a@redhat.com>
Message-ID: <7bb7dfc8-8df3-2f0f-cfe4-0eac009fd371@redhat.com>
Date: Tue, 18 Dec 2018 16:14:41 +0100
MIME-Version: 1.0
In-Reply-To: <682e51c1-443f-4cbe-83ae-06f742d9913a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/6] hw/nvram/fw_cfg: Add HMP 'info fw_cfg'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Hi Michael,

On 12/10/18 10:18 AM, Philippe Mathieu-Daudé wrote:
> On 12/7/18 6:54 PM, Michael S. Tsirkin wrote:
>> On Fri, Dec 07, 2018 at 06:03:59PM +0100, Philippe Mathieu-Daudé wrote:
>>> $ qemu-system-x86_64 -S -monitor stdio
>>> (qemu) info fw_cfg
>>>         Type    Perm    Size    Specific   Order   Info
>>>    signature      RO       4                       QEMU
>>>           id      RO       4                       0x00000003
>>>         uuid      RO      16                       00000000-0000-0000-0000-000000000000
>>>     ram_size      RO       8                       0x0000000008000000
>>>    nographic      RO       2                       0x0000
>>>      nb_cpus      RO       2                       0x0001
>>>         numa      RO      16
>>>    boot_menu      RO       2                       0x0000
>>>     max_cpus      RO       2                       0x0001
>>>     file_dir      RO    2052
>>>  file (id 1)      RO      36                 160   etc/acpi/rsdp
>>>  file (id 2)      RO  131072                 130   etc/acpi/tables
>>>  file (id 3)      RO       4                  15   etc/boot-fail-wait
>>>  file (id 4)      RO      20                  40   etc/e820
>>>  file (id 5)      RO      31                  30   etc/smbios/smbios-anchor
>>>  file (id 6)      RO     320                  20   etc/smbios/smbios-tables
>>>  file (id 7)      RO       6                  90   etc/system-states
>>>  file (id 8)      RO    4096                 140   etc/table-loader
>>> file (id 10)      RO    9216                  55   genroms/kvmvapic.bin
>>>         uuid      RO       4  (arch spec)          01000000-0000-0000-0000-000000000000
>>>     ram_size      RO     324  (arch spec)
>>>    nographic      RO     121  (arch spec)
>>
>> Weird. Your code has arch_spec.
> 
> Hmmm I'll check that.

These are the entries used for Bochs:

#define FW_CFG_ACPI_TABLES (FW_CFG_ARCH_LOCAL + 0)
#define FW_CFG_SMBIOS_ENTRIES (FW_CFG_ARCH_LOCAL + 1)
#define FW_CFG_IRQ0_OVERRIDE (FW_CFG_ARCH_LOCAL + 2)
#define FW_CFG_E820_TABLE (FW_CFG_ARCH_LOCAL + 3)
#define FW_CFG_HPET (FW_CFG_ARCH_LOCAL + 4)

static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
{
    [...]
    fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
                     acpi_tables, acpi_tables_len);
    fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE,
                   kvm_allows_irq0_override());
    fw_cfg_add_bytes(fw_cfg, FW_CFG_E820_TABLE,
                     &e820_reserve, sizeof(e820_reserve));

So what happened here is the 'type' name is incorrect (I'll fix), but
the arch_spec flag is correct. Thanks for noticing this :)

Regards,

Phil.
