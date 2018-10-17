Received: from eggs.gnu.org ([2001:4830:134:3::10]:52207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gCtXg-0007FQ-6p
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 17:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gCtXc-0007vm-3a
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 17:39:46 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 17 Oct 2018 23:39:29 +0200
Message-Id: <20181017213932.19973-2-edgar.iglesias@gmail.com>
In-Reply-To: <20181017213932.19973-1-edgar.iglesias@gmail.com>
References: <20181017213932.19973-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v3 1/4] net: cadence_gem: Announce availability
 of priority queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Announce the availability of the various priority queues.
This fixes an issue where guest kernels would miss to
configure secondary queues due to inproper feature bits.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 1795998928..16a8455128 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1283,6 +1283,7 @@ static void gem_reset(DeviceState *d)
     int i;
     CadenceGEMState *s = CADENCE_GEM(d);
     const uint8_t *a;
+    uint32_t queues_mask = 0;
 
     DB_PRINT("\n");
 
@@ -1299,7 +1300,12 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_DESCONF] = 0x02500111;
     s->regs[GEM_DESCONF2] = 0x2ab13fff;
     s->regs[GEM_DESCONF5] = 0x002f2045;
-    s->regs[GEM_DESCONF6] = 0x00000200;
+    s->regs[GEM_DESCONF6] = 0x0;
+
+    if (s->num_priority_queues > 1) {
+        queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
+        s->regs[GEM_DESCONF6] |= queues_mask;
+    }
 
     /* Set MAC address */
     a = &s->conf.macaddr.a[0];
-- 
2.17.1
