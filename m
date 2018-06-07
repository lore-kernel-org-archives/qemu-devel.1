Received: from eggs.gnu.org ([2001:4830:134:3::10]:51759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQoNC-0000oR-Rd
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 02:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQoN7-0002oL-EO
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 02:26:14 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Jun 2018 08:25:41 +0200
Message-Id: <20180607062559.16127-2-armbru@redhat.com>
In-Reply-To: <20180607062559.16127-1-armbru@redhat.com>
References: <20180607062559.16127-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 01/19] rbd: Drop deprecated -drive
 parameter "filename"
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

Parameter "filename" is deprecated since commit 91589d9e5ca, v2.10.0.
Time to get rid of it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/rbd.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index a16431e267..40c6e4185f 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -632,25 +632,9 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     QObject *crumpled = NULL;
     const QDictEntry *e;
     Error *local_err = NULL;
-    const char *filename;
     char *keypairs, *secretid;
     int r;
 
-    /* If we are given a filename, parse the filename, with precedence given to
-     * filename encoded options */
-    filename = qdict_get_try_str(options, "filename");
-    if (filename) {
-        warn_report("'filename' option specified. "
-                    "This is an unsupported option, and may be deprecated "
-                    "in the future");
-        qemu_rbd_parse_filename(filename, options, &local_err);
-        qdict_del(options, "filename");
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return -EINVAL;
-        }
-    }
-
     keypairs = g_strdup(qdict_get_try_str(options, "=keyvalue-pairs"));
     if (keypairs) {
         qdict_del(options, "=keyvalue-pairs");
-- 
2.17.1
