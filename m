Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6E12063A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6E12063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jydOo-0000AC-Id
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 11:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jydOC-0008Ah-3w
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:44:08 -0400
Received: from relay64.bu.edu ([128.197.228.104]:54948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jydO9-00049Q-MW
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 11:44:07 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 06NFhTwf032656
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 23 Jul 2020 11:43:30 -0400
Date: Thu, 23 Jul 2020 11:43:29 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [Bug 1888606] [NEW] Heap-use-after-free in
 virtio_gpu_ctrl_response
Message-ID: <20200723154329.xcma5ialcumkogg5@mozz.bu.edu>
References: <159548011952.31456.8249433335836304327.malonedeb@chaenomeles.canonical.com>
 <CAKXe6SK1=KoP4Vmyo-3pMsE+5BzMYwT-+uvqRY3zgi0qCiuENA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXe6SK1=KoP4Vmyo-3pMsE+5BzMYwT-+uvqRY3zgi0qCiuENA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 11:37:49
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bug 1888606 <1888606@bugs.launchpad.net>, Jason Wang <jasowang@redhat.com>,
 .@mozz.bu.edu, Qemu Developers <qemu-devel@nongnu.org>,
 P J P <ppandit@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200723 1351, Li Qiang wrote:
> Alexander Bulekov <1888606@bugs.launchpad.net> 于2020年7月23日周四 下午1:02写道：
> >
> > Public bug reported:
> >
> > Hello,
> > Here is a reproducer (build with --enable-sanitizers):
> > cat << EOF | ./i386-softmmu/qemu-system-i386 -nographic -M pc -nodefaults -m 512M -device virtio-vga -qtest stdio
> > outl 0xcf8 0x80001018
> > outl 0xcfc 0xe0800000
> > outl 0xcf8 0x80001020
> > outl 0xcf8 0x80001004
> > outw 0xcfc 0x7
> > writeq 0xe0801024 0x10646c00776c6cff
> > writeq 0xe080102d 0xe0801000320000
> > writeq 0xe0801015 0x12b2901ba000000
> > write 0x10646c02 0x1 0x2c
> > write 0x999 0x1 0x25
> > write 0x8 0x1 0x78
> > write 0x2c7 0x1 0x32
> > write 0x2cb 0x1 0xff
> > write 0x2cc 0x1 0x7e
> > writeq 0xe0803000 0xf2b8f0540ff83
> > EOF
> >
> > The ASAN trace:
> > ==29798==ERROR: AddressSanitizer: heap-use-after-free on address 0x60d0000050e8 at pc 0x560629814761 bp 0x7ffe916eb1e0 sp 0x7ffe916eb1d8
> > READ of size 8 at 0x60d0000050e8 thread T0
> >     #0 0x560629814760 in virtio_gpu_ctrl_response /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:181:42
> >     #1 0x56062981adc8 in virtio_gpu_ctrl_response_nodata /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:193:5
> >     #2 0x56062981adc8 in virtio_gpu_simple_process_cmd /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:791:9
> >     #3 0x5606298175f8 in virtio_gpu_process_cmdq /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:820:9
> >     #4 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/util/async.c:164:13
> >     #5 0x56062a887b9d in aio_dispatch /home/alxndr/Development/qemu/util/aio-posix.c:380:5
> >     #6 0x56062a8f6b1c in aio_ctx_dispatch /home/alxndr/Development/qemu/util/async.c:306:5
> >     #7 0x7f0d5e1cf9ed in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4e9ed)
> >     #8 0x56062a919571 in glib_pollfds_poll /home/alxndr/Development/qemu/util/main-loop.c:217:9
> >     #9 0x56062a919571 in os_host_main_loop_wait /home/alxndr/Development/qemu/util/main-loop.c:240:5
> >     #10 0x56062a919571 in main_loop_wait /home/alxndr/Development/qemu/util/main-loop.c:516:11
> >     #11 0x560629094a64 in qemu_main_loop /home/alxndr/Development/qemu/softmmu/vl.c:1676:9
> >     #12 0x56062a749ab5 in main /home/alxndr/Development/qemu/softmmu/main.c:49:5
> >     #13 0x7f0d5cd55e0a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x26e0a)
> >     #14 0x5606288ba889 in _start (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x24d0889)
> >
> > 0x60d0000050e8 is located 56 bytes inside of 136-byte region [0x60d0000050b0,0x60d000005138)
> > freed by thread T0 here:
> >     #0 0x56062893250d in free (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x254850d)
> >     #1 0x560629827730 in virtio_gpu_reset /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:1160:9
> >     #2 0x560628e81d34 in virtio_reset /home/alxndr/Development/qemu/hw/virtio/virtio.c:1999:9
> >     #3 0x560629f08773 in virtio_pci_reset /home/alxndr/Development/qemu/hw/virtio/virtio-pci.c:1841:5
> >     #4 0x560629043ab6 in memory_region_write_accessor /home/alxndr/Development/qemu/softmmu/memory.c:483:5
> >     #5 0x560629043473 in access_with_adjusted_size /home/alxndr/Development/qemu/softmmu/memory.c:544:18
> >     #6 0x560629042c99 in memory_region_dispatch_write /home/alxndr/Development/qemu/softmmu/memory.c
> >     #7 0x560628990a37 in flatview_write_continue /home/alxndr/Development/qemu/exec.c:3176:23
> >     #8 0x56062899041a in address_space_write_cached_slow /home/alxndr/Development/qemu/exec.c:3789:12
> >     #9 0x560628e6f9bb in vring_used_write /home/alxndr/Development/qemu/hw/virtio/virtio.c:347:5
> >     #10 0x560628e6f9bb in virtqueue_split_fill /home/alxndr/Development/qemu/hw/virtio/virtio.c:788:5
> >     #11 0x560628e6f9bb in virtqueue_fill /home/alxndr/Development/qemu/hw/virtio/virtio.c:852:9
> >     #12 0x560628e7205e in virtqueue_push /home/alxndr/Development/qemu/hw/virtio/virtio.c:917:5
> >     #13 0x560629814246 in virtio_gpu_ctrl_response /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:180:5
> >     #14 0x56062981adc8 in virtio_gpu_ctrl_response_nodata /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:193:5
> >     #15 0x56062981adc8 in virtio_gpu_simple_process_cmd /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:791:9
> >     #16 0x5606298175f8 in virtio_gpu_process_cmdq /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:820:9
> >     #17 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/util/async.c:164:13
> >     #18 0x56062a887b9d in aio_dispatch /home/alxndr/Development/qemu/util/aio-posix.c:380:5
> >     #19 0x56062a8f6b1c in aio_ctx_dispatch /home/alxndr/Development/qemu/util/async.c:306:5
> >     #20 0x7f0d5e1cf9ed in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4e9ed)
> >
> 
> Seems again when we write back to virtio used vring, we write to the
> MMIO addresspace.

Yes it seems to have a similar flavor as LP#1886362, but this time with
BHes in the mix, which we would hope avoid the reentrancy issues.
-Alex

> Thanks,
> Li Qiang
> 
> 
> > previously allocated by thread T0 here:
> >     #0 0x56062893278d in malloc (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x254878d)
> >     #1 0x7f0d5e1d5500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x54500)
> >     #2 0x560628e7844b in virtqueue_split_pop /home/alxndr/Development/qemu/hw/virtio/virtio.c:1524:12
> >     #3 0x560628e7844b in virtqueue_pop /home/alxndr/Development/qemu/hw/virtio/virtio.c:1693:16
> >     #4 0x560629829633 in virtio_gpu_handle_ctrl /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:878:15
> >     #5 0x560629829633 in virtio_gpu_ctrl_bh /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:893:5
> >     #6 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/util/async.c:164:13
> >     #7 0x56062a887b9d in aio_dispatch /home/alxndr/Development/qemu/util/aio-posix.c:380:5
> >     #8 0x56062a8f6b1c in aio_ctx_dispatch /home/alxndr/Development/qemu/util/async.c:306:5
> >     #9 0x7f0d5e1cf9ed in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4e9ed)
> >
> >
> > With -trace virtio\* -trace pci\* :
> > [I 1595480025.666147] OPENED
> > 31900@1595480025.706962:virtio_set_status vdev 0x633000019640 val 0
> > 31900@1595480025.710297:virtio_set_status vdev 0x633000019640 val 0
> > [R +0.046276] outl 0xcf8 0x80001018
> > OK
> > [S +0.046313] OK
> > [R +0.046332] outl 0xcfc 0xe0800000
> > 31900@1595480025.712490:pci_cfg_write virtio-vga 02:0 @0x18 <- 0xe0800000
> > OK
> > [S +0.046356] OK
> > [R +0.046365] outl 0xcf8 0x80001020
> > OK
> > [S +0.046370] OK
> > [R +0.046379] outl 0xcf8 0x80001004
> > OK
> > [S +0.046383] OK
> > [R +0.046391] outw 0xcfc 0x7
> > 31900@1595480025.712544:pci_cfg_write virtio-vga 02:0 @0x4 <- 0x7
> > 31900@1595480025.712551:pci_update_mappings_add d=0x633000000800 00:02.0 2,0xe0800000+0x4000
> > OK
> > [S +0.047572] OK
> > [R +0.047597] writeq 0xe0801024 0x10646c00776c6cff
> > OK
> > [S +0.047610] OK
> > [R +0.047619] writeq 0xe080102d 0xe0801000320000
> > OK
> > [S +0.047627] OK
> > [R +0.047636] writeq 0xe0801015 0x12b2901ba000000
> > OK
> > [S +0.047650] OK
> > [R +0.047660] write 0x10646c02 0x1 0x2c
> > OK
> > [S +0.047769] OK
> > [R +0.047782] write 0x999 0x1 0x25
> > OK
> > [S +0.047907] OK
> > [R +0.047920] write 0x8 0x1 0x78
> > OK
> > [S +0.047927] OK
> > [R +0.047935] write 0x2c7 0x1 0x32
> > OK
> > [S +0.047941] OK
> > [R +0.047949] write 0x2cb 0x1 0xff
> > OK
> > [S +0.047954] OK
> > [R +0.047962] write 0x2cc 0x1 0x7e
> > OK
> > [S +0.047967] OK
> > [R +0.047975] writeq 0xe0803000 0xf2b8f0540ff83
> > 31900@1595480025.714133:virtio_queue_notify vdev 0x633000019640 n 0 vq 0x7fe20b13d800
> > OK
> > [S +0.047996] OK
> > 31900@1595480025.714386:virtio_notify vdev 0x633000019640 vq 0x7fe20b13d800
> > 31900@1595480025.714406:virtio_gpu_features virgl 0
> > 31900@1595480025.714413:virtio_notify vdev 0x633000019640 vq 0x7fe20b13d800
> > 31900@1595480025.714421:virtio_set_status vdev 0x633000019640 val 0
> > *CRASH*
> >
> > Please let me know if I can provide any further info.
> > -Alex
> >
> > ** Affects: qemu
> >      Importance: Undecided
> >          Status: New
> >
> > --
> > You received this bug notification because you are a member of qemu-
> > devel-ml, which is subscribed to QEMU.
> > https://bugs.launchpad.net/bugs/1888606
> >
> > Title:
> >   Heap-use-after-free in virtio_gpu_ctrl_response
> >
> > Status in QEMU:
> >   New
> >
> > Bug description:
> >   Hello,
> >   Here is a reproducer (build with --enable-sanitizers):
> >   cat << EOF | ./i386-softmmu/qemu-system-i386 -nographic -M pc -nodefaults -m 512M -device virtio-vga -qtest stdio
> >   outl 0xcf8 0x80001018
> >   outl 0xcfc 0xe0800000
> >   outl 0xcf8 0x80001020
> >   outl 0xcf8 0x80001004
> >   outw 0xcfc 0x7
> >   writeq 0xe0801024 0x10646c00776c6cff
> >   writeq 0xe080102d 0xe0801000320000
> >   writeq 0xe0801015 0x12b2901ba000000
> >   write 0x10646c02 0x1 0x2c
> >   write 0x999 0x1 0x25
> >   write 0x8 0x1 0x78
> >   write 0x2c7 0x1 0x32
> >   write 0x2cb 0x1 0xff
> >   write 0x2cc 0x1 0x7e
> >   writeq 0xe0803000 0xf2b8f0540ff83
> >   EOF
> >
> >   The ASAN trace:
> >   ==29798==ERROR: AddressSanitizer: heap-use-after-free on address 0x60d0000050e8 at pc 0x560629814761 bp 0x7ffe916eb1e0 sp 0x7ffe916eb1d8
> >   READ of size 8 at 0x60d0000050e8 thread T0
> >       #0 0x560629814760 in virtio_gpu_ctrl_response /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:181:42
> >       #1 0x56062981adc8 in virtio_gpu_ctrl_response_nodata /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:193:5
> >       #2 0x56062981adc8 in virtio_gpu_simple_process_cmd /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:791:9
> >       #3 0x5606298175f8 in virtio_gpu_process_cmdq /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:820:9
> >       #4 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/util/async.c:164:13
> >       #5 0x56062a887b9d in aio_dispatch /home/alxndr/Development/qemu/util/aio-posix.c:380:5
> >       #6 0x56062a8f6b1c in aio_ctx_dispatch /home/alxndr/Development/qemu/util/async.c:306:5
> >       #7 0x7f0d5e1cf9ed in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4e9ed)
> >       #8 0x56062a919571 in glib_pollfds_poll /home/alxndr/Development/qemu/util/main-loop.c:217:9
> >       #9 0x56062a919571 in os_host_main_loop_wait /home/alxndr/Development/qemu/util/main-loop.c:240:5
> >       #10 0x56062a919571 in main_loop_wait /home/alxndr/Development/qemu/util/main-loop.c:516:11
> >       #11 0x560629094a64 in qemu_main_loop /home/alxndr/Development/qemu/softmmu/vl.c:1676:9
> >       #12 0x56062a749ab5 in main /home/alxndr/Development/qemu/softmmu/main.c:49:5
> >       #13 0x7f0d5cd55e0a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x26e0a)
> >       #14 0x5606288ba889 in _start (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x24d0889)
> >
> >   0x60d0000050e8 is located 56 bytes inside of 136-byte region [0x60d0000050b0,0x60d000005138)
> >   freed by thread T0 here:
> >       #0 0x56062893250d in free (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x254850d)
> >       #1 0x560629827730 in virtio_gpu_reset /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:1160:9
> >       #2 0x560628e81d34 in virtio_reset /home/alxndr/Development/qemu/hw/virtio/virtio.c:1999:9
> >       #3 0x560629f08773 in virtio_pci_reset /home/alxndr/Development/qemu/hw/virtio/virtio-pci.c:1841:5
> >       #4 0x560629043ab6 in memory_region_write_accessor /home/alxndr/Development/qemu/softmmu/memory.c:483:5
> >       #5 0x560629043473 in access_with_adjusted_size /home/alxndr/Development/qemu/softmmu/memory.c:544:18
> >       #6 0x560629042c99 in memory_region_dispatch_write /home/alxndr/Development/qemu/softmmu/memory.c
> >       #7 0x560628990a37 in flatview_write_continue /home/alxndr/Development/qemu/exec.c:3176:23
> >       #8 0x56062899041a in address_space_write_cached_slow /home/alxndr/Development/qemu/exec.c:3789:12
> >       #9 0x560628e6f9bb in vring_used_write /home/alxndr/Development/qemu/hw/virtio/virtio.c:347:5
> >       #10 0x560628e6f9bb in virtqueue_split_fill /home/alxndr/Development/qemu/hw/virtio/virtio.c:788:5
> >       #11 0x560628e6f9bb in virtqueue_fill /home/alxndr/Development/qemu/hw/virtio/virtio.c:852:9
> >       #12 0x560628e7205e in virtqueue_push /home/alxndr/Development/qemu/hw/virtio/virtio.c:917:5
> >       #13 0x560629814246 in virtio_gpu_ctrl_response /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:180:5
> >       #14 0x56062981adc8 in virtio_gpu_ctrl_response_nodata /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:193:5
> >       #15 0x56062981adc8 in virtio_gpu_simple_process_cmd /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:791:9
> >       #16 0x5606298175f8 in virtio_gpu_process_cmdq /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:820:9
> >       #17 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/util/async.c:164:13
> >       #18 0x56062a887b9d in aio_dispatch /home/alxndr/Development/qemu/util/aio-posix.c:380:5
> >       #19 0x56062a8f6b1c in aio_ctx_dispatch /home/alxndr/Development/qemu/util/async.c:306:5
> >       #20 0x7f0d5e1cf9ed in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4e9ed)
> >
> >   previously allocated by thread T0 here:
> >       #0 0x56062893278d in malloc (/home/alxndr/Development/qemu/build/i386-softmmu/qemu-system-i386+0x254878d)
> >       #1 0x7f0d5e1d5500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x54500)
> >       #2 0x560628e7844b in virtqueue_split_pop /home/alxndr/Development/qemu/hw/virtio/virtio.c:1524:12
> >       #3 0x560628e7844b in virtqueue_pop /home/alxndr/Development/qemu/hw/virtio/virtio.c:1693:16
> >       #4 0x560629829633 in virtio_gpu_handle_ctrl /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:878:15
> >       #5 0x560629829633 in virtio_gpu_ctrl_bh /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:893:5
> >       #6 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/util/async.c:164:13
> >       #7 0x56062a887b9d in aio_dispatch /home/alxndr/Development/qemu/util/aio-posix.c:380:5
> >       #8 0x56062a8f6b1c in aio_ctx_dispatch /home/alxndr/Development/qemu/util/async.c:306:5
> >       #9 0x7f0d5e1cf9ed in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4e9ed)
> >
> >
> >   With -trace virtio\* -trace pci\* :
> >   [I 1595480025.666147] OPENED
> >   31900@1595480025.706962:virtio_set_status vdev 0x633000019640 val 0
> >   31900@1595480025.710297:virtio_set_status vdev 0x633000019640 val 0
> >   [R +0.046276] outl 0xcf8 0x80001018
> >   OK
> >   [S +0.046313] OK
> >   [R +0.046332] outl 0xcfc 0xe0800000
> >   31900@1595480025.712490:pci_cfg_write virtio-vga 02:0 @0x18 <- 0xe0800000
> >   OK
> >   [S +0.046356] OK
> >   [R +0.046365] outl 0xcf8 0x80001020
> >   OK
> >   [S +0.046370] OK
> >   [R +0.046379] outl 0xcf8 0x80001004
> >   OK
> >   [S +0.046383] OK
> >   [R +0.046391] outw 0xcfc 0x7
> >   31900@1595480025.712544:pci_cfg_write virtio-vga 02:0 @0x4 <- 0x7
> >   31900@1595480025.712551:pci_update_mappings_add d=0x633000000800 00:02.0 2,0xe0800000+0x4000
> >   OK
> >   [S +0.047572] OK
> >   [R +0.047597] writeq 0xe0801024 0x10646c00776c6cff
> >   OK
> >   [S +0.047610] OK
> >   [R +0.047619] writeq 0xe080102d 0xe0801000320000
> >   OK
> >   [S +0.047627] OK
> >   [R +0.047636] writeq 0xe0801015 0x12b2901ba000000
> >   OK
> >   [S +0.047650] OK
> >   [R +0.047660] write 0x10646c02 0x1 0x2c
> >   OK
> >   [S +0.047769] OK
> >   [R +0.047782] write 0x999 0x1 0x25
> >   OK
> >   [S +0.047907] OK
> >   [R +0.047920] write 0x8 0x1 0x78
> >   OK
> >   [S +0.047927] OK
> >   [R +0.047935] write 0x2c7 0x1 0x32
> >   OK
> >   [S +0.047941] OK
> >   [R +0.047949] write 0x2cb 0x1 0xff
> >   OK
> >   [S +0.047954] OK
> >   [R +0.047962] write 0x2cc 0x1 0x7e
> >   OK
> >   [S +0.047967] OK
> >   [R +0.047975] writeq 0xe0803000 0xf2b8f0540ff83
> >   31900@1595480025.714133:virtio_queue_notify vdev 0x633000019640 n 0 vq 0x7fe20b13d800
> >   OK
> >   [S +0.047996] OK
> >   31900@1595480025.714386:virtio_notify vdev 0x633000019640 vq 0x7fe20b13d800
> >   31900@1595480025.714406:virtio_gpu_features virgl 0
> >   31900@1595480025.714413:virtio_notify vdev 0x633000019640 vq 0x7fe20b13d800
> >   31900@1595480025.714421:virtio_set_status vdev 0x633000019640 val 0
> >   *CRASH*
> >
> >   Please let me know if I can provide any further info.
> >   -Alex
> >
> > To manage notifications about this bug go to:
> > https://bugs.launchpad.net/qemu/+bug/1888606/+subscriptions
> >
> 

