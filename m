Received: from eggs.gnu.org ([2001:4830:134:3::10]:58069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1czL7d-0001NO-ES
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 06:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1czL7Z-0003Af-H7
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 06:40:05 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1czL7Z-0003A7-Aj
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 06:40:01 -0400
Received: by mail-wr0-x231.google.com with SMTP id z109so61194986wrb.1
	for <qemu-devel@nongnu.org>; Sat, 15 Apr 2017 03:40:01 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170404102315.24923-1-kraxel@redhat.com>
	<20170404102315.24923-4-kraxel@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d00b49ff-f541-78c8-2d68-4fa4e76ae8de@twiddle.net>
Date: Sat, 15 Apr 2017 03:39:53 -0700
MIME-Version: 1.0
In-Reply-To: <20170404102315.24923-4-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/10] vga: add vga_scanline_invalidated
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 04/04/2017 03:23 AM, Gerd Hoffmann wrote:
> +static bool vga_scanline_invalidated(VGACommonState *s, int y)
> +{
> +    if (y >= VGA_MAX_HEIGHT) {
> +        return false;
> +    }
> +    return s->invalidated_y_table[y >> 5] |= 1 << (y & 0x1f);
> +}
> +
>  void vga_sync_dirty_bitmap(VGACommonState *s)
>  {
>      memory_region_sync_dirty_bitmap(&s->vram);
> @@ -1638,8 +1646,8 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>          page1 = addr + bwidth - 1;
>          update |= memory_region_get_dirty(&s->vram, page0, page1 - page0,
>                                            DIRTY_MEMORY_VGA);
> -        /* explicit invalidation for the hardware cursor */
> -        update |= (s->invalidated_y_table[y >> 5] >> (y & 0x1f)) & 1;
> +        /* explicit invalidation for the hardware cursor (cirrus only) */
> +        update |= vga_scanline_invalidated(s, y);

The return stmt doesn't match what you're replacing.  Are you really intending 
to modify invalidated_y_table here?


r~
