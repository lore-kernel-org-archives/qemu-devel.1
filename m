Received: from eggs.gnu.org ([2001:4830:134:3::10]:49105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dufP5-0006Wm-Ew
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dufP2-0004Ga-Cr
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:51:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43329
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dufP2-0004GH-75
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:51:00 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KDn9NB071904
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:50:59 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d3nqrgdf3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:50:59 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 20 Sep 2017 14:50:57 +0100
From: Greg Kurz <groug@kaod.org>
Date: Wed, 20 Sep 2017 15:50:38 +0200
In-Reply-To: <20170920135038.21058-1-groug@kaod.org>
References: <20170920135038.21058-1-groug@kaod.org>
Message-Id: <20170920135038.21058-4-groug@kaod.org>
Subject: [Qemu-devel] [PULL 3/3] 9pfs: check the size of transport buffer
 before marshaling
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

v9fs_do_readdir_with_stat() should check for a maximum buffer size
before an attempt to marshal gathered data. Otherwise, buffers assumed
as misconfigured and the transport would be broken.

The patch brings v9fs_do_readdir_with_stat() in conformity with
v9fs_do_readdir() behavior.

Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
[groug, regression caused my commit 8d37de41cab1 # 2.10]
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index cdd44bdc82ef..23ac7bb532f0 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1748,17 +1748,26 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         if (err < 0) {
             break;
         }
+        if ((count + v9stat.size + 2) > max_count) {
+            v9fs_readdir_unlock(&fidp->fs.dir);
+
+            /* Ran out of buffer. Set dir back to old position and return */
+            v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
+            v9fs_stat_free(&v9stat);
+            v9fs_path_free(&path);
+            return count;
+        }
+
         /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
         len = pdu_marshal(pdu, 11 + count, "S", &v9stat);
 
         v9fs_readdir_unlock(&fidp->fs.dir);
 
-        if ((len != (v9stat.size + 2)) || ((count + len) > max_count)) {
-            /* Ran out of buffer. Set dir back to old position and return */
+        if (len < 0) {
             v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
             v9fs_stat_free(&v9stat);
             v9fs_path_free(&path);
-            return count;
+            return len;
         }
         count += len;
         v9fs_stat_free(&v9stat);
-- 
2.13.5
