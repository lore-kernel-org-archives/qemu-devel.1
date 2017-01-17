Received: from eggs.gnu.org ([2001:4830:134:3::10]:49096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cTJzw-0008KF-Dl
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 21:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cTJzs-00075m-HH
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 21:59:48 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:36695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cTJzr-00074i-VP
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 21:59:44 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Tue, 17 Jan 2017 10:59:24 +0800
Message-ID: <1484621964-187372-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] qtest: virtio: zeroed last vring_desc after
 allocate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, lvivier@redhat.com, eblake@redhat.com, peter.maydell@linaro.org, groug@kaod.org
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, "Longpeng(Mike)" <longpeng2@huawei.com>

As qvring_indirect_desc_setup() wouldn't initialize last vring_desc,
so it's filled with dirty data, this might cause virtio backend broken.

For example, the last bit of this vring_desc's flags might be 1, so
virtqueue_read_next_desc() would report "Desc next is ***".

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>

---
Changes since v1:
    - use writel() for @len as it's 32 bits long. [Stefan]

---
 tests/libqos/virtio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index ec30cb9..02e6a43 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -171,12 +171,20 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
     for (i = 0; i < elem - 1; ++i) {
         /* indirect->desc[i].addr */
         writeq(indirect->desc + (16 * i), 0);
+        /* indirect->desc[i].len */
+        writel(indirect->desc + (16 * i) + 8, 0);
         /* indirect->desc[i].flags */
         writew(indirect->desc + (16 * i) + 12, VRING_DESC_F_NEXT);
         /* indirect->desc[i].next */
         writew(indirect->desc + (16 * i) + 14, i + 1);
     }
 
+    /* zeroed last element */
+    writeq(indirect->desc + (16 * i), 0); /* addr */
+    writel(indirect->desc + (16 * i) + 8, 0); /* len */
+    writew(indirect->desc + (16 * i) + 12, 0); /* flags */
+    writew(indirect->desc + (16 * i) + 14, 0); /* next */
+
     return indirect;
 }
 
-- 
1.8.3.1
