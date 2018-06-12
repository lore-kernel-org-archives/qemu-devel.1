Received: from eggs.gnu.org ([2001:4830:134:3::10]:50200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisY-0007FV-V2
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisW-00039p-D6
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:30 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 12 Jun 2018 14:58:05 +0200
Message-Id: <20180612125821.4229-3-armbru@redhat.com>
In-Reply-To: <20180612125821.4229-1-armbru@redhat.com>
References: <20180612125821.4229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 02/18] iscsi: Drop deprecated -drive parameter
 "filename"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

Parameter "filename" is deprecated since commit 5c3ad1a6a8f, v2.10.0.
Time to get rid of it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/iscsi.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index c2fbd8a8aa..7e3ea72bd2 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1713,10 +1713,6 @@ static QemuOptsList runtime_opts = {
             .name = "timeout",
             .type = QEMU_OPT_NUMBER,
         },
-        {
-            .name = "filename",
-            .type = QEMU_OPT_STRING,
-        },
         { /* end of list */ }
     },
 };
@@ -1756,27 +1752,12 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     char *initiator_name = NULL;
     QemuOpts *opts;
     Error *local_err = NULL;
-    const char *transport_name, *portal, *target, *filename;
+    const char *transport_name, *portal, *target;
 #if LIBISCSI_API_VERSION >= (20160603)
     enum iscsi_transport_type transport;
 #endif
     int i, ret = 0, timeout = 0, lun;
 
-    /* If we are given a filename, parse the filename, with precedence given to
-     * filename encoded options */
-    filename = qdict_get_try_str(options, "filename");
-    if (filename) {
-        warn_report("'filename' option specified. "
-                    "This is an unsupported option, and may be deprecated "
-                    "in the future");
-        iscsi_parse_filename(filename, options, &local_err);
-        if (local_err) {
-            ret = -EINVAL;
-            error_propagate(errp, local_err);
-            goto exit;
-        }
-    }
-
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
@@ -2006,7 +1987,7 @@ out:
         }
         memset(iscsilun, 0, sizeof(IscsiLun));
     }
-exit:
+
     return ret;
 }
 
-- 
2.17.1
