Received: from eggs.gnu.org ([209.51.188.92]:54865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDqPG-0002Cw-08
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDqPE-0004IC-Uk
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:03:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDqPE-0004GE-LZ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:03:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so3401934wmf.5
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 06:03:16 -0700 (PDT)
References: <20190409110732.5C5FF7465DB@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <08d40ec6-be36-f2e1-d216-6dd9deb5c1e0@redhat.com>
Date: Tue, 9 Apr 2019 15:03:13 +0200
MIME-Version: 1.0
In-Reply-To: <20190409110732.5C5FF7465DB@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ati-vga: Fix check for blt outside vram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Andrew Randrianasulu <randrianasulu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This patch looks 4.0 worthwhile.

On 4/9/19 12:56 PM, BALATON Zoltan wrote:
> Fix the check preventing calling pixman functions that would access
> memory outside allocated vram. The r128 X driver sometimes seem to try
> blits that span outside vram, this check prevents crashing QEMU in
> that case. (The r128 X driver may have problems even on real hardware
> so I'm not sure if it's a client bug or emulation problem but at least
> QEMU should survive.)
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Tested-by: Andrew Randrianasulu <randrianasulu@gmail.com>
> ---
>  hw/display/ati_2d.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index bc98ba6eeb..fe3ae14864 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -79,10 +79,10 @@ void ati_2d_blt(ATIVGAState *s)
>                  s->regs.dst_width, s->regs.dst_height);
>          end = s->vga.vram_ptr + s->vga.vram_size;
>          if (src_bits >= end || dst_bits >= end ||
> -            src_bits + (s->regs.src_y + s->regs.dst_height) * src_stride +
> -            s->regs.src_x >= end ||
> -            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_stride +
> -            s->regs.dst_x >= end) {
> +            src_bits + s->regs.src_x + (s->regs.src_y + s->regs.dst_height) *
> +            src_stride * sizeof(uint32_t) >= end ||
> +            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_height) *
> +            dst_stride * sizeof(uint32_t) >= end) {
>              qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>              return;
>          }
> @@ -140,8 +140,8 @@ void ati_2d_blt(ATIVGAState *s)
>                  filler);
>          end = s->vga.vram_ptr + s->vga.vram_size;
>          if (dst_bits >= end ||
> -            dst_bits + (s->regs.dst_y + s->regs.dst_height) * dst_stride +
> -            s->regs.dst_x >= end) {
> +            dst_bits + s->regs.dst_x + (s->regs.dst_y + s->regs.dst_height) *
> +            dst_stride * sizeof(uint32_t) >= end) {
>              qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>              return;
>          }
> 
