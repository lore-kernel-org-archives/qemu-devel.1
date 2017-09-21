Received: from eggs.gnu.org ([2001:4830:134:3::10]:37146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAiA-0004YM-Pg
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAi9-0003qu-5V
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:50 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAi8-0003oz-U6
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:16:49 -0400
Received: by mail-wm0-x243.google.com with SMTP id e64so6456445wmi.2
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:16:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:11 +0200
Message-Id: <1506035800-30509-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/32] memory: avoid a name clash with access
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: KONRAD Frederic <frederic.konrad@adacore.com>

From: KONRAD Frederic <frederic.konrad@adacore.com>

This avoids a name clash with the access macro on windows 64:

make
	CHK version_gen.h
  CC      aarch64-softmmu/memory.o
/home/konrad/qemu/memory.c: In function 'access_with_adjusted_size':
/home/konrad/qemu/memory.c:591:73: error: macro "access" passed 7 arguments, \
                         but takes just 2
                         (size - access_size - i) * 8, access_mask, attrs);
                                                                         ^

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <1505988260-8483-1-git-send-email-frederic.konrad@adacore.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/memory.c b/memory.c
index b9920a6..2b90117 100644
--- a/memory.c
+++ b/memory.c
@@ -560,13 +560,14 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
                                       unsigned size,
                                       unsigned access_size_min,
                                       unsigned access_size_max,
-                                      MemTxResult (*access)(MemoryRegion *mr,
-                                                            hwaddr addr,
-                                                            uint64_t *value,
-                                                            unsigned size,
-                                                            unsigned shift,
-                                                            uint64_t mask,
-                                                            MemTxAttrs attrs),
+                                      MemTxResult (*access_fn)
+                                                  (MemoryRegion *mr,
+                                                   hwaddr addr,
+                                                   uint64_t *value,
+                                                   unsigned size,
+                                                   unsigned shift,
+                                                   uint64_t mask,
+                                                   MemTxAttrs attrs),
                                       MemoryRegion *mr,
                                       MemTxAttrs attrs)
 {
@@ -587,12 +588,12 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
     access_mask = -1ULL >> (64 - access_size * 8);
     if (memory_region_big_endian(mr)) {
         for (i = 0; i < size; i += access_size) {
-            r |= access(mr, addr + i, value, access_size,
+            r |= access_fn(mr, addr + i, value, access_size,
                         (size - access_size - i) * 8, access_mask, attrs);
         }
     } else {
         for (i = 0; i < size; i += access_size) {
-            r |= access(mr, addr + i, value, access_size, i * 8,
+            r |= access_fn(mr, addr + i, value, access_size, i * 8,
                         access_mask, attrs);
         }
     }
-- 
1.8.3.1
