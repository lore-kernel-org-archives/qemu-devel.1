Received: from eggs.gnu.org ([2001:4830:134:3::10]:35467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE17B-00073J-9r
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE17A-0002O4-FY
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:48:01 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Dec 2016 22:46:45 +0100
Message-Id: <1480974406-29345-15-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
References: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests RFC 14/15] arm/arm64: gic: Generalize
 ipi_enable()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org, drjones@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org
Cc: andre.przywara@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org, pbonzini@redhat.com

For ITS test we plan to reuse the ipi_enable() code to
install the IRQ handler and enable the IRQ at CPU level.
Let's rename the function into setup_irq().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/gic.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index 88c5f49..cbaab3f 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -134,6 +134,8 @@ static void check_irqnr(u32 irqnr)
 		bad_irq[smp_processor_id()] = irqnr;
 }
 
+typedef void (*handler_t)(struct pt_regs *regs __unused);
+
 static void ipi_handler(struct pt_regs *regs __unused)
 {
 	u32 irqstat = gic_read_iar();
@@ -209,20 +211,20 @@ static void ipi_test_smp(void)
 	report_prefix_pop();
 }
 
-static void ipi_enable(void)
+static void setup_irq(handler_t handler)
 {
 	gic_enable_defaults();
 #ifdef __arm__
-	install_exception_handler(EXCPTN_IRQ, ipi_handler);
+	install_exception_handler(EXCPTN_IRQ, handler);
 #else
-	install_irq_handler(EL1H_IRQ, ipi_handler);
+	install_irq_handler(EL1H_IRQ, handler);
 #endif
 	local_irq_enable();
 }
 
 static void ipi_send(void)
 {
-	ipi_enable();
+	setup_irq(ipi_handler);
 	wait_on_ready();
 	ipi_test_self();
 	ipi_test_smp();
@@ -232,7 +234,7 @@ static void ipi_send(void)
 
 static void ipi_recv(void)
 {
-	ipi_enable();
+	setup_irq(ipi_handler);
 	cpumask_set_cpu(smp_processor_id(), &ready);
 	while (1)
 		wfi();
@@ -323,7 +325,7 @@ int main(int argc, char **argv)
 	if (argc < 2) {
 
 		report_prefix_push("ipi");
-		ipi_enable();
+		setup_irq(ipi_handler);
 		ipi_test_self();
 		check_spurious();
 		report_prefix_pop();
-- 
2.5.5
