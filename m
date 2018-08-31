Received: from eggs.gnu.org ([2001:4830:134:3::10]:40765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvmOO-0000zb-Kk
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvmOI-00059n-H1
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:35:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvmOG-000524-5k
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 12:35:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7VGYCqY185263
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 16:35:13 GMT
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp2120.oracle.com with ESMTP id 2m2y2q4ewk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 16:35:13 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7VGZCpL020268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 16:35:12 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7VGZCj1016221
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 16:35:12 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 31 Aug 2018 17:36:49 +0100
Message-Id: <1535733414-6812-4-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535733414-6812-1-git-send-email-Liam.Merwick@oracle.com>
References: <1535733414-6812-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 3/8] block: Null pointer dereference in
 blk_root_get_parent_desc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The dev_id returned by the call to blk_get_attached_dev_id() in
blk_root_get_parent_desc() can be NULL (an internal call to
object_get_canonical_path may have returned NULL) so it should
be checked before dereferencing.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
---
 block/block-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index fa120630be83..210eee75006a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -136,7 +136,7 @@ static char *blk_root_get_parent_desc(BdrvChild *child)
     }
 
     dev_id = blk_get_attached_dev_id(blk);
-    if (*dev_id) {
+    if (dev_id && *dev_id) {
         return dev_id;
     } else {
         /* TODO Callback into the BB owner for something more detailed */
-- 
1.8.3.1
