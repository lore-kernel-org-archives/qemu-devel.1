Received: from eggs.gnu.org ([2001:4830:134:3::10]:60114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cWNwH-0006Ha-Dm
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cWNwE-0007EN-6L
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:48:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41441
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cWNwE-0007EE-12
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:48:38 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0PDmY1r031126
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:48:37 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 286rd5kppd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 08:48:37 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 25 Jan 2017 13:48:29 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed, 25 Jan 2017 14:48:02 +0100
In-Reply-To: <1485352082-16830-1-git-send-email-groug@kaod.org>
References: <1485352082-16830-1-git-send-email-groug@kaod.org>
Message-Id: <1485352082-16830-6-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 5/5] 9pfs: fix offset error in v9fs_xattr_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

The current code tries to copy `read_count' bytes starting at offset
`offset' from a `read_count`-sized iovec. This causes v9fs_pack() to
fail with ENOBUFS.

Since the PDU iovec is already partially filled with `offset' bytes,
let's skip them when creating `qiov_full' and have v9fs_pack() to
copy the whole of it. Moreover, this is consistent with the other
places where v9fs_init_qiov_from_pdu() is called.

This fixes commit "bcb8998fac16 9pfs: call v9fs_init_qiov_from_pdu
before v9fs_pack".

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/9pfs/9p.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index d2d028828294..138d8e825d28 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1655,7 +1655,7 @@ static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
     if (is_write) {
         pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov);
     } else {
-        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size);
+        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size + skip);
     }
 
     qemu_iovec_init_external(&elem, iov, niov);
@@ -1685,8 +1685,8 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
     }
     offset += err;
 
-    v9fs_init_qiov_from_pdu(&qiov_full, pdu, 0, read_count, false);
-    err = v9fs_pack(qiov_full.iov, qiov_full.niov, offset,
+    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, read_count, false);
+    err = v9fs_pack(qiov_full.iov, qiov_full.niov, 0,
                     ((char *)fidp->fs.xattr.value) + off,
                     read_count);
     qemu_iovec_destroy(&qiov_full);
-- 
2.7.4
