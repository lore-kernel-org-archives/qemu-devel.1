Received: from eggs.gnu.org ([2001:4830:134:3::10]:56456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqEAP-00056T-8X
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqEAK-0002Oo-Rv
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:05 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:33919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fqEAK-0002NB-Jh
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:00 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 16 Aug 2018 11:01:48 +0200
Message-Id: <cover.1534409363.git.simon@ruderich.org>
In-Reply-To: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v4 0/7] qmp/hmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Simon Ruderich <simon@ruderich.org>

Hello,

Revised patch series rebased on current master which should
incorporate all comments mentioned in the review. I've decided to
make size and offset optional for QMP, but keep it required for
HMP to make pmemload consistent with memsave/pmemsave.

Regards
Simon

Simon Ruderich (7):
  cpus: correct coding style in qmp_memsave/qmp_pmemsave
  cpus: convert qmp_memsave/qmp_pmemsave to use qemu_open
  cpus: use size_t in qmp_memsave/qmp_pmemsave
  hmp: use l for size argument in memsave/pmemsave
  hmp: use F for filename arguments in memsave/pmemsave
  qmp: add pmemload command
  hmp: add pmemload command

 cpus.c          | 81 ++++++++++++++++++++++++++++++++++++++++---------
 hmp-commands.hx | 18 +++++++++--
 hmp.c           | 16 ++++++++--
 hmp.h           |  1 +
 qapi/misc.json  | 20 ++++++++++++
 5 files changed, 118 insertions(+), 18 deletions(-)

Interdiff:

diff --git a/cpus.c b/cpus.c
index 4141ef766c..d79bf8b485 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2369,8 +2369,10 @@ exit:
     qemu_close(fd);
 }
 
-void qmp_pmemload(int64_t addr, int64_t size, int64_t offset,
-                  const char *filename, Error **errp)
+void qmp_pmemload(int64_t addr, const char *filename,
+                  bool has_size, int64_t size,
+                  bool has_offset, int64_t offset,
+                  Error **errp)
 {
     int fd;
     size_t l;
@@ -2382,13 +2384,21 @@ void qmp_pmemload(int64_t addr, int64_t size, int64_t offset,
         error_setg_file_open(errp, errno, filename);
         return;
     }
-    if (offset > 0) {
+    if (has_offset && offset > 0) {
         if (lseek(fd, offset, SEEK_SET) != offset) {
             error_setg_errno(errp, errno,
                              "could not seek to offset %" PRIx64, offset);
             goto exit;
         }
     }
+    if (!has_size) {
+        struct stat s;
+        if (fstat(fd, &s)) {
+            error_setg_errno(errp, errno, "could not fstat fd to get size");
+            goto exit;
+        }
+        size = s.st_size;
+    }
 
     while (size != 0) {
         l = sizeof(buf);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5a43dae133..c39d745a22 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -818,7 +818,7 @@ ETEXI
 
     {
         .name       = "memsave",
-        .args_type  = "val:l,size:i,filename:s",
+        .args_type  = "val:l,size:l,filename:F",
         .params     = "addr size file",
         .help       = "save to disk virtual memory dump starting at 'addr' of size 'size'",
         .cmd        = hmp_memsave,
@@ -832,7 +832,7 @@ ETEXI
 
     {
         .name       = "pmemsave",
-        .args_type  = "val:l,size:i,filename:s",
+        .args_type  = "val:l,size:l,filename:F",
         .params     = "addr size file",
         .help       = "save to disk physical memory dump starting at 'addr' of size 'size'",
         .cmd        = hmp_pmemsave,
@@ -846,7 +846,7 @@ ETEXI
 
     {
         .name       = "pmemload",
-        .args_type  = "val:l,size:i,offset:i,filename:s",
+        .args_type  = "val:l,size:l,offset:l,filename:F",
         .params     = "addr size offset file",
         .help       = "load from disk physical memory dump starting at 'addr' of size 'size' at file offset 'offset'",
         .cmd        = hmp_pmemload,
diff --git a/hmp.c b/hmp.c
index 73de92e629..293e067ed5 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1128,7 +1128,7 @@ void hmp_pmemload(Monitor *mon, const QDict *qdict)
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
 
-    qmp_pmemload(addr, size, offset, filename, &err);
+    qmp_pmemload(addr, filename, true, size, true, offset, &err);
     hmp_handle_error(mon, &err);
 }
 
diff --git a/qapi/misc.json b/qapi/misc.json
index 6c34b2ff8b..06cf36f3d4 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1188,18 +1188,18 @@
 #
 # @val: the physical address of the guest to start from
 #
-# @size: the size of memory region to load
-#
-# @offset: the offset in the file to start from
-#
 # @filename: the file to load the memory from as binary data
 #
+# @size: the size of memory region to load (defaults to whole file)
+#
+# @offset: the offset in the file to start from (defaults to 0)
+#
 # Returns: Nothing on success
 #
-# Since: 2.13
+# Since: 3.1
 ##
 { 'command': 'pmemload',
-  'data': {'val': 'int', 'size': 'int', 'offset': 'int', 'filename': 'str'} }
+  'data': {'val': 'int', 'filename': 'str', '*size': 'int', '*offset': 'int'} }
 
 ##
 # @cont:

-- 
2.17.1
