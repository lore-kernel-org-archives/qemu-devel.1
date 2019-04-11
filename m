Received: from eggs.gnu.org ([209.51.188.92]:36138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hEhz3-0003bd-VC
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 18:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hEhz0-0001Aa-NX
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 18:15:49 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:43125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hEhyx-00011v-DL
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 18:15:45 -0400
Received: by mail-ed1-x541.google.com with SMTP id w3so6595518edu.10
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 15:15:38 -0700 (PDT)
Date: Thu, 11 Apr 2019 22:15:35 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190411221535.6oirewsnbmnhp2sk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
	<20190410142756.GA3136@richard>
	<20190410170150.1c447b12@redhat.com>
	<20190411013211.GA8515@richard>
	<20190411134627.15d7c340@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411134627.15d7c340@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1] q35: acpi: do not create dummy
 MCFG table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, ehabkost@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On Thu, Apr 11, 2019 at 01:46:27PM +0200, Igor Mammedov wrote:
>On Thu, 11 Apr 2019 09:32:11 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>

[...]

>> To be honest, this is what I feel confused in your previous reply.
>> 
>> First I want to confirm both fields in RAMBlock affects the migration:
>> 
>> * used_length
>> * max_length
>> 
>> Both of them should be the same on both source/destination, otherwise the
>> migration would fail.
>well, it works fine for me.
>Where do you see max_length being used during migration?
>

I asked my colleague, but seems you are right.

>
>> Then I thought the migration would be broken if source/destination has
>> different knowledge about acpi table size. Because this will introduce
>> different value of used_length, even we have resizable MemoryRegion.
>> 
>> The 1st time ACPI generation flow:
>> 
>>     acpi_add_rom_blob
>>         rom_add_blob
>>             rom_set_mr
>>                 memory_region_init_resizable_ram
>>                     qemu_ram_alloc_resizable
>>     		        new_block->used_length = size
>>     		        new_block->max_length = max_size
>> 
>> The 2nd time ACPI generation flow:
>> 
>>     acpi_ram_update
>>         memory_regioin_ram_resize
>>             qemu_ram_resize
>>                 block->used_length = new_size
>> 
>> The max_length is always the same, while used_length would be changed to the
>> actual table_blob size.
>> 
>> In case source/destination has different knowledge about acpi table size, the
>> table_blob size(even after aligned) could be different.
>> 
>> This is why I thought there is still some chance to break migration after
>> resizable MemoryRegion.
>> 
>> Do I miss something?
>yes, you did, max_length does not influence migration stream.
>see what above mentioned commits and ram_load() -> "if (length != block->used_length)" do.
>

I see this in the code.

So the destination will check length and adjust self's length if it
doesn't equal to the source.

Thanks :-)

-- 
Wei Yang
Help you, Help me
