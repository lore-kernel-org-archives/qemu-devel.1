Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF28C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 23:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D28206A1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 23:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D28206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4v8a-0004Hk-81
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 19:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k4v80-0003qg-Ui
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 19:53:24 -0400
Received: from relay68.bu.edu ([128.197.228.73]:45657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k4v7y-0003AQ-1W
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 19:53:23 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 079NqEnD006116
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 9 Aug 2020 19:52:18 -0400
Date: Sun, 9 Aug 2020 19:52:14 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v3 7/8] hw/display/artist: Refactor artist_rop8() to
 avoid buffer over-runy
Message-ID: <20200809235214.oevaldx22c6wvi32@mozz.bu.edu>
References: <20200804140056.7690-8-deller@gmx.de>
 <20200804163954.4dzistybjwby7pzx@mozz.bu.edu>
 <20200804212019.GA876@ls3530.fritz.box>
 <20200804220145.yjq265pk363466hx@mozz.bu.edu>
 <20200805204459.GA23951@ls3530.fritz.box>
 <20200806154556.ksb2ja3hghxhukdd@mozz.bu.edu>
 <01f10f58-1b29-d7f9-e4d5-6092d69aa127@gmx.de>
 <20200809171714.3qp72ubampclo4f2@mozz.bu.edu>
 <1d16f1cd-a57e-d56c-2e4f-09f594cc86b7@gmx.de>
 <e4c6d48d-8338-b156-7d16-99b5fe97cd64@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4c6d48d-8338-b156-7d16-99b5fe97cd64@gmx.de>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 19:53:20
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
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200809 2151, Helge Deller wrote:
> On 09.08.20 21:38, Helge Deller wrote:
> > On 09.08.20 19:17, Alexander Bulekov wrote:
> >> On 200809 0717, Helge Deller wrote:
> >>> The current tree at
> >>> https://github.com/hdeller/qemu-hppa/commits/target-hppa
> >>> does survive all your tests and in addition fixes an artist bug which
> >>> made the dtwm window manager rendering wrong on HP-UX.
> >>> Please completely revert your tree before pulling again.
> >>> I'll send out a complete patch series shortly.
> >>>
> >> This still causes a segfault for me:
> >>
> >> cat << EOF | ./hppa-softmmu/qemu-system-hppa -m 64 -display none \
> >> -qtest stdio -accel qtest
> >> writew 0xf8118001 0x105a
> >> readq 0xf900f8ff
> >> EOF
> 
> Alexander, I've committed the patch below to the git tree at:
> https://github.com/hdeller/qemu-hppa/tree/target-hppa
> Ok?
> 

Hi Helge,
Yes - I tried this out and it looks like all the test cases are fixed.
Its strange that LP1890370 doesn't reproduce for you. Did you build with
--enable-sanitizers?

For this commit:
https://github.com/hdeller/qemu-hppa/commit/2db0481e69cf8ca764bc0e41c86ac9a037ae4de5
Acked-by: Alexander Bulekov <alxndr@bu.edu>

Thanks!
-Alex

> Helge

> From 0725d38381330138052e282bb61feeacc0c1e50b Mon Sep 17 00:00:00 2001
> From: Helge Deller <deller@gmx.de>
> Date: Wed, 9 Aug 2020 15:35:38 +0200
> Subject: [PATCH] hw/display/artist: Prevent out of VRAM buffer accesses
> 
> Simplify various bounds checks by changing parameters like row and column
> numbers to become unsigned instead of signed.
> With that we can check if the calculated offset is bigger than the size of the
> VRAM region and bail out if not.
> 
> Reported-by: LLVM libFuzzer
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880326
> Buglink: https://bugs.launchpad.net/qemu/+bug/1890310
> Buglink: https://bugs.launchpad.net/qemu/+bug/1890311
> Buglink: https://bugs.launchpad.net/qemu/+bug/1890312
> Buglink: https://bugs.launchpad.net/qemu/+bug/1890370
> Acked-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index f37aa9eb49..46eaa10dae 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -35,9 +35,9 @@
>  struct vram_buffer {
>      MemoryRegion mr;
>      uint8_t *data;
> -    int size;
> -    int width;
> -    int height;
> +    unsigned int size;
> +    unsigned int width;
> +    unsigned int height;
>  };
>  
>  typedef struct ARTISTState {
> @@ -274,15 +274,15 @@ static artist_rop_t artist_get_op(ARTISTState *s)
>  }
>  
>  static void artist_rop8(ARTISTState *s, struct vram_buffer *buf,
> -                        int offset, uint8_t val)
> +                        unsigned int offset, uint8_t val)
>  {
>      const artist_rop_t op = artist_get_op(s);
>      uint8_t plane_mask;
>      uint8_t *dst;
>  
> -    if (offset < 0 || offset >= buf->size) {
> +    if (offset >= buf->size) {
>          qemu_log_mask(LOG_GUEST_ERROR,
> -                      "rop8 offset:%d bufsize:%u\n", offset, buf->size);
> +                      "rop8 offset:%u bufsize:%u\n", offset, buf->size);
>          return;
>      }
>      dst = buf->data + offset;
> @@ -294,8 +294,7 @@ static void artist_rop8(ARTISTState *s, struct vram_buffer *buf,
>          break;
>  
>      case ARTIST_ROP_COPY:
> -        *dst &= ~plane_mask;
> -        *dst |= val & plane_mask;
> +        *dst = (*dst & ~plane_mask) | (val & plane_mask);
>          break;
>  
>      case ARTIST_ROP_XOR:
> @@ -349,7 +348,8 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>  {
>      struct vram_buffer *buf;
>      uint32_t vram_bitmask = s->vram_bitmask;
> -    int mask, i, pix_count, pix_length, offset, width;
> +    int mask, i, pix_count, pix_length;
> +    unsigned int offset, width;
>      uint8_t *data8, *p;
>  
>      pix_count = vram_write_pix_per_transfer(s);
> @@ -364,8 +364,7 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>          offset = posy * width + posx;
>      }
>  
> -    if (!buf->size) {
> -        qemu_log("write to non-existent buffer\n");
> +    if (!buf->size || offset >= buf->size) {
>          return;
>      }
>  
> @@ -394,7 +393,9 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>  
>      case 3:
>          if (s->cmap_bm_access) {
> -            *(uint32_t *)(p + offset) = data;
> +            if (offset + 3 < buf->size) {
> +                *(uint32_t *)(p + offset) = data;
> +            }
>              break;
>          }
>          data8 = (uint8_t *)&data;
> @@ -464,12 +465,14 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>      }
>  }
>  
> -static void block_move(ARTISTState *s, int source_x, int source_y, int dest_x,
> -                       int dest_y, int width, int height)
> +static void block_move(ARTISTState *s,
> +                       unsigned int source_x, unsigned int source_y,
> +                       unsigned int dest_x,   unsigned int dest_y,
> +                       unsigned int width,    unsigned int height)
>  {
>      struct vram_buffer *buf;
>      int line, endline, lineincr, startcolumn, endcolumn, columnincr, column;
> -    uint32_t dst, src;
> +    unsigned int dst, src;
>  
>      trace_artist_block_move(source_x, source_y, dest_x, dest_y, width, height);
>  
> @@ -481,6 +484,12 @@ static void block_move(ARTISTState *s, int source_x, int source_y, int dest_x,
>      }
>  
>      buf = &s->vram_buffer[ARTIST_BUFFER_AP];
> +    if (height > buf->height) {
> +        height = buf->height;
> +    }
> +    if (width > buf->width) {
> +        width = buf->width;
> +    }
>  
>      if (dest_y > source_y) {
>          /* move down */
> @@ -507,24 +516,27 @@ static void block_move(ARTISTState *s, int source_x, int source_y, int dest_x,
>      }
>  
>      for ( ; line != endline; line += lineincr) {
> -        src = source_x + ((line + source_y) * buf->width);
> -        dst = dest_x + ((line + dest_y) * buf->width);
> +        src = source_x + ((line + source_y) * buf->width) + startcolumn;
> +        dst = dest_x + ((line + dest_y) * buf->width) + startcolumn;
>  
>          for (column = startcolumn; column != endcolumn; column += columnincr) {
> -            if (dst + column > buf->size || src + column > buf->size) {
> +            if (dst >= buf->size || src >= buf->size) {
>                  continue;
>              }
> -            artist_rop8(s, buf, dst + column, buf->data[src + column]);
> +            artist_rop8(s, buf, dst, buf->data[src]);
> +            src += columnincr;
> +            dst += columnincr;
>          }
>      }
>  
>      artist_invalidate_lines(buf, dest_y, height);
>  }
>  
> -static void fill_window(ARTISTState *s, int startx, int starty,
> -                        int width, int height)
> +static void fill_window(ARTISTState *s,
> +                        unsigned int startx, unsigned int starty,
> +                        unsigned int width,  unsigned int height)
>  {
> -    uint32_t offset;
> +    unsigned int offset;
>      uint8_t color = artist_get_color(s);
>      struct vram_buffer *buf;
>      int x, y;
> @@ -561,7 +573,9 @@ static void fill_window(ARTISTState *s, int startx, int starty,
>      artist_invalidate_lines(buf, starty, height);
>  }
>  
> -static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
> +static void draw_line(ARTISTState *s,
> +                      unsigned int x1, unsigned int y1,
> +                      unsigned int x2, unsigned int y2,
>                        bool update_start, int skip_pix, int max_pix)
>  {
>      struct vram_buffer *buf = &s->vram_buffer[ARTIST_BUFFER_AP];
> @@ -571,12 +585,12 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
>  
>      trace_artist_draw_line(x1, y1, x2, y2);
>  
> -    if (x1 * y1 >= buf->size || x2 * y2 >= buf->size) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "draw_line (%d,%d) (%d,%d)\n", x1, y1, x2, y2);
> -        return;
> +    if ((x1 >= buf->width && x2 >= buf->width) ||
> +        (y1 >= buf->height && y2 >= buf->height)) {
> +	return;
>      }
>  
> +
>      if (update_start) {
>          s->vram_start = (x2 << 16) | y2;
>      }
> @@ -633,7 +647,7 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
>      color = artist_get_color(s);
>  
>      do {
> -        int ofs;
> +        unsigned int ofs;
>  
>          if (c1) {
>              ofs = x * s->width + y;
> @@ -765,13 +779,14 @@ static void font_write16(ARTISTState *s, uint16_t val)
>      uint16_t mask;
>      int i;
>  
> -    int startx = artist_get_x(s->vram_start);
> -    int starty = artist_get_y(s->vram_start) + s->font_write_pos_y;
> -    int offset = starty * s->width + startx;
> +    unsigned int startx = artist_get_x(s->vram_start);
> +    unsigned int starty = artist_get_y(s->vram_start) + s->font_write_pos_y;
> +    unsigned int offset = starty * s->width + startx;
>  
>      buf = &s->vram_buffer[ARTIST_BUFFER_AP];
>  
> -    if (offset + 16 > buf->size) {
> +    if (startx >= buf->width || starty >= buf->height ||
> +        offset + 16 >= buf->size) {
>          return;
>      }
>  
> @@ -1135,7 +1150,7 @@ static void artist_vram_write(void *opaque, hwaddr addr, uint64_t val,
>      struct vram_buffer *buf;
>      int posy = (addr >> 11) & 0x3ff;
>      int posx = addr & 0x7ff;
> -    uint32_t offset;
> +    unsigned int offset;
>      trace_artist_vram_write(size, addr, val);
>  
>      if (s->cmap_bm_access) {
> @@ -1156,18 +1171,28 @@ static void artist_vram_write(void *opaque, hwaddr addr, uint64_t val,
>      }
>  
>      offset = posy * buf->width + posx;
> +    if (offset >= buf->size) {
> +        return;
> +    }
> +
>      switch (size) {
>      case 4:
> -        *(uint32_t *)(buf->data + offset) = be32_to_cpu(val);
> -        memory_region_set_dirty(&buf->mr, offset, 4);
> +        if (offset + 3 < buf->size) {
> +            *(uint32_t *)(buf->data + offset) = be32_to_cpu(val);
> +            memory_region_set_dirty(&buf->mr, offset, 4);
> +        }
>          break;
>      case 2:
> -        *(uint16_t *)(buf->data + offset) = be16_to_cpu(val);
> -        memory_region_set_dirty(&buf->mr, offset, 2);
> +        if (offset + 1 < buf->size) {
> +            *(uint16_t *)(buf->data + offset) = be16_to_cpu(val);
> +            memory_region_set_dirty(&buf->mr, offset, 2);
> +        }
>          break;
>      case 1:
> -        *(uint8_t *)(buf->data + offset) = val;
> -        memory_region_set_dirty(&buf->mr, offset, 1);
> +        if (offset < buf->size) {
> +            *(uint8_t *)(buf->data + offset) = val;
> +            memory_region_set_dirty(&buf->mr, offset, 1);
> +        }
>          break;
>      default:
>          break;
> @@ -1183,9 +1208,12 @@ static uint64_t artist_vram_read(void *opaque, hwaddr addr, unsigned size)
>  
>      if (s->cmap_bm_access) {
>          buf = &s->vram_buffer[ARTIST_BUFFER_CMAP];
> -        val = *(uint32_t *)(buf->data + addr);
> +        val = 0;
> +        if (addr < buf->size && addr + 3 < buf->size) {
> +            val = *(uint32_t *)(buf->data + addr);
> +        }
>          trace_artist_vram_read(size, addr, 0, 0, val);
> -        return 0;
> +        return val;
>      }
>  
>      buf = vram_read_buffer(s);


