Received: from eggs.gnu.org ([2001:4830:134:3::10]:52891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dZexx-0003So-A2
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dZext-0004bJ-OX
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:08:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dZext-0004bC-I1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:08:09 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 24 Jul 2017 16:08:05 +0100
Message-Id: <20170724150805.19563-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2] hmp/(p)memsave: Allow >32bit file size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, thuth@redhat.com, armbru@redhat.com, admin@manateeshome.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

memsave and pmemsave only take 32bit size arguments in HMP at the
moment; let them take 64bit values.

Reported-by: Pierre Kim <admin@manateeshome.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx |  4 ++--
 hmp.c           | 13 +++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1941e19932..ddf77ae7ac 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -829,7 +829,7 @@ ETEXI
 
     {
         .name       = "memsave",
-        .args_type  = "val:l,size:i,filename:s",
+        .args_type  = "val:l,size:l,filename:s",
         .params     = "addr size file",
         .help       = "save to disk virtual memory dump starting at 'addr' of size 'size'",
         .cmd        = hmp_memsave,
@@ -843,7 +843,7 @@ ETEXI
 
     {
         .name       = "pmemsave",
-        .args_type  = "val:l,size:i,filename:s",
+        .args_type  = "val:l,size:l,filename:s",
         .params     = "addr size file",
         .help       = "save to disk physical memory dump starting at 'addr' of size 'size'",
         .cmd        = hmp_pmemsave,
diff --git a/hmp.c b/hmp.c
index bf1de747d5..5118896779 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1066,7 +1066,7 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
 
 void hmp_memsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    int64_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
@@ -1076,6 +1076,10 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
+    if (size <= 0) {
+        monitor_printf(mon, "Invalid size\n");
+        return;
+    }
 
     qmp_memsave(addr, size, filename, true, cpu_index, &err);
     hmp_handle_error(mon, &err);
@@ -1083,11 +1087,16 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
 
 void hmp_pmemsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    int64_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
 
+    if (size <= 0) {
+        monitor_printf(mon, "Invalid size\n");
+        return;
+    }
+
     qmp_pmemsave(addr, size, filename, &err);
     hmp_handle_error(mon, &err);
 }
-- 
2.13.3
