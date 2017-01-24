Received: from eggs.gnu.org ([2001:4830:134:3::10]:38995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cW3iY-0004BC-MN
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cW3iS-0008Hw-4L
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:13:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cW3iR-0008Hj-SB
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:13:04 -0500
References: <58871f9b.d635240a.4cda6.5322@mx.google.com>
	<237b1da5-532d-afd6-84ad-6adc5bd97291@redhat.com>
	<1485254930.32716.23.camel@redhat.com>
	<b269fc2b-e211-cc70-0b7e-da6b3180df88@redhat.com>
	<1485260998.32716.45.camel@redhat.com> <20170124153143.GA29823@olga.wb>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <dba0324f-e6c1-04e0-da0f-0e06a87d0375@redhat.com>
Date: Tue, 24 Jan 2017 17:12:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170124153143.GA29823@olga.wb>
Content-Type: text/plain; charset=windows-1252
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
To: Wolfgang Bumiller <w.bumiller@proxmox.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: liqiang6-s@360.cn, ghoffman@redhat.com, Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org

On 01/24/17 16:31, Wolfgang Bumiller wrote:
> On Tue, Jan 24, 2017 at 01:29:58PM +0100, Gerd Hoffmann wrote:
>>>>>>      if (pitch < 0) {
>>>>>>          int64_t min = addr
>>>>>> -            + ((int64_t)s->cirrus_blt_height-1) * pitch;
>>>>>> +            + ((int64_t)s->cirrus_blt_height-1) * pitch
>>>>>> +            - s->cirrus_blt_width;
>>>>>>          int32_t max = addr
>>>>>>              + s->cirrus_blt_width;
>>>>>>          if (min < 0 || max > s->vga.vram_size) {
>>>>>>
>>>>>
>>>>> I believe this is incorrect. In this case (AFAIR), "addr" points to the
>>>>> left-most pixel (= lowest address) of the bottom line (= highest
>>>>> address).
>>>>
>>>> If I read the code correctly it is backwards *both* x and y axis, so
>>>> addr is the right-most pixel of the bottom line.
>>>
>>> What is "max" then? If "addr" is the right-most pixel of the bottom
>>> line, then "max" has the highest address just past the rectangle, and
>>> then adding anything non-negative to it makes no sense.
>>
>> That is (with the patch applied) inconsistent indeed.  We must either
>> subtract s->cirrus_blt_width from min (addr == right-most), or add it to
>> max (addr == left-most), but certainly not both.
>>
>>> ... Really as I remember it from the downstream review, the pitch is
>>> negative (bottom-up), but the horizontal direction remains left to right.
>>
>> Looking at cirrus_vga_rop.h I see:
>>  - cirrus_bitblt_rop_fwd_*() increment src and dst while walking the
>>    scanline, and
>>  - cirrus_bitblt_rop_bkwd_*() decrement src and dst ...
>>
>> I still think x axis goes backwards too and therefore addr is the
>> right-most pixel.
> 
> I agree.
> 
> Seeing how I've already been reading through that code I thought I'd
> go over it again and too would say both min and max need to be adapted:
> 
>      if (pitch < 0) {
>          int64_t min = addr
>              + ((int64_t)s->cirrus_blt_height-1) * pitch;
> +            - s->cirrus_blt_width;
>          int32_t max = addr
> -            + s->cirrus_blt_width;
>          if (min < 0 || max > s->vga.vram_size) {
> 
> 
> Here's the rest of my analysis in case anyone's interested (mostly to
> justify the first part of this mail):
> 
> -) Sign of the blit width/height & pitch values at the beginning:
> 
>     |    s->cirrus_blt_width = (s->vga.gr[0x20] | (s->vga.gr[0x21] << 8)) + 1;
>     |    s->cirrus_blt_height = (s->vga.gr[0x22] | (s->vga.gr[0x23] << 8)) + 1;
>     |    s->cirrus_blt_dstpitch = (s->vga.gr[0x24] | (s->vga.gr[0x25] << 8));
>     |    s->cirrus_blt_srcpitch = (s->vga.gr[0x26] | (s->vga.gr[0x27] << 8));
> 
>    vga.gr is an uint8_t[]
> 
> ==> all values are positive at this point
> 
> -) Backward blits invert the sign:
> 
>     |    if (s->cirrus_blt_mode & CIRRUS_BLTMODE_BACKWARDS) {
>     |        s->cirrus_blt_dstpitch = -s->cirrus_blt_dstpitch;
>     |        s->cirrus_blt_srcpitch = -s->cirrus_blt_srcpitch;
> 
> 
> Starting with the simple one:
> 
> -) Forward blits from cirrus_vga_rop.h:
>    Width (which is positive) is subtracted from the pitch (which
>    is also positive), turning srcpitch and dstpitch into values
>    representing the remaining bytes after the current row.
>    The pattern below repeats for all functions:
> 
>       |static void
>       |glue(cirrus_bitblt_rop_fwd_, ROP_NAME)(CirrusVGAState *s,
>       |                             uint8_t *dst,const uint8_t *src,
>       |                             int dstpitch,int srcpitch,
>       |                             int bltwidth,int bltheight)
>       |{
>       |    int x,y;
>       |    dstpitch -= bltwidth;
>       |    srcpitch -= bltwidth;
>       |
>       |    if (bltheight > 1 && (dstpitch < 0 || srcpitch < 0)) {
>       |        return;
>       |    }
>       |
>       |    for (y = 0; y < bltheight; y++) {
>       |        for (x = 0; x < bltwidth; x++) {
>       |            ROP_OP(dst, *src);
>       |            dst++;
>       |            src++;
>       |        }
>       |        dst += dstpitch;
>       |        src += srcpitch;
>       |    }
>       |}
> 
>    The first access to src/dst is unmodified, so the lowest accessed
>    address is the initial address.
> 
>    Some functions iterate through pairs:
>       |   for (x = 0; x < bltwidth; x+=2) {
>       |      p1 = *dst;
>       |      p2 = *(dst+1);
>    Since the loop uses `x += 2` this `+1` should not go out of bounds
>    provided the width is even (which if not the case should at least
>    have an even pitch value).
> 
> Conclusion for forward blits:
>    We use (start + pitch * (height-1) + width) which seems obvious for
>    the main pattern but we also need to assert that the 2nd example
>    above cannot access an additional byte with *(dst+1) after this
>    value. This seems to be okay: for an odd width eg. 5, the highest
>    x value the loop body is executed with will be 4, and we access
>    4+1=5 at most.
> 
> -) Backward blits form cirrus_vga_rop.h:
>    (Pitch is negative, width is positive.)
>    They "add" the width to the pitch (essentially reducing its length),
>    turning the 'dstpitch' and 'srcpitch' variables - as with forward
>    blits - into values representing only the *remaining* bytes "in
>    front of" the data in the current row.
>    The pattern:
> 
>       |glue(cirrus_bitblt_rop_bkwd_, ROP_NAME)(CirrusVGAState *s,
>       |                                        uint8_t *dst,const uint8_t *src,
>       |                                        int dstpitch,int srcpitch,
>       |                                        int bltwidth,int bltheight)
>       |{
>       |    int x,y;
>       |    dstpitch += bltwidth;
>       |    srcpitch += bltwidth;
>       |    for (y = 0; y < bltheight; y++) {
>       |        for (x = 0; x < bltwidth; x++) {
>       |            ROP_OP(dst, *src);
>       |            dst--;
>       |            src--;
>       |        }
>       |        dst += dstpitch;
>       |        src += srcpitch;
>       |    }
>       |}
> 
>    Pitch is negative, first value touched is 'dst' and 'src'
>    unmodified. The same pattern is used throughout the rest of the
>    header.
> 
>    As far as I can see the 'bkwd' ops only ever subtract from the
>    addresses (note that in `X += Xpitch`, Xpitch is negative), and
>    like with forward blits we have at most a 'src-1' (not +1 this
>    time) access in a loop body where we iterate over pairs, so the
>    same reasoning holds here.
> 
> Conclusion for backward blits:
>    1) We should use: (addr + (height-1)*pitch - width) but originally
>       missed the `-with` part there.
> 
>    2) The maximum value should actually be `addr` itself as far as I
>       can tell, so the `+ s->cirrus_blt_width` for max should be
>       dropped.

You (and Gerd) are correct.

I've just looked up my original downstream review of this patch
("cirrus: fix blit region check", now commit d3532a0db022 in upstream).
While at that time I range-checked everything and their grandma, and
found (with Gerd's feedback) those aspects safe, I only *assumed* that
for the negative pitch case, "addr" would point to the bottom left
corner of the rectangle:

On 01/15/15 12:21, Laszlo Ersek wrote:

> The negative pitch means (I think) that "addr" points to the lower
> left corner of the rectangle.
>
> The second part guarantees that the last blitted byte fits (lower
> right corner).

To which Gerd responded "upper left". In retrospect I don't understand
why we didn't discuss that question further, as it now seems that we
were both wrong -- "addr" stands for bottom right, in the negative pitch
case.

So, I agree that we should subtract width from both min and max here.

The current discussion has proved that the blit_region_is_unsafe()
function is incorrect ATM -- in a backwards blit, the guest can advance
to lower addresses than the "min" value we calculate and enforce to be
non-negative.

Unfortunately, the original patch was meant to address the
then-embargoed CVE-2014-8106. Since we have a bug in that code (= a
security fix), this issue should have been reported privately as well,
and another embargo would have been justified. We need to fix this ASAP,
and a new CVE should be requested; the cat is now out of the bag.

Thanks
Laszlo

> 
> 
> The functions in cirrus_vga_rop2.h are a bitmore complex. The safety
> checks *may* even be too strict in some cases but I haven't seen any
> aftefacts coming from too strong *range* checks (only the zero pitch
> check for which I sent a patch yesterday which I need to make a v2 for
> now :|).
> (Too strict in the pattern functions which clamp the source offsets
> with bitands, but I really don't feel like looking deep enough into
> this to make the checks even lighter :p)
> 
