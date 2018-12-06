Received: from eggs.gnu.org ([2001:4830:134:3::10]:41511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJw-00087J-BZ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJr-0004m3-PA
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:56 -0500
Received: from mail.ispras.ru ([83.149.199.45]:59942)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJr-0004lk-DH
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:51 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 14:59:46 +0300
Message-ID: <154409758590.5432.15051246373534967280.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 12/39] windbg: implement
 find_kdDebuggerDataBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

It is necessary to find address on the structure kdDebuggerDataBlock,
which is located somewhere at kernel .data section.

We can find it in structure defined in kernel:
typedef struct _DBGKD_DEBUG_DATA_HEADER
{
    LIST_ENTRY64 List;
    ULONG OwnerTag;
    ULONG Size;
} DBGKD_DEBUG_DATA_HEADER, *PDBGKD_DEBUG_DATA_HEEADER;
where OwnerTag == 'KDBG',
then List == kdDebuggerDataBlock.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 target/i386/windbgstub.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index dc58f5a8cc..f1bab10b10 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -14,6 +14,7 @@
 
 #ifdef TARGET_X86_64
 #define OFFSET_KPCR_SELF 0x18
+#define OFFSET_KPCR_LOCK_ARRAY 0x28
 #else  /* TARGET_I386 */
 #define OFFSET_KPCR_SELF 0x1C
 #define OFFSET_KPCR_VERSION 0x34
@@ -60,6 +61,52 @@ static bool find_KPCR(CPUState *cs)
 #ifdef TARGET_X86_64
 static bool find_kdDebuggerDataBlock(CPUState *cs)
 {
+    target_ulong lockArray;
+    target_ulong dDataList;
+    const uint8_t tag[] = { 'K', 'D', 'B', 'G' };
+    target_ulong start = 0xfffff80000000000LL;
+    target_ulong finish = 0xfffff81000000000LL;
+    InitedAddr find;
+
+    /* kdDebuggerDataBlock is located in
+         - range of [0xfffff80000000000 ... 0xfffff81000000000]
+         - at offset of ('KDBG') - 0x10 */
+
+    if (!kdDebuggerDataBlock.is_init && KPCR.is_init) {
+        /* At first, find lockArray. If it is NULL,
+           then kdDebuggerDataBlock is also NULL (empirically). */
+        lockArray = VMEM_ADDR(cs, KPCR.addr + OFFSET_KPCR_LOCK_ARRAY);
+        if (!lockArray) {
+            return false;
+        }
+        DPRINTF("find LockArray " FMT_ADDR "\n", lockArray);
+
+        while (true) {
+            find = windbg_search_vmaddr(cs, start, finish, tag,
+                                        ARRAY_SIZE(tag));
+            if (!find.is_init) {
+                return false;
+            }
+
+            /* Valid address to 'KDBG ' is always aligned */
+            if (!(find.addr & 0xf)) {
+                dDataList = VMEM_ADDR(cs, find.addr - 0x10);
+
+                /* Valid address to 'dDataList ' is always
+                   in range [0xfffff80000000000 ... 0xfffff8ffffffffff] */
+                if ((dDataList >> 40) == 0xfffff8) {
+                    kdDebuggerDataBlock.addr = find.addr - 0x10;
+                    kdDebuggerDataBlock.is_init = true;
+                    DPRINTF("find kdDebuggerDataBlock " FMT_ADDR "\n",
+                            kdDebuggerDataBlock.addr);
+                    break;
+                }
+            }
+
+            start = find.addr + 0x8; /* next addr */
+        }
+    }
+
     return kdDebuggerDataBlock.is_init;
 }
 #else  /* TARGET_I386 */
