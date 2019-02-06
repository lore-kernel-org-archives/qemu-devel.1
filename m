Received: from eggs.gnu.org ([209.51.188.92]:54050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1grX2R-0004El-PD
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 18:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1grX2O-0000O3-C1
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 18:55:29 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1grX2I-0000JI-II
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 18:55:22 -0500
Received: by mail-ed1-x543.google.com with SMTP id b3so7563110ede.1
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 15:55:18 -0800 (PST)
Date: Wed, 6 Feb 2019 23:55:15 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190206235515.r2h6sk74uggt7qg3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190201010837.19278-1-richardw.yang@linux.intel.com>
	<20190206125949.511438c9@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206125949.511438c9@Igors-MacBook-Pro.local>
Subject: Re: [Qemu-devel] [PATCH] pc-dimm: use same mechanism for
 [get|set]_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com

On Wed, Feb 06, 2019 at 12:59:49PM +0100, Igor Mammedov wrote:
>On Fri,  1 Feb 2019 09:08:37 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> [get|set]_addr are two counterpart to access PCDIMMDevice.addr.
>> 
>> Since we have already set up a property PC_DIMM_ADDR_PROP for this
>> field and use this mechanism in set_addr, it would be more proper to use
>> the same mechanism in set_addr.
>> 
>> This patch uses object_property_get_uint() to replace the direct memory
>> access to make [get|set]_addr with the same mechanism.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  hw/mem/pc-dimm.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>> 
>> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
>> index 0c9b9e8292..c0658b9b88 100644
>> --- a/hw/mem/pc-dimm.c
>> +++ b/hw/mem/pc-dimm.c
>> @@ -204,9 +204,7 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
>>  
>>  static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
>>  {
>> -    const PCDIMMDevice *dimm = PC_DIMM(md);
>> -
>> -    return dimm->addr;
>> +    return object_property_get_uint(OBJECT(md), PC_DIMM_ADDR_PROP, NULL);
>it's not good to ignore errors
>
>s/NULL/error_abort/
>
>so we would notice if error ever happened.

You mean something like this?

	Error *err;
	uint64_t addr;

	addr = object_property_get_uint(OBJECT(md), PC_DIMM_ADDR_PROP, &err);

	if (err) {
		warn_report_err(&err);
		return 0;
	}

	return addr;

>
>>  }
>>  
>>  static void pc_dimm_md_set_addr(MemoryDeviceState *md, uint64_t addr,
>

-- 
Wei Yang
Help you, Help me
