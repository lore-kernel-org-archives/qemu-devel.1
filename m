Received: from eggs.gnu.org ([2001:4830:134:3::10]:51693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBy-0000Kj-7b
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eyLBv-0000VM-Ix
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 13:36:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 20 Mar 2018 18:36:27 +0100
Message-Id: <20180320173632.25480-8-kwolf@redhat.com>
In-Reply-To: <20180320173632.25480-1-kwolf@redhat.com>
References: <20180320173632.25480-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 07/12] parallels: Check maximum
 cluster size on create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, jcody@redhat.com, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

It's unclear what the real maximum cluster size is for the Parallels
format, but let's at least make sure that we don't get integer
overflows in our .bdrv_co_create implementation.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/parallels.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 2da5e56a9d..e4ca018c2e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -526,6 +526,11 @@ static int coroutine_fn parallels_co_create(BlockdevCreateOptions* opts,
         cl_size = DEFAULT_CLUSTER_SIZE;
     }
 
+    /* XXX What is the real limit here? This is an insanely large maximum. */
+    if (cl_size >= UINT64_MAX / MAX_PARALLELS_IMAGE_FACTOR) {
+        error_setg(errp, "Cluster size is too large");
+        return -EINVAL;
+    }
     if (total_size >= MAX_PARALLELS_IMAGE_FACTOR * cl_size) {
         error_setg(errp, "Image size is too large for this cluster size");
         return -E2BIG;
-- 
2.13.6
