Received: from eggs.gnu.org ([2001:4830:134:3::10]:53877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvPCA-0006Y2-Tt
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvP8j-0005u3-87
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:45:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvP8g-0005lH-2y
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:45:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7UFdGs5000803
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:40 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp2130.oracle.com with ESMTP id 2m2xhu5j5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UFjX9i014489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:34 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UFjXkq007757
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:33 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Thu, 30 Aug 2018 16:47:09 +0100
Message-Id: <1535644031-848-7-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH 6/8] block: dump_qlist() may dereference a Null
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A NULL 'list' passed into function dump_qlist() isn't correctly
validated and can be passed to qlist_first() where it is dereferenced.

This could be resolved by checking if the list is NULL in dump_qlist()
and returning immediately. However, the general case can be handled by
adding a NULL arg check to to qlist_first() and qlist_next() and all
the callers to those functions handle that cleanly.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>	
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>

---
 include/qapi/qmp/qlist.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index 8d2c32ca2863..1ec716e2eb9e 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -58,11 +58,17 @@ void qlist_destroy_obj(QObject *obj);
 
 static inline const QListEntry *qlist_first(const QList *qlist)
 {
+    if (!qlist) {
+        return NULL;
+    }
     return QTAILQ_FIRST(&qlist->head);
 }
 
 static inline const QListEntry *qlist_next(const QListEntry *entry)
 {
+    if (!entry) {
+        return NULL;
+    }
     return QTAILQ_NEXT(entry, next);
 }
 
-- 
1.8.3.1
