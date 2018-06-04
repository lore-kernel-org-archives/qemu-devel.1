Received: from eggs.gnu.org ([2001:4830:134:3::10]:41651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fPrQg-0002Aw-Na
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fPrQf-0002Xv-Dz
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:29:54 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Jun 2018 16:29:37 +0100
Message-Id: <20180604152941.20374-10-peter.maydell@linaro.org>
In-Reply-To: <20180604152941.20374-1-peter.maydell@linaro.org>
References: <20180604152941.20374-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 09/13] hw/core/or-irq: Support more than 16
 inputs to an OR gate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>

For the IoTKit MPC support, we need to wire together the
interrupt outputs of 17 MPCs; this exceeds the current
value of MAX_OR_LINES. Increase MAX_OR_LINES to 32 (which
should be enough for anyone).

The tricky part is retaining the migration compatibility for
existing OR gates; we add a subsection which is only used
for larger OR gates, and define it such that we can freely
increase MAX_OR_LINES in future (or even move to a dynamically
allocated levels[] array without an upper size limit) without
breaking compatibility.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/or-irq.h |  5 ++++-
 hw/core/or-irq.c    | 39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/include/hw/or-irq.h b/include/hw/or-irq.h
index 3f6fc1b58a4..5a31e5a1881 100644
--- a/include/hw/or-irq.h
+++ b/include/hw/or-irq.h
@@ -31,7 +31,10 @@
 
 #define TYPE_OR_IRQ "or-irq"
 
-#define MAX_OR_LINES      16
+/* This can safely be increased if necessary without breaking
+ * migration compatibility (as long as it remains greater than 15).
+ */
+#define MAX_OR_LINES      32
 
 typedef struct OrIRQState qemu_or_irq;
 
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index f9d76c46415..a86901b673c 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -66,14 +66,49 @@ static void or_irq_init(Object *obj)
     qdev_init_gpio_out(DEVICE(obj), &s->out_irq, 1);
 }
 
+/* The original version of this device had a fixed 16 entries in its
+ * VMState array; devices with more inputs than this need to
+ * migrate the extra lines via a subsection.
+ * The subsection migrates as much of the levels[] array as is needed
+ * (including repeating the first 16 elements), to avoid the awkwardness
+ * of splitting it in two to meet the requirements of VMSTATE_VARRAY_UINT16.
+ */
+#define OLD_MAX_OR_LINES 16
+#if MAX_OR_LINES < OLD_MAX_OR_LINES
+#error MAX_OR_LINES must be at least 16 for migration compatibility
+#endif
+
+static bool vmstate_extras_needed(void *opaque)
+{
+    qemu_or_irq *s = OR_IRQ(opaque);
+
+    return s->num_lines >= OLD_MAX_OR_LINES;
+}
+
+static const VMStateDescription vmstate_or_irq_extras = {
+    .name = "or-irq-extras",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = vmstate_extras_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_VARRAY_UINT16_UNSAFE(levels, qemu_or_irq, num_lines, 0,
+                                     vmstate_info_bool, bool),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static const VMStateDescription vmstate_or_irq = {
     .name = TYPE_OR_IRQ,
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_BOOL_ARRAY(levels, qemu_or_irq, MAX_OR_LINES),
+        VMSTATE_BOOL_SUB_ARRAY(levels, qemu_or_irq, 0, OLD_MAX_OR_LINES),
         VMSTATE_END_OF_LIST(),
-    }
+    },
+    .subsections = (const VMStateDescription*[]) {
+        &vmstate_or_irq_extras,
+        NULL
+    },
 };
 
 static Property or_irq_properties[] = {
-- 
2.17.1
