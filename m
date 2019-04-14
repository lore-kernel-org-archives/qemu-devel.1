Received: from eggs.gnu.org ([209.51.188.92]:43868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1hFllu-00074o-TR
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 16:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1hFllt-00044E-Ue
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 16:30:38 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:28124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hFllt-00041T-IS
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 16:30:37 -0400
Date: Sun, 14 Apr 2019 22:30:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <08d40ec6-be36-f2e1-d216-6dd9deb5c1e0@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1904142227580.56442@zero.eik.bme.hu>
References: <20190409110732.5C5FF7465DB@zero.eik.bme.hu>
	<08d40ec6-be36-f2e1-d216-6dd9deb5c1e0@redhat.com>
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
Cc: qemu-devel@nongnu.org, =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Andrew Randrianasulu <randrianasulu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, 9 Apr 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> This patch looks 4.0 worthwhile.

Now that it seems we'll have another rc, will this get in? Gerd, I think=20
you have to send a pull request with it for that.

Regards,
BALATON Zoltan

> On 4/9/19 12:56 PM, BALATON Zoltan wrote:
>> Fix the check preventing calling pixman functions that would access
>> memory outside allocated vram. The r128 X driver sometimes seem to try
>> blits that span outside vram, this check prevents crashing QEMU in
>> that case. (The r128 X driver may have problems even on real hardware
>> so I'm not sure if it's a client bug or emulation problem but at least
>> QEMU should survive.)
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>
>> ---
>>  hw/display/ati_2d.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
>> index bc98ba6eeb..fe3ae14864 100644
>> --- a/hw/display/ati_2d.c
>> +++ b/hw/display/ati_2d.c
>> @@ -79,10 +79,10 @@ void ati_2d_blt(ATIVGAState *s)
>>                  s->regs.dst_width, s->regs.dst_height);
>>          end =3D s->vga.vram_ptr + s->vga.vram_size;
>>          if (src_bits >=3D end || dst_bits >=3D end ||
>> -            src_bits + (s->regs.src_y + s->regs.dst_height) * src_str=
ide +
>> -            s->regs.src_x >=3D end ||
>> -            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_str=
ide +
>> -            s->regs.dst_x >=3D end) {
>> +            src_bits + s->regs.src_x + (s->regs.src_y + s->regs.dst_h=
eight) *
>> +            src_stride * sizeof(uint32_t) >=3D end ||
>> +            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_h=
eight) *
>> +            dst_stride * sizeof(uint32_t) >=3D end) {
>>              qemu_log_mask(LOG_UNIMP, "blt outside vram not implemente=
d\n");
>>              return;
>>          }
>> @@ -140,8 +140,8 @@ void ati_2d_blt(ATIVGAState *s)
>>                  filler);
>>          end =3D s->vga.vram_ptr + s->vga.vram_size;
>>          if (dst_bits >=3D end ||
>> -            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_str=
ide +
>> -            s->regs.dst_x >=3D end) {
>> +            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_h=
eight) *
>> +            dst_stride * sizeof(uint32_t) >=3D end) {
>>              qemu_log_mask(LOG_UNIMP, "blt outside vram not implemente=
d\n");
>>              return;
>>          }
>>
>
>
