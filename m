Received: from eggs.gnu.org ([2001:4830:134:3::10]:38915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dW5Ke-0003K4-AO
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dW5KZ-00036O-D5
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:28:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dW5KZ-00035k-3i
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:28:47 -0400
References: <1500025208-14827-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1500025208-14827-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170714180907.GM6020@localhost.localdomain>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9584b0c7-96f4-f000-e53f-93accd8a39ad@redhat.com>
Date: Fri, 14 Jul 2017 20:28:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170714180907.GM6020@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv9 3/3] fw_cfg: move QOM type defines and
 fw_cfg types into fw_cfg.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, somlo@cmu.edu, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On 07/14/17 20:09, Eduardo Habkost wrote:
> On Fri, Jul 14, 2017 at 10:40:08AM +0100, Mark Cave-Ayland wrote:
>> By exposing FWCfgIoState and FWCfgMemState internals we allow the possibility
>> for the internal MemoryRegion fields to be mapped by name for boards that wish
>> to wire up the fw_cfg device themselves.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> [...]
>> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
>> index b980cba..b77ea48 100644
>> --- a/include/hw/nvram/fw_cfg.h
>> +++ b/include/hw/nvram/fw_cfg.h
>> @@ -1,8 +1,19 @@
>>  #ifndef FW_CFG_H
>>  #define FW_CFG_H
>>  
>> +#include "qemu/typedefs.h"
>>  #include "exec/hwaddr.h"
>>  #include "hw/nvram/fw_cfg_keys.h"
>> +#include "hw/sysbus.h"
>> +#include "sysemu/dma.h"
>> +
>> +#define TYPE_FW_CFG     "fw_cfg"
>> +#define TYPE_FW_CFG_IO  "fw_cfg_io"
>> +#define TYPE_FW_CFG_MEM "fw_cfg_mem"
>> +
>> +#define FW_CFG(obj)     OBJECT_CHECK(FWCfgState,    (obj), TYPE_FW_CFG)
>> +#define FW_CFG_IO(obj)  OBJECT_CHECK(FWCfgIoState,  (obj), TYPE_FW_CFG_IO)
>> +#define FW_CFG_MEM(obj) OBJECT_CHECK(FWCfgMemState, (obj), TYPE_FW_CFG_MEM)
>>  
>>  typedef struct FWCfgFile {
>>      uint32_t  size;        /* file size */
>> @@ -35,6 +46,45 @@ typedef struct FWCfgDmaAccess {
>>  
>>  typedef void (*FWCfgReadCallback)(void *opaque);
>>  
>> +struct FWCfgState {
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +    /*< public >*/
>> +
>> +    uint16_t file_slots;
>> +    FWCfgEntry *entries[2];
>> +    int *entry_order;
>> +    FWCfgFiles *files;
>> +    uint16_t cur_entry;
>> +    uint32_t cur_offset;
>> +    Notifier machine_ready;
>> +
>> +    int fw_cfg_order_override;
>> +
>> +    bool dma_enabled;
>> +    dma_addr_t dma_addr;
>> +    AddressSpace *dma_as;
>> +    MemoryRegion dma_iomem;
>> +};
>> +
>> +struct FWCfgIoState {
>> +    /*< private >*/
>> +    FWCfgState parent_obj;
>> +    /*< public >*/
>> +
>> +    MemoryRegion comb_iomem;
>> +};
>> +
>> +struct FWCfgMemState {
>> +    /*< private >*/
>> +    FWCfgState parent_obj;
>> +    /*< public >*/
>> +
>> +    MemoryRegion ctl_iomem, data_iomem;
>> +    uint32_t data_width;
>> +    MemoryRegionOps wide_data_ops;
>> +};
> 
> Why do you need the full struct declaration to be exposed in the
> header?

Different board code wants to hook up "comb_iomem" manually to different
address spaces, so they need to access the field directly. This is the
ultimate goal of the entire exercise, IIRC.

> The memory regions are supposed to be visible as QOM
> children to the fw_cfg device, already.

I don't understand this. How else can board code work with "comb_iomem"
than described above? If there is a way, I agree it would be preferable.

Thanks
Laszlo
