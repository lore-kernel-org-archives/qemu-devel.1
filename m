Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C9DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 05:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F41B20708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 05:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F41B20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsfk5-0005kk-5O
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 01:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jsfj1-0004Zm-8u
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 01:00:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:45124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jsfix-0001oc-0z
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 01:00:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jsfiu-0005aE-IY
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 05:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 89E742E8052
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 05:00:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2020 04:52:52 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1886362@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr philmd
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <159400349818.1851.7243060688419202620.malonedeb@wampee.canonical.com>
Message-Id: <159409757229.31166.13103886621257093322.malone@wampee.canonical.com>
Subject: [Bug 1886362] Re: Heap use-after-free in lduw_he_p through
 e1000e_write_to_rx_buffers
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ffd32ad7291fe66b5578d7c1407aaae58d1e0170";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4119075d5a18860cccc69881f17063ef1fbf3145
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 01:00:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1886362 <1886362@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running with '-trace e1000\*':

e1000e_cb_pci_realize E1000E PCI realize entry
e1000e_mac_set_permanent Set permanent MAC: 52:54:00:12:34:56
e1000e_cfg_support_virtio Virtio header supported: 0
e1000e_rx_set_cso RX CSO state set to 0
e1000e_cb_qdev_reset E1000E qdev reset entry
e1000x_mac_indicate Indicating MAC to guest: 52:54:00:12:34:56
e1000x_rx_can_recv_disabled link_up: 1, rx_enabled 0, pci_master 0
e1000x_rx_can_recv_disabled link_up: 1, rx_enabled 0, pci_master 0
e1000e_vm_state_running VM state is running
[R +0.094581] outl 0xcf8 0x80001010
[S +0.094604] OK
[R +0.094632] outl 0xcfc 0xe1020000
[S +0.094654] OK
[R +0.094668] outl 0xcf8 0x80001014
[S +0.094675] OK
[R +0.094694] outl 0xcf8 0x80001004
[S +0.094702] OK
[R +0.094712] outw 0xcfc 0x7
e1000e_rx_start_recv =

[S +0.096938] OK
[R +0.096960] outl 0xcf8 0x800010a2
[S +0.096972] OK
[R +0.096986] write 0xe102003b 0x1 0xff
e1000e_core_write Write to register 0x38, 4 byte(s), value: 0xff
e1000e_vlan_vet Setting VLAN ethernet type 0xFF
[S +0.097019] OK
[R +0.097034] write 0xe1020103 0x1e 0xffffff055c5e5c30be4511d084fffffffffff=
fffffffffffffffffffffff
e1000e_core_write Write to register 0x100, 4 byte(s), value: 0xff
e1000e_rx_set_rctl RCTL =3D 0xff
e1000e_rx_desc_buff_sizes buffer sizes: [2048, 0, 0, 0]
e1000e_rx_desc_len RX descriptor length: 16
e1000e_rx_start_recv =

e1000e_wrn_regs_write_unknown WARNING: Write to unknown register 0x104, 4 b=
yte(s), value: 0x5c05ffff
e1000e_core_write Write to register 0x2820, 4 byte(s), value: 0xbe305c5e
e1000e_irq_rdtr_fpd_not_running FPD written while RDTR was not running
e1000e_wrn_regs_write_unknown WARNING: Write to unknown register 0x10c, 4 b=
yte(s), value: 0x84d01145
e1000e_core_write Write to register 0x2800, 4 byte(s), value: 0xffffffff
e1000e_core_write Write to register 0x2804, 4 byte(s), value: 0xffffffff
e1000e_core_write Write to register 0x2808, 4 byte(s), value: 0xffffffff
e1000e_wrn_regs_write_unknown WARNING: Write to unknown register 0x11c, 4 b=
yte(s), value: 0xffffffff
e1000e_core_write Write to register 0x2810, 4 byte(s), value: 0xff
[S +0.097143] OK
[R +0.097159] write 0xe1020420 0x4 0xffffffff
e1000e_core_write Write to register 0x3800, 4 byte(s), value: 0xffffffff
[S +0.097173] OK
[R +0.097183] write 0xe1020424 0x4 0xffffffff
e1000e_core_write Write to register 0x3804, 4 byte(s), value: 0xffffffff
[S +0.097196] OK
[R +0.097208] write 0xe102042b 0x1 0xff
e1000e_core_write Write to register 0x3808, 4 byte(s), value: 0xff
[S +0.097221] OK
[R +0.097231] write 0xe1020430 0x4 0x055c5e5c
e1000e_core_write Write to register 0x3810, 4 byte(s), value: 0x5c5e5c05
[S +0.097243] OK
[R +0.097253] write 0x5c041 0x1 0x04
[S +0.097914] OK
[R +0.097942] write 0x5c042 0x1 0x02
[S +0.097953] OK
[R +0.097964] write 0x5c043 0x1 0xe1
[S +0.097972] OK
[R +0.097984] write 0x5c048 0x1 0x8a
[S +0.097992] OK
[R +0.098003] write 0x5c04a 0x1 0x31
[S +0.098011] OK
[R +0.098022] write 0x5c04b 0x1 0xff
[S +0.098029] OK
[R +0.098040] write 0xe1020403 0x1 0xff
e1000e_core_write Write to register 0x400, 4 byte(s), value: 0xff
e1000e_tx_descr 0xe1020400 : ff31008a 0
e1000e_core_read Read from register 0x400, 4 byte(s), value: 0xff
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x404, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x408, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x40c, 4 b=
yte(s)
e1000e_core_read Read from register 0x410, 4 byte(s), value: 0x602008
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x414, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x418, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x41c, 4 b=
yte(s)
e1000e_core_read Read from register 0x3800, 4 byte(s), value: 0xfffffff0
e1000e_core_read Read from register 0x3804, 4 byte(s), value: 0xffffffff
e1000e_core_read Read from register 0x3808, 4 byte(s), value: 0x80
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x42c, 4 b=
yte(s)
e1000e_core_read Read from register 0x3810, 4 byte(s), value: 0x5c05
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x434, 4 b=
yte(s)
e1000e_core_read Read from register 0x3818, 4 byte(s), value: 0x0
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x43c, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x3820, 4 =
byte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x444, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x448, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x44c, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x450, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x454, 4 b=
yte(s)
e1000e_core_read Read from register 0x458, 4 byte(s), value: 0x0
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x45c, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x460, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x464, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x468, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x46c, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x470, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x474, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x478, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x47c, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x480, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x484, 4 b=
yte(s)
e1000e_wrn_regs_read_unknown WARNING: Read from unknown register 0x488, 4 b=
yte(s)
e1000e_rx_receive_iov Received vector of 4 fragments
e1000x_vlan_is_vlan_pkt Is VLAN packet: 0, ETH proto: 0x0, VET: 0xFF
e1000e_rx_rss_started Starting RSS processing
e1000e_rx_rss_disabled RSS is disabled
e1000e_rx_rss_dispatched_to_queue Packet being dispatched to queue 0
e1000e_ring_free_space ring #0: LEN: 1048448, DH: 255, DT: 0
e1000e_rx_has_buffers ring #0: free descr: 65273, packet size 142, descr bu=
ffer size 2048
e1000e_rx_descr Next RX descriptor: ring #0, PA: 0xfe0, length: 16
e1000e_rx_null_descriptor Null RX descriptor!!
e1000e_rx_descr Next RX descriptor: ring #0, PA: 0xff0, length: 16
e1000e_rx_null_descriptor Null RX descriptor!!
e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x1000, length: 16
e1000e_rx_null_descriptor Null RX descriptor!!
e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x1010, length: 16
e1000e_rx_null_descriptor Null RX descriptor!!
[...]
e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x5c020, length: 16
e1000e_rx_null_descriptor Null RX descriptor!!
e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x5c030, length: 16
e1000e_rx_null_descriptor Null RX descriptor!!
e1000e_rx_descr Next RX descriptor: ring #0, PA: 0x5c040, length: 16
e1000e_rx_desc_buff_write buffer #0, addr: 0xe1020400, offset: 0, from: 0x6=
31000028830, length: 14
e1000e_core_write Write to register 0x400, 4 byte(s), value: 0xff
e1000e_tx_descr 0xe1020400 : ff31008a 0
e1000e_irq_rearm_timer Mitigation timer armed for register 0x3820, delay 0 =
ns
e1000e_irq_set_cause_entry Going to set IRQ cause 0x2, ICR: 0x0
e1000e_irq_set_cause_exit Set IRQ cause 0x3, ICR: 0x3
e1000e_irq_fix_icr_asserted ICR_ASSERTED bit fixed: 0x80000003
e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x80000003, IMS: 0x0)
e1000e_irq_legacy_notify IRQ line state: 0
e1000e_wrn_regs_write_unknown WARNING: Write to unknown register 0x404, 4 b=
yte(s), value: 0x0
e1000e_wrn_regs_write_unknown WARNING: Write to unknown register 0x408, 4 b=
yte(s), value: 0x0
e1000e_wrn_regs_write_unknown WARNING: Write to unknown register 0x40c, 4 b=
yte(s), value: 0x0
e1000e_rx_desc_buff_write buffer #0, addr: 0xe1020400, offset: 14, from: 0x=
62500024200e, length: 124
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D32103=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0x=
62500024200e at pc 0x55cd3c40c9aa bp 0x7ffd97112bf0 sp 0x7ffd971123a0

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1886362

Title:
  Heap use-after-free in lduw_he_p through e1000e_write_to_rx_buffers

Status in QEMU:
  New

Bug description:
  Hello,
  This reproducer causes a heap-use-after free. QEMU Built with --enable-sa=
nitizers:
  cat << EOF | ./i386-softmmu/qemu-system-i386 -M q35,accel=3Dqtest \
  -qtest stdio -nographic -monitor none -serial none
  outl 0xcf8 0x80001010
  outl 0xcfc 0xe1020000
  outl 0xcf8 0x80001014
  outl 0xcf8 0x80001004
  outw 0xcfc 0x7
  outl 0xcf8 0x800010a2
  write 0xe102003b 0x1 0xff
  write 0xe1020103 0x1e 0xffffff055c5e5c30be4511d084fffffffffffffffffffffff=
fffffffffff
  write 0xe1020420 0x4 0xffffffff
  write 0xe1020424 0x4 0xffffffff
  write 0xe102042b 0x1 0xff
  write 0xe1020430 0x4 0x055c5e5c
  write 0x5c041 0x1 0x04
  write 0x5c042 0x1 0x02
  write 0x5c043 0x1 0xe1
  write 0x5c048 0x1 0x8a
  write 0x5c04a 0x1 0x31
  write 0x5c04b 0x1 0xff
  write 0xe1020403 0x1 0xff
  EOF

  The Output:
  =3D=3D22689=3D=3DERROR: AddressSanitizer: heap-use-after-free on address =
0x62500026800e at pc 0x55b93bb18bfa bp 0x7fffdbe844f0 sp 0x7fffdbe83cb8
  READ of size 2 at 0x62500026800e thread T0
      #0  in __asan_memcpy (/build/i386-softmmu/qemu-system-i386+)
      #1  in lduw_he_p /include/qemu/bswap.h:332:5
      #2  in ldn_he_p /include/qemu/bswap.h:550:1
      #3  in flatview_write_continue /exec.c:3145:19
      #4  in flatview_write /exec.c:3186:14
      #5  in address_space_write /exec.c:3280:18
      #6  in address_space_rw /exec.c:3290:16
      #7  in dma_memory_rw_relaxed /include/sysemu/dma.h:87:18
      #8  in dma_memory_rw /include/sysemu/dma.h:113:12
      #9  in pci_dma_rw /include/hw/pci/pci.h:789:5
      #10  in pci_dma_write /include/hw/pci/pci.h:802:12
      #11  in e1000e_write_to_rx_buffers /hw/net/e1000e_core.c:1412:9
      #12  in e1000e_write_packet_to_guest /hw/net/e1000e_core.c:1582:21
      #13  in e1000e_receive_iov /hw/net/e1000e_core.c:1709:9
      #14  in e1000e_nc_receive_iov /hw/net/e1000e.c:213:12
      #15  in net_tx_pkt_sendv /hw/net/net_tx_pkt.c:544:9
      #16  in net_tx_pkt_send /hw/net/net_tx_pkt.c:620:9
      #17  in net_tx_pkt_send_loopback /hw/net/net_tx_pkt.c:633:11
      #18  in e1000e_tx_pkt_send /hw/net/e1000e_core.c:664:16
      #19  in e1000e_process_tx_desc /hw/net/e1000e_core.c:743:17
      #20  in e1000e_start_xmit /hw/net/e1000e_core.c:934:9
      #21  in e1000e_set_tctl /hw/net/e1000e_core.c:2431:9
      #22  in e1000e_core_write /hw/net/e1000e_core.c:3265:9
      #23  in e1000e_mmio_write /hw/net/e1000e.c:109:5
      #24  in memory_region_write_accessor /memory.c:483:5
      #25  in access_with_adjusted_size /memory.c:544:18
      #26  in memory_region_dispatch_write /memory.c:1476:16
      #27  in flatview_write_continue /exec.c:3146:23
      #28  in flatview_write /exec.c:3186:14
      #29  in address_space_write /exec.c:3280:18
      #30  in qtest_process_command /qtest.c:567:9
      #31  in qtest_process_inbuf /qtest.c:710:9
      #32  in qtest_read /qtest.c:722:5
      #33  in qemu_chr_be_write_impl /chardev/char.c:188:9
      #34  in qemu_chr_be_write /chardev/char.c:200:9
      #35  in fd_chr_read /chardev/char-fd.c:68:9
      #36  in qio_channel_fd_source_dispatch /io/channel-watch.c:84:12
      #37  in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.=
0.so.0+)
      #38  in glib_pollfds_poll /util/main-loop.c:219:9
      #39  in os_host_main_loop_wait /util/main-loop.c:242:5
      #40  in main_loop_wait /util/main-loop.c:518:11
      #41  in qemu_main_loop /softmmu/vl.c:1664:9
      #42  in main /softmmu/main.c:52:5
      #43  in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+)
      #44  in _start (/build/i386-softmmu/qemu-system-i386+)

  0x62500026800e is located 14 bytes inside of 138-byte region [0x625000268=
000,0x62500026808a)
  freed by thread T0 here:
      #0  in free (/build/i386-softmmu/qemu-system-i386+)
      #1  in qemu_vfree /util/oslib-posix.c:238:5
      #2  in address_space_unmap /exec.c:3616:5
      #3  in dma_memory_unmap /include/sysemu/dma.h:148:5
      #4  in pci_dma_unmap /include/hw/pci/pci.h:839:5
      #5  in net_tx_pkt_reset /hw/net/net_tx_pkt.c:453:9
      #6  in e1000e_process_tx_desc /hw/net/e1000e_core.c:749:9
      #7  in e1000e_start_xmit /hw/net/e1000e_core.c:934:9
      #8  in e1000e_set_tctl /hw/net/e1000e_core.c:2431:9
      #9  in e1000e_core_write /hw/net/e1000e_core.c:3265:9
      #10  in e1000e_mmio_write /hw/net/e1000e.c:109:5
      #11  in memory_region_write_accessor /memory.c:483:5
      #12  in access_with_adjusted_size /memory.c:544:18
      #13  in memory_region_dispatch_write /memory.c:1476:16
      #14  in flatview_write_continue /exec.c:3146:23
      #15  in flatview_write /exec.c:3186:14
      #16  in address_space_write /exec.c:3280:18
      #17  in address_space_rw /exec.c:3290:16
      #18  in dma_memory_rw_relaxed /include/sysemu/dma.h:87:18
      #19  in dma_memory_rw /include/sysemu/dma.h:113:12
      #20  in pci_dma_rw /include/hw/pci/pci.h:789:5
      #21  in pci_dma_write /include/hw/pci/pci.h:802:12
      #22  in e1000e_write_to_rx_buffers /hw/net/e1000e_core.c:1412:9
      #23  in e1000e_write_packet_to_guest /hw/net/e1000e_core.c:1582:21
      #24  in e1000e_receive_iov /hw/net/e1000e_core.c:1709:9
      #25  in e1000e_nc_receive_iov /hw/net/e1000e.c:213:12
      #26  in net_tx_pkt_sendv /hw/net/net_tx_pkt.c:544:9
      #27  in net_tx_pkt_send /hw/net/net_tx_pkt.c:620:9
      #28  in net_tx_pkt_send_loopback /hw/net/net_tx_pkt.c:633:11
      #29  in e1000e_tx_pkt_send /hw/net/e1000e_core.c:664:16

  previously allocated by thread T0 here:
      #0  in posix_memalign (/build/i386-softmmu/qemu-system-i386+)
      #1  in qemu_try_memalign /util/oslib-posix.c:198:11
      #2  in qemu_memalign /util/oslib-posix.c:214:27
      #3  in address_space_map /exec.c:3558:25
      #4  in dma_memory_map /include/sysemu/dma.h:138:9
      #5  in pci_dma_map /include/hw/pci/pci.h:832:11
      #6  in net_tx_pkt_add_raw_fragment /hw/net/net_tx_pkt.c:391:24
      #7  in e1000e_process_tx_desc /hw/net/e1000e_core.c:731:14
      #8  in e1000e_start_xmit /hw/net/e1000e_core.c:934:9
      #9  in e1000e_set_tctl /hw/net/e1000e_core.c:2431:9
      #10  in e1000e_core_write /hw/net/e1000e_core.c:3265:9
      #11  in e1000e_mmio_write /hw/net/e1000e.c:109:5
      #12  in memory_region_write_accessor /memory.c:483:5
      #13  in access_with_adjusted_size /memory.c:544:18
      #14  in memory_region_dispatch_write /memory.c:1476:16
      #15  in flatview_write_continue /exec.c:3146:23
      #16  in flatview_write /exec.c:3186:14
      #17  in address_space_write /exec.c:3280:18
      #18  in qtest_process_command /qtest.c:567:9
      #19  in qtest_process_inbuf /qtest.c:710:9
      #20  in qtest_read /qtest.c:722:5
      #21  in qemu_chr_be_write_impl /chardev/char.c:188:9
      #22  in qemu_chr_be_write /chardev/char.c:200:9
      #23  in fd_chr_read /chardev/char-fd.c:68:9
      #24  in qio_channel_fd_source_dispatch /io/channel-watch.c:84:12
      #25  in g_main_context_dispatch (/usr/lib/x86_64-linux-gnu/libglib-2.=
0.so.0+)

  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1886362/+subscriptions

