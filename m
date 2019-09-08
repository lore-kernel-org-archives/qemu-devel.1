Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B25C433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 12:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9496B216C8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 12:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9496B216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anthonycoulter.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6wU3-0001Ok-P4
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 08:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <riscv@anthonycoulter.name>) id 1i6nhn-00064B-O6
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 23:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <riscv@anthonycoulter.name>) id 1i6nhm-0003Zm-IK
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 23:17:35 -0400
Received: from raines.redjes.us ([45.32.221.159]:12141)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <riscv@anthonycoulter.name>)
 id 1i6nhm-0003Zb-CX
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 23:17:34 -0400
Received: from localhost (raines.redjes.us [local])
 by raines.redjes.us (OpenSMTPD) with ESMTPA id fb010eca
 for <qemu-devel@nongnu.org>; Sat, 7 Sep 2019 23:17:32 -0400 (EDT)
From: Anthony Coulter <riscv@anthonycoulter.name>
Date: Sat, 7 Sep 2019 23:17:32 -0400 (EDT)
To: qemu-devel@nongnu.org
Message-ID: <c60524d97e92e4e2@raines.redjes.us>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 45.32.221.159
X-Mailman-Approved-At: Sun, 08 Sep 2019 08:39:05 -0400
Subject: [Qemu-devel] [PATCH] riscv: Fix timer overflow in sifive_clint.c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a hart writes -1 to mtimecmp it should not receive a timer interrupt
for (2^64 - 1)/(10 MHz) = 58455 years assuming a 10 MHz realtime clock.
But in practice I get a timer interrupt immediately because of an
integer overflow bug when QEMU converts realtime clock ticks into
nanoseconds.

My proposal is to check for this overflow and, on detecting it, setting
the timer to fire as far in the future as QEMU can support:

	INT64_MAX = 2^63 - 1 nanoseconds = 292 years

This patch is technically incomplete, in that someone running QEMU for
292 years will eventually receive a timer interrupt for the hart even
though mtime < mtimecmp. But I'm fixing this for my own purposes, and
"my purposes" don't involve running QEMU for more than an hour at a
time. So it'll be fine.

My patch also eliminates some computations that canceled each other
out (e.g. subtracting the realtime clock and then adding it back in,
but using different units for each). So far as I can tell, the required
calculation is just:

	next = value*1000

but I dressed it up with symbolic constants and the fancy muldiv64 to
get more precise results in case someone changes the SIFIVE frequency
to something that isn't an exact factor of 1 billion.

Regards,
Anthony Coulter

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index e5a8f75cee..d6d66082e0 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -41,8 +41,6 @@ static uint64_t cpu_riscv_read_rtc(void)
 static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
 {
     uint64_t next;
-    uint64_t diff;
-
     uint64_t rtc_r = cpu_riscv_read_rtc();
 
     cpu->env.timecmp = value;
@@ -55,10 +53,15 @@ static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
 
     /* otherwise, set up the future timer interrupt */
     riscv_cpu_update_mip(cpu, MIP_MTIP, BOOL_TO_MASK(0));
-    diff = cpu->env.timecmp - rtc_r;
-    /* back to ns (note args switched in muldiv64) */
-    next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-        muldiv64(diff, NANOSECONDS_PER_SECOND, SIFIVE_CLINT_TIMEBASE_FREQ);
+
+    /* check for integer overflow */
+    if (value >= muldiv64(INT64_MAX, SIFIVE_CLINT_TIMEBASE_FREQ,
+        NANOSECONDS_PER_SECOND))
+        next = INT64_MAX;
+    else
+        next = muldiv64(value, NANOSECONDS_PER_SECOND,
+            SIFIVE_CLINT_TIMEBASE_FREQ);
+
     timer_mod(cpu->env.timer, next);
 }
 

