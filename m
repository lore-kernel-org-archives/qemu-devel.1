Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26393C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF646208D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF646208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX0iK-0003kb-6j
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 05:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iX0hd-0003KX-Uh
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iX0ha-0003DZ-BY
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:25:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:34628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iX0ha-0003CY-5G
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:25:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iX0hY-00020r-B3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 10:25:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4F1D72E80C0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 10:25:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Nov 2019 10:16:34 -0000
From: Leonid Myravjev <1853123@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ffasm
X-Launchpad-Bug-Reporter: Leonid Myravjev (ffasm)
X-Launchpad-Bug-Modifier: Leonid Myravjev (ffasm)
Message-Id: <157415859481.31407.14877522937916803487.malonedeb@wampee.canonical.com>
Subject: [Bug 1853123] [NEW] Memory synchronization error between kvm and
 target, e1000(dpdk)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9ce58656c9586bf86efd1179638305252c6fa7b8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1853123 <1853123@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hi folks.

I use linux with dpdk drivers on the target system, and e1000 emulation dev=
ice with tap interface for host. I use kvm for accelerate.
Version qemu 4.0.94 and master (Nov 12 10:14:33 2019)
Version dpdk stable-17.11.4
Version linux host 4.15.0-66-generic (ubuntu 18.04)

I type command "ping <target ip> -f" and wait about 1-2 minutes. Network
subsystem freezes.

For receive the eth pack from host system (tap interface) to host system
the e1000 using ring buffer.

The e1000 write body of eth pack, set E1000_RXD_STAT_DD flag and move RDH (=
Ring Device Head).
(file hw/net/e1000.c function e1000_receive_iov() )

The dpdk driver is reading from E1000_RXD_STAT_DD flags (ignoring RDH), if =
flag is set: read buffer, unset flag E1000_RXD_STAT_DD and move RDT (Ring D=
evice Tail).
(source drivers/net/e1000/em_rxtx.c function eth_em_recv_scattered_pkts() )

I see what the driver unet E1000_RXD_STAT_DD (rxdp->status =3D 0; ), but
sometimes rxdp->status remains equal to 7. On the next cycle, this this
buffer is read, RDT moved to far. RDH becomes equal RDT and network is
freezes.

If I insert some delay after unset E1000_RXD_STAT_DD, and repeatedly unset =
E1000_RXD_STAT_DD (if rxdp->status =3D=3D 7 ), then all work fine.
If check E1000_RXD_STAT_DD without delay, status rxdp->status always valid.

This only appears on kvm. If I use tcg all works fine.

I trying set watchpoint for memory on the qemu (for tcg), and see, that
for one package cycle of set/unse STAT_DD repeated once.

I trying set watchpoint for memory on the qemu (for kvm), and see, that
rxdp->status changed to 0(unset) only once, but is changes immediately
before set flag.


Please help me with advice on how to catch and fix this error. =

Theoretically, it would help me to trace the memory access when writing to =
E1000_RXD_STAT_DD, RHD and RDT, both from the target and the host system. B=
ut I have no idea how this can be done.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1853123

Title:
  Memory synchronization error between kvm and target, e1000(dpdk)

Status in QEMU:
  New

Bug description:
  Hi folks.

  I use linux with dpdk drivers on the target system, and e1000 emulation d=
evice with tap interface for host. I use kvm for accelerate.
  Version qemu 4.0.94 and master (Nov 12 10:14:33 2019)
  Version dpdk stable-17.11.4
  Version linux host 4.15.0-66-generic (ubuntu 18.04)

  I type command "ping <target ip> -f" and wait about 1-2 minutes.
  Network subsystem freezes.

  For receive the eth pack from host system (tap interface) to host
  system the e1000 using ring buffer.

  The e1000 write body of eth pack, set E1000_RXD_STAT_DD flag and move RDH=
 (Ring Device Head).
  (file hw/net/e1000.c function e1000_receive_iov() )

  The dpdk driver is reading from E1000_RXD_STAT_DD flags (ignoring RDH), i=
f flag is set: read buffer, unset flag E1000_RXD_STAT_DD and move RDT (Ring=
 Device Tail).
  (source drivers/net/e1000/em_rxtx.c function eth_em_recv_scattered_pkts()=
 )

  I see what the driver unet E1000_RXD_STAT_DD (rxdp->status =3D 0; ), but
  sometimes rxdp->status remains equal to 7. On the next cycle, this
  this buffer is read, RDT moved to far. RDH becomes equal RDT and
  network is freezes.

  If I insert some delay after unset E1000_RXD_STAT_DD, and repeatedly unse=
t E1000_RXD_STAT_DD (if rxdp->status =3D=3D 7 ), then all work fine.
  If check E1000_RXD_STAT_DD without delay, status rxdp->status always vali=
d.

  This only appears on kvm. If I use tcg all works fine.

  I trying set watchpoint for memory on the qemu (for tcg), and see,
  that for one package cycle of set/unse STAT_DD repeated once.

  I trying set watchpoint for memory on the qemu (for kvm), and see,
  that rxdp->status changed to 0(unset) only once, but is changes
  immediately before set flag.

  =

  Please help me with advice on how to catch and fix this error. =

  Theoretically, it would help me to trace the memory access when writing t=
o E1000_RXD_STAT_DD, RHD and RDT, both from the target and the host system.=
 But I have no idea how this can be done.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1853123/+subscriptions

