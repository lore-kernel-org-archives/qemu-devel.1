Received: from eggs.gnu.org ([2001:4830:134:3::10]:40590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dZcFb-0004my-Gl
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dZcFY-0006a4-C4
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dZcFY-0006Zo-5Z
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:14:12 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 24 Jul 2017 13:14:09 +0100
Message-Id: <20170724121409.8623-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] hmp/(p)memsave: Allow >32bit file size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, thuth@redhat.com, admin@manateeshome.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

memsave and pmemsave only take 32bit size arguments in HMP at the
moment; let them take 64bit values.

Reported-by: Pierre Kim <admin@manateeshome.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands.hx | 4 ++--
 hmp.c           | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

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
index bf1de747d5..dfbd615380 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1066,7 +1066,7 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
 
 void hmp_memsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    uint64_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
@@ -1083,7 +1083,7 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
 
 void hmp_pmemsave(Monitor *mon, const QDict *qdict)
 {
-    uint32_t size = qdict_get_int(qdict, "size");
+    uint64_t size = qdict_get_int(qdict, "size");
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
-- 
2.13.3
