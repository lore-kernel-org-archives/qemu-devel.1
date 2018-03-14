Received: from eggs.gnu.org ([2001:4830:134:3::10]:45840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ew7Hq-0004Lh-3k
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ew7Hm-00034L-W2
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:21:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41510 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ew7Hm-00033Z-RE
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 10:21:46 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Wed, 14 Mar 2018 15:21:33 +0100
Message-Id: <20180314142133.14166-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH] dump-guest-memory: more descriptive
 lookup_type failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, marcandre.lureau@redhat.com, lersek@redhat.com

We've seen a few reports of

 (gdb) source /usr/share/qemu-kvm/dump-guest-memory.py
 Traceback (most recent call last):
   File "/usr/share/qemu-kvm/dump-guest-memory.py", line 19, in <module>
     UINTPTR_T = gdb.lookup_type("uintptr_t")
 gdb.error: No type named uintptr_t.

This occurs when symbols haven't been loaded first, i.e. neither a
QEMU binary was loaded nor a QEMU process was attached first. Let's
better inform the user of how to fix the issue themselves in order
to avoid more reports.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 scripts/dump-guest-memory.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 51acfcd0c053..e56fff6d7e82 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -16,7 +16,11 @@ the COPYING file in the top-level directory.
 import ctypes
 import struct
 
-UINTPTR_T = gdb.lookup_type("uintptr_t")
+try:
+    UINTPTR_T = gdb.lookup_type("uintptr_t")
+except Exception as inst:
+    raise gdb.GdbError("Symbols must be loaded prior to sourcing dump-guest-memory.\n"
+                       "Symbols may be loaded by first 'attach'ing a QEMU process id or by 'load'ing a QEMU binary.")
 
 TARGET_PAGE_SIZE = 0x1000
 TARGET_PAGE_MASK = 0xFFFFFFFFFFFFF000
-- 
2.13.6
