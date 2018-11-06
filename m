Received: from eggs.gnu.org ([2001:4830:134:3::10]:60266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gJzh1-0008Id-BQ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gJzh0-0004Ol-JL
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:38:47 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gJzh0-00049H-D9
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:38:46 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gJzgm-0007d4-41
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:38:32 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Nov 2018 11:38:24 +0000
Message-Id: <20181106113826.25810-4-peter.maydell@linaro.org>
In-Reply-To: <20181106113826.25810-1-peter.maydell@linaro.org>
References: <20181106113826.25810-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/5] hw/arm/exynos4210: Zero memory allocated
 for Exynos4210State
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In exynos4210_init() we allocate memory for an Exynos4210State
struct. Generally devices can assume that the memory allocated
for their state struct is zero-initialized; we broke that
assumption here by using g_new(). Use g_new0() instead.
(In particular, some code assumes that the various irq arrays
in the Exynos4210Irq sub-struct are zero-initialized.)

In the longer term, this code should be QOMified, and then
the struct memory will be allocated elsewhere and by functions
which always zero-initalize it; but for 3.1 this is a
simple fix.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181105151132.13884-1-peter.maydell@linaro.org
---
 hw/arm/exynos4210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 827318a0036..af82e955421 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -162,7 +162,7 @@ static uint64_t exynos4210_calc_affinity(int cpu)
 
 Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
 {
-    Exynos4210State *s = g_new(Exynos4210State, 1);
+    Exynos4210State *s = g_new0(Exynos4210State, 1);
     qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
     SysBusDevice *busdev;
     DeviceState *dev;
-- 
2.19.1
