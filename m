Received: from eggs.gnu.org ([2001:4830:134:3::10]:34460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fJLhX-0006ab-Jh
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fJLhU-0007Jz-Kj
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:24:23 -0400
Received: from mail-eopbgr50097.outbound.protection.outlook.com
	([40.107.5.97]:20608
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fJLhU-0007FD-Cr
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:24:20 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Thu, 17 May 2018 19:23:41 +0300
Message-Id: <20180517162342.4330-4-viktor.prutyanov@virtuozzo.com>
In-Reply-To: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
References: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/4] dump: add fallback KDBG using in Windows
 dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rkagan@virtuozzo.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, armbru@redhat.com, Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

KdDebuggerDataBlock may be encrypted in guest memory and dump will be
useless in this case. But guest driver can obtain decrypted KDBG and
expose its address through BugcheckParameter1 field in raw header.
After this patch, QEMU will be able to use fallback KdDebuggerDataBlock.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 win_dump.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/win_dump.c b/win_dump.c
index 7d956ca996..2d9afb514e 100644
--- a/win_dump.c
+++ b/win_dump.c
@@ -144,21 +144,37 @@ static void check_kdbg(WinDumpHeader64 *h, Error **errp)
 {
     const char OwnerTag[] = "KDBG";
     char read_OwnerTag[4];
+    uint64_t KdDebuggerDataBlock = h->KdDebuggerDataBlock;
+    bool try_fallback = true;
 
+try_again:
     if (cpu_memory_rw_debug(first_cpu,
-            h->KdDebuggerDataBlock + KDBG_OWNER_TAG_OFFSET64,
+            KdDebuggerDataBlock + KDBG_OWNER_TAG_OFFSET64,
             (uint8_t *)&read_OwnerTag, sizeof(read_OwnerTag), 0)) {
         error_setg(errp, "win-dump: failed to read OwnerTag");
         return;
     }
 
     if (memcmp(read_OwnerTag, OwnerTag, sizeof(read_OwnerTag))) {
-        error_setg(errp, "win-dump: invalid KDBG OwnerTag,"
-                         " expected '%.4s', got '%.4s',"
-                         " KdDebuggerDataBlock seems to be encrypted",
-                         OwnerTag, read_OwnerTag);
-        return;
+        if (try_fallback) {
+            /*
+             * If attempt to use original KDBG failed
+             * (most likely because of its encryption),
+             * we try to use KDBG obtained by guest driver.
+             */
+
+            KdDebuggerDataBlock = h->BugcheckParameter1;
+            try_fallback = false;
+            goto try_again;
+        } else {
+            error_setg(errp, "win-dump: invalid KDBG OwnerTag,"
+                             " expected '%.4s', got '%.4s'",
+                             OwnerTag, read_OwnerTag);
+            return;
+        }
     }
+
+    h->KdDebuggerDataBlock = KdDebuggerDataBlock;
 }
 
 void create_win_dump(DumpState *s, Error **errp)
-- 
2.14.3
