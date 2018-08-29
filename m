Received: from eggs.gnu.org ([2001:4830:134:3::10]:60495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fuzp9-0006PJ-0S
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fuznl-00031T-An
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:42:28 -0400
Received: from mail-eopbgr40138.outbound.protection.outlook.com
	([40.107.4.138]:19424
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fuznl-0002zG-1A
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 08:42:25 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Wed, 29 Aug 2018 15:41:26 +0300
Message-Id: <1535546488-30208-4-git-send-email-viktor.prutyanov@virtuozzo.com>
In-Reply-To: <1535546488-30208-1-git-send-email-viktor.prutyanov@virtuozzo.com>
References: <1535546488-30208-1-git-send-email-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/5] contrib/elf2dmp: improve paging root
 selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, armbru@redhat.com, dgilbert@redhat.com, rkagan@virtuozzo.com, viktor.prutyanov@phystech.edu, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

Even if KERNEL_GS_BASEs are absent in QEMU CPU states, there
is a chance to find suitable CR3 value from CPU which runs kernel task.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 contrib/elf2dmp/main.c     | 56 +++++++++++++++++++++++++++++++++++++++-------
 contrib/elf2dmp/qemu_elf.c | 16 +++++++++++--
 contrib/elf2dmp/qemu_elf.h |  3 +++
 3 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index eb11e66..62f08e0 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -188,17 +188,53 @@ static void win_context_init_from_qemu_cpu_state(WinContext *ctx,
     *ctx = win_ctx;
 }
 
-static void fix_dtb(struct va_space *vs, QEMUCPUState *s)
+/*
+ * Finds paging-structure hierarchy base,
+ * if previously set doesn't give access to kernel structures
+ */
+static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
 {
-    uint64_t Prcb = (s->gs.base >> 63) ? s->gs.base : s->kernel_gs_base;
-    void *prcb = va_space_resolve(vs, Prcb);
+    /*
+     * Firstly, test previously set DTB.
+     */
+    if (va_space_resolve(vs, SharedUserData)) {
+        return 0;
+    }
+
+    /*
+     * Secondly, find CPU which run system task.
+     */
+    for (size_t i = 0; i < qe->state_nr; i++) {
+        QEMUCPUState *s = qe->state[i];
 
-    if (!prcb) {
-        va_space_set_dtb(vs, *(uint64_t *)va_space_resolve(vs, Prcb + 0x7000));
+        if (is_system(s)) {
+            va_space_set_dtb(vs, s->cr[3]);
+            printf("DTB 0x%016lx has been found from CPU #%zu"
+                    " as system task CR3\n", vs->dtb, i);
+            return !(va_space_resolve(vs, SharedUserData));
+        }
     }
 
-    assert(va_space_resolve(vs, Prcb));
-    printf("DTB is 0x%016lx\n", vs->dtb);
+    /*
+     * Thirdly, use KERNEL_GS_BASE from CPU #0 as PRCB address and
+     * CR3 as [Prcb+0x7000]
+     */
+    if (qe->has_kernel_gs_base) {
+        QEMUCPUState *s = qe->state[0];
+        uint64_t Prcb = s->kernel_gs_base;
+        uint64_t *cr3 = va_space_resolve(vs, Prcb + 0x7000);
+
+        if (!cr3) {
+            return 1;
+        }
+
+        va_space_set_dtb(vs, *cr3);
+        printf("DirectoryTableBase = 0x%016lx has been found from CPU #0"
+                " as interrupt handling CR3\n", vs->dtb);
+        return !(va_space_resolve(vs, SharedUserData));
+    }
+
+    return 1;
 }
 
 static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
@@ -448,7 +484,11 @@ int main(int argc, char *argv[])
     printf("CPU #0 CR3 is 0x%016lx\n", state->cr[3]);
 
     va_space_create(&vs, &ps, state->cr[3]);
-    fix_dtb(&vs, state);
+    if (fix_dtb(&vs, &qemu_elf)) {
+        eprintf("Failed to find paging base\n");
+        err = 1;
+        goto out_elf;
+    }
 
     printf("CPU #0 IDT is at 0x%016lx\n", state->idt.base);
 
diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index f7b5ebd..d139db2 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -33,6 +33,11 @@
       DIV_ROUND_UP((name_size), 4) +                    \
       DIV_ROUND_UP((desc_size), 4)) * 4)
 
+int is_system(QEMUCPUState *s)
+{
+    return s->gs.base >> 63;
+}
+
 static char *nhdr_get_name(Elf64_Nhdr *nhdr)
 {
     return (char *)nhdr + ROUND_UP(sizeof(*nhdr), 4);
@@ -76,13 +81,20 @@ static int init_states(QEMU_Elf *qe)
         return 1;
     }
 
+    qe->has_kernel_gs_base = 1;
+
     for (Elf64_Nhdr *nhdr = start; nhdr < end; nhdr = nhdr_get_next(nhdr)) {
         if (!strcmp(nhdr_get_name(nhdr), QEMU_NOTE_NAME)) {
             QEMUCPUState *state = nhdr_get_desc(nhdr);
 
             if (state->size < sizeof(*state)) {
-                eprintf("QEMU CPU state size %d doesn't match\n", state->size);
-                return 1;
+                eprintf("CPU #%zu: QEMU CPU state size %u doesn't match\n",
+                        cpu_nr, state->size);
+                /*
+                 * We assume either every QEMU CPU state has KERNEL_GS_BASE or
+                 * no one has.
+                 */
+                qe->has_kernel_gs_base = 0;
             }
             cpu_nr++;
         }
diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index 2a28bb0..d85d655 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -31,12 +31,15 @@ typedef struct QEMUCPUState {
     uint64_t kernel_gs_base;
 } QEMUCPUState;
 
+int is_system(QEMUCPUState *s);
+
 typedef struct QEMU_Elf {
     int fd;
     size_t size;
     void *map;
     QEMUCPUState **state;
     size_t state_nr;
+    int has_kernel_gs_base;
 } QEMU_Elf;
 
 int QEMU_Elf_init(QEMU_Elf *qe, const char *filename);
-- 
2.7.4
