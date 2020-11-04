Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D91BC4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E688B20782
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E688B20782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaPRV-0002QY-Kq
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 15:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaPQi-000189-9j
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 15:30:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:51660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaPQd-0007Kv-At
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 15:30:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaPQc-0001lx-0s
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 20:30:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 053942E8131
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 20:30:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2020 20:24:40 -0000
From: John Snow <1878253@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=jsnow@redhat.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr jnsnow
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <158930706000.2313.17393615876486439811.malonedeb@gac.canonical.com>
Message-Id: <160452148013.12454.7296896932442572511.malone@gac.canonical.com>
Subject: [Bug 1878253] Re: null-ptr dereference in address_space_to_flatview
 through ide
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: f62cf5db6b18bf9a015b6abe7928172c51689d93
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 14:49:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1878253 <1878253@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Merged upstream:

55adb3c45620c31f29978f209e2a44a08d34e2da
4ac4e7281a2dd1ca5158812198c4d2cbacf2ae25
b45bcd81e05dea2781f2164ca1c9dd86069502ea
1a9925e3390b6adf1125e3abaa17c80ca012bede


** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878253

Title:
  null-ptr dereference in address_space_to_flatview through ide

Status in QEMU:
  Fix Committed

Bug description:
  Hello,
  While fuzzing, I found an input that triggers a null-ptr dereference in
  address_space_to_flatview through ide:

  =3D=3D31699=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x00000=
0000020 (pc 0x55e0f562bafd bp 0x7ffee92355b0 sp 0x7ffee92354e0 T0)
  =3D=3D31699=3D=3DThe signal is caused by a READ memory access.
  =3D=3D31699=3D=3DHint: address points to the zero page.
      #0 0x55e0f562bafd in address_space_to_flatview /home/alxndr/Developme=
nt/qemu/include/exec/memory.h:693:12
      #1 0x55e0f562bafd in address_space_write /home/alxndr/Development/qem=
u/exec.c:3267:14
      #2 0x55e0f562dd9c in address_space_unmap /home/alxndr/Development/qem=
u/exec.c:3592:9
      #3 0x55e0f5ab8277 in dma_memory_unmap /home/alxndr/Development/qemu/i=
nclude/sysemu/dma.h:145:5
      #4 0x55e0f5ab8277 in dma_blk_unmap /home/alxndr/Development/qemu/dma-=
helpers.c:104:9
      #5 0x55e0f5ab8277 in dma_blk_cb /home/alxndr/Development/qemu/dma-hel=
pers.c:139:5
      #6 0x55e0f617a6b8 in blk_aio_complete /home/alxndr/Development/qemu/b=
lock/block-backend.c:1398:9
      #7 0x55e0f617a6b8 in blk_aio_complete_bh /home/alxndr/Development/qem=
u/block/block-backend.c:1408:5
      #8 0x55e0f6355efb in aio_bh_call /home/alxndr/Development/qemu/util/a=
sync.c:136:5
      #9 0x55e0f6355efb in aio_bh_poll /home/alxndr/Development/qemu/util/a=
sync.c:164:13
      #10 0x55e0f63608ce in aio_dispatch /home/alxndr/Development/qemu/util=
/aio-posix.c:380:5
      #11 0x55e0f635799a in aio_ctx_dispatch /home/alxndr/Development/qemu/=
util/async.c:306:5
      #12 0x7f16e85d69ed in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e9ed)
      #13 0x55e0f635e384 in glib_pollfds_poll /home/alxndr/Development/qemu=
/util/main-loop.c:219:9
      #14 0x55e0f635e384 in os_host_main_loop_wait /home/alxndr/Development=
/qemu/util/main-loop.c:242:5
      #15 0x55e0f635e384 in main_loop_wait /home/alxndr/Development/qemu/ut=
il/main-loop.c:518:11
      #16 0x55e0f593d676 in qemu_main_loop /home/alxndr/Development/qemu/so=
ftmmu/vl.c:1664:9
      #17 0x55e0f6267c6a in main /home/alxndr/Development/qemu/softmmu/main=
.c:49:5
      #18 0x7f16e7186e0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.3=
0/csu/../csu/libc-start.c:308:16
      #19 0x55e0f55727b9 in _start (/home/alxndr/Development/qemu/build/i38=
6-softmmu/qemu-system-i386+0x9027b9)

  AddressSanitizer can not provide additional info.
  SUMMARY: AddressSanitizer: SEGV /home/alxndr/Development/qemu/include/exe=
c/memory.h:693:12 in address_space_to_flatview

  I can reproduce it in qemu 5.0 using:

  cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc=
 -nographic -drive file=3Dnull-co://,if=3Dide,cache=3Dwriteback,format=3Dra=
w -nodefaults -display none -nographic -qtest stdio -monitor none -serial n=
one
  outl 0xcf8 0x80000920
  outl 0xcfc 0xc001
  outl 0xcf8 0x80000924
  outl 0xcf8 0x80000904
  outw 0xcfc 0x7
  outb 0x1f7 0xc8
  outw 0x3f6 0xe784
  outw 0x3f6 0xeb01
  outb 0xc005 0x21
  write 0x2103 0x1 0x4e
  outb 0xc000 0x1b
  outw 0x1f7 0xff35
  EOF

  I also attached the traces to this launchpad report, in case the
  formatting is broken:

  qemu-system-i386 -M pc -nographic -drive file=3Dnull-
  co://,if=3Dide,cache=3Dwriteback,format=3Draw -nodefaults -display none
  -nographic -qtest stdio -monitor none -serial none < attachment

  Please let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878253/+subscriptions

