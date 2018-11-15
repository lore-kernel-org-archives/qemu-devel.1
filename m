Received: from eggs.gnu.org ([2001:4830:134:3::10]:41759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNHbi-0003Ca-Ej
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:22:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNHbd-0006y9-Md
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:22:54 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:51727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1gNHbb-0006tV-QA
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:22:49 -0500
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 15 Nov 2018 14:22:39 +0100
Message-Id: <4e25c4e14e76cee9a1b0d062f2623426e2a0e0bb.1542287931.git.simon@ruderich.org>
In-Reply-To: <cover.1542287931.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1542287931.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 6/7] qmp: add pmemload command
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

Adapted patch from Baojun Wang [1] with the following commit message:

    I found this could be useful to have qemu-softmmu as a cross
    debugger (launch with -s -S command line option), then if we can
    have a command to load guest physical memory, we can use cross gdb
    to do some target debug which gdb cannot do directly.

This patch contains only the qmp changes of the original patch.

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
 cpus.c         | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json | 20 ++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/cpus.c b/cpus.c
index ee54595733..a12076dc68 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2445,6 +2445,57 @@ exit:
     qemu_close(fd);
 }
 
+void qmp_pmemload(int64_t addr, const char *filename,
+                  bool has_size, int64_t size,
+                  bool has_offset, int64_t offset,
+                  Error **errp)
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
+    if (has_offset && offset > 0) {
+        if (lseek(fd, offset, SEEK_SET) != offset) {
+            error_setg_errno(errp, errno,
+                             "could not seek to offset %" PRIx64, offset);
+            goto exit;
+        }
+    }
+    if (!has_size) {
+        struct stat s;
+        if (fstat(fd, &s)) {
+            error_setg_errno(errp, errno, "could not fstat fd to get size");
+            goto exit;
+        }
+        size = s.st_size;
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
diff --git a/qapi/misc.json b/qapi/misc.json
index 6c1c5c0a37..6eb9d29339 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1186,6 +1186,26 @@
 { 'command': 'pmemsave',
   'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
 
+##
+# @pmemload:
+#
+# Load a portion of guest physical memory from a file.
+#
+# @val: the physical address of the guest to start from
+#
+# @filename: the file to load the memory from as binary data
+#
+# @size: the size of memory region to load (defaults to whole file)
+#
+# @offset: the offset in the file to start from (defaults to 0)
+#
+# Returns: Nothing on success
+#
+# Since: 3.1
+##
+{ 'command': 'pmemload',
+  'data': {'val': 'int', 'filename': 'str', '*size': 'int', '*offset': 'int'} }
+
 ##
 # @cont:
 #
-- 
2.19.1
