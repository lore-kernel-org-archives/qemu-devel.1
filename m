Received: from eggs.gnu.org ([2001:4830:134:3::10]:46328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cvR5p-0006cz-Se
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cvR5n-0005l7-6y
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:14:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cvR5m-0005kE-TF
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 12:14:03 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v34G99rm018795
	for <qemu-devel@nongnu.org>; Tue, 4 Apr 2017 12:14:01 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29m0j52w9u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 12:14:01 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 4 Apr 2017 17:13:59 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue,  4 Apr 2017 18:13:30 +0200
In-Reply-To: <1491322410-24532-1-git-send-email-groug@kaod.org>
References: <1491322410-24532-1-git-send-email-groug@kaod.org>
Message-Id: <1491322410-24532-3-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 2/2] 9pfs: clear migration blocker at session
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

The migration blocker survives a device reset: if the guest mounts a 9p
share and then gets rebooted with system_reset, it will be unmigratable
until it remounts and umounts the 9p share again.

This happens because the migration blocker is supposed to be cleared when
we put the last reference on the root fid, but virtfs_reset() wrongly calls
free_fid() instead of put_fid().

This patch fixes virtfs_reset() so that it honor the way fids are supposed
to be manipulated: first get a reference and later put it back when you're
done.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/9pfs/9p.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index ef47a0a5ad6f..c80ba67389ce 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -539,14 +539,15 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
 
     /* Free all fids */
     while (s->fid_list) {
+        /* Get fid */
         fidp = s->fid_list;
+        fidp->ref++;
+
+        /* Clunk fid */
         s->fid_list = fidp->next;
+        fidp->clunked = 1;
 
-        if (fidp->ref) {
-            fidp->clunked = 1;
-        } else {
-            free_fid(pdu, fidp);
-        }
+        put_fid(pdu, fidp);
     }
 }
 
-- 
2.7.4
