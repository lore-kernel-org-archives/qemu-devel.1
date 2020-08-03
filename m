Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C98C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE94022B40
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 18:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE94022B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2fI9-0005lo-5y
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 14:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k2fH4-0004tA-4T
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:33:26 -0400
Received: from relay68.bu.edu ([128.197.228.73]:38466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k2fH0-0004WF-CW
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 14:33:25 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 073IWquK014449
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 3 Aug 2020 14:32:56 -0400
Date: Mon, 3 Aug 2020 14:32:52 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v2 4/4] hw/display/artist.c: fix out of bounds check
Message-ID: <20200803183252.74z3czd2o5t2twjp@mozz.bu.edu>
References: <20200801131357.17379-1-deller@gmx.de>
 <20200801131357.17379-5-deller@gmx.de>
 <20200803173604.qtryrjnnubcpgoxq@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803173604.qtryrjnnubcpgoxq@mozz.bu.edu>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 14:33:21
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
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200803 1336, Alexander Bulekov wrote:
> Hi,
> I applied this patch, but I can still trigger a segfault and heap
> overread through artist_reg_write -> fill_window. I dont know if these
> problems are related to what this patch fixes. If not, let me know and
> I can create a separate launchpad report for these.

And another one through draw_line...
cat << EOF | ./hppa-softmmu/qemu-system-hppa -display none \
-qtest stdio -accel qtest
writeq 0xf8100e02 0x4f4f4f4f4f939600
EOF

==13563==ERROR: AddressSanitizer: SEGV on unknown address 0x7f3fe4d403fd (pc 0x55ae401eb392 bp 0x7ffea90ca2d0 sp 0x7ffea90ca1e0 T0)
==13563==The signal is caused by a READ memory access.
    #0 0x55ae401eb392 in artist_rop8 /hw/display/artist.c:284:14
    #1 0x55ae401ee163 in draw_line /hw/display/artist.c:635:13
    #2 0x55ae401e730a in draw_line_size /hw/display/artist.c:685:5
    #3 0x55ae401db25d in artist_reg_write /hw/display/artist.c:917:9
    #4 0x55ae3f8cd7a3 in memory_region_write_accessor /softmmu/memory.c:483:5
    #5 0x55ae3f8ccadc in access_with_adjusted_size /softmmu/memory.c:539:18
    #6 0x55ae3f8ca873 in memory_region_dispatch_write /softmmu/memory.c:1466:16
    #7 0x55ae3ef78056 in flatview_write_continue /exec.c:3176:23
    #8 0x55ae3ef60866 in flatview_write /exec.c:3216:14
    #9 0x55ae3ef60387 in address_space_write /exec.c:3308:18
    #10 0x55ae3f974604 in qtest_process_command /softmmu/qtest.c:452:13
    #11 0x55ae3f96bc08 in qtest_process_inbuf /softmmu/qtest.c:710:9
    #12 0x55ae3f96a895 in qtest_read /softmmu/qtest.c:722:5
    #13 0x55ae41e262f3 in qemu_chr_be_write_impl /chardev/char.c:188:9
    #14 0x55ae41e26477 in qemu_chr_be_write /chardev/char.c:200:9
    #15 0x55ae41e3a763 in fd_chr_read /chardev/char-fd.c:68:9
    #16 0x55ae41f8eb24 in qio_channel_fd_source_dispatch /io/channel-watch.c:84:12
    #17 0x7f400f6cc897 in g_main_context_dispatch ()
    #18 0x55ae42386a2b in glib_pollfds_poll /util/main-loop.c:217:9
    #19 0x55ae4238415b in os_host_main_loop_wait /util/main-loop.c:240:5
    #20 0x55ae42383af4 in main_loop_wait /util/main-loop.c:516:11
    #21 0x55ae3f98cd00 in qemu_main_loop /softmmu/vl.c:1676:9
    #22 0x55ae41fc6911 in main /softmmu/main.c:49:5


> -Alex
> 
> (1) Segfault:
> cat << EOF | ./hppa-softmmu/qemu-system-hppa -display none \
> -qtest stdio -accel qtest
> writeq 0xf8100a02 0x845c235c223f0584
> EOF
> 
> AddressSanitizer: SEGV on unknown address 0x7fa50235cc00
> #0 0x555577f8b392 in artist_rop8/hw/display/artist.c:284:14
> #1 0x555577f84603 in fill_window/hw/display/artist.c:549:13
> #2 0x555577f7abfc in artist_reg_write/hw/display/artist.c:895:9
> #3 0x55557766d7a3 in memory_region_write_accessor/softmmu/memory.c:483:5
> #4 0x55557766cadc in access_with_adjusted_size/softmmu/memory.c:539:18
> #5 0x55557766a873 in memory_region_dispatch_write/softmmu/memory.c:1466:16
> #6 0x555576d18056 in flatview_write_continue/exec.c:3176:23
> #7 0x555576d00866 in flatview_write/exec.c:3216:14
> #8 0x555576d00387 in address_space_write/exec.c:3308:18
> #9 0x555577714604 in qtest_process_command/softmmu/qtest.c:452:13
> 
> ===========================================================
> 
> (2) Heap Overflow:
> cat << EOF | ./hppa-softmmu/qemu-system-hppa -display none -m 64 \
> -qtest stdio -accel qtest
> writeq 0xf8100a02 0x8cd00011900a0203
> EOF
> 
> AddressSanitizer: heap-buffer-overflow on address 0x603000045bc8 at pc 0x55bb3196f704 bp 0x7fff1c701d70 sp 0x7fff1c701d68
> READ of size 8 at 0x603000045bc8 thread T0
> 
> #0 0x55bb3196f703 in cpu_physical_memory_set_dirty_range/include/exec/ram_addr.h:318:35
> #1 0x55bb3196e6f2 in memory_region_set_dirty/softmmu/memory.c:1994:5
> #2 0x55bb32279bb6 in artist_invalidate_lines/hw/display/artist.c:212:9
> #3 0x55bb3227165d in fill_window/hw/display/artist.c:552:5
> #4 0x55bb32267bfc in artist_reg_write/hw/display/artist.c:895:9
> #5 0x55bb3195a7a3 in memory_region_write_accessor/softmmu/memory.c:483:5
> #6 0x55bb31959adc in access_with_adjusted_size/softmmu/memory.c:539:18
> #7 0x55bb31957873 in memory_region_dispatch_write/softmmu/memory.c:1466:16
> #8 0x55bb31005056 in flatview_write_continue/exec.c:3176:23
> #9 0x55bb30fed866 in flatview_write/exec.c:3216:14
> #10 0x55bb30fed387 in address_space_write/exec.c:3308:18
> 
> 0x603000045bc8 is located 0 bytes to the right of 24-byte region [0x603000045bb0,0x603000045bc8)
> allocated by thread T0 here:
> #0 0x55bb30f7111d in malloc ()
> #1 0x7fdae3d35500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x54500)
> #2 0x55bb30fd84d4 in ram_block_add/exec.c:2268:9
> #3 0x55bb30fded16 in qemu_ram_alloc_internal/exec.c:2441:5
> #4 0x55bb30fdefed in qemu_ram_alloc/exec.c:2460:12
> #5 0x55bb3195c0be in memory_region_init_ram_shared_nomigrate/softmmu/memory.c:1515:21
> #6 0x55bb31cd6544 in ram_backend_memory_alloc/backends/hostmem-ram.c:30:5
> #7 0x55bb31ccf875 in host_memory_backend_memory_complete/backends/hostmem.c:333:9
> #8 0x55bb3360737e in user_creatable_complete/qom/object_interfaces.c:23:9
> #9 0x55bb31a44e59 in create_default_memdev/softmmu/vl.c:2830:5
> #10 0x55bb31a2d528 in qemu_init/softmmu/vl.c:4352:9
> #11 0x55bb3405390c in main/softmmu/main.c:48:5
> 
> 
> On 200801 1513, Helge Deller wrote:
> > From: Sven Schnelle <svens@stackframe.org>
> > 
> > Signed-off-by: Sven Schnelle <svens@stackframe.org>
> > Signed-off-by: Helge Deller <deller@gmx.de>
> > ---
> >  hw/display/artist.c | 24 +++++++++++-------------
> >  1 file changed, 11 insertions(+), 13 deletions(-)
> > 
> > diff --git a/hw/display/artist.c b/hw/display/artist.c
> > index 6261bfe65b..de56200dbf 100644
> > --- a/hw/display/artist.c
> > +++ b/hw/display/artist.c
> > @@ -340,14 +340,13 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
> >  {
> >      struct vram_buffer *buf;
> >      uint32_t vram_bitmask = s->vram_bitmask;
> > -    int mask, i, pix_count, pix_length, offset, height, width;
> > +    int mask, i, pix_count, pix_length, offset, width;
> >      uint8_t *data8, *p;
> > 
> >      pix_count = vram_write_pix_per_transfer(s);
> >      pix_length = vram_pixel_length(s);
> > 
> >      buf = vram_write_buffer(s);
> > -    height = buf->height;
> >      width = buf->width;
> > 
> >      if (s->cmap_bm_access) {
> > @@ -367,13 +366,6 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
> >          pix_count = size * 8;
> >      }
> > 
> > -    if (posy * width + posx + pix_count > buf->size) {
> > -        qemu_log("write outside bounds: wants %dx%d, max size %dx%d\n",
> > -                 posx, posy, width, height);
> > -        return;
> > -    }
> > -
> > -
> >      switch (pix_length) {
> >      case 0:
> >          if (s->image_bitmap_op & 0x20000000) {
> > @@ -381,8 +373,11 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
> >          }
> > 
> >          for (i = 0; i < pix_count; i++) {
> > -            artist_rop8(s, p + offset + pix_count - 1 - i,
> > -                        (data & 1) ? (s->plane_mask >> 24) : 0);
> > +            uint32_t off = offset + pix_count - 1 - i;
> > +            if (off < buf->size) {
> > +                artist_rop8(s, p + off,
> > +                            (data & 1) ? (s->plane_mask >> 24) : 0);
> > +            }
> >              data >>= 1;
> >          }
> >          memory_region_set_dirty(&buf->mr, offset, pix_count);
> > @@ -398,7 +393,10 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
> >          for (i = 3; i >= 0; i--) {
> >              if (!(s->image_bitmap_op & 0x20000000) ||
> >                  s->vram_bitmask & (1 << (28 + i))) {
> > -                artist_rop8(s, p + offset + 3 - i, data8[ROP8OFF(i)]);
> > +                uint32_t off = offset + 3 - i;
> > +                if (off < buf->size) {
> > +                    artist_rop8(s, p + off, data8[ROP8OFF(i)]);
> > +                }
> >              }
> >          }
> >          memory_region_set_dirty(&buf->mr, offset, 3);
> > @@ -420,7 +418,7 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
> >              break;
> >          }
> > 
> > -        for (i = 0; i < pix_count; i++) {
> > +        for (i = 0; i < pix_count && offset + i < buf->size; i++) {
> >              mask = 1 << (pix_count - 1 - i);
> > 
> >              if (!(s->image_bitmap_op & 0x20000000) ||
> > --
> > 2.21.3
> > 
> > 

