Received: from eggs.gnu.org ([2001:4830:134:3::10]:56833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTMB-000677-6V
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCTM8-0000DR-Uh
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCTM8-0000BC-H6
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:42:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2818CD162
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 715B96249E
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:42:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Oct 2018 19:41:57 +0200
Message-Id: <20181016174158.15229-38-armbru@redhat.com>
In-Reply-To: <20181016174158.15229-1-armbru@redhat.com>
References: <20181016174158.15229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 37/38] raw: Convert a warning to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/raw-format.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/raw-format.c b/block/raw-format.c
index 6f6dc99b2c..d65fd0ffce 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -29,6 +29,7 @@
 #include "qemu/osdep.h"
 #include "block/block_int.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/option.h"
 
 typedef struct BDRVRawState {
@@ -436,14 +437,14 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
             bs->file->bs->supported_zero_flags);
 
     if (bs->probed && !bdrv_is_read_only(bs)) {
-        fprintf(stderr,
-                "WARNING: Image format was not specified for '%s' and probing "
-                "guessed raw.\n"
-                "         Automatically detecting the format is dangerous for "
-                "raw images, write operations on block 0 will be restricted.\n"
-                "         Specify the 'raw' format explicitly to remove the "
-                "restrictions.\n",
-                bs->file->bs->filename);
+        warn_report("Image format was not specified for '%s' and probing "
+                    "guessed raw",
+                    bs->file->bs->filename);
+        error_printf("Automatically detecting the format is dangerous for "
+                     "raw images, write\n"
+                     "operations on block 0 will be restricted.\n"
+                     "Specify the 'raw' format explicitly to remove the "
+                     "restrictions.\n");
     }
 
     ret = raw_read_options(options, bs, s, errp);
-- 
2.17.1
