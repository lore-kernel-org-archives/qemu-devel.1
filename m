Received: from eggs.gnu.org ([2001:4830:134:3::10]:52876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yasmins@linux.vnet.ibm.com>) id 1ekEPi-0007EC-1O
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yasmins@linux.vnet.ibm.com>) id 1ekEPe-0006ex-3L
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:32:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yasmins@linux.vnet.ibm.com>)
	id 1ekEPd-0006ej-Qz
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 14:32:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w19JVVUw146425
	for <qemu-devel@nongnu.org>; Fri, 9 Feb 2018 14:32:44 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g1fgf5kc1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 14:32:41 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <yasmins@linux.vnet.ibm.com>;
	Fri, 9 Feb 2018 12:32:40 -0700
From: Yasmin Beatriz <yasmins@linux.vnet.ibm.com>
Date: Fri,  9 Feb 2018 13:31:38 -0600
Message-Id: <20180209193138.97198-1-yasmins@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] dump: Show custom message for ENOSPC
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
 dump.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/dump.c b/dump.c
index e9dfed060a..eb56ff53f6 100644
--- a/dump.c
+++ b/dump.c
@@ -106,6 +106,9 @@ static int fd_write_vmcore(const void *buf, size_t size, void *opaque)
 
     written_size = qemu_write_full(s->fd, buf, size);
     if (written_size != size) {
+        if (errno == ENOSPC) {
+            return -ENOSPC;
+        }
         return -1;
     }
 
@@ -364,7 +367,11 @@ static void write_data(DumpState *s, void *buf, int length, Error **errp)
 
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
