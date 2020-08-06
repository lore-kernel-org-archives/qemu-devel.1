Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E848BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1999B22E01
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1999B22E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3i8C-0003qQ-Tc
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 11:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k3i77-00035r-J6
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:47:29 -0400
Received: from relay64.bu.edu ([128.197.228.104]:51618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k3i73-0006MY-L6
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:47:28 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 076Fk533024834
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Aug 2020 11:46:09 -0400
Date: Thu, 6 Aug 2020 11:46:05 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v3 7/8] hw/display/artist: Refactor artist_rop8() to
 avoid buffer over-run
Message-ID: <20200806154556.ksb2ja3hghxhukdd@mozz.bu.edu>
References: <20200804140056.7690-1-deller@gmx.de>
 <20200804140056.7690-8-deller@gmx.de>
 <20200804163954.4dzistybjwby7pzx@mozz.bu.edu>
 <20200804212019.GA876@ls3530.fritz.box>
 <20200804220145.yjq265pk363466hx@mozz.bu.edu>
 <20200805204459.GA23951@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805204459.GA23951@ls3530.fritz.box>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 11:47:23
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

On 200805 2244, Helge Deller wrote:
> Hello Alexander,
> 
> * Alexander Bulekov <alxndr@bu.edu>:
> > On 200804 2320, Helge Deller wrote:
> > > * Alexander Bulekov <alxndr@bu.edu>:
> > > > I applied this series and it fixes most of the problems I saw before.
> > > > I still see a few crashes - I made issues for them on launchpad:
> > > > https://bugs.launchpad.net/qemu/+bug/1890310
> > > > https://bugs.launchpad.net/qemu/+bug/1890311
> > > > https://bugs.launchpad.net/qemu/+bug/1890312
> > Hi Helge, I can still reproduce this one  ^^^
> > I'll fuzz it some more, but so far I am not finding anything else.
> 
> I've now updated the patch which does address all issues you found
> so far. It's attached below.
> 
> If you like you can pull the full series from
> https://github.com/hdeller/qemu-hppa/commits/target-hppa

Hi Helge,
I pulled from your repo, but I can still reproduce LP1890312
(I build with --enable-sanitizers). Maybe I am missing something? With
this cleared up, I'm happy to leave an Acked-by for the artist patches
in this series.

git show --summary
commit 1657a7a95adc15552138c2b4d310a06128093892 (HEAD, hppa/target-hppa, target-hppa)
Author: Helge Deller <deller@gmx.de>
Date:   Tue Aug 4 15:35:38 2020 +0200

    hw/display/artist: Prevent out of VRAM buffer accesses
...

cat << EOF | ./hppa-softmmu/qemu-system-hppa -m 64 -display none -qtest stdio -accel qtest
writew 0xf8118001 0x105a
readq 0xf900f8ff
EOF
[I 1596728668.114076] OPENED
[R +0.048943] writew 0xf8118001 0x105a
OK
[S +0.048977] OK
[R +0.048994] readq 0xf900f8ff
/home/alxndr/Development/qemu/general-fuzz/hw/display/artist.c:1218:15: runtime error: load of misaligned address 0x7fdbcd40f8ff for type 'uint32_t' (aka 'unsigned int'), which
requires 4 byte alignment
0x7fdbcd40f8ff: note: pointer points here
<memory cannot be printed>
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior /home/alxndr/Development/qemu/general-fuzz/hw/display/artist.c:1218:15 in
AddressSanitizer:DEADLYSIGNAL
=================================================================
==8496==ERROR: AddressSanitizer: SEGV on unknown address 0x7fdbcd40f8ff (pc 0x55de9a75bf5f bp 0x7ffe26482770 sp 0x7ffe26482510 T0)
==8496==The signal is caused by a READ memory access.
    #0 in artist_vram_read /hw/display/artist.c:1218:15
    #1 in memory_region_read_accessor /softmmu/memory.c:434:11
    #2 in access_with_adjusted_size /softmmu/memory.c:539:18
    #3 in memory_region_dispatch_read1 /softmmu/memory.c:1385:16
    #4 in memory_region_dispatch_read /softmmu/memory.c:1413:9
    #5 in flatview_read_continue /exec.c:3239:23
    #6 in flatview_read /exec.c:3278:12
    #7 in address_space_read_full /exec.c:3291:18
    #8 in address_space_read /include/exec/memory.h:2414:18
    #9 in qtest_process_command /softmmu/qtest.c:485:13
    #10 in qtest_process_inbuf /softmmu/qtest.c:710:9
    #11 in qtest_read /softmmu/qtest.c:722:5
    #12 in qemu_chr_be_write_impl /chardev/char.c:188:9
    #13 in qemu_chr_be_write /chardev/char.c:200:9
    #14 in fd_chr_read /chardev/char-fd.c:68:9
    #15 in qio_channel_fd_source_dispatch /io/channel-watch.c:84:12
    #16 in g_main_context_dispatch 
    #17 in glib_pollfds_poll /util/main-loop.c:217:9
    #18 in os_host_main_loop_wait /util/main-loop.c:240:5
    #19 in main_loop_wait /util/main-loop.c:516:11
    #20 in qemu_main_loop /softmmu/vl.c:1676:9
    #21 in main /softmmu/main.c:49:5

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV /home/alxndr/Development/qemu/general-fuzz/hw/display/artist.c:1218:15 in artist_vram_read
==8496==ABORTING

-Alex

> I'd be happy if you could recheck if you find anything else.
> 
> In the next step I need to check if everything still works on HP-UX. If
> that's Ok, I'd like to send out a new pull request.  If you could give
> your Acked-by or Reviewed-by it would be great.
> 
> Thanks!
> Helge
> 
> ---
> From 1657a7a95adc15552138c2b4d310a06128093892 Mon Sep 17 00:00:00 2001
> From: Helge Deller <deller@gmx.de>
> Date: Tue, 4 Aug 2020 15:35:38 +0200
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
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index 47de17b9e9..570811030f 100644
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
> @@ -203,14 +203,18 @@ static int16_t artist_get_y(uint32_t reg)
>  }
> 
>  static void artist_invalidate_lines(struct vram_buffer *buf,
> -                                    int starty, int height)
> +                                    unsigned int starty, unsigned int height)
>  {
> -    int start = starty * buf->width;
> -    int size = height * buf->width;
> +    unsigned int start, size;
> 
> -    if (start + size <= buf->size) {
> -        memory_region_set_dirty(&buf->mr, start, size);
> +    if (starty >= buf->height) {
> +        return;
>      }
> +
> +    start = starty * buf->width;
> +    size = MIN(height * buf->width, buf->size - start);
> +
> +    memory_region_set_dirty(&buf->mr, start, size);
>  }
> 
>  static int vram_write_pix_per_transfer(ARTISTState *s)
> @@ -274,15 +278,15 @@ static artist_rop_t artist_get_op(ARTISTState *s)
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
> @@ -294,8 +298,7 @@ static void artist_rop8(ARTISTState *s, struct vram_buffer *buf,
>          break;
> 
>      case ARTIST_ROP_COPY:
> -        *dst &= ~plane_mask;
> -        *dst |= val & plane_mask;
> +        *dst = (*dst & ~plane_mask) | (val & plane_mask);
>          break;
> 
>      case ARTIST_ROP_XOR:
> @@ -349,7 +352,8 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>  {
>      struct vram_buffer *buf;
>      uint32_t vram_bitmask = s->vram_bitmask;
> -    int mask, i, pix_count, pix_length, offset, width;
> +    int mask, i, pix_count, pix_length;
> +    unsigned int offset, width;
>      uint8_t *data8, *p;
> 
>      pix_count = vram_write_pix_per_transfer(s);
> @@ -364,8 +368,7 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
>          offset = posy * width + posx;
>      }
> 
> -    if (!buf->size) {
> -        qemu_log("write to non-existent buffer\n");
> +    if (!buf->size || offset >= buf->size) {
>          return;
>      }
> 
> @@ -394,7 +397,9 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
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
> @@ -464,12 +469,14 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
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
> @@ -481,6 +488,12 @@ static void block_move(ARTISTState *s, int source_x, int source_y, int dest_x,
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
> @@ -507,24 +520,27 @@ static void block_move(ARTISTState *s, int source_x, int source_y, int dest_x,
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
> @@ -561,7 +577,9 @@ static void fill_window(ARTISTState *s, int startx, int starty,
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
> @@ -636,7 +654,7 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
>      color = artist_get_color(s);
> 
>      do {
> -        int ofs;
> +        unsigned int ofs;
> 
>          if (c1) {
>              ofs = x * s->width + y;
> @@ -768,13 +786,14 @@ static void font_write16(ARTISTState *s, uint16_t val)
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
> @@ -1138,7 +1157,7 @@ static void artist_vram_write(void *opaque, hwaddr addr, uint64_t val,
>      struct vram_buffer *buf;
>      int posy = (addr >> 11) & 0x3ff;
>      int posx = addr & 0x7ff;
> -    uint32_t offset;
> +    unsigned int offset;
>      trace_artist_vram_write(size, addr, val);
> 
>      if (s->cmap_bm_access) {
> @@ -1159,18 +1178,28 @@ static void artist_vram_write(void *opaque, hwaddr addr, uint64_t val,
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

