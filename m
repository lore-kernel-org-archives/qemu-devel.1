Received: from eggs.gnu.org ([209.51.188.92]:47510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wir-0003yz-1v
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wiq-0000hq-6E
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:45 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2Wip-0000h7-VW
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:44 -0500
Received: by mail-wr1-x432.google.com with SMTP id o9so448759wrv.9
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:43 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id 11sm5252294wmg.27.2019.03.08.23.48.41
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 08 Mar 2019 23:48:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:48:18 +0100
Message-Id: <1552117698-12355-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/25] exec: streamline flatview_add_to_dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The while loop in flatview_add_to_dispatch can only be executed twice
and it will go through different paths on each execution (in fact
one of the "if" branches is dead).  Remove the loop completely,
the code becomes clearer at the cost of a handful of duplicated
lines.

Reported-by: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/exec.c b/exec.c
index 1d4f378..9647593 100644
--- a/exec.c
+++ b/exec.c
@@ -1601,33 +1601,37 @@ static void register_multipage(FlatView *fv,
 
 void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
 {
-    MemoryRegionSection now = *section, remain = *section;
+    MemoryRegionSection remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
 
-    if (now.offset_within_address_space & ~TARGET_PAGE_MASK) {
+    if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
+        MemoryRegionSection now = remain;
         uint64_t left = TARGET_PAGE_ALIGN(now.offset_within_address_space)
                        - now.offset_within_address_space;
 
         now.size = int128_min(int128_make64(left), now.size);
         register_subpage(fv, &now);
-    } else {
-        now.size = int128_zero();
-    }
-    while (int128_ne(remain.size, now.size)) {
+        if (int128_eq(remain.size, now.size)) {
+            return;
+        }
         remain.size = int128_sub(remain.size, now.size);
         remain.offset_within_address_space += int128_get64(now.size);
         remain.offset_within_region += int128_get64(now.size);
-        now = remain;
-        if (int128_lt(remain.size, page_size)) {
-            register_subpage(fv, &now);
-        } else if (remain.offset_within_address_space & ~TARGET_PAGE_MASK) {
-            now.size = page_size;
-            register_subpage(fv, &now);
-        } else {
-            now.size = int128_and(now.size, int128_neg(page_size));
-            register_multipage(fv, &now);
+    }
+
+    if (int128_ge(remain.size, page_size)) {
+        MemoryRegionSection now = remain;
+        now.size = int128_and(now.size, int128_neg(page_size));
+        register_multipage(fv, &now);
+        if (int128_eq(remain.size, now.size)) {
+            return;
         }
+        remain.size = int128_sub(remain.size, now.size);
+        remain.offset_within_address_space += int128_get64(now.size);
+        remain.offset_within_region += int128_get64(now.size);
     }
+
+    register_subpage(fv, &remain);
 }
 
 void qemu_flush_coalesced_mmio_buffer(void)
-- 
1.8.3.1
