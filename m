Received: from eggs.gnu.org ([2001:4830:134:3::10]:32863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTNBk-0001MT-6D
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTNBc-0008Pg-5n
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:01:00 -0400
Date: Thu, 14 Jun 2018 10:00:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180614013532.GE3042@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806140955020.19899@zero.eik.bme.hu>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<a9d502cce05cfa57895c415164efd288f4926fb6.1528935420.git.balaton@eik.bme.hu>
	<20180614013532.GE3042@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v3 8/9] sm501: Perform a full update after
 palette change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Sebastian Bauer <mail@sebastianbauer.info>

On Thu, 14 Jun 2018, David Gibson wrote:
> On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
>> From: Sebastian Bauer <mail@sebastianbauer.info>
>>
>> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Commit message.  Why is this necessary?

Maybe because changing palette does not change display unless an update is 
done and dirty tracking which is used in update_display does not detect 
changes in device registers where palette is stored.

I'm not sure this is needed in all modes but I guess palette is not used 
in modes that are not indexed so unecessary updates should not happen evem 
in those cases because if palette is not used anyway, guest is unlikely to 
change it unless doing something really strange but we haven't seen any 
guests yet that would do that. Therefore this simple way of handling this 
should be OK.

Regards,
BALATON Zoltan

>> ---
>>  hw/display/sm501.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index 0625cf5..a2ee6e3 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -479,6 +479,7 @@ typedef struct SM501State {
>>      MemoryRegion twoD_engine_region;
>>      uint32_t last_width;
>>      uint32_t last_height;
>> +    uint32_t do_full_update; /* perform a full update next time */
>>      I2CBus *i2c_bus;
>>
>>      /* mmio registers */
>> @@ -1032,6 +1033,7 @@ static void sm501_palette_write(void *opaque, hwaddr addr,
>>
>>      assert(range_covers_byte(0, 0x400 * 3, addr));
>>      *(uint32_t *)&s->dc_palette[addr] = value;
>> +    s->do_full_update = 1;
>>  }
>>
>>  static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
>> @@ -1620,6 +1622,12 @@ static void sm501_update_display(void *opaque)
>>          full_update = 1;
>>      }
>>
>> +    /* someone else requested a full update */
>> +    if (s->do_full_update) {
>> +        s->do_full_update = 0;
>> +        full_update = 1;
>> +    }
>> +
>>      /* draw each line according to conditions */
>>      snap = memory_region_snapshot_and_clear_dirty(&s->local_mem_region,
>>                offset, width * height * src_bpp, DIRTY_MEMORY_VGA);
>
>
