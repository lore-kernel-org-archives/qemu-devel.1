Received: from eggs.gnu.org ([2001:4830:134:3::10]:50332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dLGGH-0008Nc-1F
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 17:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dLGGG-0004mx-5y
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 17:55:37 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 14 Jun 2017 17:55:26 -0400
Message-Id: <20170614215526.9218-3-jcody@redhat.com>
In-Reply-To: <20170614215526.9218-1-jcody@redhat.com>
References: <20170614215526.9218-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] block/iscsi: enable filename option and
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

When enabling option parsing and blockdev-add for iscsi, we removed the
'filename' option.  Unfortunately, this was a bit optimistic, as
previous versions of QEMU allowed the use of the option in backing
filenames via json.  This means that without parsing this option, we
cannot open existing images that used to work fine.

See bug: https://bugzilla.redhat.com/show_bug.cgi?id=1457088

Tested-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
Message-id: 0789ab6c32814ab4b6896707d378804bd4424c65.1497444637.git.jcody@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/iscsi.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 5daa201..b5f7a22 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1732,6 +1732,10 @@ static QemuOptsList runtime_opts = {
             .name = "timeout",
             .type = QEMU_OPT_NUMBER,
         },
+        {
+            .name = "filename",
+            .type = QEMU_OPT_STRING,
+        },
         { /* end of list */ }
     },
 };
@@ -1747,12 +1751,27 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     char *initiator_name = NULL;
     QemuOpts *opts;
     Error *local_err = NULL;
-    const char *transport_name, *portal, *target;
+    const char *transport_name, *portal, *target, *filename;
 #if LIBISCSI_API_VERSION >= (20160603)
     enum iscsi_transport_type transport;
 #endif
     int i, ret = 0, timeout = 0, lun;
 
+    /* If we are given a filename, parse the filename, with precedence given to
+     * filename encoded options */
+    filename = qdict_get_try_str(options, "filename");
+    if (filename) {
+        error_report("Warning: 'filename' option specified. "
+                      "This is an unsupported option, and may be deprecated "
+                      "in the future");
+        iscsi_parse_filename(filename, options, &local_err);
+        if (local_err) {
+            ret = -EINVAL;
+            error_propagate(errp, local_err);
+            goto exit;
+        }
+    }
+
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
@@ -1967,6 +1986,7 @@ out:
         }
         memset(iscsilun, 0, sizeof(IscsiLun));
     }
+exit:
     return ret;
 }
 
-- 
2.9.3
