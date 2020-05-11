Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C78C54E8F
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728EC20708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728EC20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYAxr-0000aK-Jp
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYAw0-00074i-9O
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:05:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:43316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYAvx-0007Ws-ER
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:05:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jYAvv-0002jX-AB
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 16:05:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 46E722E80E7
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 16:05:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2020 15:53:09 -0000
From: Alexander Bulekov <1878034@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
Message-Id: <158921238974.12092.6203453160058985938.malonedeb@wampee.canonical.com>
Subject: [Bug 1878034] [NEW] memcpy param-overlap through
 e1000e_write_to_rx_buffers
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b8c007397a6de7346555435ea549bb2f91884045
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 11:35:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1878034 <1878034@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,
While fuzzing, I found an input that triggers an overlapping memcpy (caught=
 by AddressSanitizer).
Overlapping memcpys are undefined behavior according to the POSIX and C sta=
ndards, and can lead to bugs.

=3D=3D22287=3D=3DERROR: AddressSanitizer: memcpy-param-overlap: memory rang=
es
#0 0x563c9f4823d4 in __asan_memcpy (/home/alxndr/Development/qemu/build/i38=
6-softmmu/qemu-system-i386+0x97a3d4)
#1 0x563c9f4cb2b1 in flatview_write_continue /home/alxndr/Development/qemu/=
exec.c:3142:13
#2 0x563c9f4c3b97 in flatview_write /home/alxndr/Development/qemu/exec.c:31=
77:14
#3 0x563c9f4c3b97 in address_space_write /home/alxndr/Development/qemu/exec=
.c:3268:18
#4 0x563c9fbc457b in dma_memory_rw_relaxed /home/alxndr/Development/qemu/in=
clude/sysemu/dma.h:87:18
#5 0x563c9fbc457b in dma_memory_rw /home/alxndr/Development/qemu/include/sy=
semu/dma.h:110:12
#6 0x563c9fbc457b in pci_dma_rw /home/alxndr/Development/qemu/include/hw/pc=
i/pci.h:787:5
#7 0x563c9fbc457b in pci_dma_write /home/alxndr/Development/qemu/include/hw=
/pci/pci.h:800:12
#8 0x563c9fbc457b in e1000e_write_to_rx_buffers /home/alxndr/Development/qe=
mu/hw/net/e1000e_core.c:1412:9
#9 0x563c9fbb9c98 in e1000e_write_packet_to_guest /home/alxndr/Development/=
qemu/hw/net/e1000e_core.c:1582:21
#10 0x563c9fbb9c98 in e1000e_receive_iov /home/alxndr/Development/qemu/hw/n=
et/e1000e_core.c:1709:9
#11 0x563c9fba8080 in net_tx_pkt_sendv /home/alxndr/Development/qemu/hw/net=
/net_tx_pkt.c:544:9
#12 0x563c9fba8080 in net_tx_pkt_send /home/alxndr/Development/qemu/hw/net/=
net_tx_pkt.c:620:9
#13 0x563c9fba8827 in net_tx_pkt_send_loopback /home/alxndr/Development/qem=
u/hw/net/net_tx_pkt.c:633:11
#14 0x563c9fbd2052 in e1000e_tx_pkt_send /home/alxndr/Development/qemu/hw/n=
et/e1000e_core.c:664:16
#15 0x563c9fbd2052 in e1000e_process_tx_desc /home/alxndr/Development/qemu/=
hw/net/e1000e_core.c:743:17
#16 0x563c9fbd2052 in e1000e_start_xmit /home/alxndr/Development/qemu/hw/ne=
t/e1000e_core.c:934:9
#17 0x563c9fbcecf0 in e1000e_set_tdt /home/alxndr/Development/qemu/hw/net/e=
1000e_core.c:2451:9
#18 0x563c9fbbf20c in e1000e_core_write /home/alxndr/Development/qemu/hw/ne=
t/e1000e_core.c:3261:9
#19 0x563c9f5b68d6 in memory_region_write_accessor /home/alxndr/Development=
/qemu/memory.c:483:5
#20 0x563c9f5b627f in access_with_adjusted_size /home/alxndr/Development/qe=
mu/memory.c:544:18
#21 0x563c9f5b627f in memory_region_dispatch_write /home/alxndr/Development=
/qemu/memory.c:1476:16

I can reproduce it in qemu 5.0 built with --enable-sanitizers using:
cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc-q=
35-5.0 -accel qtest -qtest stdio -nographic -monitor none -serial none
outl 0xcf8 0x80001010
outl 0xcfc 0xe1020000
outl 0xcf8 0x80001014
outl 0xcf8 0x80001004
outw 0xcfc 0x7
outl 0xcf8 0x800010a2
write 0xe102003a 0x3ff 0xd1055e2d3b0002e10000000001ffd3055e2d3b0002e1000000=
0001ffd5055e2d3b0002e10000000001ffd7055e2d3b0002e10000000001ffd9055e2d3b000=
2e10000000001ffdb055e2d3b0002e10000000001ffdd055e2d3b0002e10000000001ffdf05=
5e2d3b0002e10000000001ffe1055e2d3b0002e10000000001ffe3055e2d3b0002e10000000=
001ffe5055e2d3b0002e10000000001ffe7055e2d3b0002e10000000001ffe9055e2d3b0002=
e10000000001ffeb055e2d3b0002e10000000001ffed055e2d3b0002e10000000001ffef055=
e2d3b0002e10000000001fff1055e2d3b0002e10000000001fff3055e2d3b0002e100000000=
01fff5055e2d3b0002e10000000001fff7055e2d3b0002e10000000001fff9055e2d3b0002e=
10000000001fffb055e2d3b0002e10000000001fffd055e2d3b0002e10000000001ffff055e=
2d3b0002e10000000001ff01055e2d3b0002e10000000001ff03055e2d3b0002e1000000000=
1ff05055e2d3b0002e10000000001ff07055e2d3b0002e10000000001ff09055e2d3b0002e1=
0000000001ff0b055e2d3b0002e10000000001ff0d055e2d3b0002e10000000001ff0f055e2=
d3b0002e10000000001ff11055e2d3b0002e10000000001ff13055e2d3b0002e10000000001=
ff15055e2d3b0002e10000000001ff17055e2d3b0002e10000000001ff19055e2d3b0002e10=
000000001ff1b055e2d3b0002e10000000001ff1d055e2d3b0002e10000000001ff1f055e2d=
3b0002e10000000001ff21055e2d3b0002e10000000001ff23055e2d3b0002e10000000001f=
f25055e2d3b0002e10000000001ff27055e2d3b0002e10000000001ff29055e2d3b0002e100=
00000001ff2b055e2d3b0002e10000000001ff2d055e2d3b0002e10000000001ff2f055e2d3=
b0002e10000000001ff31055e2d3b0002e10000000001ff33055e2d3b0002e10000000001ff=
35055e2d3b0002e10000000001ff37055e2d3b0002e10000000001ff39055e2d3b0002e1000=
0000001ff3b055e2d3b0002e10000000001ff3d055e2d3b0002e10000000001ff3f055e2d3b=
0002e10000000001ff41055e2d3b0002e10000000001ff43055e2d3b0002e10000000001ff4=
5055e2d3b0002e10000000001ff47055e2d3b0002e10000000001ff49055e2d3b0002e10000=
000001ff4b055e2d3b0002e10000000001ff4d055e2d3b0002e10000000001ff4f055e2d3b0=
002e10000000001ff51055e2d3b0002e10000000001ff53055e2d3b0002e10000000001ff55=
055e2d3b0002e10000000001ff57055e2d3b0002e10000000001ff59055e2d3b0002e100000=
00001ff5b055e2d3b0002e10000000001ff5d055e2d3b0002e10000000001ff5f055e2d3b00=
02e10000000001ff61055e2d3b0002e10000000001ff63
EOF

I also attached the trace to this launchpad report, in case the
formatting is broken:

qemu-system-i386 -M pc-q35-5.0 -accel qtest -qtest stdio -nographic
-monitor none -serial none < attachment

Please let me know if I can provide any further info.
-Alex

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "attachment"
   https://bugs.launchpad.net/bugs/1878034/+attachment/5369905/+files/attac=
hment

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878034

Title:
  memcpy param-overlap through e1000e_write_to_rx_buffers

Status in QEMU:
  New

Bug description:
  Hello,
  While fuzzing, I found an input that triggers an overlapping memcpy (caug=
ht by AddressSanitizer).
  Overlapping memcpys are undefined behavior according to the POSIX and C s=
tandards, and can lead to bugs.

  =3D=3D22287=3D=3DERROR: AddressSanitizer: memcpy-param-overlap: memory ra=
nges
  #0 0x563c9f4823d4 in __asan_memcpy (/home/alxndr/Development/qemu/build/i=
386-softmmu/qemu-system-i386+0x97a3d4)
  #1 0x563c9f4cb2b1 in flatview_write_continue /home/alxndr/Development/qem=
u/exec.c:3142:13
  #2 0x563c9f4c3b97 in flatview_write /home/alxndr/Development/qemu/exec.c:=
3177:14
  #3 0x563c9f4c3b97 in address_space_write /home/alxndr/Development/qemu/ex=
ec.c:3268:18
  #4 0x563c9fbc457b in dma_memory_rw_relaxed /home/alxndr/Development/qemu/=
include/sysemu/dma.h:87:18
  #5 0x563c9fbc457b in dma_memory_rw /home/alxndr/Development/qemu/include/=
sysemu/dma.h:110:12
  #6 0x563c9fbc457b in pci_dma_rw /home/alxndr/Development/qemu/include/hw/=
pci/pci.h:787:5
  #7 0x563c9fbc457b in pci_dma_write /home/alxndr/Development/qemu/include/=
hw/pci/pci.h:800:12
  #8 0x563c9fbc457b in e1000e_write_to_rx_buffers /home/alxndr/Development/=
qemu/hw/net/e1000e_core.c:1412:9
  #9 0x563c9fbb9c98 in e1000e_write_packet_to_guest /home/alxndr/Developmen=
t/qemu/hw/net/e1000e_core.c:1582:21
  #10 0x563c9fbb9c98 in e1000e_receive_iov /home/alxndr/Development/qemu/hw=
/net/e1000e_core.c:1709:9
  #11 0x563c9fba8080 in net_tx_pkt_sendv /home/alxndr/Development/qemu/hw/n=
et/net_tx_pkt.c:544:9
  #12 0x563c9fba8080 in net_tx_pkt_send /home/alxndr/Development/qemu/hw/ne=
t/net_tx_pkt.c:620:9
  #13 0x563c9fba8827 in net_tx_pkt_send_loopback /home/alxndr/Development/q=
emu/hw/net/net_tx_pkt.c:633:11
  #14 0x563c9fbd2052 in e1000e_tx_pkt_send /home/alxndr/Development/qemu/hw=
/net/e1000e_core.c:664:16
  #15 0x563c9fbd2052 in e1000e_process_tx_desc /home/alxndr/Development/qem=
u/hw/net/e1000e_core.c:743:17
  #16 0x563c9fbd2052 in e1000e_start_xmit /home/alxndr/Development/qemu/hw/=
net/e1000e_core.c:934:9
  #17 0x563c9fbcecf0 in e1000e_set_tdt /home/alxndr/Development/qemu/hw/net=
/e1000e_core.c:2451:9
  #18 0x563c9fbbf20c in e1000e_core_write /home/alxndr/Development/qemu/hw/=
net/e1000e_core.c:3261:9
  #19 0x563c9f5b68d6 in memory_region_write_accessor /home/alxndr/Developme=
nt/qemu/memory.c:483:5
  #20 0x563c9f5b627f in access_with_adjusted_size /home/alxndr/Development/=
qemu/memory.c:544:18
  #21 0x563c9f5b627f in memory_region_dispatch_write /home/alxndr/Developme=
nt/qemu/memory.c:1476:16

  I can reproduce it in qemu 5.0 built with --enable-sanitizers using:
  cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc=
-q35-5.0 -accel qtest -qtest stdio -nographic -monitor none -serial none
  outl 0xcf8 0x80001010
  outl 0xcfc 0xe1020000
  outl 0xcf8 0x80001014
  outl 0xcf8 0x80001004
  outw 0xcfc 0x7
  outl 0xcf8 0x800010a2
  write 0xe102003a 0x3ff 0xd1055e2d3b0002e10000000001ffd3055e2d3b0002e10000=
000001ffd5055e2d3b0002e10000000001ffd7055e2d3b0002e10000000001ffd9055e2d3b0=
002e10000000001ffdb055e2d3b0002e10000000001ffdd055e2d3b0002e10000000001ffdf=
055e2d3b0002e10000000001ffe1055e2d3b0002e10000000001ffe3055e2d3b0002e100000=
00001ffe5055e2d3b0002e10000000001ffe7055e2d3b0002e10000000001ffe9055e2d3b00=
02e10000000001ffeb055e2d3b0002e10000000001ffed055e2d3b0002e10000000001ffef0=
55e2d3b0002e10000000001fff1055e2d3b0002e10000000001fff3055e2d3b0002e1000000=
0001fff5055e2d3b0002e10000000001fff7055e2d3b0002e10000000001fff9055e2d3b000=
2e10000000001fffb055e2d3b0002e10000000001fffd055e2d3b0002e10000000001ffff05=
5e2d3b0002e10000000001ff01055e2d3b0002e10000000001ff03055e2d3b0002e10000000=
001ff05055e2d3b0002e10000000001ff07055e2d3b0002e10000000001ff09055e2d3b0002=
e10000000001ff0b055e2d3b0002e10000000001ff0d055e2d3b0002e10000000001ff0f055=
e2d3b0002e10000000001ff11055e2d3b0002e10000000001ff13055e2d3b0002e100000000=
01ff15055e2d3b0002e10000000001ff17055e2d3b0002e10000000001ff19055e2d3b0002e=
10000000001ff1b055e2d3b0002e10000000001ff1d055e2d3b0002e10000000001ff1f055e=
2d3b0002e10000000001ff21055e2d3b0002e10000000001ff23055e2d3b0002e1000000000=
1ff25055e2d3b0002e10000000001ff27055e2d3b0002e10000000001ff29055e2d3b0002e1=
0000000001ff2b055e2d3b0002e10000000001ff2d055e2d3b0002e10000000001ff2f055e2=
d3b0002e10000000001ff31055e2d3b0002e10000000001ff33055e2d3b0002e10000000001=
ff35055e2d3b0002e10000000001ff37055e2d3b0002e10000000001ff39055e2d3b0002e10=
000000001ff3b055e2d3b0002e10000000001ff3d055e2d3b0002e10000000001ff3f055e2d=
3b0002e10000000001ff41055e2d3b0002e10000000001ff43055e2d3b0002e10000000001f=
f45055e2d3b0002e10000000001ff47055e2d3b0002e10000000001ff49055e2d3b0002e100=
00000001ff4b055e2d3b0002e10000000001ff4d055e2d3b0002e10000000001ff4f055e2d3=
b0002e10000000001ff51055e2d3b0002e10000000001ff53055e2d3b0002e10000000001ff=
55055e2d3b0002e10000000001ff57055e2d3b0002e10000000001ff59055e2d3b0002e1000=
0000001ff5b055e2d3b0002e10000000001ff5d055e2d3b0002e10000000001ff5f055e2d3b=
0002e10000000001ff61055e2d3b0002e10000000001ff63
  EOF

  I also attached the trace to this launchpad report, in case the
  formatting is broken:

  qemu-system-i386 -M pc-q35-5.0 -accel qtest -qtest stdio -nographic
  -monitor none -serial none < attachment

  Please let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878034/+subscriptions

