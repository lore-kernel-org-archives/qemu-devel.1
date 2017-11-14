Received: from eggs.gnu.org ([2001:4830:134:3::10]:53777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEex5-0005ra-TM
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEex1-0004Gd-0l
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:24:47 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 18:24:04 +0100
Message-Id: <20171114172417.7654-8-mreitz@redhat.com>
In-Reply-To: <20171114172417.7654-1-mreitz@redhat.com>
References: <20171114172417.7654-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 07/20] qcow2: Assert that the crypto header does
 not overlap other metadata
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

From: Alberto Garcia <berto@igalia.com>

The crypto header is initialized only when QEMU is creating a new
image, so there's no chance of this happening on a corrupted image.

If QEMU is really trying to allocate the header overlapping other
existing metadata sections then this is a serious bug in QEMU itself
so let's add an assertion.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: ae3d77f312fc0c5e0ac2bbd71676c0112eebe2e5.1509718618.git.berto@igalia.com
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index defc1fe49f..b3d66a0e88 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -126,6 +126,7 @@ static ssize_t qcow2_crypto_hdr_init_func(QCryptoBlock *block, size_t headerlen,
     /* Zero fill remaining space in cluster so it has predictable
      * content in case of future spec changes */
     clusterlen = size_to_clusters(s, headerlen) * s->cluster_size;
+    assert(qcow2_pre_write_overlap_check(bs, 0, ret, clusterlen) == 0);
     ret = bdrv_pwrite_zeroes(bs->file,
                              ret + headerlen,
                              clusterlen - headerlen, 0);
-- 
2.13.6
