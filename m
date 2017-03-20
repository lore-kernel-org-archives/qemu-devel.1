Received: from eggs.gnu.org ([2001:4830:134:3::10]:41197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qp-0001oG-Ls
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qj-000529-R0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qj-000514-GU
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Yr4020562
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:36 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 299yqc6yqd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:36 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:35 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:09 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-46-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 45/81] virtio-crypto: fix possible integer and
 heap overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gonglei <arei.gonglei@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Gonglei <arei.gonglei@huawei.com>

Because the 'size_t' type is 4 bytes in 32-bit platform, which
is the same with 'int'. It's easy to make 'max_len' to zero when
integer overflow and then cause heap overflow if 'max_len' is zero.

Using uint_64 instead of size_t to avoid the integer overflow.

Cc: qemu-stable@nongnu.org
Reported-by: Li Qiang <liqiang6-s@360.cn>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Tested-by: Li Qiang <liqiang6-s@360.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit a08aaff811fb194950f79711d2afe5a892ae03a4)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 2f2467e..c23e1ad 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -416,7 +416,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
     uint32_t hash_start_src_offset = 0, len_to_hash = 0;
     uint32_t cipher_start_src_offset = 0, len_to_cipher = 0;
 
-    size_t max_len, curr_size = 0;
+    uint64_t max_len, curr_size = 0;
     size_t s;
 
     /* Plain cipher */
@@ -441,7 +441,7 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
         return NULL;
     }
 
-    max_len = iv_len + aad_len + src_len + dst_len + hash_result_len;
+    max_len = (uint64_t)iv_len + aad_len + src_len + dst_len + hash_result_len;
     if (unlikely(max_len > vcrypto->conf.max_size)) {
         virtio_error(vdev, "virtio-crypto too big length");
         return NULL;
-- 
2.7.4
