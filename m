Received: from eggs.gnu.org ([2001:4830:134:3::10]:50065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvnwG-0007EM-Lu
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvnwD-0005uF-W8
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvnwD-0005tn-NO
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7VIDih4094124
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:28 GMT
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by aserp2120.oracle.com with ESMTP id 2m2y2q4vjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:28 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7VIESd4019484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:28 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7VIESLU007759
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:28 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 31 Aug 2018 19:16:08 +0100
Message-Id: <1535739372-24454-5-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v3 4/8] qemu-img: potential Null pointer deref
 in img_commit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The function block_job_get() may return NULL so before dereferencing
the 'job' pointer in img_commit() it should be checked.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
---
 qemu-img.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index b12f4cd19b0a..51fe09bd08ed 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1029,6 +1029,9 @@ static int img_commit(int argc, char **argv)
     }
 
     job = block_job_get("commit");
+    if (job == NULL) {
+        goto unref_backing;
+    }
     run_block_job(job, &local_err);
     if (local_err) {
         goto unref_backing;
-- 
1.8.3.1
