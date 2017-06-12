Received: from eggs.gnu.org ([2001:4830:134:3::10]:59600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dKQpP-00054j-4y
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dKQpO-00038C-7s
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 11:00:27 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 12 Jun 2017 11:00:17 -0400
Message-Id: <06e5d41f597b506e2550c86745db3690daf35928.1497279406.git.jcody@redhat.com>
In-Reply-To: <cover.1497279406.git.jcody@redhat.com>
References: <cover.1497279406.git.jcody@redhat.com>
In-Reply-To: <cover.1497279406.git.jcody@redhat.com>
References: <cover.1497279406.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] block/iscsi: enable filename option and
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, rjones@redhat.com

When enabling option parsing and blockdev-add for iscsi, we removed the
'filename' option.  Unfortunately, this was a bit optimistic, as
previous versions of QEMU allowed the use of the option in backing
filenames via json.  This means that without parsing this option, we
cannot open existing images that used to work fine.

See bug: https://bugzilla.redhat.com/show_bug.cgi?id=1457088

Tested-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/iscsi.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 5daa201..ba50e76 100644
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
@@ -1747,12 +1751,24 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -1967,6 +1983,7 @@ out:
         }
         memset(iscsilun, 0, sizeof(IscsiLun));
     }
+exit:
     return ret;
 }
 
-- 
2.9.3
