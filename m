Received: from eggs.gnu.org ([2001:4830:134:3::10]:54885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f60lG-0002Kq-Ub
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f60lC-0008Vf-N7
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:25:06 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:33563)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1f60lC-0008UH-F6
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:25:02 -0400
Date: Tue, 10 Apr 2018 23:24:59 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Adapted patch from Baojun Wang [1] with the following commit message:

    I found this could be useful to have qemu-softmmu as a cross
    debugger (launch with -s -S command line option), then if we can
    have a command to load guest physical memory, we can use cross gdb
    to do some target debug which gdb cannot do directly.

pmemload is necessary to directly write physical memory which is not
possible with gdb alone as it uses only logical addresses.

[1]: https://lists.gnu.org/archive/html/qemu-trivial/2014-04/msg00073.html

Based-on-patch-by: Baojun Wang <wangbj@gmail.com>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
---

Hello,

I'm using pmemload to manipulate physical memory in Qemu with
this patch; the existing pmemsave can be used to dump the
physical memory.

I've only used pmemload from qemu's monitor and not via qapi.
This part was taken unchanged from the original patch.

Regards
Simon

 cpus.c           | 30 ++++++++++++++++++++++++++++++
 hmp-commands.hx  | 14 ++++++++++++++
 hmp.c            | 11 +++++++++++
 hmp.h            |  1 +
 qapi-schema.json | 18 ++++++++++++++++++
 5 files changed, 74 insertions(+)

diff --git a/cpus.c b/cpus.c
index 114c29b6a0..b2325dd7bb 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2039,6 +2039,36 @@ exit:
     fclose(f);
 }
 
+void qmp_pmemload(int64_t addr, int64_t size, const char *filename,
+                  Error **errp)
+{
+    FILE *f;
+    size_t l;
+    uint8_t buf[1024];
+
+    f = fopen(filename, "rb");
+    if (!f) {
+        error_setg_file_open(errp, errno, filename);
+        return;
+    }
+
+    while (size != 0) {
+        l = sizeof(buf);
+        if (l > size)
+            l = size;
+        if (fread(buf, 1, l, f) != l) {
+            error_setg(errp, QERR_IO_ERROR);
+            goto exit;
+        }
+        cpu_physical_memory_write(addr, buf, l);
+        addr += l;
+        size -= l;
+    }
+
+exit:
+    fclose(f);
+}
+
 void qmp_inject_nmi(Error **errp)
 {
     nmi_monitor_handle(monitor_get_cpu_index(), errp);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 4afd57cf5f..cc1956252e 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -853,6 +853,20 @@ STEXI
 @item pmemsave @var{addr} @var{size} @var{file}
 @findex pmemsave
 save to disk physical memory dump starting at @var{addr} of size @var{size}.
+ETEXI
+
+    {
+        .name       = "pmemload",
+        .args_type  = "val:l,size:i,filename:s",
+        .params     = "addr size file",
+        .help       = "load from disk physical memory dump starting at 'addr' of size 'size'",
+        .cmd        = hmp_pmemload,
+    },
+
+STEXI
+@item pmemload @var{addr} @var{size} @var{file}
+@findex pmemload
+load from disk physical memory dump starting at @var{addr} of size @var{size}.
 ETEXI
 
     {
diff --git a/hmp.c b/hmp.c
index 35a7041824..bec5eac621 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1107,6 +1107,17 @@ void hmp_pmemsave(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+void hmp_pmemload(Monitor *mon, const QDict *qdict)
+{
+    uint32_t size = qdict_get_int(qdict, "size");
+    const char *filename = qdict_get_str(qdict, "filename");
+    uint64_t addr = qdict_get_int(qdict, "val");
+    Error *err = NULL;
+
+    qmp_pmemload(addr, size, filename, &err);
+    hmp_handle_error(mon, &err);
+}
+
 void hmp_ringbuf_write(Monitor *mon, const QDict *qdict)
 {
     const char *chardev = qdict_get_str(qdict, "device");
diff --git a/hmp.h b/hmp.h
index a6f56b1f29..b433d919e9 100644
--- a/hmp.h
+++ b/hmp.h
@@ -49,6 +49,7 @@ void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
 void hmp_cpu(Monitor *mon, const QDict *qdict);
 void hmp_memsave(Monitor *mon, const QDict *qdict);
 void hmp_pmemsave(Monitor *mon, const QDict *qdict);
+void hmp_pmemload(Monitor *mon, const QDict *qdict);
 void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
 void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
 void hmp_cont(Monitor *mon, const QDict *qdict);
diff --git a/qapi-schema.json b/qapi-schema.json
index 18457954a8..a013d590c5 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1136,6 +1136,24 @@
 { 'command': 'pmemsave',
   'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
 
+##
+# @pmemload:
+#
+# Load a portion of guest physical memory from a file.
+#
+# @val: the physical address of the guest to start from
+#
+# @size: the size of memory region to load
+#
+# @filename: the file to load the memory from as binary data
+#
+# Returns: Nothing on success
+#
+# Since: 2.10
+##
+{ 'command': 'pmemload',
+  'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
+
 ##
 # @cont:
 #
-- 
2.15.0

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
