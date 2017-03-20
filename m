Received: from eggs.gnu.org ([2001:4830:134:3::10]:41558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qy-0001zS-3Q
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qq-00059N-NL
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47232
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qq-00058Z-F4
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Vkg084319
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:43 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29amb2abaa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:43 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:43 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:25 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-62-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 61/81] block/nfs: fix NULL pointer dereference
 in URI parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>

From: Peter Lieven <pl@kamp.de>

parse_uint_full wants to put the parsed value into the
variable passed via its second argument which is NULL.

Fixes: 94d6a7a76e9df9919629428f6c598e2b97d9426c
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 1485942829-10756-2-git-send-email-pl@kamp.de
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 8d20abe87afa735cd0ae6688bd105c7a27390343)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/nfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/nfs.c b/block/nfs.c
index a490660..dd376db 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -108,12 +108,13 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
     qdict_put(options, "path", qstring_from_str(uri->path));
 
     for (i = 0; i < qp->n; i++) {
+        unsigned long long val;
         if (!qp->p[i].value) {
             error_setg(errp, "Value for NFS parameter expected: %s",
                        qp->p[i].name);
             goto out;
         }
-        if (parse_uint_full(qp->p[i].value, NULL, 0)) {
+        if (parse_uint_full(qp->p[i].value, &val, 0)) {
             error_setg(errp, "Illegal value for NFS parameter: %s",
                        qp->p[i].name);
             goto out;
-- 
2.7.4
