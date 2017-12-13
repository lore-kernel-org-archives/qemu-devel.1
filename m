Received: from eggs.gnu.org ([2001:4830:134:3::10]:51805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWp-000505-1C
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWo-0008Cl-4G
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:11 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWn-0008Ay-TX
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:10 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWm-0007pK-M1
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:13:08 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:35 +0000
Message-Id: <1513188761-20784-38-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 37/43] nvic: Make nvic_sysreg_ns_ops work with
 any MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Generalize nvic_sysreg_ns_ops so that we can pass it an
arbitrary MemoryRegion which it will use as the underlying
register implementation to apply the NS-alias behaviour
to. We'll want this so we can do the same with systick.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1512154296-5652-2-git-send-email-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 5d9c883..63f2743 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1786,10 +1786,12 @@ static MemTxResult nvic_sysreg_ns_write(void *opaque, hwaddr addr,
                                         uint64_t value, unsigned size,
                                         MemTxAttrs attrs)
 {
+    MemoryRegion *mr = opaque;
+
     if (attrs.secure) {
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
-        return nvic_sysreg_write(opaque, addr, value, size, attrs);
+        return memory_region_dispatch_write(mr, addr, value, size, attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -1803,10 +1805,12 @@ static MemTxResult nvic_sysreg_ns_read(void *opaque, hwaddr addr,
                                        uint64_t *data, unsigned size,
                                        MemTxAttrs attrs)
 {
+    MemoryRegion *mr = opaque;
+
     if (attrs.secure) {
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
-        return nvic_sysreg_read(opaque, addr, data, size, attrs);
+        return memory_region_dispatch_read(mr, addr, data, size, attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -2075,7 +2079,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
 
     if (arm_feature(&s->cpu->env, ARM_FEATURE_V8)) {
         memory_region_init_io(&s->sysreg_ns_mem, OBJECT(s),
-                              &nvic_sysreg_ns_ops, s,
+                              &nvic_sysreg_ns_ops, &s->sysregmem,
                               "nvic_sysregs_ns", 0x1000);
         memory_region_add_subregion(&s->container, 0x20000, &s->sysreg_ns_mem);
     }
-- 
2.7.4
