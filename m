Received: from eggs.gnu.org ([2001:4830:134:3::10]:43110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCD-0004Al-1n
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC9-0001X2-C5
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKC9-0001W3-1G
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:49 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbh0130814
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:48 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdkvs77s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:47 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:47 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:43 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-50-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 49/67] slirp: Fix access to freed memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

if_start() goes through the slirp->if_fastq and slirp->if_batchq
list of pending messages, and accesses ifm->ifq_so->so_nqueued of its
elements if ifm->ifq_so != NULL.  When freeing a socket, we thus need
to make sure that any pending message for this socket does not refer
to the socket any more.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Tested-by: Brian Candler <b.candler@pobox.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit ea64d5f08817b5e79e17135dce516c7583107f91)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 slirp/socket.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/slirp/socket.c b/slirp/socket.c
index 280050a..6c18971 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -66,6 +66,23 @@ void
 sofree(struct socket *so)
 {
   Slirp *slirp = so->slirp;
+  struct mbuf *ifm;
+
+  for (ifm = (struct mbuf *) slirp->if_fastq.qh_link;
+       (struct quehead *) ifm != &slirp->if_fastq;
+       ifm = ifm->ifq_next) {
+    if (ifm->ifq_so == so) {
+      ifm->ifq_so = NULL;
+    }
+  }
+
+  for (ifm = (struct mbuf *) slirp->if_batchq.qh_link;
+       (struct quehead *) ifm != &slirp->if_batchq;
+       ifm = ifm->ifq_next) {
+    if (ifm->ifq_so == so) {
+      ifm->ifq_so = NULL;
+    }
+  }
 
   if (so->so_emu==EMU_RSH && so->extra) {
 	sofree(so->extra);
-- 
1.9.1
