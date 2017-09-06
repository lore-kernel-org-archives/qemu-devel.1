Received: from eggs.gnu.org ([2001:4830:134:3::10]:53529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxZ-0002dX-4X
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxR-00013n-68
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dpgxQ-000128-TA
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:29:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed,  6 Sep 2017 16:28:44 -0400
Message-Id: <1504729728-23279-3-git-send-email-cota@braap.org>
In-Reply-To: <1504729728-23279-1-git-send-email-cota@braap.org>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [RFC 2/6] plugin: add initial plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

This is still a work in progress, hence the limited public-facing API.
I wanted to add more events (e.g. memory and basic block callbacks), but
before spending more time on time I'd like to see whether this direction
is appreciated by others.

The goals are to:
- Have a simple implementation that shares nothing with tracing code.

- Make sure we cannot deadlock, particularly under MTTCG. For this,
  we acquire a lock when called from plugin code, and keep
  RCU lists of callbacks so that we do not have to hold the lock
  when calling the callbacks. This is also for performance, since
  some callbacks (e.g. memory access callbacks) might be called very
  frequently.
  * A consequence of this is that we keep our own list of CPUs, so that
    we do not have to worry about locking order wrt cpu_list_lock.
  * Some functions such as vcpu_for_each will call plugin code with the
    lock held. Instead of making the lock recursive, just document that
    the function called by vcpu_for_each cannot call any other plugin API.

- Support as many plugins as the user wants (e.g. -plugin foo -plugin bar),
  just like other tools (e.g. dynamorio) do.

- Support the installation/uninstallation of a plugin any time (i.e. from
  any callback from the guest, or from QAPI/QMP).

- Avoid malicious plugins from abusing the API. This is done by:
  * Adding a qemu_plugin_id_t that all calls need to use. This is a unique
    id per plugin.
  * Hiding CPUState * under cpu_index. Plugin code can keep per-vcpu
    data by using said index (say to index an array).
  * Only exporting the relevant qemu_plugin symbols to the plugins by
    passing --dynamic-file to the linker (when supported), instead of
    exporting all symbols with -rdynamic.

- Performance: registering/unregistering callbacks is slow. But this is
  very infrequent; we want performance when calling (or not) callbacks.
  Using RCU is great for this. The only difficulty is when uninstalling
  a plugin, where some callbacks might still be called after the
  uninstall returns. An alternative would be to use r/w locks, but that
  would complicate code quite a bit for very little gain; I suspect most
  plugins will just run until QEMU exits.

Some design decisions:
- I considered registering callbacks per-vcpu, but really I don't see the
  use case for it (would complicate the API and 99% of plugins won't care, so
  I'd rather make that 1% slower by letting them discard unwanted callbacks).

- Using a per-vcpu mask is key to allow for maximum performance/scalability.
  With RCU callbacks and async work we can ensure no events are missed, and
  we keep maximum scalability (again, we assume callbacks are a lot more
  common than callback registration).

- Last, 'plugin' vs. 'instrumentation' naming: I think instrumentation is a
  subset of the functionality that plugins can provide. IOW, in the future
  not all plugins might be considered instrumentation, even if currently
  my goal is to use them for that purpose.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 Makefile.objs             |   1 +
 include/exec/exec-all.h   |   2 +
 include/exec/tb-hash-xx.h |  26 ++-
 include/exec/tb-hash.h    |   6 +-
 include/exec/tb-lookup.h  |   1 +
 include/qemu/plugin-api.h | 105 ++++++++++
 include/qemu/plugin.h     |  74 +++++++
 include/qom/cpu.h         |   4 +
 accel/tcg/cpu-exec.c      |   6 +-
 accel/tcg/translate-all.c |   6 +-
 plugin.c                  | 519 ++++++++++++++++++++++++++++++++++++++++++++++
 qom/cpu.c                 |   3 +
 tests/qht-bench.c         |   2 +-
 qemu-plugins.symbols      |   6 +
 14 files changed, 746 insertions(+), 15 deletions(-)
 create mode 100644 include/qemu/plugin-api.h
 create mode 100644 include/qemu/plugin.h
 create mode 100644 plugin.c
 create mode 100644 qemu-plugins.symbols

diff --git a/Makefile.objs b/Makefile.objs
index 24a4ea0..52cc89c 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -84,6 +84,7 @@ endif
 #######################################################################
 # Target-independent parts used in system and user emulation
 common-obj-y += cpus-common.o
+common-obj-$(CONFIG_PLUGINS) += plugin.o
 common-obj-y += hw/
 common-obj-y += qom/
 common-obj-y += disas/
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 1d4e977..add9423 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -346,6 +346,8 @@ struct TranslationBlock {
     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;
 
+    uint32_t plugin_mask;
+
     struct tb_tc tc;
 
     /* original tb when cflags has CF_NOCACHE */
diff --git a/include/exec/tb-hash-xx.h b/include/exec/tb-hash-xx.h
index 747a9a6..4015d6a 100644
--- a/include/exec/tb-hash-xx.h
+++ b/include/exec/tb-hash-xx.h
@@ -49,7 +49,8 @@
  * contiguous in memory.
  */
 static inline uint32_t
-tb_hash_func7(uint64_t a0, uint64_t b0, uint32_t e, uint32_t f, uint32_t g)
+tb_hash_func8(uint64_t a0, uint64_t b0, uint32_t e, uint32_t f, uint32_t g,
+              uint32_t h)
 {
     uint32_t v1 = TB_HASH_XX_SEED + PRIME32_1 + PRIME32_2;
     uint32_t v2 = TB_HASH_XX_SEED + PRIME32_2;
@@ -77,17 +78,24 @@ tb_hash_func7(uint64_t a0, uint64_t b0, uint32_t e, uint32_t f, uint32_t g)
     v4 = rol32(v4, 13);
     v4 *= PRIME32_1;
 
-    h32 = rol32(v1, 1) + rol32(v2, 7) + rol32(v3, 12) + rol32(v4, 18);
-    h32 += 28;
+    v1 += e * PRIME32_2;
+    v1 = rol32(v1, 13);
+    v1 *= PRIME32_1;
 
-    h32 += e * PRIME32_3;
-    h32  = rol32(h32, 17) * PRIME32_4;
+    v2 += f * PRIME32_2;
+    v2 = rol32(v2, 13);
+    v2 *= PRIME32_1;
 
-    h32 += f * PRIME32_3;
-    h32  = rol32(h32, 17) * PRIME32_4;
+    v3 += g * PRIME32_2;
+    v3 = rol32(v3, 13);
+    v3 *= PRIME32_1;
 
-    h32 += g * PRIME32_3;
-    h32  = rol32(h32, 17) * PRIME32_4;
+    v4 += h * PRIME32_2;
+    v4 = rol32(v4, 13);
+    v4 *= PRIME32_1;
+
+    h32 = rol32(v1, 1) + rol32(v2, 7) + rol32(v3, 12) + rol32(v4, 18);
+    h32 += 32;
 
     h32 ^= h32 >> 15;
     h32 *= PRIME32_2;
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 0526c4f..f501dd1 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -59,9 +59,11 @@ static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
 
 static inline
 uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags,
-                      uint32_t cf_mask, uint32_t trace_vcpu_dstate)
+                      uint32_t cf_mask, uint32_t trace_vcpu_dstate,
+                      uint32_t plugin_mask)
 {
-    return tb_hash_func7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
+    return tb_hash_func8(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate,
+                         plugin_mask);
 }
 
 #endif
diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
index 2961385..c879903 100644
--- a/include/exec/tb-lookup.h
+++ b/include/exec/tb-lookup.h
@@ -35,6 +35,7 @@ tb_lookup__cpu_state(CPUState *cpu, target_ulong *pc, target_ulong *cs_base,
                tb->cs_base == *cs_base &&
                tb->flags == *flags &&
                tb->trace_vcpu_dstate == *cpu->trace_dstate &&
+               tb->plugin_mask == *cpu->plugin_mask &&
                (tb_cflags(tb) & (CF_HASH_MASK | CF_INVALID)) == cf_mask)) {
         return tb;
     }
diff --git a/include/qemu/plugin-api.h b/include/qemu/plugin-api.h
new file mode 100644
index 0000000..85f827a
--- /dev/null
+++ b/include/qemu/plugin-api.h
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#ifndef QEMU_PLUGIN_API_H
+#define QEMU_PLUGIN_API_H
+
+#include <inttypes.h>
+
+/*
+ * For best performance, build the plugin with -fvisibility=hidden so that
+ * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
+ * QEMU_PLUGIN_EXPORT. For more info, see
+ *   https://gcc.gnu.org/wiki/Visibility
+ */
+#if defined _WIN32 || defined __CYGWIN__
+  #ifdef BUILDING_DLL
+    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
+  #else
+    #define QEMU_PLUGIN_EXPORT __declspec(dllimport)
+  #endif
+  #define QEMU_PLUGIN_LOCAL
+#else
+  #if __GNUC__ >= 4
+    #define QEMU_PLUGIN_EXPORT __attribute__((visibility("default")))
+    #define QEMU_PLUGIN_LOCAL  __attribute__((visibility("hidden")))
+  #else
+    #define QEMU_PLUGIN_EXPORT
+    #define QEMU_PLUGIN_LOCAL
+  #endif
+#endif
+
+typedef uint64_t qemu_plugin_id_t;
+
+/**
+ * qemu_plugin_install - Install a plugin
+ * @id: this plugin's opaque ID
+ * @argc: number of arguments
+ * @argv: array of arguments (@argc elements)
+ *
+ * All plugins must export this symbol.
+ *
+ * Note: @argv is freed after this function returns.
+ */
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv);
+
+/**
+ * qemu_plugin_uninstall - Uninstall a plugin
+ * @id: this plugin's opaque ID
+ *
+ * Removes all callbacks and unloads the plugin.
+ *
+ * Once this function returns, no further API calls from it are allowed.
+ *
+ * Note: if the plugin is multi-threaded (e.g. it is subscribed to callbacks
+ * from vCPUs running in parallel), some time will elapse before changes
+ * propagate to all threads, and therefore some callbacks might still be called
+ * for a short period of time after this function returns.
+ */
+void qemu_plugin_uninstall(qemu_plugin_id_t id);
+
+typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
+                                             unsigned int vcpu_index);
+
+/**
+ * qemu_plugin_register_vcpu_init_cb - register a vCPU initialization callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU is initialized.
+ *
+ * See also: qemu_plugin_register_vcpu_exit_cb()
+ */
+void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_exit_cb - register a vCPU exit callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU exits.
+ *
+ * See also: qemu_plugin_register_vcpu_init_cb()
+ */
+void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb);
+
+/**
+ * qemu_plugin_vcpu_for_each - iterate over the existing vCPU
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called once for each existing vCPU.
+ * Note: to avoid deadlock, @cb cannot make any other qemu_plugin_*() call.
+ *
+ * See also: qemu_plugin_register_vcpu_init_cb()
+ */
+void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
+                               qemu_plugin_vcpu_simple_cb_t cb);
+
+#endif /* QEMU_PLUGIN_API_H */
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
new file mode 100644
index 0000000..a73540b
--- /dev/null
+++ b/include/qemu/plugin.h
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#ifndef QEMU_PLUGIN_H
+#define QEMU_PLUGIN_H
+
+#include "qemu/config-file.h"
+#include "qemu/plugin-api.h"
+#include "qemu/error-report.h"
+#include "qemu/queue.h"
+#include "qemu/option.h"
+
+/*
+ * Option parsing/processing.
+ * Note that we can load an arbitrary number of plugins.
+ */
+struct qemu_plugin_desc;
+QTAILQ_HEAD(qemu_plugin_list, qemu_plugin_desc);
+
+#ifdef CONFIG_PLUGINS
+extern QemuOptsList qemu_plugin_opts;
+
+static inline void qemu_plugin_add_opts(void)
+{
+    qemu_add_opts(&qemu_plugin_opts);
+}
+
+void qemu_plugin_opt_parse(const char *optarg, struct qemu_plugin_list *head);
+int qemu_plugin_load_list(struct qemu_plugin_list *head);
+#else /* !CONFIG_PLUGINS */
+static inline void qemu_plugin_add_opts(void)
+{ }
+
+static inline void qemu_plugin_opt_parse(const char *optarg,
+                                         struct qemu_plugin_list *head)
+{
+    error_report("plugin interface not enabled in this build");
+    exit(1);
+}
+
+static inline int qemu_plugin_load_list(struct qemu_plugin_list *head)
+{
+    return 0;
+}
+#endif /* !CONFIG_PLUGINS */
+
+/*
+ * Events that plugins can subscribe to.
+ */
+enum qemu_plugin_event {
+    QEMU_PLUGIN_EV_VCPU_INIT,
+    QEMU_PLUGIN_EV_VCPU_EXIT,
+    QEMU_PLUGIN_EV_MAX,
+};
+
+#ifdef CONFIG_PLUGINS
+
+void qemu_plugin_vcpu_init_hook(CPUState *cpu);
+void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
+
+#else /* !CONFIG_PLUGINS */
+
+static inline void qemu_plugin_vcpu_init_hook(CPUState *cpu)
+{ }
+
+static inline void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
+{ }
+
+#endif /* !CONFIG_PLUGINS */
+
+#endif /* QEMU_PLUGIN_H */
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 25eefea..899b2d6 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -27,6 +27,7 @@
 #include "qemu/bitmap.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
+#include "qemu/plugin.h"
 
 typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
                                      void *opaque);
@@ -305,6 +306,7 @@ struct qemu_work_item;
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
+ * @plugin_mask: Plugin event bitmap. Modified only via async work.
  *
  * State of one CPU core or thread.
  */
@@ -377,6 +379,8 @@ struct CPUState {
     DECLARE_BITMAP(trace_dstate_delayed, CPU_TRACE_DSTATE_MAX_EVENTS);
     DECLARE_BITMAP(trace_dstate, CPU_TRACE_DSTATE_MAX_EVENTS);
 
+    DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
+
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index; /* used by alpha TCG */
     uint32_t halted; /* used by alpha, cris, ppc TCG */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index e38479b..5523c44 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -271,6 +271,7 @@ struct tb_desc {
     uint32_t flags;
     uint32_t cf_mask;
     uint32_t trace_vcpu_dstate;
+    uint32_t plugin_mask;
 };
 
 static bool tb_lookup_cmp(const void *p, const void *d)
@@ -283,6 +284,7 @@ static bool tb_lookup_cmp(const void *p, const void *d)
         tb->cs_base == desc->cs_base &&
         tb->flags == desc->flags &&
         tb->trace_vcpu_dstate == desc->trace_vcpu_dstate &&
+        tb->plugin_mask == desc->plugin_mask &&
         (tb_cflags(tb) & (CF_HASH_MASK | CF_INVALID)) == desc->cf_mask) {
         /* check next page if needed */
         if (tb->page_addr[1] == -1) {
@@ -314,10 +316,12 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     desc.flags = flags;
     desc.cf_mask = cf_mask;
     desc.trace_vcpu_dstate = *cpu->trace_dstate;
+    desc.plugin_mask = *cpu->plugin_mask;
     desc.pc = pc;
     phys_pc = get_page_addr_code(desc.env, pc);
     desc.phys_page1 = phys_pc & TARGET_PAGE_MASK;
-    h = tb_hash_func(phys_pc, pc, flags, cf_mask, *cpu->trace_dstate);
+    h = tb_hash_func(phys_pc, pc, flags, cf_mask, *cpu->trace_dstate,
+                     *cpu->plugin_mask);
     return qht_lookup_custom(&tb_ctx.htable, tb_lookup_cmp, &desc, h);
 }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7332afc..17abfcc 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1027,6 +1027,7 @@ static bool tb_cmp(const void *ap, const void *bp)
         a->flags == b->flags &&
         (tb_cflags(a) & CF_HASH_MASK) == (tb_cflags(b) & CF_HASH_MASK) &&
         a->trace_vcpu_dstate == b->trace_vcpu_dstate &&
+        a->plugin_mask == b->plugin_mask &&
         a->page_addr[0] == b->page_addr[0] &&
         a->page_addr[1] == b->page_addr[1];
 }
@@ -1344,7 +1345,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     /* remove the TB from the hash list */
     phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
     h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
-                     tb->trace_vcpu_dstate);
+                     tb->trace_vcpu_dstate, tb->plugin_mask);
     if (!qht_remove(&tb_ctx.htable, tb, h)) {
         return;
     }
@@ -1533,7 +1534,7 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
 
     /* add in the hash table */
     h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
-                     tb->trace_vcpu_dstate);
+                     tb->trace_vcpu_dstate, tb->plugin_mask);
     existing_tb = qht_insert(&tb_ctx.htable, tb, h);
 
     /* remove TB from the page(s) if we couldn't insert it */
@@ -1600,6 +1601,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->flags = flags;
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
+    tb->plugin_mask = *cpu->plugin_mask;
 
 #ifdef CONFIG_PROFILER
     /* includes aborted translations because of exceptions */
diff --git a/plugin.c b/plugin.c
new file mode 100644
index 0000000..3cd19df
--- /dev/null
+++ b/plugin.c
@@ -0,0 +1,519 @@
+/* plugin.c - QEMU Plugin interface
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/plugin.h"
+#include "qemu/config-file.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
+#include "qemu/rcu_queue.h"
+#include "qemu/rcu.h"
+#include "qom/cpu.h"
+#include "exec/cpu-common.h"
+#include <dlfcn.h>
+
+struct qemu_plugin_cb {
+    struct qemu_plugin_ctx *ctx;
+    union {
+        qemu_plugin_vcpu_simple_cb_t vcpu_simple_cb;
+        void *func;
+    };
+    QLIST_ENTRY(qemu_plugin_cb) entry;
+};
+
+QLIST_HEAD(qemu_plugin_cb_head, qemu_plugin_cb);
+
+struct qemu_plugin_ctx {
+    /* @rcu: keep at the top to help valgrind find the whole struct */
+    struct rcu_head rcu;
+    void *handle; /* dlopen */
+    qemu_plugin_id_t id;
+    struct qemu_plugin_cb *callbacks[QEMU_PLUGIN_EV_MAX];
+    QTAILQ_ENTRY(qemu_plugin_ctx) entry;
+    bool uninstalling; /* protected by plugin.lock */
+};
+
+/* global state */
+struct qemu_plugin_state {
+    QTAILQ_HEAD(, qemu_plugin_ctx) ctxs;
+    struct qemu_plugin_cb_head cb_lists[QEMU_PLUGIN_EV_MAX];
+    /*
+     * Use the HT as a hash map by inserting k == v, which saves memory as
+     * documented by GLib. The parent struct is obtained with container_of().
+     */
+    GHashTable *id_ht;
+    /*
+     * Use the HT as a hash map. Note that we could use a list here,
+     * but with the HT we avoid adding a field to CPUState.
+     */
+    GHashTable *cpu_ht;
+    DECLARE_BITMAP(mask, QEMU_PLUGIN_EV_MAX);
+    /*
+     * @lock protects the struct as well as ctx->uninstalling.
+     * The lock must be acquired by all API ops. Since some API ops
+     * call plugin code repeatedly (e.g. vcpu_for_each), we keep
+     * a counter to allow for recursive acquisitions.
+     */
+    QemuMutex lock;
+};
+
+/*
+ * For convenience we use a bitmap for plugin.mask, but really all we need is a
+ * u32, which is what we store in TranslationBlock.
+ */
+QEMU_BUILD_BUG_ON(QEMU_PLUGIN_EV_MAX > 32);
+
+struct qemu_plugin_desc {
+    char *path;
+    char **argv;
+    QTAILQ_ENTRY(qemu_plugin_desc) entry;
+    int argc;
+};
+
+struct qemu_plugin_parse_arg {
+    struct qemu_plugin_list *head;
+    struct qemu_plugin_desc *curr;
+};
+
+QemuOptsList qemu_plugin_opts = {
+    .name = "plugin",
+    .implied_opt_name = "file",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_plugin_opts.head),
+    .desc = {
+        /* do our own parsing to support multiple plugins */
+        { /* end of list */ }
+    },
+};
+
+typedef int (*qemu_plugin_install_func_t)(qemu_plugin_id_t, int, char **);
+
+static struct qemu_plugin_state plugin;
+static __thread bool plugin_lock_held;
+
+static inline void plugin_lock(void)
+{
+    g_assert(!plugin_lock_held);
+    qemu_mutex_lock(&plugin.lock);
+    plugin_lock_held = true;
+}
+
+static inline void plugin_unlock(void)
+{
+    plugin_lock_held = false;
+    qemu_mutex_unlock(&plugin.lock);
+}
+
+static struct qemu_plugin_desc *plugin_find_desc(struct qemu_plugin_list *head,
+                                                 const char *path)
+{
+    struct qemu_plugin_desc *desc;
+
+    QTAILQ_FOREACH(desc, head, entry) {
+        if (strcmp(desc->path, path) == 0) {
+            return desc;
+        }
+    }
+    return NULL;
+}
+
+static int plugin_add(void *opaque, const char *name, const char *value,
+                      Error **errp)
+{
+    struct qemu_plugin_parse_arg *arg = opaque;
+    struct qemu_plugin_desc *p;
+
+    if (strcmp(name, "file") == 0) {
+        if (strcmp(value, "") == 0) {
+            error_setg(errp, "requires a non-empty argument");
+            return 1;
+        }
+        p = plugin_find_desc(arg->head, value);
+        if (p == NULL) {
+            p = g_new0(struct qemu_plugin_desc, 1);
+            p->path = g_strdup(value);
+            QTAILQ_INSERT_TAIL(arg->head, p, entry);
+        }
+        arg->curr = p;
+    } else if (strcmp(name, "arg") == 0) {
+        if (arg->curr == NULL) {
+            error_setg(errp, "missing earlier '-plugin file=' option");
+            return 1;
+        }
+        p = arg->curr;
+        p->argc++;
+        p->argv = g_realloc_n(p->argv, p->argc, sizeof(char *));
+        p->argv[p->argc - 1] = g_strdup(value);
+    } else {
+        g_assert_not_reached();
+    }
+    return 0;
+}
+
+void qemu_plugin_opt_parse(const char *optarg, struct qemu_plugin_list *head)
+{
+    struct qemu_plugin_parse_arg arg;
+    QemuOpts *opts;
+
+    opts = qemu_opts_parse_noisily(qemu_find_opts("plugin"), optarg, true);
+    if (opts == NULL) {
+        exit(1);
+    }
+    arg.head = head;
+    arg.curr = NULL;
+    qemu_opt_foreach(opts, plugin_add, &arg, &error_fatal);
+    qemu_opts_del(opts);
+}
+
+/*
+ * From: https://en.wikipedia.org/wiki/Xorshift
+ * This is faster than rand_r(), and gives us a wider range (RAND_MAX is only
+ * guaranteed to be >= INT_MAX).
+ */
+static uint64_t xorshift64star(uint64_t x)
+{
+    x ^= x >> 12; /* a */
+    x ^= x << 25; /* b */
+    x ^= x >> 27; /* c */
+    return x * UINT64_C(2685821657736338717);
+}
+
+static int plugin_load(struct qemu_plugin_desc *desc)
+{
+    qemu_plugin_install_func_t install;
+    struct qemu_plugin_ctx *ctx;
+    char *err;
+    int rc;
+
+    ctx = qemu_memalign(qemu_dcache_linesize, sizeof(*ctx));
+    memset(ctx, 0, sizeof(*ctx));
+    ctx->handle = dlopen(desc->path, RTLD_NOW);
+    if (ctx->handle == NULL) {
+        error_report("%s: %s", __func__, dlerror());
+        goto err_dlopen;
+    }
+
+    /* clear any previous dlerror, call dlsym, then check dlerror */
+    dlerror();
+    install = dlsym(ctx->handle, "qemu_plugin_install");
+    err = dlerror();
+    if (err) {
+        error_report("%s: %s", __func__, err);
+        goto err_symbol;
+    }
+    /* symbol was found; it could be NULL though */
+    if (install == NULL) {
+        error_report("%s: %s: qemu_plugin_install is NULL",
+                     __func__, desc->path);
+        goto err_symbol;
+    }
+
+    plugin_lock();
+
+    /* find an unused random id with &ctx as the seed */
+    ctx->id = (uint64_t)ctx;
+    for (;;) {
+        void *existing;
+
+        ctx->id = xorshift64star(ctx->id);
+        existing = g_hash_table_lookup(plugin.id_ht, &ctx->id);
+        if (likely(existing == NULL)) {
+            bool success;
+
+            success = g_hash_table_insert(plugin.id_ht, &ctx->id, &ctx->id);
+            g_assert(success);
+            break;
+        }
+    }
+    QTAILQ_INSERT_TAIL(&plugin.ctxs, ctx, entry);
+    plugin_unlock();
+
+    rc = install(ctx->id, desc->argc, desc->argv);
+    if (rc) {
+        error_report("%s: qemu_plugin_install returned error code %d",
+                     __func__, rc);
+        /*
+         * we cannot rely on the plugin doing its own cleanup, so
+         * call a full uninstall if the plugin did not already call it.
+         */
+        plugin_lock();
+        if (!ctx->uninstalling) {
+            qemu_plugin_uninstall(ctx->id);
+        }
+        plugin_unlock();
+        return 1;
+    }
+    return 0;
+
+ err_symbol:
+    if (dlclose(ctx->handle)) {
+        warn_report("%s: %s", __func__, dlerror());
+    }
+ err_dlopen:
+    qemu_vfree(ctx);
+    return 1;
+}
+
+/* call after having removed @desc from the list */
+static void plugin_desc_free(struct qemu_plugin_desc *desc)
+{
+    int i;
+
+    for (i = 0; i < desc->argc; i++) {
+        g_free(desc->argv[i]);
+    }
+    g_free(desc->argv);
+    g_free(desc->path);
+    g_free(desc);
+}
+
+/**
+ * qemu_plugin_load_list - load a list of plugins
+ * @head: head of the list of descriptors of the plugins to be loaded
+ *
+ * Returns 0 if all plugins in the list are installed, !0 otherwise.
+ *
+ * Note: the descriptor of each successfully installed plugin is removed
+ * from the list given by @head and then freed.
+ */
+int qemu_plugin_load_list(struct qemu_plugin_list *head)
+{
+    struct qemu_plugin_desc *desc, *next;
+
+    QTAILQ_FOREACH_SAFE(desc, head, entry, next) {
+        int err;
+
+        err = plugin_load(desc);
+        if (err) {
+            return err;
+        }
+        QTAILQ_REMOVE(head, desc, entry);
+        plugin_desc_free(desc);
+    }
+    return 0;
+}
+
+static struct qemu_plugin_ctx *id_to_ctx(qemu_plugin_id_t id)
+{
+    struct qemu_plugin_ctx *ctx;
+    qemu_plugin_id_t *id_p;
+
+    g_assert(plugin_lock_held);
+    id_p = g_hash_table_lookup(plugin.id_ht, &id);
+    ctx = container_of(id_p, struct qemu_plugin_ctx, id);
+    if (ctx == NULL) {
+        error_report("plugin: invalid plugin id %" PRIu64, id);
+        abort();
+    }
+    return ctx;
+}
+
+static void plugin_cpu_update__async(CPUState *cpu, run_on_cpu_data data)
+{
+    bitmap_copy(cpu->plugin_mask, &data.host_ulong, QEMU_PLUGIN_EV_MAX);
+    cpu_tb_jmp_cache_clear(cpu);
+}
+
+static void plugin_cpu_update(gpointer k, gpointer v, gpointer udata)
+{
+    CPUState *cpu = container_of(k, CPUState, cpu_index);
+    run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
+
+    g_assert(plugin_lock_held);
+
+    if (cpu->created) {
+        async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
+    } else {
+        plugin_cpu_update__async(cpu, mask);
+    }
+}
+
+static void plugin_unregister_cb(struct qemu_plugin_ctx *ctx,
+                                 enum qemu_plugin_event ev)
+{
+    struct qemu_plugin_cb *cb = ctx->callbacks[ev];
+
+    g_assert(plugin_lock_held);
+
+    if (cb == NULL) {
+        return;
+    }
+    QLIST_REMOVE_RCU(cb, entry);
+    g_free(cb);
+    ctx->callbacks[ev] = NULL;
+    if (QLIST_EMPTY_RCU(&plugin.cb_lists[ev])) {
+        clear_bit(ev, plugin.mask);
+        g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update, NULL);
+    }
+}
+
+static void plugin_destroy__rcuthread(struct qemu_plugin_ctx *ctx)
+{
+    plugin_lock();
+    QTAILQ_REMOVE(&plugin.ctxs, ctx, entry);
+    g_assert(ctx->uninstalling);
+    plugin_unlock();
+
+    if (dlclose(ctx->handle)) {
+        warn_report("%s: %s", __func__, dlerror());
+    }
+    qemu_vfree(ctx);
+}
+
+void qemu_plugin_uninstall(qemu_plugin_id_t id)
+{
+    struct qemu_plugin_ctx *ctx;
+    enum qemu_plugin_event ev;
+    bool success;
+
+    plugin_lock();
+    ctx = id_to_ctx(id);
+    if (unlikely(ctx->uninstalling)) {
+        error_report("plugin: called %s more than once", __func__);
+        abort();
+    }
+    ctx->uninstalling = true;
+    /*
+     * Unregister all callbacks. This is an RCU list so it is possible that some
+     * callbacks will still be called in this RCU grace period. For this reason
+     * we cannot yet free the context nor invalidate its id.
+     */
+    for (ev = 0; ev < QEMU_PLUGIN_EV_MAX; ev++) {
+        plugin_unregister_cb(ctx, ev);
+    }
+    success = g_hash_table_remove(plugin.id_ht, &ctx->id);
+    g_assert(success);
+    plugin_unlock();
+
+    call_rcu(ctx, plugin_destroy__rcuthread, rcu);
+}
+
+static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
+{
+    struct qemu_plugin_cb *cb, *next;
+
+    switch (ev) {
+    case QEMU_PLUGIN_EV_VCPU_INIT:
+    case QEMU_PLUGIN_EV_VCPU_EXIT:
+        /* iterate safely; plugins might uninstall themselves at any time */
+        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+            qemu_plugin_vcpu_simple_cb_t func = cb->vcpu_simple_cb;
+
+            func(cb->ctx->id, cpu->cpu_index);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void plugin_register_cb(qemu_plugin_id_t id, enum qemu_plugin_event ev,
+                               void *func)
+{
+    struct qemu_plugin_ctx *ctx;
+
+    plugin_lock();
+    ctx = id_to_ctx(id);
+    if (func) {
+        struct qemu_plugin_cb *cb = ctx->callbacks[ev];
+
+        if (cb) {
+            cb->func = func;
+        } else {
+            cb = g_new(struct qemu_plugin_cb, 1);
+            cb->ctx = ctx;
+            cb->func = func;
+            ctx->callbacks[ev] = cb;
+            QLIST_INSERT_HEAD_RCU(&plugin.cb_lists[ev], cb, entry);
+            if (!test_bit(ev, plugin.mask)) {
+                set_bit(ev, plugin.mask);
+                g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update, NULL);
+            }
+        }
+    } else {
+        plugin_unregister_cb(ctx, ev);
+    }
+    plugin_unlock();
+}
+
+void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INIT, cb);
+}
+
+void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXIT, cb);
+}
+
+void qemu_plugin_vcpu_init_hook(CPUState *cpu)
+{
+    bool success;
+
+    plugin_lock();
+    success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
+                                  &cpu->cpu_index);
+    g_assert(success);
+    plugin_unlock();
+
+    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
+}
+
+void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
+{
+    bool success;
+
+    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_EXIT);
+
+    plugin_lock();
+    success = g_hash_table_remove(plugin.cpu_ht, &cpu->cpu_index);
+    g_assert(success);
+    plugin_unlock();
+}
+
+struct plugin_for_each_args {
+    struct qemu_plugin_ctx *ctx;
+    qemu_plugin_vcpu_simple_cb_t cb;
+};
+
+static void plugin_vcpu_for_each(gpointer k, gpointer v, gpointer udata)
+{
+    struct plugin_for_each_args *args = udata;
+    int cpu_index = *(int *)k;
+
+    args->cb(args->ctx->id, cpu_index);
+}
+
+void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
+                               qemu_plugin_vcpu_simple_cb_t cb)
+{
+    struct plugin_for_each_args args;
+
+    if (cb == NULL) {
+        return;
+    }
+    plugin_lock();
+    args.ctx = id_to_ctx(id);
+    args.cb = cb;
+    g_hash_table_foreach(plugin.cpu_ht, plugin_vcpu_for_each, &args);
+    plugin_unlock();
+}
+
+static void __attribute__((__constructor__)) plugin_init(void)
+{
+    int i;
+
+    for (i = 0; i < QEMU_PLUGIN_EV_MAX; i++) {
+        QLIST_INIT(&plugin.cb_lists[i]);
+    }
+    qemu_mutex_init(&plugin.lock);
+    plugin.id_ht = g_hash_table_new(g_int64_hash, g_int64_equal);
+    plugin.cpu_ht = g_hash_table_new(g_int_hash, g_int_equal);
+    QTAILQ_INIT(&plugin.ctxs);
+}
diff --git a/qom/cpu.c b/qom/cpu.c
index 4f38db0..60b4a56 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -31,6 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/qdev-properties.h"
 #include "trace-root.h"
+#include "qemu/plugin.h"
 
 CPUInterruptHandler cpu_interrupt_handler;
 
@@ -368,6 +369,7 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 
     /* NOTE: latest generic point where the cpu is fully realized */
     trace_init_vcpu(cpu);
+    qemu_plugin_vcpu_init_hook(cpu);
 }
 
 static void cpu_common_unrealizefn(DeviceState *dev, Error **errp)
@@ -375,6 +377,7 @@ static void cpu_common_unrealizefn(DeviceState *dev, Error **errp)
     CPUState *cpu = CPU(dev);
     /* NOTE: latest generic point before the cpu is fully unrealized */
     trace_fini_vcpu(cpu);
+    qemu_plugin_vcpu_exit_hook(cpu);
     cpu_exec_unrealizefn(cpu);
 }
 
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 6c2eb8e..86cd85a 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -103,7 +103,7 @@ static bool is_equal(const void *ap, const void *bp)
 
 static inline uint32_t h(unsigned long v)
 {
-    return tb_hash_func7(v, 0, 0, 0, 0);
+    return tb_hash_func8(v, 0, 0, 0, 0, 0);
 }
 
 /*
diff --git a/qemu-plugins.symbols b/qemu-plugins.symbols
new file mode 100644
index 0000000..2b8463e
--- /dev/null
+++ b/qemu-plugins.symbols
@@ -0,0 +1,6 @@
+{
+  qemu_plugin_uninstall;
+  qemu_plugin_register_vcpu_init_cb;
+  qemu_plugin_register_vcpu_exit_cb;
+  qemu_plugin_vcpu_for_each;
+};
-- 
2.7.4
