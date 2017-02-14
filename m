Received: from eggs.gnu.org ([2001:4830:134:3::10]:38823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJQ-0005qs-9L
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJN-0003Nu-R3
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdaJN-0003NB-Ky
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:17 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D33EE4E028
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A0FB4ACB84
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 10:26:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:26:04 +0100
Message-Id: <1487067971-10443-18-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 17/24] util/cutils: Drop
 QEMU_STRTOSZ_DEFSUFFIX_* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Writing QEMU_STRTOSZ_DEFSUFFIX_* instead of '*' gains nothing.  Get
rid of these eyesores.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/cutils.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index ef658bb..4a290ea 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -178,30 +178,22 @@ int fcntl_setfl(int fd, int flag)
 }
 #endif
 
-#define QEMU_STRTOSZ_DEFSUFFIX_EB 'E'
-#define QEMU_STRTOSZ_DEFSUFFIX_PB 'P'
-#define QEMU_STRTOSZ_DEFSUFFIX_TB 'T'
-#define QEMU_STRTOSZ_DEFSUFFIX_GB 'G'
-#define QEMU_STRTOSZ_DEFSUFFIX_MB 'M'
-#define QEMU_STRTOSZ_DEFSUFFIX_KB 'K'
-#define QEMU_STRTOSZ_DEFSUFFIX_B 'B'
-
 static int64_t suffix_mul(char suffix, int64_t unit)
 {
     switch (qemu_toupper(suffix)) {
-    case QEMU_STRTOSZ_DEFSUFFIX_B:
+    case 'B':
         return 1;
-    case QEMU_STRTOSZ_DEFSUFFIX_KB:
+    case 'K':
         return unit;
-    case QEMU_STRTOSZ_DEFSUFFIX_MB:
+    case 'M':
         return unit * unit;
-    case QEMU_STRTOSZ_DEFSUFFIX_GB:
+    case 'G':
         return unit * unit * unit;
-    case QEMU_STRTOSZ_DEFSUFFIX_TB:
+    case 'T':
         return unit * unit * unit * unit;
-    case QEMU_STRTOSZ_DEFSUFFIX_PB:
+    case 'P':
         return unit * unit * unit * unit * unit;
-    case QEMU_STRTOSZ_DEFSUFFIX_EB:
+    case 'E':
         return unit * unit * unit * unit * unit * unit;
     }
     return -1;
@@ -258,17 +250,17 @@ fail:
 
 int64_t qemu_strtosz(const char *nptr, char **end)
 {
-    return do_strtosz(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_B, 1024);
+    return do_strtosz(nptr, end, 'B', 1024);
 }
 
 int64_t qemu_strtosz_mebi(const char *nptr, char **end)
 {
-    return do_strtosz(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_MB, 1024);
+    return do_strtosz(nptr, end, 'M', 1024);
 }
 
 int64_t qemu_strtosz_metric(const char *nptr, char **end)
 {
-    return do_strtosz(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_B, 1000);
+    return do_strtosz(nptr, end, 'B', 1000);
 }
 
 /**
-- 
2.7.4
