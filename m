Received: from eggs.gnu.org ([209.51.188.92]:49935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGeU-00034b-Gp
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGTx-0006RI-5N
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:14 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guGTw-0006QP-VO
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:13 -0500
Received: by mail-wm1-x343.google.com with SMTP id d15so6168294wmb.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 04:51:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 12:50:55 +0000
Message-Id: <20190214125107.22178-3-peter.maydell@linaro.org>
In-Reply-To: <20190214125107.22178-1-peter.maydell@linaro.org>
References: <20190214125107.22178-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/14] hw/misc/tz-ppc: Support having unused
 ports in the middle of the range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The Peripheral Protection Controller's handling of unused ports
is that if there is nothing connected to the port's downstream
then it does not create the sysbus MMIO region for the upstream
end of the port. This results in odd behaviour when there is
an unused port in the middle of the range: since sysbus MMIO
regions are implicitly consecutively allocated, any used ports
above the unused ones end up with sysbus MMIO region numbers
that don't match the port number.

Avoid this numbering mismatch by creating dummy MMIO regions
for the unused ports. This doesn't change anything for our
existing boards, which don't have any gaps in the middle of
the port ranges they use; but it will be needed for the Musca
board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/tz-ppc.h |  8 +++++++-
 hw/misc/tz-ppc.c         | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/tz-ppc.h b/include/hw/misc/tz-ppc.h
index fc8b806e4df..080d6e2ec17 100644
--- a/include/hw/misc/tz-ppc.h
+++ b/include/hw/misc/tz-ppc.h
@@ -38,7 +38,13 @@
  *
  * QEMU interface:
  * + sysbus MMIO regions 0..15: MemoryRegions defining the upstream end
- *   of each of the 16 ports of the PPC
+ *   of each of the 16 ports of the PPC. When a port is unused (i.e. no
+ *   downstream MemoryRegion is connected to it) at the end of the 0..15
+ *   range then no sysbus MMIO region is created for its upstream. When an
+ *   unused port lies in the middle of the range with other used ports at
+ *   higher port numbers, a dummy MMIO region is created to ensure that
+ *   port N's upstream is always sysbus MMIO region N. Dummy regions should
+ *   not be mapped, and will assert if any access is made to them.
  * + Property "port[0..15]": MemoryRegion defining the downstream device(s)
  *   for each of the 16 ports of the PPC
  * + Named GPIO inputs "cfg_nonsec[0..15]": set to 1 if the port should be
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 3dd045c15f5..2e04837bea9 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -181,6 +181,21 @@ static const MemoryRegionOps tz_ppc_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static bool tz_ppc_dummy_accepts(void *opaque, hwaddr addr,
+                                 unsigned size, bool is_write,
+                                 MemTxAttrs attrs)
+{
+    /*
+     * Board code should never map the upstream end of an unused port,
+     * so we should never try to make a memory access to it.
+     */
+    g_assert_not_reached();
+}
+
+static const MemoryRegionOps tz_ppc_dummy_ops = {
+    .valid.accepts = tz_ppc_dummy_accepts,
+};
+
 static void tz_ppc_reset(DeviceState *dev)
 {
     TZPPC *s = TZ_PPC(dev);
@@ -210,16 +225,33 @@ static void tz_ppc_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     TZPPC *s = TZ_PPC(dev);
     int i;
+    int max_port = 0;
 
     /* We can't create the upstream end of the port until realize,
      * as we don't know the size of the MR used as the downstream until then.
      */
     for (i = 0; i < TZ_NUM_PORTS; i++) {
+        if (s->port[i].downstream) {
+            max_port = i;
+        }
+    }
+
+    for (i = 0; i <= max_port; i++) {
         TZPPCPort *port = &s->port[i];
         char *name;
         uint64_t size;
 
         if (!port->downstream) {
+            /*
+             * Create dummy sysbus MMIO region so the sysbus region
+             * numbering doesn't get out of sync with the port numbers.
+             * The size is entirely arbitrary.
+             */
+            name = g_strdup_printf("tz-ppc-dummy-port[%d]", i);
+            memory_region_init_io(&port->upstream, obj, &tz_ppc_dummy_ops,
+                                  port, name, 0x10000);
+            sysbus_init_mmio(sbd, &port->upstream);
+            g_free(name);
             continue;
         }
 
-- 
2.20.1
