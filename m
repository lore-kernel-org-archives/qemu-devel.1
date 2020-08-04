Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5C9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6BB208A9
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6BB208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3021-0006V1-ML
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k2zzq-0002eA-Ek
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:41:02 -0400
Received: from relay64.bu.edu ([128.197.228.104]:45909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k2zzo-0002Un-CS
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:41:01 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 074GdsAO026884
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Aug 2020 12:40:00 -0400
Date: Tue, 4 Aug 2020 12:39:54 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v3 7/8] hw/display/artist: Refactor artist_rop8() to
 avoid buffer over-run
Message-ID: <20200804163954.4dzistybjwby7pzx@mozz.bu.edu>
References: <20200804140056.7690-1-deller@gmx.de>
 <20200804140056.7690-8-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804140056.7690-8-deller@gmx.de>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 12:40:58
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Helge,
I applied this series and it fixes most of the problems I saw before.
I still see a few crashes - I made issues for them on launchpad:
https://bugs.launchpad.net/qemu/+bug/1890310
https://bugs.launchpad.net/qemu/+bug/1890311
https://bugs.launchpad.net/qemu/+bug/1890312

Thanks!
-Alex

On 200804 1600, Helge Deller wrote:
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Invalid I/O writes can craft an offset out of the vram_buffer range.
> Instead of passing an unsafe pointer to artist_rop8(), pass the vram_buffer and
> the offset. We can now check if the offset is in range before accessing it.
> 
> We avoid:
> 
>   Program terminated with signal SIGSEGV, Segmentation fault.
>   284             *dst &= ~plane_mask;
>   (gdb) bt
>   #0  0x000056367b2085c0 in artist_rop8 (s=0x56367d38b510, dst=0x7f9f972fffff <error: Cannot access memory at address 0x7f9f972fffff>, val=0 '\000') at hw/display/artist.c:284
>   #1  0x000056367b209325 in draw_line (s=0x56367d38b510, x1=-20480, y1=-1, x2=0, y2=17920, update_start=true, skip_pix=-1, max_pix=-1) at hw/display/artist.c:646
> 
> Reported-by: LLVM libFuzzer
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880326
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/display/artist.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index a206afe641..47de17b9e9 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -273,11 +273,20 @@ static artist_rop_t artist_get_op(ARTISTState *s)
>      return (s->image_bitmap_op >> 8) & 0xf;
>  }
> 
> -static void artist_rop8(ARTISTState *s, uint8_t *dst, uint8_t val)
> +static void artist_rop8(ARTISTState *s, struct vram_buffer *buf,
> +                        int offset, uint8_t val)
>  {
> -
>      const artist_rop_t op = artist_get_op(s);
> -    uint8_t plane_mask = s->plane_mask & 0xff;
> +    uint8_t plane_mask;
> +    uint8_t *dst;
> +
> +    if (offset < 0 || offset >= buf->size) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "rop8 offset:%d bufsize:%u\n", offset, buf->size);
> +        return;
> +    }
> +    dst = buf->data + offset;
> +    plane_mask = s->plane_mask & 0xff;
> 
>      switch (op) {
>      case ARTIST_ROP_CLEAR:
> @@ -375,7 +384,7 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>          for (i = 0; i < pix_count; i++) {
>              uint32_t off = offset + pix_count - 1 - i;
>              if (off < buf->size) {
> -                artist_rop8(s, p + off,
> +                artist_rop8(s, buf, off,
>                              (data & 1) ? (s->plane_mask >> 24) : 0);
>              }
>              data >>= 1;
> @@ -395,7 +404,7 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>                  s->vram_bitmask & (1 << (28 + i))) {
>                  uint32_t off = offset + 3 - i;
>                  if (off < buf->size) {
> -                    artist_rop8(s, p + off, data8[ROP8OFF(i)]);
> +                    artist_rop8(s, buf, off, data8[ROP8OFF(i)]);
>                  }
>              }
>          }
> @@ -424,10 +433,10 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>              if (!(s->image_bitmap_op & 0x20000000) ||
>                  (vram_bitmask & mask)) {
>                  if (data & mask) {
> -                    artist_rop8(s, p + offset + i, s->fg_color);
> +                    artist_rop8(s, buf, offset + i, s->fg_color);
>                  } else {
>                      if (!(s->image_bitmap_op & 0x10000002)) {
> -                        artist_rop8(s, p + offset + i, s->bg_color);
> +                        artist_rop8(s, buf, offset + i, s->bg_color);
>                      }
>                  }
>              }
> @@ -505,7 +514,7 @@ static void block_move(ARTISTState *s, int source_x, int source_y, int dest_x,
>              if (dst + column > buf->size || src + column > buf->size) {
>                  continue;
>              }
> -            artist_rop8(s, buf->data + dst + column, buf->data[src + column]);
> +            artist_rop8(s, buf, dst + column, buf->data[src + column]);
>          }
>      }
> 
> @@ -546,7 +555,7 @@ static void fill_window(ARTISTState *s, int startx, int starty,
>          offset = y * s->width;
> 
>          for (x = startx; x < startx + width; x++) {
> -            artist_rop8(s, buf->data + offset + x, color);
> +            artist_rop8(s, buf, offset + x, color);
>          }
>      }
>      artist_invalidate_lines(buf, starty, height);
> @@ -559,7 +568,6 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
>      uint8_t color;
>      int dx, dy, t, e, x, y, incy, diago, horiz;
>      bool c1;
> -    uint8_t *p;
> 
>      trace_artist_draw_line(x1, y1, x2, y2);
> 
> @@ -628,16 +636,18 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
>      color = artist_get_color(s);
> 
>      do {
> +        int ofs;
> +
>          if (c1) {
> -            p = buf->data + x * s->width + y;
> +            ofs = x * s->width + y;
>          } else {
> -            p = buf->data + y * s->width + x;
> +            ofs = y * s->width + x;
>          }
> 
>          if (skip_pix > 0) {
>              skip_pix--;
>          } else {
> -            artist_rop8(s, p, color);
> +            artist_rop8(s, buf, ofs, color);
>          }
> 
>          if (e > 0) {
> @@ -771,10 +781,10 @@ static void font_write16(ARTISTState *s, uint16_t val)
>      for (i = 0; i < 16; i++) {
>          mask = 1 << (15 - i);
>          if (val & mask) {
> -            artist_rop8(s, buf->data + offset + i, color);
> +            artist_rop8(s, buf, offset + i, color);
>          } else {
>              if (!(s->image_bitmap_op & 0x20000000)) {
> -                artist_rop8(s, buf->data + offset + i, s->bg_color);
> +                artist_rop8(s, buf, offset + i, s->bg_color);
>              }
>          }
>      }
> --
> 2.21.3
> 
> 

