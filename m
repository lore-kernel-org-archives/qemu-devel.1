Received: from eggs.gnu.org ([2001:4830:134:3::10]:53349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1ff5D7-0005Jl-RM
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1ff5D3-0000CK-P6
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:14:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41360
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1ff5D3-0000BE-Io
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:14:45 -0400
From: Andre Przywara <andre.przywara@arm.com>
Date: Mon, 16 Jul 2018 16:14:38 +0100
Message-Id: <20180716151438.9877-3-andre.przywara@arm.com>
In-Reply-To: <20180716151438.9877-1-andre.przywara@arm.com>
References: <20180716151438.9877-1-andre.przywara@arm.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 2/2] arm64: timer: Add TVAL
 timeout IRQ trigger test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org

So far we were only testing the CVAL register. Add a test which programs
a (relative) TVAL value to check this functionality as well.
Also we go into WFI and wait for the interrupt to release us from it.
The timer tests are run with a 2 second timeout on the host side, so
that any failure in coming back would be covered.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/timer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arm/timer.c b/arm/timer.c
index 1c9ef44..275d049 100644
--- a/arm/timer.c
+++ b/arm/timer.c
@@ -211,6 +211,7 @@ static void test_timer(struct timer_info *info)
 	u64 now = info->read_counter();
 	u64 time_10s = read_sysreg(cntfrq_el0) * 10;
 	u64 later = now + time_10s;
+	s32 left;
 
 	/* We don't want the irq handler to fire because that will change the
 	 * timer state and we want to test the timer output signal.  We can
@@ -236,6 +237,15 @@ static void test_timer(struct timer_info *info)
 
 	/* Disable the timer again */
 	info->write_ctl(0);
+
+	/* Test TVAL and IRQ trigger */
+	info->irq_received = false;
+	info->write_tval(read_sysreg(cntfrq_el0) / 100);	/* 10 ms */
+	info->write_ctl(ARCH_TIMER_CTL_ENABLE);
+	wfi();
+	left = info->read_tval();
+	report("interrupt received after TVAL/WFI", info->irq_received);
+	report("timer has expired (%d)", left < 0, left);
 }
 
 static void test_vtimer(void)
-- 
2.14.4
