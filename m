Received: from eggs.gnu.org ([2001:4830:134:3::10]:58098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df9Jg-00063x-QZ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1df9Jf-0002Rm-N7
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:33:20 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  8 Aug 2017 14:33:00 -0400
Message-Id: <20170808183306.27474-4-jsnow@redhat.com>
In-Reply-To: <20170808183306.27474-1-jsnow@redhat.com>
References: <20170808183306.27474-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 3/9] IDE: add tracing for data ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

To be used sparingly, but still interesting in the case of small
firmwares designed to reproduce bugs in QEMU IDE.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 6235bdf..29848ff 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2251,6 +2251,8 @@ void ide_data_writew(void *opaque, uint32_t addr, uint32_t val)
     IDEState *s = idebus_active_if(bus);
     uint8_t *p;
 
+    trace_ide_data_writew(addr, val, bus, s);
+
     /* PIO data access allowed only when DRQ bit is set. The result of a write
      * during PIO out is indeterminate, just ignore it. */
     if (!(s->status & DRQ_STAT) || ide_is_pio_out(s)) {
@@ -2296,6 +2298,8 @@ uint32_t ide_data_readw(void *opaque, uint32_t addr)
         s->status &= ~DRQ_STAT;
         s->end_transfer_func(s);
     }
+
+    trace_ide_data_readw(addr, ret, bus, s);
     return ret;
 }
 
@@ -2305,6 +2309,8 @@ void ide_data_writel(void *opaque, uint32_t addr, uint32_t val)
     IDEState *s = idebus_active_if(bus);
     uint8_t *p;
 
+    trace_ide_data_writel(addr, val, bus, s);
+
     /* PIO data access allowed only when DRQ bit is set. The result of a write
      * during PIO out is indeterminate, just ignore it. */
     if (!(s->status & DRQ_STAT) || ide_is_pio_out(s)) {
@@ -2335,7 +2341,8 @@ uint32_t ide_data_readl(void *opaque, uint32_t addr)
     /* PIO data access allowed only when DRQ bit is set. The result of a read
      * during PIO in is indeterminate, return 0 and don't move forward. */
     if (!(s->status & DRQ_STAT) || !ide_is_pio_out(s)) {
-        return 0;
+        ret = 0;
+        goto out;
     }
 
     p = s->data_ptr;
@@ -2350,6 +2357,9 @@ uint32_t ide_data_readl(void *opaque, uint32_t addr)
         s->status &= ~DRQ_STAT;
         s->end_transfer_func(s);
     }
+
+out:
+    trace_ide_data_readl(addr, ret, bus, s);
     return ret;
 }
 
-- 
2.9.4
