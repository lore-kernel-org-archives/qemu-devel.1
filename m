Received: from eggs.gnu.org ([2001:4830:134:3::10]:50101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvnwI-0007Gh-RK
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvnwG-0005vL-6d
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvnwF-0005uu-Sm
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7VIDeKE061907
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:31 GMT
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by userp2130.oracle.com with ESMTP id 2m2xhucv7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:31 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7VIEUbT025954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:30 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7VIEUWx007765
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:30 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 31 Aug 2018 19:16:10 +0100
Message-Id: <1535739372-24454-7-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v3 6/8] block: dump_qlist() may dereference a
 Null pointer
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

Given that dump_qlist() is static, and callers already do the right
thing, just add an assert to catch future potential bugs.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qapi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/qapi.c b/block/qapi.c
index c66f949db839..e81be604217c 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -740,6 +740,8 @@ static void dump_qlist(fprintf_function func_fprintf, void *f, int indentation,
     const QListEntry *entry;
     int i = 0;
 
+    assert(list);
+
     for (entry = qlist_first(list); entry; entry = qlist_next(entry), i++) {
         QType type = qobject_type(entry->value);
         bool composite = (type == QTYPE_QDICT || type == QTYPE_QLIST);
-- 
1.8.3.1
