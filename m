Received: from eggs.gnu.org ([2001:4830:134:3::10]:36219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gThTU-0004D0-V5
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 01:12:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gThTQ-0000Tx-TR
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 01:12:56 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15328
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gThTL-0000Qj-8K
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 01:12:48 -0500
References: <1542765966-20244-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-2-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-3-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-4-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-5-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-6-git-send-email-lizhijian@cn.fujitsu.com>
	<20181130090249-mutt-send-email-mst@kernel.org>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <fb63610f-41be-98ff-6f61-2eb1c7773d43@cn.fujitsu.com>
Date: Mon, 3 Dec 2018 14:12:40 +0800
MIME-Version: 1.0
In-Reply-To: <20181130090249-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 5/5] x86: allow load initrd below 4G for
 recent linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <zhijianx.li@intel.com>, Philip Li <philip.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>


On 11/30/2018 10:53 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 21, 2018 at 10:06:06AM +0800, Li Zhijian wrote:
>> a new field xloadflags was added to recent x86 linux, and BIT 1:
>> XLF_CAN_BE_LOADED_ABOVE_4G is used to tell bootload that where initrd can be
>> loaded saftly.
> safely
>
>> Current QEMU always load
> loads
>
>> initrd below below_4g_mem_size which
> is
>
>> always
>> less than 4G, so here limit
>
> limiting

okay, thanks


>
>> initrd_max to 4G - 1 simply is enough if
>> this bit is set.
>>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> CC: Richard Henderson <rth@twiddle.net>
>> CC: Eduardo Habkost <ehabkost@redhat.com>
>> CC: "Michael S. Tsirkin" <mst@redhat.com>
>> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
>>   hw/i386/pc.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 2ffe6fb..6d4b973 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -92,6 +92,7 @@
>>   #define FW_CFG_HPET (FW_CFG_ARCH_LOCAL + 4)
>>   
>>   #define E820_NR_ENTRIES		16
>> +#define XLF_CAN_BE_LOADED_ABOVE_4G_MASK (1 << 1)
> why not XLF_CAN_BE_LOADED_ABOVE_4G to be consistent
> with Linux?
> In fact let's import include/uapi/asm/bootparam.h
> into standard-headers, and use the macro from there?

Okay, i will import this header at V3


>
>
>>   
>>   struct e820_entry {
>>       uint64_t address;
>> @@ -916,6 +917,17 @@ static void load_linux(PCMachineState *pcms,
>>       } else {
>>           initrd_max = 0x37ffffff;
>>       }
>> +    if (protocol >= 0x20c) {
> Let's move it above so we have
>
> if (protocol >= 20c)
> else if 0x203
> else

Okay


>
>> +        unsigned int xloadflags = lduw_p(header+0x236);
>> +        if (xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G_MASK) {
>> +                /*
>> +                 * Although kernel allow
> allows
>
>> initrd loading to above 4G, here we
>> +                 * limit initrd_max to 4G -1
>
> Well not really, it just makes it as large as possible
> while still staying below 4G.
>
>> due to
> since
>
>> current QEMU always loads
>> +                 * initrd
> It's not QEMU, is it? It's actually the bios ...

Got it, thanks again


Thanks
Zhijian


>
>> below pcms->below_4g_mem_size
>> +                 */
>> +                initrd_max = UINT32_MAX;
>> +        }
>> +    }
>>   
>>       if (initrd_max >= pcms->below_4g_mem_size - pcmc->acpi_data_size) {
>>           initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
>> -- 
>> 2.7.4
>
> .
>
