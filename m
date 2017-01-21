Received: from eggs.gnu.org ([2001:4830:134:3::10]:53051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cUweO-00068F-RZ
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 09:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cUweL-0003hr-OH
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 09:28:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cUweL-0003cy-Er
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 09:28:13 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0LEQLup106488
	for <qemu-devel@nongnu.org>; Sat, 21 Jan 2017 09:28:05 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2844p5rjd0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 21 Jan 2017 09:28:05 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sat, 21 Jan 2017 07:28:04 -0700
From: Greg Kurz <groug@kaod.org>
Date: Sat, 21 Jan 2017 15:27:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148500887769.19567.3784247823786701992.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH] 9pfs: fix offset error in v9fs_xattr_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

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
---
 hw/9pfs/9p.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index fa58877570f6..f0eef1a3ef53 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
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
