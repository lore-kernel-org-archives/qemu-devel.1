Received: from eggs.gnu.org ([2001:4830:134:3::10]:51646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4KI-0000lL-R4
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4KF-0007y4-M8
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:54 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dS4KF-0007xU-Co
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:35:51 -0400
Received: by mail-wm0-x244.google.com with SMTP id j85so21514439wmj.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:35:51 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Jul 2017 18:34:37 +0200
Message-Id: <1499099693-22903-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/22] tcg: move page_size_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

From: Yang Zhong <yang.zhong@intel.com>

translate-all.c will be disabled if tcg is disabled in the build,
so page_size_init() function and related variables will be moved
to exec.c file.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/translate-all.c | 18 ------------------
 exec.c                    | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 93fb923..8428fce 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -112,9 +112,6 @@ typedef struct PageDesc {
 #define V_L2_BITS 10
 #define V_L2_SIZE (1 << V_L2_BITS)
 
-uintptr_t qemu_host_page_size;
-intptr_t qemu_host_page_mask;
-
 /*
  * L1 Mapping properties
  */
@@ -363,21 +360,6 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t retaddr)
     return r;
 }
 
-void page_size_init(void)
-{
-    /* NOTE: we can always suppose that qemu_host_page_size >=
-       TARGET_PAGE_SIZE */
-    qemu_real_host_page_size = getpagesize();
-    qemu_real_host_page_mask = -(intptr_t)qemu_real_host_page_size;
-    if (qemu_host_page_size == 0) {
-        qemu_host_page_size = qemu_real_host_page_size;
-    }
-    if (qemu_host_page_size < TARGET_PAGE_SIZE) {
-        qemu_host_page_size = TARGET_PAGE_SIZE;
-    }
-    qemu_host_page_mask = -(intptr_t)qemu_host_page_size;
-}
-
 static void page_init(void)
 {
     page_size_init();
diff --git a/exec.c b/exec.c
index 42ad1ea..ee61915 100644
--- a/exec.c
+++ b/exec.c
@@ -118,6 +118,11 @@ __thread CPUState *current_cpu;
    2 = Adaptive rate instruction counting.  */
 int use_icount;
 
+uintptr_t qemu_host_page_size;
+intptr_t qemu_host_page_mask;
+uintptr_t qemu_real_host_page_size;
+intptr_t qemu_real_host_page_mask;
+
 bool set_preferred_target_page_bits(int bits)
 {
     /* The target page size is the lowest common denominator for all
@@ -3590,3 +3595,18 @@ err:
 }
 
 #endif
+
+void page_size_init(void)
+{
+    /* NOTE: we can always suppose that qemu_host_page_size >=
+       TARGET_PAGE_SIZE */
+    qemu_real_host_page_size = getpagesize();
+    qemu_real_host_page_mask = -(intptr_t)qemu_real_host_page_size;
+    if (qemu_host_page_size == 0) {
+        qemu_host_page_size = qemu_real_host_page_size;
+    }
+    if (qemu_host_page_size < TARGET_PAGE_SIZE) {
+        qemu_host_page_size = TARGET_PAGE_SIZE;
+    }
+    qemu_host_page_mask = -(intptr_t)qemu_host_page_size;
+}
-- 
1.8.3.1
