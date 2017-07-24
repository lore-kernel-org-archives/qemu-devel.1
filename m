Received: from eggs.gnu.org ([2001:4830:134:3::10]:41164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZlAr-0005BQ-DX
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZlAq-0006Mh-Hz
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:45:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-23-f4bug@amsat.org>
	<CAFEAcA9dciLWNYce7+4HjW1Cu4pEJ1V9gHQ2pokBECCj0mp1QA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1c5022a5-8036-36b7-d167-4c187ea7dbc2@amsat.org>
Date: Mon, 24 Jul 2017 18:45:43 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9dciLWNYce7+4HjW1Cu4pEJ1V9gHQ2pokBECCj0mp1QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 22/35] arm/vexpress: fix potential
 memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 07/24/2017 06:11 PM, Peter Maydell wrote:
> On 24 July 2017 at 19:27, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Reorder to only allocate if required.
>>
>> hw/arm/vexpress.c:667:13: warning: Potential leak of memory pointed to by 'flashalias'
>>
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/arm/vexpress.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
>> index 528c65ddb6..76c4d84482 100644
>> --- a/hw/arm/vexpress.c
>> +++ b/hw/arm/vexpress.c
>> @@ -553,8 +553,6 @@ static void vexpress_common_init(MachineState *machine)
>>       MemoryRegion *sysmem = get_system_memory();
>>       MemoryRegion *vram = g_new(MemoryRegion, 1);
>>       MemoryRegion *sram = g_new(MemoryRegion, 1);
>> -    MemoryRegion *flashalias = g_new(MemoryRegion, 1);
>> -    MemoryRegion *flash0mem;
>>       const hwaddr *map = daughterboard->motherboard_map;
>>       int i;
>>
>> @@ -657,6 +655,9 @@ static void vexpress_common_init(MachineState *machine)
>>       }
>>
>>       if (map[VE_NORFLASHALIAS] != -1) {
>> +        MemoryRegion *flashalias = g_new(MemoryRegion, 1);
>> +        MemoryRegion *flash0mem;
>> +
>>           /* Map flash 0 as an alias into low memory */
>>           flash0mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(pflash0), 0);
>>           memory_region_init_alias(flashalias, NULL, "vexpress.flashalias",
>> --
>> 2.13.3
> 
> flashalias is no different from any of the other MemoryRegion*
> variables we allocate here with g_new() -- they all
> leak, and it doesn't matter because the function
> runs once and we want the MemoryRegions to survive
> until the end of the simulation.
> 
> These days we could in theory clean this up by
> switching from doing g_new() to having a set of
> MemoryRegion fields in the VexpressMachineState
> struct (compare hw/arm/mps2.c).

I agree with the analyzer here, why allocate something you'll never use?
However this is not the case here since in your commit 6ec1588e097 both 
legacy/a9 and aseries/a15 use NORFLASHALIAS to remap their flash at 0.

Anyway patch dropped.

Thanks,

Phil.
