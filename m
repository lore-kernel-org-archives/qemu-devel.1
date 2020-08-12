Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43621C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A75B20774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A75B20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5u8o-0001aI-3t
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5u7c-0000Yb-Vf
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:01:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:50774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5u7W-0006vg-BS
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:01:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k5u7U-0003sZ-6Z
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 17:00:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 299652E8081
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 17:00:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2020 16:55:00 -0000
From: Alexander Bulekov <1891354@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
References: <159724841583.21381.1589855553145708820.malonedeb@chaenomeles.canonical.com>
Message-ID: <20200812165500.qxcyyirb3kqzv67o@mozz.bu.edu>
Subject: Re: [Bug 1891354] [NEW] Heap-use-after-free in usb_packet_unmap
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: bdcaa45acfab9a92933d952d9e61f404d3eab386
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:10:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1891354 <1891354@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200812165500.VWOphQ7YdBPJKXLw38XfHNaTAm9pfS7xlfFMJuA82lc@z>

On 200813 0024, Li Qiang wrote:
> Alexander Bulekov <1891354@bugs.launchpad.net> =E4=BA=8E2020=E5=B9=B48=E6=
=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:21=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> > Public bug reported:
> >
> > Hello,
> > Reproducer:
> >
> > cat << EOF | ./i386-softmmu/qemu-system-i386 -device nec-usb-xhci \
> > -trace usb\* -device usb-audio -device usb-storage,drive=3Dmydrive \
> > -drive id=3Dmydrive,file=3Dnull-co://,size=3D2M,format=3Draw,if=3Dnone \
> > -nodefaults -nographic -qtest stdio
> > outl 0xcf8 0x80001010
> > outl 0xcfc 0xc0202
> > outl 0xcf8 0x80001004
> > outl 0xcfc 0x1c77695e
> > writel 0xc0040 0xffffd855
> > writeq 0xc2000 0xff05140100000000
> > write 0x1d 0x1 0x27
> > write 0x2d 0x1 0x2e
> > write 0x17232 0x1 0x03
> > write 0x17254 0x1 0x05
> > write 0x17276 0x1 0x72
> > write 0x17278 0x1 0x02
> > write 0x3d 0x1 0x27
> > write 0x40 0x1 0x2e
> > write 0x41 0x1 0x72
> > write 0x42 0x1 0x01
> > write 0x4d 0x1 0x2e
> > write 0x4f 0x1 0x01
> > write 0x2007c 0x1 0xc7
> > writeq 0xc2000 0x5c05140100000000
> > write 0x20070 0x1 0x80
> > write 0x20078 0x1 0x08
> > write 0x2007c 0x1 0xfe
> > write 0x2007d 0x1 0x08
> > write 0x20081 0x1 0xff
> > write 0x20082 0x1 0x0b
> > write 0x20089 0x1 0x8c
> > write 0x2008d 0x1 0x04
> > write 0x2009d 0x1 0x10
> > writeq 0xc2000 0x2505ef019e092f00
> > EOF
> >
> > 20091=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0x61=
1000045030 at pc 0x55db79edeef2 bp 0x7ffc4020b2b0 sp 0x7ffc4020b2a8
> > READ of size 4 at 0x611000045030 thread T0
> >     #0 0x55db79edeef1 in usb_packet_unmap hw/usb/libhw.c:64:28
> >     #1 0x55db79ede66f in usb_packet_map hw/usb/libhw.c:54:5
> >     #2 0x55db79f6d5f1 in xhci_setup_packet hw/usb/hcd-xhci.c:1618:5
> >     #3 0x55db79f67143 in xhci_fire_ctl_transfer hw/usb/hcd-xhci.c:1722:9
> >     #4 0x55db79f67143 in xhci_kick_epctx hw/usb/hcd-xhci.c:1991:13
> >     #5 0x55db79f8837d in xhci_doorbell_write hw/usb/hcd-xhci.c:3162:13
> >     #6 0x55db792c6b8e in memory_region_write_accessor softmmu/memory.c:=
483:5
> >     #7 0x55db792c658b in access_with_adjusted_size softmmu/memory.c:544=
:18
> >     #8 0x55db792c5d9b in memory_region_dispatch_write softmmu/memory.c
> >     #9 0x55db78d094d2 in flatview_write_continue exec.c:3176:23
> >     #10 0x55db78cfee6b in flatview_write exec.c:3216:14
> >     #11 0x55db78cfee6b in address_space_write exec.c:3308:18
> >     #12 0x55db793072a9 in qtest_process_command softmmu/qtest.c:452:13
> >     #13 0x55db79304087 in qtest_process_inbuf softmmu/qtest.c:710:9
> >     #14 0x55db7a7d7293 in fd_chr_read chardev/char-fd.c:68:9
> >     #15 0x7fc5d7f1a897 in g_main_context_dispatch
> >     #16 0x55db7aa571b3 in glib_pollfds_poll util/main-loop.c:217:9
> >     #17 0x55db7aa571b3 in os_host_main_loop_wait util/main-loop.c:240:5
> >     #18 0x55db7aa571b3 in main_loop_wait util/main-loop.c:516:11
> >     #19 0x55db79315008 in qemu_main_loop softmmu/vl.c:1676:9
> >     #20 0x55db7a8860fd in main softmmu/main.c:49:5
> >
> > 0x611000045030 is located 48 bytes inside of 256-byte region [0x6110000=
45000,0x611000045100)
> > freed by thread T0 here:
> >     #0 0x55db78cac16d in free (build/i386-softmmu/qemu-system-i386+0x25=
0e16d)
> >     #1 0x55db79f7c0e8 in xhci_ep_nuke_xfers hw/usb/hcd-xhci.c:1252:9
> >     #2 0x55db79f7b454 in xhci_disable_ep hw/usb/hcd-xhci.c:1279:5
> >     #3 0x55db79f79af7 in xhci_disable_slot hw/usb/hcd-xhci.c:2048:13
> >     #4 0x55db79f5aea3 in xhci_reset hw/usb/hcd-xhci.c:2706:9
> >     #5 0x55db79f82f49 in xhci_oper_write hw/usb/hcd-xhci.c:2966:13
> >     #6 0x55db792c6b8e in memory_region_write_accessor softmmu/memory.c:=
483:5
> >     #7 0x55db792c658b in access_with_adjusted_size softmmu/memory.c:544=
:18
> >     #8 0x55db792c5d9b in memory_region_dispatch_write softmmu/memory.c
> >     #9 0x55db78d094d2 in flatview_write_continue exec.c:3176:23
> >     #10 0x55db78cfee6b in flatview_write exec.c:3216:14
> >     #11 0x55db78cfee6b in address_space_write exec.c:3308:18
> >     #12 0x55db78d01fe7 in address_space_unmap exec.c:3634:9
> >     #13 0x55db79edebbb in dma_memory_unmap include/sysemu/dma.h:145:5
> >     #14 0x55db79edebbb in usb_packet_unmap hw/usb/libhw.c:65:9
> >     #15 0x55db79ede66f in usb_packet_map hw/usb/libhw.c:54:5
> >     #16 0x55db79f6d5f1 in xhci_setup_packet hw/usb/hcd-xhci.c:1618:5
> >     #17 0x55db79f67143 in xhci_fire_ctl_transfer hw/usb/hcd-xhci.c:1722=
:9
> >     #18 0x55db79f67143 in xhci_kick_epctx hw/usb/hcd-xhci.c:1991:13
> >     #19 0x55db79f8837d in xhci_doorbell_write hw/usb/hcd-xhci.c:3162:13
> >     #20 0x55db792c6b8e in memory_region_write_accessor softmmu/memory.c=
:483:5
> >     #21 0x55db792c658b in access_with_adjusted_size softmmu/memory.c:54=
4:18
> >     #22 0x55db792c5d9b in memory_region_dispatch_write softmmu/memory.c
> >     #23 0x55db78d094d2 in flatview_write_continue exec.c:3176:23
> >     #24 0x55db78cfee6b in flatview_write exec.c:3216:14
> >     #25 0x55db78cfee6b in address_space_write exec.c:3308:18
> >     #26 0x55db793072a9 in qtest_process_command softmmu/qtest.c:452:13
> >     #27 0x55db79304087 in qtest_process_inbuf softmmu/qtest.c:710:9
> >     #28 0x55db7a7d7293 in fd_chr_read chardev/char-fd.c:68:9
> >     #29 0x7fc5d7f1a897 in g_main_context_dispatch
> >
> =

> This issue as far as I can see, is the DMA to MMIO issue.

Another one - Interesting...
So it joins these:
https://bugs.launchpad.net/qemu/+bug/1888606
https://bugs.launchpad.net/qemu/+bug/1886362

Could this one be dealt with by moving xhci_reset into a BH?
-Alex

> Thanks,
> Li Qiang
> =

> =

> > previously allocated by thread T0 here:
> >     #0 0x55db78cac562 in calloc (build/i386-softmmu/qemu-system-i386+0x=
250e562)
> >     #1 0x7fc5d7f20548 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libglib-2=
.0.so.0+0x54548)
> >     #2 0x55db79f8837d in xhci_doorbell_write hw/usb/hcd-xhci.c:3162:13
> >     #3 0x55db792c6b8e in memory_region_write_accessor softmmu/memory.c:=
483:5
> >     #4 0x55db792c658b in access_with_adjusted_size softmmu/memory.c:544=
:18
> >     #5 0x55db792c5d9b in memory_region_dispatch_write softmmu/memory.c
> >     #6 0x55db78d094d2 in flatview_write_continue exec.c:3176:23
> >     #7 0x55db78cfee6b in flatview_write exec.c:3216:14
> >     #8 0x55db78cfee6b in address_space_write exec.c:3308:18
> >     #9 0x55db793072a9 in qtest_process_command softmmu/qtest.c:452:13
> >     #10 0x55db79304087 in qtest_process_inbuf softmmu/qtest.c:710:9
> >     #11 0x55db7a7d7293 in fd_chr_read chardev/char-fd.c:68:9
> >     #12 0x7fc5d7f1a897 in g_main_context_dispatch
> >
> > -Alex
> >
> > ** Affects: qemu
> >      Importance: Undecided
> >          Status: New
> >
> > --
> > You received this bug notification because you are a member of qemu-
> > devel-ml, which is subscribed to QEMU.
> > https://bugs.launchpad.net/bugs/1891354
> >
> > Title:
> >   Heap-use-after-free in usb_packet_unmap
> >
> > Status in QEMU:
> >   New
> >
> > Bug description:
> >   Hello,
> >   Reproducer:
> >
> >   cat << EOF | ./i386-softmmu/qemu-system-i386 -device nec-usb-xhci \
> >   -trace usb\* -device usb-audio -device usb-storage,drive=3Dmydrive \
> >   -drive id=3Dmydrive,file=3Dnull-co://,size=3D2M,format=3Draw,if=3Dnon=
e \
> >   -nodefaults -nographic -qtest stdio
> >   outl 0xcf8 0x80001010
> >   outl 0xcfc 0xc0202
> >   outl 0xcf8 0x80001004
> >   outl 0xcfc 0x1c77695e
> >   writel 0xc0040 0xffffd855
> >   writeq 0xc2000 0xff05140100000000
> >   write 0x1d 0x1 0x27
> >   write 0x2d 0x1 0x2e
> >   write 0x17232 0x1 0x03
> >   write 0x17254 0x1 0x05
> >   write 0x17276 0x1 0x72
> >   write 0x17278 0x1 0x02
> >   write 0x3d 0x1 0x27
> >   write 0x40 0x1 0x2e
> >   write 0x41 0x1 0x72
> >   write 0x42 0x1 0x01
> >   write 0x4d 0x1 0x2e
> >   write 0x4f 0x1 0x01
> >   write 0x2007c 0x1 0xc7
> >   writeq 0xc2000 0x5c05140100000000
> >   write 0x20070 0x1 0x80
> >   write 0x20078 0x1 0x08
> >   write 0x2007c 0x1 0xfe
> >   write 0x2007d 0x1 0x08
> >   write 0x20081 0x1 0xff
> >   write 0x20082 0x1 0x0b
> >   write 0x20089 0x1 0x8c
> >   write 0x2008d 0x1 0x04
> >   write 0x2009d 0x1 0x10
> >   writeq 0xc2000 0x2505ef019e092f00
> >   EOF
> >
> >   20091=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0x=
611000045030 at pc 0x55db79edeef2 bp 0x7ffc4020b2b0 sp 0x7ffc4020b2a8
> >   READ of size 4 at 0x611000045030 thread T0
> >       #0 0x55db79edeef1 in usb_packet_unmap hw/usb/libhw.c:64:28
> >       #1 0x55db79ede66f in usb_packet_map hw/usb/libhw.c:54:5
> >       #2 0x55db79f6d5f1 in xhci_setup_packet hw/usb/hcd-xhci.c:1618:5
> >       #3 0x55db79f67143 in xhci_fire_ctl_transfer hw/usb/hcd-xhci.c:172=
2:9
> >       #4 0x55db79f67143 in xhci_kick_epctx hw/usb/hcd-xhci.c:1991:13
> >       #5 0x55db79f8837d in xhci_doorbell_write hw/usb/hcd-xhci.c:3162:13
> >       #6 0x55db792c6b8e in memory_region_write_accessor softmmu/memory.=
c:483:5
> >       #7 0x55db792c658b in access_with_adjusted_size softmmu/memory.c:5=
44:18
> >       #8 0x55db792c5d9b in memory_region_dispatch_write softmmu/memory.c
> >       #9 0x55db78d094d2 in flatview_write_continue exec.c:3176:23
> >       #10 0x55db78cfee6b in flatview_write exec.c:3216:14
> >       #11 0x55db78cfee6b in address_space_write exec.c:3308:18
> >       #12 0x55db793072a9 in qtest_process_command softmmu/qtest.c:452:13
> >       #13 0x55db79304087 in qtest_process_inbuf softmmu/qtest.c:710:9
> >       #14 0x55db7a7d7293 in fd_chr_read chardev/char-fd.c:68:9
> >       #15 0x7fc5d7f1a897 in g_main_context_dispatch
> >       #16 0x55db7aa571b3 in glib_pollfds_poll util/main-loop.c:217:9
> >       #17 0x55db7aa571b3 in os_host_main_loop_wait util/main-loop.c:240=
:5
> >       #18 0x55db7aa571b3 in main_loop_wait util/main-loop.c:516:11
> >       #19 0x55db79315008 in qemu_main_loop softmmu/vl.c:1676:9
> >       #20 0x55db7a8860fd in main softmmu/main.c:49:5
> >
> >   0x611000045030 is located 48 bytes inside of 256-byte region [0x61100=
0045000,0x611000045100)
> >   freed by thread T0 here:
> >       #0 0x55db78cac16d in free (build/i386-softmmu/qemu-system-i386+0x=
250e16d)
> >       #1 0x55db79f7c0e8 in xhci_ep_nuke_xfers hw/usb/hcd-xhci.c:1252:9
> >       #2 0x55db79f7b454 in xhci_disable_ep hw/usb/hcd-xhci.c:1279:5
> >       #3 0x55db79f79af7 in xhci_disable_slot hw/usb/hcd-xhci.c:2048:13
> >       #4 0x55db79f5aea3 in xhci_reset hw/usb/hcd-xhci.c:2706:9
> >       #5 0x55db79f82f49 in xhci_oper_write hw/usb/hcd-xhci.c:2966:13
> >       #6 0x55db792c6b8e in memory_region_write_accessor softmmu/memory.=
c:483:5
> >       #7 0x55db792c658b in access_with_adjusted_size softmmu/memory.c:5=
44:18
> >       #8 0x55db792c5d9b in memory_region_dispatch_write softmmu/memory.c
> >       #9 0x55db78d094d2 in flatview_write_continue exec.c:3176:23
> >       #10 0x55db78cfee6b in flatview_write exec.c:3216:14
> >       #11 0x55db78cfee6b in address_space_write exec.c:3308:18
> >       #12 0x55db78d01fe7 in address_space_unmap exec.c:3634:9
> >       #13 0x55db79edebbb in dma_memory_unmap include/sysemu/dma.h:145:5
> >       #14 0x55db79edebbb in usb_packet_unmap hw/usb/libhw.c:65:9
> >       #15 0x55db79ede66f in usb_packet_map hw/usb/libhw.c:54:5
> >       #16 0x55db79f6d5f1 in xhci_setup_packet hw/usb/hcd-xhci.c:1618:5
> >       #17 0x55db79f67143 in xhci_fire_ctl_transfer hw/usb/hcd-xhci.c:17=
22:9
> >       #18 0x55db79f67143 in xhci_kick_epctx hw/usb/hcd-xhci.c:1991:13
> >       #19 0x55db79f8837d in xhci_doorbell_write hw/usb/hcd-xhci.c:3162:=
13
> >       #20 0x55db792c6b8e in memory_region_write_accessor softmmu/memory=
.c:483:5
> >       #21 0x55db792c658b in access_with_adjusted_size softmmu/memory.c:=
544:18
> >       #22 0x55db792c5d9b in memory_region_dispatch_write softmmu/memory=
.c
> >       #23 0x55db78d094d2 in flatview_write_continue exec.c:3176:23
> >       #24 0x55db78cfee6b in flatview_write exec.c:3216:14
> >       #25 0x55db78cfee6b in address_space_write exec.c:3308:18
> >       #26 0x55db793072a9 in qtest_process_command softmmu/qtest.c:452:13
> >       #27 0x55db79304087 in qtest_process_inbuf softmmu/qtest.c:710:9
> >       #28 0x55db7a7d7293 in fd_chr_read chardev/char-fd.c:68:9
> >       #29 0x7fc5d7f1a897 in g_main_context_dispatch
> >
> >   previously allocated by thread T0 here:
> >       #0 0x55db78cac562 in calloc (build/i386-softmmu/qemu-system-i386+=
0x250e562)
> >       #1 0x7fc5d7f20548 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libglib=
-2.0.so.0+0x54548)
> >       #2 0x55db79f8837d in xhci_doorbell_write hw/usb/hcd-xhci.c:3162:13
> >       #3 0x55db792c6b8e in memory_region_write_accessor softmmu/memory.=
c:483:5
> >       #4 0x55db792c658b in access_with_adjusted_size softmmu/memory.c:5=
44:18
> >       #5 0x55db792c5d9b in memory_region_dispatch_write softmmu/memory.c
> >       #6 0x55db78d094d2 in flatview_write_continue exec.c:3176:23
> >       #7 0x55db78cfee6b in flatview_write exec.c:3216:14
> >       #8 0x55db78cfee6b in address_space_write exec.c:3308:18
> >       #9 0x55db793072a9 in qtest_process_command softmmu/qtest.c:452:13
> >       #10 0x55db79304087 in qtest_process_inbuf softmmu/qtest.c:710:9
> >       #11 0x55db7a7d7293 in fd_chr_read chardev/char-fd.c:68:9
> >       #12 0x7fc5d7f1a897 in g_main_context_dispatch
> >
> >   -Alex
> >
> > To manage notifications about this bug go to:
> > https://bugs.launchpad.net/qemu/+bug/1891354/+subscriptions
> >
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1891354

Title:
  Heap-use-after-free in usb_packet_unmap

Status in QEMU:
  New

Bug description:
  Hello,
  Reproducer:

  cat << EOF | ./i386-softmmu/qemu-system-i386 -device nec-usb-xhci \
  -trace usb\* -device usb-audio -device usb-storage,drive=3Dmydrive \
  -drive id=3Dmydrive,file=3Dnull-co://,size=3D2M,format=3Draw,if=3Dnone \
  -nodefaults -nographic -qtest stdio
  outl 0xcf8 0x80001010
  outl 0xcfc 0xc0202
  outl 0xcf8 0x80001004
  outl 0xcfc 0x1c77695e
  writel 0xc0040 0xffffd855
  writeq 0xc2000 0xff05140100000000
  write 0x1d 0x1 0x27
  write 0x2d 0x1 0x2e
  write 0x17232 0x1 0x03
  write 0x17254 0x1 0x05
  write 0x17276 0x1 0x72
  write 0x17278 0x1 0x02
  write 0x3d 0x1 0x27
  write 0x40 0x1 0x2e
  write 0x41 0x1 0x72
  write 0x42 0x1 0x01
  write 0x4d 0x1 0x2e
  write 0x4f 0x1 0x01
  write 0x2007c 0x1 0xc7
  writeq 0xc2000 0x5c05140100000000
  write 0x20070 0x1 0x80
  write 0x20078 0x1 0x08
  write 0x2007c 0x1 0xfe
  write 0x2007d 0x1 0x08
  write 0x20081 0x1 0xff
  write 0x20082 0x1 0x0b
  write 0x20089 0x1 0x8c
  write 0x2008d 0x1 0x04
  write 0x2009d 0x1 0x10
  writeq 0xc2000 0x2505ef019e092f00
  EOF

  20091=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0x6110=
00045030 at pc 0x55db79edeef2 bp 0x7ffc4020b2b0 sp 0x7ffc4020b2a8
  READ of size 4 at 0x611000045030 thread T0
      #0 0x55db79edeef1 in usb_packet_unmap hw/usb/libhw.c:64:28
      #1 0x55db79ede66f in usb_packet_map hw/usb/libhw.c:54:5
      #2 0x55db79f6d5f1 in xhci_setup_packet hw/usb/hcd-xhci.c:1618:5
      #3 0x55db79f67143 in xhci_fire_ctl_transfer hw/usb/hcd-xhci.c:1722:9
      #4 0x55db79f67143 in xhci_kick_epctx hw/usb/hcd-xhci.c:1991:13
      #5 0x55db79f8837d in xhci_doorbell_write hw/usb/hcd-xhci.c:3162:13
      #6 0x55db792c6b8e in memory_region_write_accessor softmmu/memory.c:48=
3:5
      #7 0x55db792c658b in access_with_adjusted_size softmmu/memory.c:544:18
      #8 0x55db792c5d9b in memory_region_dispatch_write softmmu/memory.c
      #9 0x55db78d094d2 in flatview_write_continue exec.c:3176:23
      #10 0x55db78cfee6b in flatview_write exec.c:3216:14
      #11 0x55db78cfee6b in address_space_write exec.c:3308:18
      #12 0x55db793072a9 in qtest_process_command softmmu/qtest.c:452:13
      #13 0x55db79304087 in qtest_process_inbuf softmmu/qtest.c:710:9
      #14 0x55db7a7d7293 in fd_chr_read chardev/char-fd.c:68:9
      #15 0x7fc5d7f1a897 in g_main_context_dispatch
      #16 0x55db7aa571b3 in glib_pollfds_poll util/main-loop.c:217:9
      #17 0x55db7aa571b3 in os_host_main_loop_wait util/main-loop.c:240:5
      #18 0x55db7aa571b3 in main_loop_wait util/main-loop.c:516:11
      #19 0x55db79315008 in qemu_main_loop softmmu/vl.c:1676:9
      #20 0x55db7a8860fd in main softmmu/main.c:49:5

  0x611000045030 is located 48 bytes inside of 256-byte region [0x611000045=
000,0x611000045100)
  freed by thread T0 here:
      #0 0x55db78cac16d in free (build/i386-softmmu/qemu-system-i386+0x250e=
16d)
      #1 0x55db79f7c0e8 in xhci_ep_nuke_xfers hw/usb/hcd-xhci.c:1252:9
      #2 0x55db79f7b454 in xhci_disable_ep hw/usb/hcd-xhci.c:1279:5
      #3 0x55db79f79af7 in xhci_disable_slot hw/usb/hcd-xhci.c:2048:13
      #4 0x55db79f5aea3 in xhci_reset hw/usb/hcd-xhci.c:2706:9
      #5 0x55db79f82f49 in xhci_oper_write hw/usb/hcd-xhci.c:2966:13
      #6 0x55db792c6b8e in memory_region_write_accessor softmmu/memory.c:48=
3:5
      #7 0x55db792c658b in access_with_adjusted_size softmmu/memory.c:544:18
      #8 0x55db792c5d9b in memory_region_dispatch_write softmmu/memory.c
      #9 0x55db78d094d2 in flatview_write_continue exec.c:3176:23
      #10 0x55db78cfee6b in flatview_write exec.c:3216:14
      #11 0x55db78cfee6b in address_space_write exec.c:3308:18
      #12 0x55db78d01fe7 in address_space_unmap exec.c:3634:9
      #13 0x55db79edebbb in dma_memory_unmap include/sysemu/dma.h:145:5
      #14 0x55db79edebbb in usb_packet_unmap hw/usb/libhw.c:65:9
      #15 0x55db79ede66f in usb_packet_map hw/usb/libhw.c:54:5
      #16 0x55db79f6d5f1 in xhci_setup_packet hw/usb/hcd-xhci.c:1618:5
      #17 0x55db79f67143 in xhci_fire_ctl_transfer hw/usb/hcd-xhci.c:1722:9
      #18 0x55db79f67143 in xhci_kick_epctx hw/usb/hcd-xhci.c:1991:13
      #19 0x55db79f8837d in xhci_doorbell_write hw/usb/hcd-xhci.c:3162:13
      #20 0x55db792c6b8e in memory_region_write_accessor softmmu/memory.c:4=
83:5
      #21 0x55db792c658b in access_with_adjusted_size softmmu/memory.c:544:=
18
      #22 0x55db792c5d9b in memory_region_dispatch_write softmmu/memory.c
      #23 0x55db78d094d2 in flatview_write_continue exec.c:3176:23
      #24 0x55db78cfee6b in flatview_write exec.c:3216:14
      #25 0x55db78cfee6b in address_space_write exec.c:3308:18
      #26 0x55db793072a9 in qtest_process_command softmmu/qtest.c:452:13
      #27 0x55db79304087 in qtest_process_inbuf softmmu/qtest.c:710:9
      #28 0x55db7a7d7293 in fd_chr_read chardev/char-fd.c:68:9
      #29 0x7fc5d7f1a897 in g_main_context_dispatch

  previously allocated by thread T0 here:
      #0 0x55db78cac562 in calloc (build/i386-softmmu/qemu-system-i386+0x25=
0e562)
      #1 0x7fc5d7f20548 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libglib-2.0=
.so.0+0x54548)
      #2 0x55db79f8837d in xhci_doorbell_write hw/usb/hcd-xhci.c:3162:13
      #3 0x55db792c6b8e in memory_region_write_accessor softmmu/memory.c:48=
3:5
      #4 0x55db792c658b in access_with_adjusted_size softmmu/memory.c:544:18
      #5 0x55db792c5d9b in memory_region_dispatch_write softmmu/memory.c
      #6 0x55db78d094d2 in flatview_write_continue exec.c:3176:23
      #7 0x55db78cfee6b in flatview_write exec.c:3216:14
      #8 0x55db78cfee6b in address_space_write exec.c:3308:18
      #9 0x55db793072a9 in qtest_process_command softmmu/qtest.c:452:13
      #10 0x55db79304087 in qtest_process_inbuf softmmu/qtest.c:710:9
      #11 0x55db7a7d7293 in fd_chr_read chardev/char-fd.c:68:9
      #12 0x7fc5d7f1a897 in g_main_context_dispatch

  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1891354/+subscriptions

