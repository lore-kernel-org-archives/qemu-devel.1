Received: from eggs.gnu.org ([2001:4830:134:3::10]:35169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yasmins@linux.vnet.ibm.com>) id 1ekFG2-0000Hs-2v
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yasmins@linux.vnet.ibm.com>) id 1ekFFy-0001QL-ON
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:26:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42156
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yasmins@linux.vnet.ibm.com>)
	id 1ekFFy-0001Q7-IG
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:26:50 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w19KOHOt150042
	for <qemu-devel@nongnu.org>; Fri, 9 Feb 2018 15:26:49 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g1exr8rr0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 15:26:49 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <yasmins@linux.vnet.ibm.com>;
	Fri, 9 Feb 2018 13:26:48 -0700
From: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
Date: Fri,  9 Feb 2018 14:26:21 -0600
Message-Id: <20180209202621.97852-1-yasmins@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] dump: Show custom message for ENOSPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-trivial@nongnu.org, joserz@linux.vnet.ibm.com

This patch intends to make a more specific message for when
the system has not enough space to save guest memory.

Reported-by: yilzhang@redhat.com
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Signed-off-by: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
---
 dump.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/dump.c b/dump.c
index e9dfed060a..12e0c779ee 100644
--- a/dump.c
+++ b/dump.c
@@ -106,7 +106,7 @@ static int fd_write_vmcore(const void *buf, size_t size, void *opaque)
 
     written_size = qemu_write_full(s->fd, buf, size);
     if (written_size != size) {
-        return -1;
+        return -errno;
     }
 
     return 0;
@@ -364,7 +364,11 @@ static void write_data(DumpState *s, void *buf, int length, Error **errp)
 
     ret = fd_write_vmcore(buf, length, s);
     if (ret < 0) {
-        error_setg(errp, "dump: failed to save memory");
+        if (ret == -ENOSPC) {
+            error_setg(errp, "dump: not enough space to save memory");
+        } else {
+            error_setg(errp, "dump: failed to save memory");
+        }
     } else {
         s->written_size += length;
     }
-- 
2.14.1
