Received: from eggs.gnu.org ([2001:4830:134:3::10]:56262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1cwWB3-0001cm-Bf
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1cwWB2-0002eU-C9
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:51:57 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:34527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1cwWB2-0002e9-5y
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 11:51:56 -0400
Received: by mail-oi0-x22c.google.com with SMTP id g204so17167167oib.1
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 08:51:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170406101356.GC21261@stefanha-x1.localdomain>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170331084147.32716-5-haozhong.zhang@intel.com>
	<20170406101356.GC21261@stefanha-x1.localdomain>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 7 Apr 2017 08:51:54 -0700
Message-ID: <CAPcyv4hUOb+BO9qi8YCty65SZ79+2eyT21GtMV_gtOGCQOC=Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] nvdimm acpi: build flush hint
 address structure if required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Apr 6, 2017 at 3:13 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Fri, Mar 31, 2017 at 04:41:47PM +0800, Haozhong Zhang wrote:
>>
>> Add an boolean option 'flush-hint' to device 'nvdimm'. If it's on, a
>> flush hint address structure will be constructed for each nvdimm
>> device.
>
> Users should not need to set the flush hint option.  NVDIMM
> configurations that persist data properly without Flush Hint Addresses
> shouldn't use them (for best performance).  Configurations that rely on
> flush hints *must* use them to guarantee data integrity.
>
> I don't remember if there's a way to detect the configuration from host
> userspace, but we should focus on setting this correctly without
> requiring users to know which setting is necessary.
>
>> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> ---
>>  hw/acpi/nvdimm.c        | 106 +++++++++++++++++++++++++++++++++++++++++++++---
>>  hw/i386/pc.c            |   5 ++-
>>  hw/mem/nvdimm.c         |  26 ++++++++++++
>>  include/hw/mem/nvdimm.h |   2 +-
>>  4 files changed, 132 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
>> index ea2ac3e..a7ff0b2 100644
>> --- a/hw/acpi/nvdimm.c
>> +++ b/hw/acpi/nvdimm.c
>> @@ -32,6 +32,8 @@
>>  #include "hw/acpi/bios-linker-loader.h"
>>  #include "hw/nvram/fw_cfg.h"
>>  #include "hw/mem/nvdimm.h"
>> +#include "exec/address-spaces.h"
>> +#include "qapi/error.h"
>>
>>  static int nvdimm_device_list(Object *obj, void *opaque)
>>  {
>> @@ -168,6 +170,22 @@ struct NvdimmNfitControlRegion {
>>  typedef struct NvdimmNfitControlRegion NvdimmNfitControlRegion;
>>
>>  /*
>> + * NVDIMM Flush Hint Address Structure
>> + *
>> + * It enables the data durability mechanism via ACPI.
>> + */
>> +struct NvdimmNfitFlushHintAddress {
>> +    uint16_t type;
>> +    uint16_t length;
>> +    uint32_t nfit_handle;
>> +    uint16_t nr_flush_hint_addr;
>> +    uint8_t  reserved[6];
>> +#define NR_FLUSH_HINT_ADDR 1
>> +    uint64_t flush_hint_addr[NR_FLUSH_HINT_ADDR];
>
> How should the number of flush hints be set?  This patch hardcodes it to
> 1 but the Linux nvdimm drivers tries to balance between flush hint
> addresses to improve performance (to prevent cache line bouncing?).

No, 1 should be fine for qemu. The reason for multiple flush hints is
to accommodate multiple flush queues in the hardware. Since each flush
takes some amount of time you can get more parallelism  if multiple
threads are waiting for the same flush event, rather than being queued
serially. I don't think you can realize the same parallelism with
fsync() calls.
