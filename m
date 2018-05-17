Received: from eggs.gnu.org ([2001:4830:134:3::10]:34457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fJLhX-0006aZ-J2
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@virtuozzo.com>) id 1fJLhU-0007JF-7a
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:24:23 -0400
Received: from mail-eopbgr50097.outbound.protection.outlook.com
	([40.107.5.97]:20608
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <viktor.prutyanov@virtuozzo.com>)
	id 1fJLhU-0007FD-1I
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:24:20 -0400
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date: Thu, 17 May 2018 19:23:40 +0300
Message-Id: <20180517162342.4330-3-viktor.prutyanov@virtuozzo.com>
In-Reply-To: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
References: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/4] dump: use system context in Windows dump
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

We use CPU #0 to access guest virtual memory, but it can execute user
thread at that moment. So, switch CR3 to PageDirectoryBase from header
and restore original value at the end.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 win_dump.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/win_dump.c b/win_dump.c
index 58255c12ee..7d956ca996 100644
--- a/win_dump.c
+++ b/win_dump.c
@@ -111,12 +111,6 @@ static void patch_header(WinDumpHeader64 *h)
     h->PhysicalMemoryBlock.unused = 0;
     h->unused1 = 0;
 
-    /*
-     * We assume h->DirectoryBase and current CR3 are the same when we access
-     * memory by virtual address. In other words, we suppose current context
-     * is system context. It is definetely true in case of BSOD.
-     */
-
     patch_mm_pfn_database(h, &local_err);
     if (local_err) {
         warn_report_err(local_err);
@@ -171,6 +165,8 @@ void create_win_dump(DumpState *s, Error **errp)
 {
     WinDumpHeader64 *h = (WinDumpHeader64 *)(s->guest_note +
             VMCOREINFO_ELF_NOTE_HDR_SIZE);
+    X86CPU *first_x86_cpu = X86_CPU(first_cpu);
+    uint64_t saved_cr3 = first_x86_cpu->env.cr[3];
     Error *local_err = NULL;
 
     if (s->guest_note_size != sizeof(WinDumpHeader64) +
@@ -185,10 +181,17 @@ void create_win_dump(DumpState *s, Error **errp)
         return;
     }
 
+    /*
+     * Further access to kernel structures by virtual addresses
+     * should be made from system context.
+     */
+
+    first_x86_cpu->env.cr[3] = h->DirectoryTableBase;
+
     check_kdbg(h, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        return;
+        goto out_cr3;
     }
 
     patch_header(h);
@@ -198,12 +201,17 @@ void create_win_dump(DumpState *s, Error **errp)
     s->written_size = qemu_write_full(s->fd, h, sizeof(*h));
     if (s->written_size != sizeof(*h)) {
         error_setg(errp, QERR_IO_ERROR);
-        return;
+        goto out_cr3;
     }
 
     write_runs(s, h, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        return;
+        goto out_cr3;
     }
+
+out_cr3:
+    first_x86_cpu->env.cr[3] = saved_cr3;
+
+    return;
 }
-- 
2.14.3
