Received: from eggs.gnu.org ([2001:4830:134:3::10]:53111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmS-0004dK-4v
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmM-0001ku-EJ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:48 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:50 +0200
Message-Id: <20180611142611.6609-9-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 08/29] qemu-img: Recognize no creation support
 in -o help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180509210023.20283-6-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 07935cb232..b1c1e484d2 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -249,6 +249,11 @@ static int print_block_option_help(const char *filename, const char *fmt)
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
@@ -257,6 +262,11 @@ static int print_block_option_help(const char *filename, const char *fmt)
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
2.17.1
