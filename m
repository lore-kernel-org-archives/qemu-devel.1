Received: from eggs.gnu.org ([2001:4830:134:3::10]:51079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dIr7K-0001Hr-9H
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dIr7H-0007R1-6y
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:40:26 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dIr7H-0007Qr-08
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:40:23 -0400
Received: by mail-pf0-x243.google.com with SMTP id u1so4037473pfg.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 23:40:22 -0700 (PDT)
References: <20170607080639.22120-1-haozhong.zhang@intel.com>
	<011f1bfe-f882-d940-52eb-7b5d511f9ffc@gmail.com>
	<20170608050640.ov5wtygx737ory6z@hz-desktop>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <11a7114a-95e5-d758-8479-86571037da3d@gmail.com>
Date: Thu, 8 Jun 2017 14:40:29 +0800
MIME-Version: 1.0
In-Reply-To: <20170608050640.ov5wtygx737ory6z@hz-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nvdimm acpi: fix region format interface
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>



On 06/08/2017 01:06 PM, Haozhong Zhang wrote:
> On 06/08/17 11:07 +0800, Xiao Guangrong wrote:
>>
>>
>> On 06/07/2017 04:06 PM, Haozhong Zhang wrote:
>>> Per ACPI 6.2, section 5.2.25.6 and JEDEC Annex L Release 3, the
>>> current region format interface code 0x201 indicates the block
>>> addressed function interface 1, rather than a byte addressable
>>> interface. Fix it by using 0x301 which indicates the byte addressable
>>> no energy backed function interface 1.
>>>
>>> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>>> ---
>>>    hw/acpi/nvdimm.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
>>> index 8e7d6ec034..b5734f5897 100644
>>> --- a/hw/acpi/nvdimm.c
>>> +++ b/hw/acpi/nvdimm.c
>>> @@ -338,9 +338,10 @@ static void nvdimm_build_structure_dcr(GArray *structures, DeviceState *dev)
>>>        nfit_dcr->revision_id = cpu_to_le16(1 /* Current Revision supported
>>>                                                 in ACPI 6.0 is 1. */);
>>>        nfit_dcr->serial_number = cpu_to_le32(sn);
>>> -    nfit_dcr->fic = cpu_to_le16(0x201 /* Format Interface Code. See Chapter
>>> -                                         2: NVDIMM Device Specific Method
>>> -                                         (DSM) in DSM Spec Rev1.*/);
>>> +    nfit_dcr->fic = cpu_to_le16(0x301 /* Format Interface Code:
>>> +                                         Byte addressable, no energy backed.
>>> +                                         See ACPI 6.2, sect 5.2.25.6 and
>>> +                                         JEDEC Annex L Release 3. */);
>>
>> Shouldn't the 'no energy backend' indicator be set only for !dax disk?
> 
> Above specs define RFIC for two classes of byte-addressable NVDIMM:
> 1. 0x10[0|1]: A function containing byte addressable persistent memory
>                whose persistence is achieved through the use of DRAM,
>                nonvolatile memory (e.g., Flash) and an energy source.
> 	      Only the DRAM portion is addressable by the system.
> 2. 0x30[0|1]: A function containing byte addressable persistent
>                memory. All of the persistent memory is addressable by
>                the system. No external energy source is required.
> If the last bit is 0, then it's a proprietary interface.

As both of them indicate persistent memory, it is okay to me.

The FIC, 0x201, comes from the document of Intel DSM example, i have no idea why
it uses 0x201. Maybe it is worth being fixed too.
