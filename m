Received: from eggs.gnu.org ([2001:4830:134:3::10]:49103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dufP5-0006Wb-9B
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dufP2-0004GR-7U
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:51:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dufP1-0004GB-Vd
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:51:00 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KDol22059526
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:50:58 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3r0pf813-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:50:58 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 20 Sep 2017 14:50:56 +0100
From: Greg Kurz <groug@kaod.org>
Date: Wed, 20 Sep 2017 15:50:37 +0200
In-Reply-To: <20170920135038.21058-1-groug@kaod.org>
References: <20170920135038.21058-1-groug@kaod.org>
Message-Id: <20170920135038.21058-3-groug@kaod.org>
Subject: [Qemu-devel] [PULL 2/3] 9pfs: fix name_to_path assertion in
 v9fs_complete_rename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Jan Dakinevich <jan.dakinevich@gmail.com>

From: Jan Dakinevich <jan.dakinevich@gmail.com>

The third parameter of v9fs_co_name_to_path() must not contain `/'
character.

The issue is most likely related to 9p2000.u protocol only.

Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
[groug, regression caused by commit f57f5878578a # 2.10]
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 1078cfdaa4af..cdd44bdc82ef 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2553,13 +2553,11 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
                                              int32_t newdirfid,
                                              V9fsString *name)
 {
-    char *end;
     int err = 0;
     V9fsPath new_path;
     V9fsFidState *tfidp;
     V9fsState *s = pdu->s;
     V9fsFidState *dirfidp = NULL;
-    char *old_name, *new_name;
 
     v9fs_path_init(&new_path);
     if (newdirfid != -1) {
@@ -2577,18 +2575,15 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
             goto out;
         }
     } else {
-        old_name = fidp->path.data;
-        end = strrchr(old_name, '/');
-        if (end) {
-            end++;
-        } else {
-            end = old_name;
-        }
-        new_name = g_malloc0(end - old_name + name->size + 1);
-        strncat(new_name, old_name, end - old_name);
-        strncat(new_name + (end - old_name), name->data, name->size);
-        err = v9fs_co_name_to_path(pdu, NULL, new_name, &new_path);
-        g_free(new_name);
+        char *dir_name = g_path_get_dirname(fidp->path.data);
+        V9fsPath dir_path;
+
+        v9fs_path_init(&dir_path);
+        v9fs_path_sprintf(&dir_path, "%s", dir_name);
+        g_free(dir_name);
+
+        err = v9fs_co_name_to_path(pdu, &dir_path, name->data, &new_path);
+        v9fs_path_free(&dir_path);
         if (err < 0) {
             goto out;
         }
-- 
2.13.5
