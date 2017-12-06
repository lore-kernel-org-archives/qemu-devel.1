Received: from eggs.gnu.org ([2001:4830:134:3::10]:50050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCm-000144-H2
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCj-000168-AX
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36806
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCj-00015V-41
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:18:01 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE903036945
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:18:00 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epne8b8y7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:18:00 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:59 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:44 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-52-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 51/55] nbd/server: fix nbd_negotiate_handle_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

namelen should be here, length is unrelated, and always 0 at this
point.  Broken in introduction in commit f37708f6, but mostly
harmless (replying with '' as the name does not violate protocol,
and does not confuse qemu as the nbd client since our implementation
does not ask for the name; but might confuse some other client that
does ask for the name especially if the default export is different
than the export name being queried).

Adding an assert makes it obvious that we are not skipping any bytes
in the client's message, as well as making it obvious that we were
using the wrong variable.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: qemu-stable@nongnu.org
Message-Id: <20171101154204.27146-1-vsementsov@virtuozzo.com>
[eblake: improve commit message, squash in assert addition]
Signed-off-by: Eric Blake <eblake@redhat.com>

(cherry picked from commit 46321d6b5f8c880932a6b3d07bd0ff6f892e665c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 56aed3a735..5042cc4786 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -434,6 +434,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
             break;
         }
     }
+    assert(length == 0);
 
     exp = nbd_export_find(name);
     if (!exp) {
@@ -444,7 +445,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
 
     /* Don't bother sending NBD_INFO_NAME unless client requested it */
     if (sendname) {
-        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, length, name,
+        rc = nbd_negotiate_send_info(client, opt, NBD_INFO_NAME, namelen, name,
                                      errp);
         if (rc < 0) {
             return rc;
-- 
2.11.0
