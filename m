Received: from eggs.gnu.org ([2001:4830:134:3::10]:53347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1ff5D7-0005Jk-Qb
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1ff5D2-0000AM-TI
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:14:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41352
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1ff5D2-000082-Lp
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 11:14:44 -0400
From: Andre Przywara <andre.przywara@arm.com>
Date: Mon, 16 Jul 2018 16:14:37 +0100
Message-Id: <20180716151438.9877-2-andre.przywara@arm.com>
In-Reply-To: <20180716151438.9877-1-andre.przywara@arm.com>
References: <20180716151438.9877-1-andre.przywara@arm.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH 1/2] arm64: timer: add TVAL
 accessors
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

The ARM arch timer features the CVAL register, which holds an absolute
value that is compared against the counter value.
But there is also the TVAL register, which is defined as (CVAL - counter),
and can be used to program or read relative timeouts.

Add accessors for the TVAL register, to be able to read and write them
easily later.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arm/timer.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arm/timer.c b/arm/timer.c
index 5f3135f..1c9ef44 100644
--- a/arm/timer.c
+++ b/arm/timer.c
@@ -40,6 +40,16 @@ static void write_vtimer_cval(u64 val)
 	write_sysreg(val, cntv_cval_el0);
 }
 
+static s32 read_vtimer_tval(void)
+{
+	return read_sysreg(cntv_tval_el0);
+}
+
+static void write_vtimer_tval(s32 val)
+{
+	write_sysreg(val, cntv_tval_el0);
+}
+
 static u64 read_vtimer_ctl(void)
 {
 	return read_sysreg(cntv_ctl_el0);
@@ -65,6 +75,16 @@ static void write_ptimer_cval(u64 val)
 	write_sysreg(val, cntp_cval_el0);
 }
 
+static s32 read_ptimer_tval(void)
+{
+	return read_sysreg(cntp_tval_el0);
+}
+
+static void write_ptimer_tval(s32 val)
+{
+	write_sysreg(val, cntp_tval_el0);
+}
+
 static u64 read_ptimer_ctl(void)
 {
 	return read_sysreg(cntp_ctl_el0);
@@ -82,6 +102,8 @@ struct timer_info {
 	u64 (*read_counter)(void);
 	u64 (*read_cval)(void);
 	void (*write_cval)(u64);
+	s32 (*read_tval)(void);
+	void (*write_tval)(s32);
 	u64 (*read_ctl)(void);
 	void (*write_ctl)(u64);
 };
@@ -91,6 +113,8 @@ static struct timer_info vtimer_info = {
 	.read_counter = read_vtimer_counter,
 	.read_cval = read_vtimer_cval,
 	.write_cval = write_vtimer_cval,
+	.read_tval = read_vtimer_tval,
+	.write_tval = write_vtimer_tval,
 	.read_ctl = read_vtimer_ctl,
 	.write_ctl = write_vtimer_ctl,
 };
@@ -100,6 +124,8 @@ static struct timer_info ptimer_info = {
 	.read_counter = read_ptimer_counter,
 	.read_cval = read_ptimer_cval,
 	.write_cval = write_ptimer_cval,
+	.read_tval = read_ptimer_tval,
+	.write_tval = write_ptimer_tval,
 	.read_ctl = read_ptimer_ctl,
 	.write_ctl = write_ptimer_ctl,
 };
-- 
2.14.4
