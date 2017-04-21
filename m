Received: from eggs.gnu.org ([2001:4830:134:3::10]:34896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1SZM-0002ah-Uc
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d1SZJ-0004bo-Sl
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:01:29 -0400
Received: from chuckie.co.uk ([82.165.15.123]:49754
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d1SZJ-0004a7-Ke
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:01:25 -0400
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1491381329-3995-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<f56ec3d4-236e-2082-db5a-8402eb050503@twiddle.net>
	<03d1cb2e-7b0d-7ae1-a884-413cf388762e@ilande.co.uk>
	<56405e09-c3ad-f8dc-7946-2f458727e482@twiddle.net>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <df8a5fdf-a364-91fb-7ef8-08e106ab1374@ilande.co.uk>
Date: Fri, 21 Apr 2017 08:00:56 +0100
MIME-Version: 1.0
In-Reply-To: <56405e09-c3ad-f8dc-7946-2f458727e482@twiddle.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/14] cg3: remove unused width and height
 variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, kraxel@redhat.com, qemu-devel@nongnu.org

On 18/04/17 15:55, Richard Henderson wrote:

> On 04/18/2017 07:38 AM, Mark Cave-Ayland wrote:
>> On 15/04/17 11:54, Richard Henderson wrote:
>>
>>> On 04/05/2017 01:35 AM, Mark Cave-Ayland wrote:
>>>> These aren't required since we can use the display width and height
>>>> directly.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> ---
>>>>  hw/display/cg3.c |   15 ++++++---------
>>>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
>>>> index b42f60e..178a6dd 100644
>>>> --- a/hw/display/cg3.c
>>>> +++ b/hw/display/cg3.c
>>>> @@ -93,14 +93,11 @@ static void cg3_update_display(void *opaque)
>>>>      uint32_t *data;
>>>>      uint32_t dval;
>>>>      int x, y, y_start;
>>>> -    unsigned int width, height;
>>>>      ram_addr_t page, page_min, page_max;
>>>>
>>>>      if (surface_bits_per_pixel(surface) != 32) {
>>>>          return;
>>>>      }
>>>> -    width = s->width;
>>>> -    height = s->height;
>>>>
>>>>      y_start = -1;
>>>>      page_min = -1;
>>>> @@ -110,11 +107,11 @@ static void cg3_update_display(void *opaque)
>>>>      data = (uint32_t *)surface_data(surface);
>>>>
>>>>      memory_region_sync_dirty_bitmap(&s->vram_mem);
>>>> -    for (y = 0; y < height; y++) {
>>>> +    for (y = 0; y < s->height; y++) {
>>>
>>> I suspect the generated code is much worse, since the compiler can no
>>> longer tell that the loop bounds are constant.
>>>
>>> You probably do want to keep width and height in local variables across
>>> this function.
>>
>> Can you explain a bit more about this? My thoughts were that with
>> optimisation enabled the compiler would assume s->width is constant
>> throughout the loop by default (or at least in OpenBIOS I've had to
>> explicitly mark variables as volatile to ensure the compiler refetches
>> the original value instead of reusing a previous copy from the
>> stack/registers)?
> 
> With data in memory, as for foo->bar, the compiler is obliged to
> consider the memory may be changed for e.g. an intervening function call
> baz(), when foo is "global", as it is here.  You have many of those in
> those loops.

Given that you know a lot more about this than I do, I'll drop this
patch for now and send a v2. I see that TCX references s->width in a
similar way, however I'm going to be AFK for a while and so I'll try and
send a PR later today since this is a blocker on Gerd's VGA fixes
patchset - TCX can be altered later in a similar way if it is deemed to
give a noticeable performance benefit.


ATB,

Mark.
