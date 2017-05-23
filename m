Received: from eggs.gnu.org ([2001:4830:134:3::10]:46666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dD7ux-0000Aa-EH
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dD7us-0000Hi-HJ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:23:59 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 23 May 2017 13:22:57 +0200
Message-Id: <95b03a81b53b6cd20c78112545072eb3c669c7d5.1495536228.git.berto@igalia.com>
In-Reply-To: <cover.1495536228.git.berto@igalia.com>
References: <cover.1495536228.git.berto@igalia.com>
In-Reply-To: <cover.1495536228.git.berto@igalia.com>
References: <cover.1495536228.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 2/7] qcow2: Use unsigned int for both members
 of Qcow2COWRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>

Qcow2COWRegion has two attributes:

- The offset of the COW region from the start of the first cluster
  touched by the I/O request. Since it's always going to be positive
  and the maximum request size is at most INT_MAX, we can use a
  regular unsigned int to store this offset.

- The size of the COW region in bytes. This is guaranteed to be >= 0,
  so we should use an unsigned type instead.

In x86_64 this reduces the size of Qcow2COWRegion from 16 to 8 bytes.
It will also help keep some assertions simpler now that we know that
there are no negative numbers.

The prototype of do_perform_cow() is also updated to reflect these
changes.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 4 ++--
 block/qcow2.h         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3dc170e421..6757875ec9 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -406,8 +406,8 @@ int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
 static int coroutine_fn do_perform_cow(BlockDriverState *bs,
                                        uint64_t src_cluster_offset,
                                        uint64_t cluster_offset,
-                                       int offset_in_cluster,
-                                       int bytes)
+                                       unsigned offset_in_cluster,
+                                       unsigned bytes)
 {
     BDRVQcow2State *s = bs->opaque;
     QEMUIOVector qiov;
diff --git a/block/qcow2.h b/block/qcow2.h
index 1801dc30dc..c26ee0a33d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -301,10 +301,10 @@ typedef struct Qcow2COWRegion {
      * Offset of the COW region in bytes from the start of the first cluster
      * touched by the request.
      */
-    uint64_t    offset;
+    unsigned    offset;
 
     /** Number of bytes to copy */
-    int         nb_bytes;
+    unsigned    nb_bytes;
 } Qcow2COWRegion;
 
 /**
-- 
2.11.0
