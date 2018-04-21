Received: from eggs.gnu.org ([2001:4830:134:3::10]:45245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9vme-0007xE-8U
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 12:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9vmd-0003CL-D4
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 12:54:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 21 Apr 2018 18:54:21 +0200
Message-Id: <20180421165423.30759-6-mreitz@redhat.com>
In-Reply-To: <20180421165423.30759-1-mreitz@redhat.com>
References: <20180421165423.30759-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 5/7] qemu-img: Recognize no creation support in
 -o help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The only users of print_block_option_help() are qemu-img create and
qemu-img convert for the output image, so this function is always used
for image creation (it used to be used for amendment also, but that is
no longer the case).

So if image creation is not supported by either the format or the
protocol, there is no need to print any option description, because the
user cannot create an image like this anyway.

This also fixes an assertion failure:

    $ qemu-img create -f bochs -o help
    Supported options:
    qemu-img: util/qemu-option.c:219:
    qemu_opts_print_help: Assertion `list' failed.
    [1]    24831 abort (core dumped)  qemu-img create -f bochs -o help

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 45e243cc80..29efd80c35 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -250,6 +250,11 @@ static int print_block_option_help(const char *filename, const char *fmt)
         return 1;
     }
 
+    if (!drv->create_opts) {
+        error_report("Format driver '%s' does not support image creation", fmt);
+        return 1;
+    }
+
     create_opts = qemu_opts_append(create_opts, drv->create_opts);
     if (filename) {
         proto_drv = bdrv_find_protocol(filename, true, &local_err);
@@ -258,6 +263,11 @@ static int print_block_option_help(const char *filename, const char *fmt)
             qemu_opts_free(create_opts);
             return 1;
         }
+        if (!proto_drv->create_opts) {
+            error_report("Protocal driver '%s' does not support image creation",
+                         proto_drv->format_name);
+            return 1;
+        }
         create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
     }
 
-- 
2.14.3
