Received: from eggs.gnu.org ([209.51.188.92]:38691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOi-0005tA-Jw
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtLOf-00051U-Kd
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:54:00 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtLOf-0004lL-4C
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:53:57 -0500
Received: by mail-pf1-x442.google.com with SMTP id q1so336136pfi.5
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:53:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 15:52:55 -0800
Message-Id: <20190211235258.542-26-richard.henderson@linaro.org>
In-Reply-To: <20190211235258.542-1-richard.henderson@linaro.org>
References: <20190211235258.542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 25/28] target/arm: Add allocation tag
 storage for user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Control this with x-tagged-pages, which is off by default.

The limitation to non-shared pages is not part of a future kernel API,
but a limitation of linux-user not being able to map virtual pages back
to physical pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Add the x-tagged-pages cpu property
---
 target/arm/cpu.h        |  1 +
 target/arm/cpu64.c      | 18 ++++++++++++++++++
 target/arm/mte_helper.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2626af4a9c..ec5ddfbacc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -910,6 +910,7 @@ struct ARMCPU {
 
 #ifdef CONFIG_USER_ONLY
     bool guarded_pages;
+    bool tagged_pages;
 #endif
 
     QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c5675fe7d1..53a7d92c95 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -293,6 +293,18 @@ static void aarch64_cpu_set_guarded_pages(Object *obj, bool val, Error **errp)
     ARMCPU *cpu = ARM_CPU(obj);
     cpu->guarded_pages = val;
 }
+
+static bool aarch64_cpu_get_tagged_pages(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    return cpu->tagged_pages;
+}
+
+static void aarch64_cpu_set_tagged_pages(Object *obj, bool val, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    cpu->tagged_pages = val;
+}
 #endif
 
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
@@ -380,6 +392,12 @@ static void aarch64_max_initfn(Object *obj)
                                  aarch64_cpu_set_guarded_pages, NULL);
         object_property_set_description(obj, "x-guarded-pages",
             "Set on/off GuardPage bit for all pages", NULL);
+
+        object_property_add_bool(obj, "x-tagged-pages",
+                                 aarch64_cpu_get_tagged_pages,
+                                 aarch64_cpu_set_tagged_pages, NULL);
+        object_property_set_description(obj, "x-tagged-pages",
+            "Set on/off MemAttr Tagged for all pages", NULL);
 #endif
 
         cpu->sve_max_vq = ARM_MAX_VQ;
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 6d0f82eb99..09c387e2c7 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -28,8 +28,44 @@
 static uint8_t *allocation_tag_mem(CPUARMState *env, uint64_t ptr,
                                    bool write, uintptr_t ra)
 {
+#ifdef CONFIG_USER_ONLY
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    uint8_t *tags;
+    uintptr_t index;
+    int flags;
+
+    flags = page_get_flags(ptr);
+
+    if (!(flags & PAGE_VALID) || !(flags & (write ? PAGE_WRITE : PAGE_READ))) {
+        /* SIGSEGV */
+        env->exception.vaddress = ptr;
+        cpu_restore_state(CPU(cpu), ra, true);
+        raise_exception(env, EXCP_DATA_ABORT, 0, 1);
+    }
+
+    if (!cpu->tagged_pages) {
+        /* Tag storage is disabled.  */
+        return NULL;
+    }
+    if (flags & PAGE_SHARED) {
+        /* There may be multiple mappings; pretend not implemented.  */
+        return NULL;
+    }
+
+    tags = page_get_target_data(ptr);
+    if (tags == NULL) {
+        size_t alloc_size = TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1);
+        tags = page_alloc_target_data(ptr, alloc_size);
+        assert(tags != NULL);
+    }
+
+    index = extract32(ptr, LOG2_TAG_GRANULE + 1,
+                      TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
+    return tags + index;
+#else
     /* Tag storage not implemented.  */
     return NULL;
+#endif
 }
 
 static int get_allocation_tag(CPUARMState *env, uint64_t ptr, uintptr_t ra)
-- 
2.17.2
