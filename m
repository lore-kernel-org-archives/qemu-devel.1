Received: from eggs.gnu.org ([2001:4830:134:3::10]:49018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f6bgZ-0004A8-0w
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f6bgW-0005mo-Cg
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:50:43 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:36909)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1f6bgW-0005li-6I
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:50:40 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 12 Apr 2018 14:50:38 +0200
Message-Id: <6f775e11a75a2faa1c66a86e6d23a97f695c2ca1.1523537181.git.simon@ruderich.org>
In-Reply-To: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
References: <20180412124834.GA2025@ruderich.org>
	<68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
In-Reply-To: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
References: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v2 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Simon Ruderich <simon@ruderich.org>

Adapted patch from Baojun Wang [1] with the following commit message:

    I found this could be useful to have qemu-softmmu as a cross
    debugger (launch with -s -S command line option), then if we can
    have a command to load guest physical memory, we can use cross gdb
    to do some target debug which gdb cannot do directly.

pmemload is necessary to directly write physical memory which is not
possible with gdb alone as it uses only logical addresses.

The QAPI for pmemload uses "val" as parameter name for the physical
address. This name is not very descriptive but is consistent with the
existing pmemsave. Changing the parameter name of pmemsave is not
possible without breaking the existing API.

[1]: https://lists.gnu.org/archive/html/qemu-trivial/2014-04/msg00074.html

Based-on-patch-by: Baojun Wang <wangbj@gmail.com>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 cpus.c          | 41 +++++++++++++++++++++++++++++++++++++++++
 hmp-commands.hx | 14 ++++++++++++++
 hmp.c           | 12 ++++++++++++
 hmp.h           |  1 +
 qapi/misc.json  | 20 ++++++++++++++++++++
 5 files changed, 88 insertions(+)

diff --git a/cpus.c b/cpus.c
index d256d8e9b4..c690dc205f 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2314,6 +2314,47 @@ exit:
     qemu_close(fd);
 }
 
+void qmp_pmemload(int64_t addr, int64_t size, int64_t offset,
+                  const char *filename, Error **errp)
+{
+    int fd;
+    size_t l;
+    ssize_t r;
+    uint8_t buf[1024];
+
+    fd = qemu_open(filename, O_RDONLY | O_BINARY);
+    if (fd < 0) {
+        error_setg_file_open(errp, errno, filename);
+        return;
+    }
+    if (offset > 0) {
+        if (lseek(fd, offset, SEEK_SET) != offset) {
+            error_setg_errno(errp, errno,
+                             "could not seek to offset %" PRIx64, offset);
+            goto exit;
+        }
+    }
+
+    while (size != 0) {
+        l = sizeof(buf);
+        if (l > size) {
+            l = size;
+        }
+        r = read(fd, buf, l);
+        if (r <= 0) {
+            error_setg(errp, QERR_IO_ERROR);
+            goto exit;
+        }
+        l = r; /* in case of short read */
+        cpu_physical_memory_write(addr, buf, l);
+        addr += l;
+        size -= l;
+    }
+
+exit:
+    qemu_close(fd);
+}
+
 void qmp_inject_nmi(Error **errp)
 {
     nmi_monitor_handle(monitor_get_cpu_index(), errp);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 35d862a5d2..a392d0e379 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -822,6 +822,20 @@ STEXI
 @item pmemsave @var{addr} @var{size} @var{file}
 @findex pmemsave
 save to disk physical memory dump starting at @var{addr} of size @var{size}.
+ETEXI
+
+    {
+        .name       = "pmemload",
+        .args_type  = "val:l,size:i,offset:i,filename:s",
+        .params     = "addr size offset file",
+        .help       = "load from disk physical memory dump starting at 'addr' of size 'size' at file offset 'offset'",
+        .cmd        = hmp_pmemload,
+    },
+
+STEXI
+@item pmemload @var{addr} @var{size} @var{offset} @var{file}
+@findex pmemload
+load from disk physical memory dump starting at @var{addr} of size @var{size} at file offset @var{offset}.
 ETEXI
 
     {
diff --git a/hmp.c b/hmp.c
index 1e392055f7..c9b37dbfbd 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1090,6 +1090,18 @@ void hmp_pmemsave(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+void hmp_pmemload(Monitor *mon, const QDict *qdict)
+{
+    uint64_t size = qdict_get_int(qdict, "size");
+    uint64_t offset = qdict_get_int(qdict, "offset");
+    const char *filename = qdict_get_str(qdict, "filename");
+    uint64_t addr = qdict_get_int(qdict, "val");
+    Error *err = NULL;
+
+    qmp_pmemload(addr, size, offset, filename, &err);
+    hmp_handle_error(mon, &err);
+}
+
 void hmp_ringbuf_write(Monitor *mon, const QDict *qdict)
 {
     const char *chardev = qdict_get_str(qdict, "device");
diff --git a/hmp.h b/hmp.h
index 4e2ec375b0..0a69e371ca 100644
--- a/hmp.h
+++ b/hmp.h
@@ -47,6 +47,7 @@ void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
 void hmp_cpu(Monitor *mon, const QDict *qdict);
 void hmp_memsave(Monitor *mon, const QDict *qdict);
 void hmp_pmemsave(Monitor *mon, const QDict *qdict);
+void hmp_pmemload(Monitor *mon, const QDict *qdict);
 void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
 void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
 void hmp_cont(Monitor *mon, const QDict *qdict);
diff --git a/qapi/misc.json b/qapi/misc.json
index 5636f4a149..2255d219fa 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1185,6 +1185,26 @@
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
+# @offset: the offset in the file to start from
+#
+# @filename: the file to load the memory from as binary data
+#
+# Returns: Nothing on success
+#
+# Since: 2.13
+##
+{ 'command': 'pmemload',
+  'data': {'val': 'int', 'size': 'int', 'offset': 'int', 'filename': 'str'} }
+
 ##
 # @cont:
 #
-- 
2.15.0
