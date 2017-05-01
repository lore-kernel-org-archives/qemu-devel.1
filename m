Received: from eggs.gnu.org ([2001:4830:134:3::10]:47186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d54YU-0006Pe-Sa
	for qemu-devel@nongnu.org; Mon, 01 May 2017 02:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1d54YP-0005am-Tv
	for qemu-devel@nongnu.org; Mon, 01 May 2017 02:11:30 -0400
Received: from chuckie.co.uk ([82.165.15.123]:56625
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1d54YP-0005WW-M5
	for qemu-devel@nongnu.org; Mon, 01 May 2017 02:11:25 -0400
References: <1492763327-12742-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1492763327-12742-12-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CAFEAcA-V+6i-eQFiyBCki0-cYuQ=NvUo9raFphv=fz2-doVUqg@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <fceccecc-eb7f-f277-5fab-d0d0440b7bcf@ilande.co.uk>
Date: Mon, 1 May 2017 07:10:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-V+6i-eQFiyBCki0-cYuQ=NvUo9raFphv=fz2-doVUqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/13] tcx: remove primitives for
 non-32-bit surfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 25/04/17 15:54, Peter Maydell wrote:

> On 21 April 2017 at 09:28, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> As all surfaces in QEMU are now either shared or 32-bit ARGB regardless of
>> the guest depth, remove all non-32-bit primitives from tcx_update_display()
>> and consequence their implementation which are no longer required.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  hw/display/tcx.c |  126 ++++--------------------------------------------------
>>  1 file changed, 8 insertions(+), 118 deletions(-)
>>
>> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
>> index 0dd007e..6da6dfb 100644
>> --- a/hw/display/tcx.c
>> +++ b/hw/display/tcx.c
>> @@ -140,25 +140,12 @@ static void update_palette_entries(TCXState *s, int start, int end)
>>      int i;
>>
>>      for (i = start; i < end; i++) {
>> -        switch (surface_bits_per_pixel(surface)) {
>> -        default:
>> -        case 8:
>> -            s->palette[i] = rgb_to_pixel8(s->r[i], s->g[i], s->b[i]);
>> -            break;
>> -        case 15:
>> -            s->palette[i] = rgb_to_pixel15(s->r[i], s->g[i], s->b[i]);
>> -            break;
>> -        case 16:
>> -            s->palette[i] = rgb_to_pixel16(s->r[i], s->g[i], s->b[i]);
>> -            break;
>> -        case 32:
>> -            if (is_surface_bgr(surface)) {
>> -                s->palette[i] = rgb_to_pixel32bgr(s->r[i], s->g[i], s->b[i]);
>> -            } else {
>> -                s->palette[i] = rgb_to_pixel32(s->r[i], s->g[i], s->b[i]);
>> -            }
>> -            break;
>> +        if (is_surface_bgr(surface)) {
>> +            s->palette[i] = rgb_to_pixel32bgr(s->r[i], s->g[i], s->b[i]);
>> +        } else {
>> +            s->palette[i] = rgb_to_pixel32(s->r[i], s->g[i], s->b[i]);
>>          }
>> +        break;
>>      }
> 
> Something's gone wrong here. Coverity points out that we now
> have a for() loop that only executes once, because it ends
> with a "break" statement. Looks like the 'break' from inside
> the 'case 32:' was retained when the switch was deleted,
> and it should just be deleted?

Ooops, yes indeed it looks like I fat-fingered the delete. I'll send a
patch to remove this.


ATB,

Mark.
