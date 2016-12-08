Received: from eggs.gnu.org ([2001:4830:134:3::10]:59821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qM-0003Pq-DV
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cF2qL-0004Cq-IT
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 12:50:54 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Thu,  8 Dec 2016 18:50:24 +0100
Message-Id: <20161208175030.12269-5-drjones@redhat.com>
In-Reply-To: <20161208175030.12269-1-drjones@redhat.com>
References: <20161208175030.12269-1-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH kvm-unit-tests v8 04/10] arm/arm64: irq
 enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, marc.zyngier@arm.com, andre.przywara@arm.com, eric.auger@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, christoffer.dall@linaro.org

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 lib/arm/asm/processor.h   | 10 ++++++++++
 lib/arm64/asm/processor.h | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/lib/arm/asm/processor.h b/lib/arm/asm/processor.h
index 857bdd96a3cc..6dc1472468dd 100644
--- a/lib/arm/asm/processor.h
+++ b/lib/arm/asm/processor.h
@@ -35,6 +35,16 @@ static inline unsigned long current_cpsr(void)
=20
 #define current_mode() (current_cpsr() & MODE_MASK)
=20
+static inline void local_irq_enable(void)
+{
+	asm volatile("cpsie i" : : : "memory", "cc");
+}
+
+static inline void local_irq_disable(void)
+{
+	asm volatile("cpsid i" : : : "memory", "cc");
+}
+
 #define MPIDR __ACCESS_CP15(c0, 0, c0, 5)
 static inline unsigned int get_mpidr(void)
 {
diff --git a/lib/arm64/asm/processor.h b/lib/arm64/asm/processor.h
index 0898d89f9761..f42f15c79d43 100644
--- a/lib/arm64/asm/processor.h
+++ b/lib/arm64/asm/processor.h
@@ -68,6 +68,16 @@ static inline unsigned long current_level(void)
 	return el & 0xc;
 }
=20
+static inline void local_irq_enable(void)
+{
+	asm volatile("msr daifclr, #2" : : : "memory");
+}
+
+static inline void local_irq_disable(void)
+{
+	asm volatile("msr daifset, #2" : : : "memory");
+}
+
 static inline unsigned int get_mpidr(void)
 {
 	return read_sysreg(mpidr_el1);
--=20
2.9.3
