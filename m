Received: from eggs.gnu.org ([2001:4830:134:3::10]:38510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdBE-0007uA-Bz
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdBB-0001Rn-6o
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:12 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdBA-0001P3-VM
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:09 -0400
Received: by mail-wr0-x243.google.com with SMTP id a12-v6so6696671wro.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:06:08 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:05:05 +0200
Message-Id: <1530216310-52873-56-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 55/60] dump: add fallback KDBG using in Windows
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
Cc: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>

KdDebuggerDataBlock may be encrypted in guest memory and dump will be
useless in this case. But guest driver can obtain decrypted KDBG and
expose its address through BugcheckParameter1 field in raw header.
After this patch, QEMU will be able to use fallback KdDebuggerDataBlock.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Message-Id: <20180517162342.4330-4-viktor.prutyanov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 win_dump.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/win_dump.c b/win_dump.c
index 7d956ca..2d9afb5 100644
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
1.8.3.1
