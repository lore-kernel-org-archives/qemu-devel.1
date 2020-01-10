Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6ADC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763AB20661
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763AB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipx7T-0008SF-JF
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 11:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ipx6T-0007xP-S7
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ipx6R-00028t-Kt
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:25:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:34858)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ipx6P-00027G-Vj
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:25:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ipx6O-0008Mq-FW
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 16:25:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 746A02E8073
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 16:25:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jan 2020 16:16:25 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=alex.bennee@linaro.org; 
X-Launchpad-Bug-Tags: arm tcg testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee alexlngw
X-Launchpad-Bug-Reporter: Alex Longwall (alexlngw)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <157857629827.5165.2496570379985305724.malonedeb@gac.canonical.com>
Message-Id: <20200110161626.31943-2-alex.bennee@linaro.org>
Subject: [Bug 1859021] [PATCH v1 1/2] target/arm: detect 64 bit overflow
 caused by high cval + voff
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8ab3a9ca89969fa6723d66b7e5af24b12e338f3e
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
Reply-To: Bug 1859021 <1859021@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200110161625.ybr2Ub5qeMgp4FVjnZLWsYqQR0YZNkLE0J1-4ioWB9Y@z>

If we don't detect this we will be stuck in a busy loop as we schedule
a timer for before now which will continually trigger gt_recalc_timer
even though we haven't reached the state required to trigger the IRQ.

Bug: https://bugs.launchpad.net/bugs/1859021
Cc: 1859021@bugs.launchpad.net
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 19a57a17da5..eb17106f7bd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2481,6 +2481,9 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
         } else {
             /* Next transition is when we hit cval */
             nexttick =3D gt->cval + offset;
+            if (nexttick < gt->cval) {
+                nexttick =3D UINT64_MAX;
+            }
         }
         /* Note that the desired next expiry time might be beyond the
          * signed-64-bit range of a QEMUTimer -- in this case we just
-- =

2.20.1

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859021

Title:
  qemu-system-aarch64 (tcg):  cval + voff overflow not handled, causes
  qemu to hang

Status in QEMU:
  Confirmed

Bug description:
  The Armv8 architecture reference manual states that for any timer set
  (e.g. CNTP* and CNTV*), the condition for such timer to generate an
  interrupt (if enabled & unmasked) is:

  CVAL <=3D CNT(P/V)CT

  Although this is arguably sloppy coding, I have seen code that is
  therefore assuming it can set CVAL to a very high value (e.g.
  UINT64_MAX) and leave the interrupt enabled in CTL, and never get the
  interrupt.

  On latest master commit as the time of writing, there is an integer
  overflow in target/arm/helper.c gt_recalc_timer affecting the virtual
  timer when the interrupt is enabled in CTL:

      /* Next transition is when we hit cval */
      nexttick =3D gt->cval + offset;

  When this overflow happens, I notice that qemu is no longer responsive an=
d that I have to SIGKILL the process:
      - qemu takes nearly all the cpu time of the cores it is running on (e=
.g. 50% cpu usage if running on half the cores) and is completely unrespons=
ive
      - no guest interrupt (reported via -d int) is generated

  Here the minimal code example to reproduce the issue:

      mov     x0, #1
      msr     cntvoff_el2, x0
      mov     x0, #-1
      msr     cntv_cval_el0, x0
      mov     x0, #1
      msr     cntv_ctl_el0, x0 // interrupt generation enabled, not masked;=
 qemu will start to hang here

  Options used:
  -nographic -machine virt,virtualization=3Don,gic-version=3D2,accel=3Dtcg =
-cpu cortex-a57
  -smp 4 -m 1024 -kernel whatever.elf -d unimp,guest_errors,int -semihostin=
g-config enable,target=3Dnative
  -serial mon:stdio

  Version used: 4.2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859021/+subscriptions

