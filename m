Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6C4C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8395F207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8395F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir0zn-00083I-DC
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 09:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ir0yL-0007BA-Af
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ir0yJ-0006Ho-V3
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:45:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:37348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ir0yJ-0006Ge-P1
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:45:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ir0yI-0007P2-5i
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 14:45:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E30022E8042
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 14:45:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jan 2020 14:36:47 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm gic
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee alexlngw pmaydell
X-Launchpad-Bug-Reporter: Alex Longwall (alexlngw)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <157887973843.5281.117317310678495552.malonedeb@gac.canonical.com>
Message-Id: <157892620732.14410.9250586282956495645.malone@wampee.canonical.com>
Subject: [Bug 1859384] Re: arm gic: interrupt model never 1 on non-mpcore and
 race condition in gic_acknowledge_irq
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: eca705151610b72f76b4d788e3285be8780be7f1
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
Reply-To: Bug 1859384 <1859384@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Oops, yes, missed that use of GIC_DIST_TEST_MODEL because it was in the
header file...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859384

Title:
  arm gic: interrupt model never 1 on non-mpcore and race condition in
  gic_acknowledge_irq

Status in QEMU:
  New

Bug description:
  For a 1-N interrupt (any SPI on the GICv2), as mandated by the TRM,
  only one CPU can acknowledge the IRQ until it becomes inactive.

  The TRM also mandates that SGIs and PPIs follow the N-N model and that
  SPIs follow the 1-N model.

  However this is not currently the case with QEMU. I have locally (no
  minimal test case) seen e.g. uart interrupts being acknowledged twice
  before having been deactivated (expected: irqId on one CPU and 1023 on
  the other instead).

  I have narrowed the issue down to the following:

  1) arm_gic_common_reset resets all irq_state[id] fields to 0. This
  means all IRQ will use the N-N model, and if s->revision !=3D
  REV_11MPCORE, then there's no way to set any interrupt to 1-N.

  If ""fixed"" locally with a hackjob, I still have the following trace:

  pl011_irq_state 534130.800 pid=3D2424 level=3D0x1
  gic_set_irq 2.900 pid=3D2424 irq=3D0x21 level=3D0x1 cpumask=3D0xff target=
=3D0xff
  gic_update_set_irq 3.300 pid=3D2424 cpu=3D0x0 name=3Dirq level=3D0x1
  gic_update_set_irq 4.200 pid=3D2424 cpu=3D0x1 name=3Dirq level=3D0x1
  gic_acknowledge_irq 539.400 pid=3D2424 s=3Dcpu cpu=3D0x1 irq=3D0x21
  gic_update_set_irq 269.800 pid=3D2424 cpu=3D0x0 name=3Dirq level=3D0x1
  gic_cpu_read 4.100 pid=3D2424 s=3Dcpu cpu=3D0x1 addr=3D0xc val=3D0x21
  gic_acknowledge_irq 15.600 pid=3D2424 s=3Dcpu cpu=3D0x0 irq=3D0x21
  gic_cpu_read 265.000 pid=3D2424 s=3Dcpu cpu=3D0x0 addr=3D0xc val=3D0x21
  pl011_write 1594.700 pid=3D2424 addr=3D0x44 value=3D0x50
  pl011_irq_state 2.000 pid=3D2424 level=3D0x0
  gic_set_irq 1.300 pid=3D2424 irq=3D0x21 level=3D0x0 cpumask=3D0xff target=
=3D0xff
  pl011_write 30.700 pid=3D2424 addr=3D0x38 value=3D0x0
  pl011_irq_state 1.200 pid=3D2424 level=3D0x0
  gic_cpu_write 110.600 pid=3D2424 s=3Dcpu cpu=3D0x0 addr=3D0x10 val=3D0x21
  gic_cpu_write 193.400 pid=3D2424 s=3Dcpu cpu=3D0x0 addr=3D0x1000 val=3D0x=
21
  pl011_irq_state 1169.500 pid=3D2424 level=3D0x0

  This is because:

  2) gic_acknowledge_irq calls gic_clear_pending which uses
  GIC_DIST_CLEAR_PENDING but this usually has no effect on level-
  sensitive interrupts.

  With this often being a no-op (ie. assuming ispendr was not written
  to), any 1-n level-sensitive interrupt is still improperly pending on
  all the other cores.

  (Also, I don't really know how the qemu thread model works, there
  might be race conditions in the acknowledgment logic if
  gic_acknowledge_irq is called by multiple threads, too.)

  Option used:
  -nographic -machine virt,virtualization=3Don,accel=3Dtcg,gic-version=3D2 =
-cpu cortex-a57 -smp 4 -m 1024
  -kernel whatever.elf -d unimp,guest_errors -semihosting-config enable,tar=
get=3Dnative
  -chardev stdio,id=3Duart -serial chardev:uart -monitor none
  -trace gic_update_set_irq -trace gic_acknowledge_irq -trace pl011_irq_sta=
te -trace pl011_write -trace gic_cpu_read -trace gic_cpu_write
  -trace gic_set_irq

  Commit used: dc65a5bdc9fa543690a775b50d4ffbeb22c56d6d "Merge remote-
  tracking branch 'remotes/dgibson/tags/ppc-for-5.0-20200108' into
  staging"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859384/+subscriptions

