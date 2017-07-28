Received: from eggs.gnu.org ([2001:4830:134:3::10]:42915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db5iH-0002OM-Su
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1db5iD-0000u0-4w
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:53:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1db5iC-0000t4-UC
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:53:53 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 28 Jul 2017 15:45:51 +0200
Message-Id: <1501249552-788-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1501249552-788-1-git-send-email-armbru@redhat.com>
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] COLO: Define COLOMode without QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>

COLOMode is defined in the QAPI schema, but not used there.  Of the
stuff QAPI generates for it only the typedef is actually used.  Use of
QAPI is pointless and only complicates things, so don't.

Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/migration/colo.h |  6 ++++++
 qapi-schema.json         | 16 ----------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index ff9874e..5d7c500 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -26,6 +26,12 @@ void migration_incoming_exit_colo(void);
 void *colo_process_incoming_thread(void *opaque);
 bool migration_incoming_in_colo_state(void);
 
+typedef enum {
+    COLO_MODE_UNKNOWN,
+    COLO_MODE_PRIMARY,
+    COLO_MODE_SECONDARY,
+} COLOMode;
+
 COLOMode get_colo_mode(void);
 
 /* failover */
diff --git a/qapi-schema.json b/qapi-schema.json
index 9b6f6cb..3f0eb05 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1304,22 +1304,6 @@
             'vmstate-loaded' ] }
 
 ##
-# @COLOMode:
-#
-# The colo mode
-#
-# @unknown: unknown mode
-#
-# @primary: master side
-#
-# @secondary: slave side
-#
-# Since: 2.8
-##
-{ 'enum': 'COLOMode',
-  'data': [ 'unknown', 'primary', 'secondary'] }
-
-##
 # @FailoverStatus:
 #
 # An enumeration of COLO failover status
-- 
2.7.5
