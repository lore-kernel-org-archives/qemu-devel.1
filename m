Received: from eggs.gnu.org ([2001:4830:134:3::10]:41417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qu-0001tx-De
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qn-00055t-NR
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39889
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qn-00055N-HV
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8aUr119496
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:41 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29ajfe8ntf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:40 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:40 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:18 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-55-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 54/81] block/iscsi: avoid data corruption with
 cache=writeback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>

From: Peter Lieven <pl@kamp.de>

nb_cls_shrunk in iscsi_allocmap_update can become -1 if the
request starts and ends within the same cluster. This results
in passing -1 to bitmap_set and bitmap_clear and they don't
handle negative values properly. In the end this leads to data
corruption.

Fixes: e1123a3b40a1a9a625a29c8ed4debb7e206ea690
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Message-Id: <1484579832-18589-1-git-send-email-pl@kamp.de>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 1da45e0c4cf4719fa75898d019e0874b9b2bc774)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/iscsi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 0960929..a1ac8d9 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -498,14 +498,18 @@ iscsi_allocmap_update(IscsiLun *iscsilun, int64_t sector_num,
     if (allocated) {
         bitmap_set(iscsilun->allocmap, cl_num_expanded, nb_cls_expanded);
     } else {
-        bitmap_clear(iscsilun->allocmap, cl_num_shrunk, nb_cls_shrunk);
+        if (nb_cls_shrunk > 0) {
+            bitmap_clear(iscsilun->allocmap, cl_num_shrunk, nb_cls_shrunk);
+        }
     }
 
     if (iscsilun->allocmap_valid == NULL) {
         return;
     }
     if (valid) {
-        bitmap_set(iscsilun->allocmap_valid, cl_num_shrunk, nb_cls_shrunk);
+        if (nb_cls_shrunk > 0) {
+            bitmap_set(iscsilun->allocmap_valid, cl_num_shrunk, nb_cls_shrunk);
+        }
     } else {
         bitmap_clear(iscsilun->allocmap_valid, cl_num_expanded,
                      nb_cls_expanded);
-- 
2.7.4
