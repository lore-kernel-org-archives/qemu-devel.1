Received: from eggs.gnu.org ([2001:4830:134:3::10]:36822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9n-0003bn-0T
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9l-0006kY-Rb
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:42 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9l-0006ir-LB
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:41 -0400
Received: by mail-wm0-x22a.google.com with SMTP id t189so3146347wmt.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:19 +0100
Message-Id: <1489508300-48184-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/18] memory: info mtree check mr range overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

The address of memory regions might overflow when something wrong
happened, like reported in:

https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg02043.html

For easier debugging, let's try to detect it.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1489496187-624-1-git-send-email-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/memory.c b/memory.c
index 284894b..64b0a60 100644
--- a/memory.c
+++ b/memory.c
@@ -2494,6 +2494,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     MemoryRegionListHead submr_print_queue;
     const MemoryRegion *submr;
     unsigned int i;
+    hwaddr cur_start, cur_end;
 
     if (!mr) {
         return;
@@ -2503,6 +2504,18 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
         mon_printf(f, MTREE_INDENT);
     }
 
+    cur_start = base + mr->addr;
+    cur_end = cur_start + MR_SIZE(mr->size);
+
+    /*
+     * Try to detect overflow of memory region. This should never
+     * happen normally. When it happens, we dump something to warn the
+     * user who is observing this.
+     */
+    if (cur_start < base || cur_end < cur_start) {
+        mon_printf(f, "[DETECTED OVERFLOW!] ");
+    }
+
     if (mr->alias) {
         MemoryRegionList *ml;
         bool found = false;
@@ -2522,8 +2535,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
         mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
                    " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
                    "-" TARGET_FMT_plx "%s\n",
-                   base + mr->addr,
-                   base + mr->addr + MR_SIZE(mr->size),
+                   cur_start, cur_end,
                    mr->priority,
                    memory_region_type((MemoryRegion *)mr),
                    memory_region_name(mr),
@@ -2534,8 +2546,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     } else {
         mon_printf(f,
                    TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %s): %s%s\n",
-                   base + mr->addr,
-                   base + mr->addr + MR_SIZE(mr->size),
+                   cur_start, cur_end,
                    mr->priority,
                    memory_region_type((MemoryRegion *)mr),
                    memory_region_name(mr),
@@ -2562,7 +2573,7 @@ static void mtree_print_mr(fprintf_function mon_printf, void *f,
     }
 
     QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
-        mtree_print_mr(mon_printf, f, ml->mr, level + 1, base + mr->addr,
+        mtree_print_mr(mon_printf, f, ml->mr, level + 1, cur_start,
                        alias_print_queue);
     }
 
-- 
1.8.3.1
