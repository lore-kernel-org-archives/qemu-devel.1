Received: from eggs.gnu.org ([2001:4830:134:3::10]:35093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE16f-0006cH-7A
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE16a-0002D0-AV
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:47:29 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Dec 2016 22:46:36 +0100
Message-Id: <1480974406-29345-6-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
References: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests RFC 05/15] arm/arm64: GICv3: add cpu
 count
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

Add a new cpu_count field in gicv3_data indicating the
number of redistributors. This will be useful for enumeration
of their resources such as LPI pending tables.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 lib/arm/asm/gic-v3.h | 1 +
 lib/arm/gic-v3.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
index ed330af..039b7c2 100644
--- a/lib/arm/asm/gic-v3.h
+++ b/lib/arm/asm/gic-v3.h
@@ -58,6 +58,7 @@ struct gicv3_data {
 	void *dist_base;
 	void *redist_base[NR_CPUS];
 	unsigned int irq_nr;
+	unsigned int cpu_count;
 };
 extern struct gicv3_data gicv3_data;
 
diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
index 6246221..9921f4d 100644
--- a/lib/arm/gic-v3.c
+++ b/lib/arm/gic-v3.c
@@ -12,12 +12,14 @@ void gicv3_set_redist_base(size_t stride)
 	void *ptr = gicv3_data.redist_base[0];
 	u64 typer;
 
+	gicv3_data.cpu_count = 0;
 	do {
 		typer = gicv3_read_typer(ptr + GICR_TYPER);
 		if ((typer >> 32) == aff) {
 			gicv3_redist_base() = ptr;
 			return;
 		}
+		gicv3_data.cpu_count++;
 		ptr += stride; /* skip RD_base, SGI_base, etc. */
 	} while (!(typer & GICR_TYPER_LAST));
 
-- 
2.5.5
