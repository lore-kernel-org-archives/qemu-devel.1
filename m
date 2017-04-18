Received: from eggs.gnu.org ([2001:4830:134:3::10]:43245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d0UOl-0002LD-1D
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d0UOh-0005IJ-M6
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:46:31 -0400
Received: from chuckie.co.uk ([82.165.15.123]:38174
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d0UOh-0005GL-ER
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:46:27 -0400
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1491381329-3995-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<46f6de36-7e4a-046c-b9c0-21b873422cb5@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3edf454c-0079-a3af-c05a-3bfddfa6910d@ilande.co.uk>
Date: Tue, 18 Apr 2017 15:46:00 +0100
MIME-Version: 1.0
In-Reply-To: <46f6de36-7e4a-046c-b9c0-21b873422cb5@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/14] tcx: alter tcx_set_dirty() to accept
 address and length parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, kraxel@redhat.com, qemu-devel@nongnu.org

On 15/04/17 15:27, Philippe Mathieu-Daudé wrote:

Hi Philippe,

> Hi Mark,
> 
> On 04/05/2017 05:35 AM, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/display/tcx.c |   12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
>> index 8e26aae..d24466f 100644
>> --- a/hw/display/tcx.c
>> +++ b/hw/display/tcx.c
>> @@ -93,9 +93,9 @@ typedef struct TCXState {
>>      uint16_t cursy;
>>  } TCXState;
>>
>> -static void tcx_set_dirty(TCXState *s)
>> +static void tcx_set_dirty(TCXState *s, ram_addr_t addr, int len)
> 
> len is uint64_t

Yes, this was deliberate in order to match the existing tcx_* functions
in the same file which tend to use int for len/width parameters. Note
that TCX is fixed 1024x768 resolution giving a maximum len of ~800K so
there is no risk of overflow here.

> with this change:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> This function can also be inlined.

My current understanding is that these days compilers tend to handle
inlining themselves and inline is either a no-op or a very weak hint?

>>  {
>> -    memory_region_set_dirty(&s->vram_mem, 0, MAXX * MAXY);
>> +    memory_region_set_dirty(&s->vram_mem, addr, len);
>>  }
>>
>>  static inline int tcx24_check_dirty(TCXState *s, ram_addr_t page,
>> @@ -156,7 +156,7 @@ static void update_palette_entries(TCXState *s,
>> int start, int end)
>>              break;
>>          }
>>      }
>> -    tcx_set_dirty(s);
>> +    tcx_set_dirty(s, 0, memory_region_size(&s->vram_mem));
>>  }
>>
>>  static void tcx_draw_line32(TCXState *s1, uint8_t *d,
>> @@ -526,7 +526,7 @@ static void tcx_invalidate_display(void *opaque)
>>  {
>>      TCXState *s = opaque;
>>
>> -    tcx_set_dirty(s);
>> +    tcx_set_dirty(s, 0, memory_region_size(&s->vram_mem));
>>      qemu_console_resize(s->con, s->width, s->height);
>>  }
>>
>> @@ -534,7 +534,7 @@ static void tcx24_invalidate_display(void *opaque)
>>  {
>>      TCXState *s = opaque;
>>
>> -    tcx_set_dirty(s);
>> +    tcx_set_dirty(s, 0, memory_region_size(&s->vram_mem));
>>      qemu_console_resize(s->con, s->width, s->height);
>>  }
>>
>> @@ -543,7 +543,7 @@ static int vmstate_tcx_post_load(void *opaque, int
>> version_id)
>>      TCXState *s = opaque;
>>
>>      update_palette_entries(s, 0, 256);
>> -    tcx_set_dirty(s);
>> +    tcx_set_dirty(s, 0, memory_region_size(&s->vram_mem));
>>      return 0;
>>  }

ATB,

Mark.
