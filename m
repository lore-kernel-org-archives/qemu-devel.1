Received: from eggs.gnu.org ([2001:4830:134:3::10]:37353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cVzDc-0006Fz-40
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cVzDY-0007NI-Ub
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:24:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cVzDY-0007N6-MT
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:24:52 -0500
References: <58871f9b.d635240a.4cda6.5322@mx.google.com>
	<237b1da5-532d-afd6-84ad-6adc5bd97291@redhat.com>
	<1485254930.32716.23.camel@redhat.com>
	<b269fc2b-e211-cc70-0b7e-da6b3180df88@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a513396f-fbe3-1e03-df83-04c0c6143ace@redhat.com>
Date: Tue, 24 Jan 2017 12:24:49 +0100
MIME-Version: 1.0
In-Reply-To: <b269fc2b-e211-cc70-0b7e-da6b3180df88@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cirrus: fix oob access issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org, ghoffman@redhat.com, liqiang6-s@360.cn

On 01/24/17 12:17, Laszlo Ersek wrote:
> On 01/24/17 11:48, Gerd Hoffmann wrote:
>>>> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
>>>> index 379910d..7ddd289 100644
>>>> --- a/hw/display/cirrus_vga.c
>>>> +++ b/hw/display/cirrus_vga.c
>>>> @@ -277,7 +277,8 @@ static bool blit_region_is_unsafe(struct CirrusVGAState *s,
>>>>      }
>>>>      if (pitch < 0) {
>>>>          int64_t min = addr
>>>> -            + ((int64_t)s->cirrus_blt_height-1) * pitch;
>>>> +            + ((int64_t)s->cirrus_blt_height-1) * pitch
>>>> +            - s->cirrus_blt_width;
>>>>          int32_t max = addr
>>>>              + s->cirrus_blt_width;
>>>>          if (min < 0 || max > s->vga.vram_size) {
>>>>
>>>
>>> I believe this is incorrect. In this case (AFAIR), "addr" points to the
>>> left-most pixel (= lowest address) of the bottom line (= highest
>>> address).
>>
>> If I read the code correctly it is backwards *both* x and y axis, so
>> addr is the right-most pixel of the bottom line.
> 
> What is "max" then? If "addr" is the right-most pixel of the bottom
> line, then "max" has the highest address just past the rectangle, and
> then adding anything non-negative to it makes no sense.

sorry, over-editing caused a bug. I meant

  If "addr" is the right-most pixel of the bottom line (or just one
  past that), then *it* has the highest address, and then adding
  anything non-negative to it (i.e., how we end up with "max") makes no
  sense.

I should have started with the diagram, not with the text.

Thanks
Laszlo

> 
> Adding a negative value to it (i.e., if s->cirrus_blt_width were
> negative) might make sense, for getting the leftmost pixel on the bottom
> line, but then that "max" value shouldn't be used for the final boundary
> check (against RAM size).
> 
> ... Really as I remember it from the downstream review, the pitch is
> negative (bottom-up), but the horizontal direction remains left to right.
> 
> 0-----------------------------------------------------------------> x
> |
> |   addr + (height - 1) * pitch, pitch < 0, height > 0
> |   |
> |   v
> |   *--------------------* <-- addr + (height - 1) * pitch + width
> |   |                    |
> |   |                    |
> |   |                    |
> |   |                    |
> |   |                    |
> |   |                    |
> |   *--------------------*
> |   ^                    ^
> |   |                    |
> |   addr                 max = addr + width, width > 0
> |
> v
> y
> 
> 
> The rightmost column represented here is exclusive, the rest is inclusive.
> 
> Thanks
> Laszlo
> 
