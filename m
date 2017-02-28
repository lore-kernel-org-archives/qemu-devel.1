Received: from eggs.gnu.org ([2001:4830:134:3::10]:58919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cied5-0006oF-Uk
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cied2-00047h-Pq
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:03:35 -0500
Received: from greensocs.com ([193.104.36.180]:38376)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cied2-00047G-D2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:03:32 -0500
From: fred.konrad@greensocs.com
Date: Tue, 28 Feb 2017 11:02:58 +0100
Message-Id: <1488276185-31168-4-git-send-email-fred.konrad@greensocs.com>
In-Reply-To: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
Subject: [Qemu-devel] [PATCH v3 03/10] qemu-clk: allow to bind two clocks
 together
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, clg@kaod.org, mark.burton@greensocs.com, fred.konrad@greensocs.com

From: KONRAD Frederic <fred.konrad@greensocs.com>

This introduces the clock binding and the update part.
When the qemu_clk_rate_update(qemu_clk, int) function is called:
  * The clock callback is called on the qemu_clk so it can change the rate.
  * The qemu_clk_rate_update function is called on all the driven clock.

Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>

V2 -> V3:
  * s/qemu_clk/QEMUClock/g
  * Rename in_rate to ref_rate
  * Rename out_rate to rate
  * Rename qemu_clk_bind_clock to qemu_clk_bind
V1 -> V2:
  * Rename qemu_clk_on_rate_update_cb to QEMUClkRateUpdateCallback and
    move the pointer to the structure instead of having a pointer-to-function
    type.
---
 include/qemu/qemu-clock.h | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 qemu-clock.c              | 58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/include/qemu/qemu-clock.h b/include/qemu/qemu-clock.h
index ffe743d..f80de56 100644
--- a/include/qemu/qemu-clock.h
+++ b/include/qemu/qemu-clock.h
@@ -30,12 +30,25 @@
 #define TYPE_CLOCK "qemu-clk"
 #define QEMU_CLOCK(obj) OBJECT_CHECK(QEMUClock, (obj), TYPE_CLOCK)
 
+typedef struct ClkList ClkList;
+typedef uint64_t QEMUClkRateUpdateCallback(void *opaque, uint64_t rate);
+
 typedef struct QEMUClock {
     /*< private >*/
     Object parent_obj;
     char *name;            /* name of this clock in the device. */
+    uint64_t ref_rate;     /* rate of the clock which drive this pin. */
+    uint64_t rate;         /* rate of this clock pin. */
+    void *opaque;
+    QEMUClkRateUpdateCallback *cb;
+    QLIST_HEAD(, ClkList) bound;
 } QEMUClock;
 
+struct ClkList {
+    QEMUClock *clk;
+    QLIST_ENTRY(ClkList) node;
+};
+
 /**
  * qemu_clk_device_add_clock:
  * @dev: the device on which the clock needs to be added.
@@ -59,4 +72,58 @@ void qemu_clk_device_add_clock(DeviceState *dev, QEMUClock *clk,
  */
 QEMUClock *qemu_clk_device_get_clock(DeviceState *dev, const char *name);
 
+/**
+ * qemu_clk_bind:
+ * @out: the clock output.
+ * @in: the clock input.
+ *
+ * Connect the clock together. This is unidirectional so a
+ * qemu_clk_update_rate will go from @out to @in.
+ *
+ */
+void qemu_clk_bind(QEMUClock *out, QEMUClock *in);
+
+/**
+ * qemu_clk_unbind:
+ * @out: the clock output.
+ * @in: the clock input.
+ *
+ * Disconnect the clocks if they were bound together.
+ *
+ */
+void qemu_clk_unbind(QEMUClock *out, QEMUClock *in);
+
+/**
+ * qemu_clk_update_rate:
+ * @clk: the clock to update.
+ * @rate: the new rate in Hz.
+ *
+ * Update the @clk to the new @rate.
+ *
+ */
+void qemu_clk_update_rate(QEMUClock *clk, uint64_t rate);
+
+/**
+ * qemu_clk_refresh:
+ * @clk: the clock to be refreshed.
+ *
+ * If a model alters the topology of a clock tree, it must call this function on
+ * the clock source to refresh the clock tree.
+ *
+ */
+void qemu_clk_refresh(QEMUClock *clk);
+
+/**
+ * qemu_clk_set_callback:
+ * @clk: the clock associated to the callback.
+ * @cb: the function which is called when a refresh happen on the clock @clk.
+ * @opaque: the opaque data passed to the callback.
+ *
+ * Set the callback @cb which will be called when the clock @clk is updated.
+ *
+ */
+void qemu_clk_set_callback(QEMUClock *clk,
+                           QEMUClkRateUpdateCallback *cb,
+                           void *opaque);
+
 #endif /* QEMU_CLOCK_H */
diff --git a/qemu-clock.c b/qemu-clock.c
index 6eeecf3..24719e2 100644
--- a/qemu-clock.c
+++ b/qemu-clock.c
@@ -37,6 +37,64 @@
     }                                                                        \
 } while (0);
 
+void qemu_clk_refresh(QEMUClock *clk)
+{
+    qemu_clk_update_rate(clk, clk->ref_rate);
+}
+
+void qemu_clk_update_rate(QEMUClock *clk, uint64_t rate)
+{
+    ClkList *child;
+
+    clk->ref_rate = rate;
+    clk->rate = rate;
+
+    if (clk->cb) {
+        clk->rate = clk->cb(clk->opaque, rate);
+    }
+
+    DPRINTF("%s output rate updated to %" PRIu64 "\n",
+            object_get_canonical_path(OBJECT(clk)),
+            clk->rate);
+
+    QLIST_FOREACH(child, &clk->bound, node) {
+        qemu_clk_update_rate(child->clk, clk->rate);
+    }
+}
+
+void qemu_clk_bind(QEMUClock *out, QEMUClock *in)
+{
+    ClkList *child;
+
+    child = g_malloc(sizeof(child));
+    assert(child);
+    child->clk = in;
+    object_ref(OBJECT(in));
+    QLIST_INSERT_HEAD(&out->bound, child, node);
+    qemu_clk_update_rate(in, out->rate);
+}
+
+void qemu_clk_unbind(QEMUClock *out, QEMUClock *in)
+{
+    ClkList *child, *next;
+
+    QLIST_FOREACH_SAFE(child, &out->bound, node, next) {
+        if (child->clk == in) {
+            QLIST_REMOVE(child, node);
+            g_free(child);
+            object_unref(OBJECT(in));
+        }
+    }
+}
+
+void qemu_clk_set_callback(QEMUClock *clk,
+                           QEMUClkRateUpdateCallback *cb,
+                           void *opaque)
+{
+    clk->cb = cb;
+    clk->opaque = opaque;
+}
+
 void qemu_clk_device_add_clock(DeviceState *dev, QEMUClock *clk,
                                const char *name)
 {
-- 
1.8.3.1
