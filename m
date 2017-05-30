Received: from eggs.gnu.org ([2001:4830:134:3::10]:50698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dFcRK-0006VB-6K
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dFcRH-0001Oy-V1
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dFcRH-0001Nn-PU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:23:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1DFAC83E
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:23:38 +0000 (UTC)
Received: from moe.brq.redhat.com (dhcp129-131.brq.redhat.com [10.34.129.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5702317151
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:23:38 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Tue, 30 May 2017 10:23:34 +0200
Message-Id: <dadb5dde09c4a6c41596782706e8b9f308aaccc1.1496132443.git.mprivozn@redhat.com>
In-Reply-To: <cover.1496132443.git.mprivozn@redhat.com>
References: <cover.1496132443.git.mprivozn@redhat.com>
In-Reply-To: <cover.1496132443.git.mprivozn@redhat.com>
References: <cover.1496132443.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qemu-bridge-helper: Reverse return value
 setting logic in parse_acl_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Just like in the previous commit, it's better to have just a
single point of exit from a function as we can have cleanup code
just once instead of copying it all over the place.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 qemu-bridge-helper.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index af6613ea18..a7f9bf06cc 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -65,6 +65,7 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
     FILE *f;
     char line[4096];
     ACLRule *acl_rule;
+    int ret = -1;
 
     f = fopen(filename, "r");
     if (f == NULL) {
@@ -92,9 +93,8 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
 
         if (arg == NULL) {
             fprintf(stderr, "Invalid config line:\n  %s\n", line);
-            fclose(f);
             errno = EINVAL;
-            return -1;
+            goto cleanup;
         }
 
         *arg = 0;
@@ -132,15 +132,16 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
             parse_acl_file(arg, acl_list);
         } else {
             fprintf(stderr, "Unknown command `%s'\n", cmd);
-            fclose(f);
             errno = EINVAL;
-            return -1;
+            goto cleanup;
         }
     }
 
-    fclose(f);
+    ret = 0;
 
-    return 0;
+ cleanup:
+    fclose(f);
+    return ret;
 }
 
 static bool has_vnet_hdr(int fd)
-- 
2.13.0
