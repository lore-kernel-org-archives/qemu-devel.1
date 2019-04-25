Received: from eggs.gnu.org ([209.51.188.92]:45795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1hJnQJ-0000sW-L3
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 19:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1hJnE6-0006Di-30
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:52:23 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:20735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hJnE5-00068u-Pw
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 18:52:22 -0400
Date: Fri, 26 Apr 2019 00:51:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1904142227580.56442@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1904260048210.88235@zero.eik.bme.hu>
References: <20190409110732.5C5FF7465DB@zero.eik.bme.hu>
	<08d40ec6-be36-f2e1-d216-6dd9deb5c1e0@redhat.com>
	<alpine.BSF.2.21.9999.1904142227580.56442@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ati-vga: Fix check for blt outside vram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Andrew Randrianasulu <randrianasulu@gmail.com>

On Sun, 14 Apr 2019, BALATON Zoltan wrote:
> On Tue, 9 Apr 2019, Philippe Mathieu-Daud=C3=A9 wrote:
>> This patch looks 4.0 worthwhile.
>
> Now that it seems we'll have another rc, will this get in? Gerd, I thin=
k you=20
> have to send a pull request with it for that.

Ping? This has missed two rc-s. This prevents a crash so you might want t=
o=20
queue it for stable as well now.

Regards,
BALATON Zoltan

>
>> On 4/9/19 12:56 PM, BALATON Zoltan wrote:
>>> Fix the check preventing calling pixman functions that would access
>>> memory outside allocated vram. The r128 X driver sometimes seem to tr=
y
>>> blits that span outside vram, this check prevents crashing QEMU in
>>> that case. (The r128 X driver may have problems even on real hardware
>>> so I'm not sure if it's a client bug or emulation problem but at leas=
t
>>> QEMU should survive.)
>>>=20
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>
>>> ---
>>>  hw/display/ati_2d.c | 12 ++++++------
>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
>>> index bc98ba6eeb..fe3ae14864 100644
>>> --- a/hw/display/ati_2d.c
>>> +++ b/hw/display/ati_2d.c
>>> @@ -79,10 +79,10 @@ void ati_2d_blt(ATIVGAState *s)
>>>                  s->regs.dst_width, s->regs.dst_height);
>>>          end =3D s->vga.vram_ptr + s->vga.vram_size;
>>>          if (src_bits >=3D end || dst_bits >=3D end ||
>>> -            src_bits + (s->regs.src_y + s->regs.dst_height) * src_st=
ride=20
>>> +
>>> -            s->regs.src_x >=3D end ||
>>> -            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_st=
ride=20
>>> +
>>> -            s->regs.dst_x >=3D end) {
>>> +            src_bits + s->regs.src_x + (s->regs.src_y +=20
>>> s->regs.dst_height) *
>>> +            src_stride * sizeof(uint32_t) >=3D end ||
>>> +            dst_bits + s->regs.dst_x + (s->regs.dst_y +=20
>>> s->regs.dst_height) *
>>> +            dst_stride * sizeof(uint32_t) >=3D end) {
>>>              qemu_log_mask(LOG_UNIMP, "blt outside vram not=20
>>> implemented\n");
>>>              return;
>>>          }
>>> @@ -140,8 +140,8 @@ void ati_2d_blt(ATIVGAState *s)
>>>                  filler);
>>>          end =3D s->vga.vram_ptr + s->vga.vram_size;
>>>          if (dst_bits >=3D end ||
>>> -            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_st=
ride=20
>>> +
>>> -            s->regs.dst_x >=3D end) {
>>> +            dst_bits + s->regs.dst_x + (s->regs.dst_y +=20
>>> s->regs.dst_height) *
>>> +            dst_stride * sizeof(uint32_t) >=3D end) {
>>>              qemu_log_mask(LOG_UNIMP, "blt outside vram not=20
>>> implemented\n");
>>>              return;
>>>          }
>>>=20
>>=20
>>=20
>
>
