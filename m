Received: from eggs.gnu.org ([2001:4830:134:3::10]:38996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTVMZ-0005YR-1I
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fTVMV-0002ut-TN
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 12:44:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 14 Jun 2018 17:44:31 +0100
Message-Id: <20180614164431.29305-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] compiler: add a sizeof_field() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org, qemu-s390x@nongnu.org

Determining the size of a field is useful when you don't have a struct
variable handy.  Open-coding this is ugly.

This patch adds the sizeof_field() macro, which is similar to
typeof_field().  Existing instances are updated to use the macro.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/xen/io/ring.h      |  2 +-
 include/qemu/compiler.h       |  2 ++
 accel/tcg/translate-all.c     |  2 +-
 hw/display/xenfb.c            |  4 ++--
 hw/net/rocker/rocker_of_dpa.c |  2 +-
 hw/net/virtio-net.c           |  2 +-
 target/i386/kvm.c             |  2 +-
 target/ppc/arch_dump.c        | 10 +++++-----
 target/s390x/arch_dump.c      | 20 ++++++++++----------
 9 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/hw/xen/io/ring.h b/include/hw/xen/io/ring.h
index abbca47687..ffa3ebadc8 100644
--- a/include/hw/xen/io/ring.h
+++ b/include/hw/xen/io/ring.h
@@ -65,7 +65,7 @@ typedef unsigned int RING_IDX;
  */
 #define __CONST_RING_SIZE(_s, _sz) \
     (__RD32(((_sz) - offsetof(struct _s##_sring, ring)) / \
-	    sizeof(((struct _s##_sring *)0)->ring[0])))
+            sizeof_field(struct _s##_sring, ring[0])))
 /*
  * The same for passing in an actual pointer instead of a name tag.
  */
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 9f762695d1..5843812710 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -64,6 +64,8 @@
         (type *) ((char *) __mptr - offsetof(type, member));})
 #endif
 
+#define sizeof_field(type, field) sizeof(((type *)0)->field)
+
 /* Convert from a base type to a parent type, with compile time checking.  */
 #ifdef __GNUC__
 #define DO_UPCAST(type, field, dev) ( __extension__ ( { \
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d48b56ca38..767066ecd6 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -132,7 +132,7 @@ typedef struct PageDesc {
 
 /* Make sure all possible CPU event bits fit in tb->trace_vcpu_dstate */
 QEMU_BUILD_BUG_ON(CPU_TRACE_DSTATE_MAX_EVENTS >
-                  sizeof(((TranslationBlock *)0)->trace_vcpu_dstate)
+                  sizeof_field(TranslationBlock, trace_vcpu_dstate)
                   * BITS_PER_BYTE);
 
 /*
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index f5afcc0358..911291c5c3 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -525,8 +525,8 @@ static int xenfb_configure_fb(struct XenFB *xenfb, size_t fb_len_lim,
                               int width, int height, int depth,
                               size_t fb_len, int offset, int row_stride)
 {
-    size_t mfn_sz = sizeof(*((struct xenfb_page *)0)->pd);
-    size_t pd_len = sizeof(((struct xenfb_page *)0)->pd) / mfn_sz;
+    size_t mfn_sz = sizeof_field(struct xenfb_page, pd[0]);
+    size_t pd_len = sizeof_field(struct xenfb_page, pd) / mfn_sz;
     size_t fb_pages = pd_len * XC_PAGE_SIZE / mfn_sz;
     size_t fb_len_max = fb_pages * XC_PAGE_SIZE;
     int max_width, max_height;
diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 60046720a5..8e347d1ee4 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -104,7 +104,7 @@ typedef struct of_dpa_flow_key {
 
 /* Width of key which includes field 'f' in u64s, rounded up */
 #define FLOW_KEY_WIDTH(f) \
-    DIV_ROUND_UP(offsetof(OfDpaFlowKey, f) + sizeof(((OfDpaFlowKey *)0)->f), \
+    DIV_ROUND_UP(offsetof(OfDpaFlowKey, f) + sizeof_field(OfDpaFlowKey, f), \
     sizeof(uint64_t))
 
 typedef struct of_dpa_flow_action {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 90502fca7c..f154756e85 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -46,7 +46,7 @@
  * 'container'.
  */
 #define endof(container, field) \
-    (offsetof(container, field) + sizeof(((container *)0)->field))
+    (offsetof(container, field) + sizeof_field(container, field))
 
 typedef struct VirtIOFeature {
     uint64_t flags;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 445e0e0b11..ad0e904b2c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1526,7 +1526,7 @@ static int kvm_put_fpu(X86CPU *cpu)
 #define XSAVE_PKRU        672
 
 #define XSAVE_BYTE_OFFSET(word_offset) \
-    ((word_offset) * sizeof(((struct kvm_xsave *)0)->region[0]))
+    ((word_offset) * sizeof_field(struct kvm_xsave, region[0]))
 
 #define ASSERT_OFFSET(word_offset, field) \
     QEMU_BUILD_BUG_ON(XSAVE_BYTE_OFFSET(word_offset) != \
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 351a65b22f..cc1460e4e3 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -210,11 +210,11 @@ static const struct NoteFuncDescStruct {
     int contents_size;
     void (*note_contents_func)(NoteFuncArg *arg, PowerPCCPU *cpu);
 } note_func[] = {
-    {sizeof(((Note *)0)->contents.prstatus),  ppc_write_elf_prstatus},
-    {sizeof(((Note *)0)->contents.fpregset),  ppc_write_elf_fpregset},
-    {sizeof(((Note *)0)->contents.vmxregset), ppc_write_elf_vmxregset},
-    {sizeof(((Note *)0)->contents.vsxregset), ppc_write_elf_vsxregset},
-    {sizeof(((Note *)0)->contents.speregset), ppc_write_elf_speregset},
+    {sizeof_field(Note, contents.prstatus),  ppc_write_elf_prstatus},
+    {sizeof_field(Note, contents.fpregset),  ppc_write_elf_fpregset},
+    {sizeof_field(Note, contents.vmxregset), ppc_write_elf_vmxregset},
+    {sizeof_field(Note, contents.vsxregset), ppc_write_elf_vsxregset},
+    {sizeof_field(Note, contents.speregset), ppc_write_elf_speregset},
     { 0, NULL}
 };
 
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 6f61ff95af..c9ef0a6e60 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -184,20 +184,20 @@ typedef struct NoteFuncDescStruct {
 } NoteFuncDesc;
 
 static const NoteFuncDesc note_core[] = {
-    {sizeof(((Note *)0)->contents.prstatus), s390x_write_elf64_prstatus},
-    {sizeof(((Note *)0)->contents.fpregset), s390x_write_elf64_fpregset},
+    {sizeof_field(Note, contents.prstatus), s390x_write_elf64_prstatus},
+    {sizeof_field(Note, contents.fpregset), s390x_write_elf64_fpregset},
     { 0, NULL}
 };
 
 static const NoteFuncDesc note_linux[] = {
-    {sizeof(((Note *)0)->contents.prefix),   s390x_write_elf64_prefix},
-    {sizeof(((Note *)0)->contents.ctrs),     s390x_write_elf64_ctrs},
-    {sizeof(((Note *)0)->contents.timer),    s390x_write_elf64_timer},
-    {sizeof(((Note *)0)->contents.todcmp),   s390x_write_elf64_todcmp},
-    {sizeof(((Note *)0)->contents.todpreg),  s390x_write_elf64_todpreg},
-    {sizeof(((Note *)0)->contents.vregslo),  s390x_write_elf64_vregslo},
-    {sizeof(((Note *)0)->contents.vregshi),  s390x_write_elf64_vregshi},
-    {sizeof(((Note *)0)->contents.gscb),     s390x_write_elf64_gscb},
+    {sizeof_field(Note, contents.prefix),   s390x_write_elf64_prefix},
+    {sizeof_field(Note, contents.ctrs),     s390x_write_elf64_ctrs},
+    {sizeof_field(Note, contents.timer),    s390x_write_elf64_timer},
+    {sizeof_field(Note, contents.todcmp),   s390x_write_elf64_todcmp},
+    {sizeof_field(Note, contents.todpreg),  s390x_write_elf64_todpreg},
+    {sizeof_field(Note, contents.vregslo),  s390x_write_elf64_vregslo},
+    {sizeof_field(Note, contents.vregshi),  s390x_write_elf64_vregshi},
+    {sizeof_field(Note, contents.gscb),     s390x_write_elf64_gscb},
     { 0, NULL}
 };
 
-- 
2.17.1
