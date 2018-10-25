Received: from eggs.gnu.org ([2001:4830:134:3::10]:44353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gFmLU-0001Rk-56
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gFmHb-0007K8-CI
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:31:08 -0400
References: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
	<20181018182856.28001-8-mark.cave-ayland@ilande.co.uk>
	<82a4a209-3fba-ab45-3d27-c9f2e6585608@posteo.de>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <23718185-791d-ce03-4b2b-7aa4348cbac8@ilande.co.uk>
Date: Thu, 25 Oct 2018 21:30:39 +0100
MIME-Version: 1.0
In-Reply-To: <82a4a209-3fba-ab45-3d27-c9f2e6585608@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 07/11] hw/m68k: add Nubus support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <th.huth@posteo.de>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, yongbok.kim@mips.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

On 23/10/2018 08:36, Thomas Huth wrote:

> On 2018-10-18 19:28, Mark Cave-Ayland wrote:
>> From: Laurent Vivier <laurent@vivier.eu>
>>
>> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
> [...]
>> +static void nubus_register_format_block(NubusDevice *dev)
>> +{
>> +    char fblock_name[27];
>> +
>> +    sprintf(fblock_name, "nubus-slot-%d-format-block", dev->slot_nb);
> 
> Latest GCC (version 8) got very picky about possible buffer overflows
> during sprintf() ... not sure, but it might be necessary to either use a
> bigger array here, or assert(dev->slot_nb < NUBUS_SLOT_NB), or even
> better use g_strdup_printf() instead (with g_free() at the end of the
> function) instead.

Good point. I've gone for replacing sprintf() with g_strdup_printf() whenever it
occurs in this file.

>> +    hwaddr fblock_offset = memory_region_size(&dev->slot_mem) - FBLOCK_SIZE;
>> +    memory_region_init_io(&dev->fblock_io, NULL, &nubus_format_block_ops,
>> +                          dev, fblock_name, FBLOCK_SIZE);
>> +    memory_region_add_subregion(&dev->slot_mem, fblock_offset,
>> +                                &dev->fblock_io);
>> +}
> [...]
>> diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
>> index 70ea5480fe..3059f2f36a 100644
>> --- a/include/hw/display/macfb.h
>> +++ b/include/hw/display/macfb.h
>> @@ -39,4 +39,25 @@ typedef struct {
>>      MacfbState macfb;
>>  } MacfbSysBusState;
>>  
>> +#define MACFB_NUBUS_DEVICE_CLASS(class) \
>> +    OBJECT_CLASS_CHECK(MacfbNubusDeviceClass, (class), TYPE_NUBUS_MACFB)
>> +#define MACFB_NUBUS_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(MacfbNubusDeviceClass, (obj), TYPE_NUBUS_MACFB)
>> +
>> +typedef struct MacfbNubusDeviceClass {
>> +    DeviceClass parent_class;
>> +
>> +    DeviceRealize parent_realize;> +} MacfbNubusDeviceClass;
>>
>> +#define TYPE_NUBUS_MACFB "nubus-macfb"
>> +#define NUBUS_MACFB(obj) \
>> +    OBJECT_CHECK(MacfbNubusState, (obj), TYPE_NUBUS_MACFB)
>> +
>> +typedef struct {
>> +    NubusDevice busdev;
>> +
>> +    MacfbState macfb;
>> +} MacfbNubusState;
>> +
>>  #endif
> 
> I think this should rather be part of the next patch instead?

Ooops yes. I've fixed in the latest version of the patch series.


ATB,

Mark.
