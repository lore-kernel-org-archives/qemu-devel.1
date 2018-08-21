Received: from eggs.gnu.org ([2001:4830:134:3::10]:42315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fs5vL-0003r0-OC
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fs5vF-0000Ni-E0
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:38:15 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:57479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fs5vF-0000IU-3R
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:38:09 -0400
Date: Tue, 21 Aug 2018 14:38:02 +0200
From: Simon Ruderich <simon@ruderich.org>
Message-ID: <96fa6847da651ffcaf57405b5e8f020ce5c09d6f.1534854457.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <abbc398b-0ded-5531-aba5-bd95200c937c@redhat.com>
Subject: [Qemu-devel] [PATCH v5 5/6] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, David Alan Gilbert <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

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

Hello,

I've adapted the patch to error out if a char/block device is
used. I think that's the simplest fix for the issue mentioned by
Eric Blake.

Are the any other issues remaining? All other patches are
unchanged, should I resend the whole series?

Regards
Simon

Diff of this patch since v4:

    diff --git a/cpus.c b/cpus.c
    index d79bf8b485..1622f00846 100644
    --- a/cpus.c
    +++ b/cpus.c
    @@ -2397,6 +2397,10 @@ void qmp_pmemload(int64_t addr, const char *filename,
                error_setg_errno(errp, errno, "could not fstat fd to get size");
                goto exit;
            }
    +        if (S_ISCHR(s.st_mode) || S_ISBLK(s.st_mode)) {
    +            error_setg(errp, "pmemload doesn't support char/block devices");
    +            goto exit;
    +        }
            size = s.st_size;
        }

 cpus.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json | 20 ++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/cpus.c b/cpus.c
index 243f2c0d2e..1622f00846 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2369,6 +2369,61 @@ exit:
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
+        if (S_ISCHR(s.st_mode) || S_ISBLK(s.st_mode)) {
+            error_setg(errp, "pmemload doesn't support char/block devices");
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
index d450cfef21..06cf36f3d4 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1181,6 +1181,26 @@
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
2.17.1

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
