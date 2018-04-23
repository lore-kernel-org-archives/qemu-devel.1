Received: from eggs.gnu.org ([2001:4830:134:3::10]:41601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAk1z-0006Q3-BM
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 18:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fAk1y-0005dj-M2
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 18:33:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 23 Apr 2018 17:33:35 -0500
Message-Id: <20180423223337.82366-4-eblake@redhat.com>
In-Reply-To: <20180423223337.82366-1-eblake@redhat.com>
References: <20180423223337.82366-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 3/5] qcow2: Reduce REFT_OFFSET_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com, Max Reitz <mreitz@redhat.com>

Match our code to the spec change in the previous patch - there's
no reason for the refcount table to allow larger offsets than the
L1/L2 tables. In practice, no image has more than 64PB of
allocated clusters anyways, as anything beyond that can't be
expressed via L2 mappings to host offsets.

Suggested-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>

---
v4: new patch
---
 block/qcow2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index adf5c3950fd..1df15a18aa1 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -443,7 +443,7 @@ typedef enum QCow2MetadataOverlap {
 #define L2E_OFFSET_MASK 0x00fffffffffffe00ULL
 #define L2E_COMPRESSED_OFFSET_SIZE_MASK 0x3fffffffffffffffULL

-#define REFT_OFFSET_MASK 0xfffffffffffffe00ULL
+#define REFT_OFFSET_MASK 0x00fffffffffffe00ULL

 static inline int64_t start_of_cluster(BDRVQcow2State *s, int64_t offset)
 {
-- 
2.14.3
