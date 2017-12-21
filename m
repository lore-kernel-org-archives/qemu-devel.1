Received: from eggs.gnu.org ([2001:4830:134:3::10]:46166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1rD-0008Tx-PF
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:30:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1rA-000678-AD
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1rA-00066i-1X
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:56 -0500
Date: Thu, 21 Dec 2017 16:29:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-21-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 20/25] vhost-user: document memory accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Wei Wang <wei.w.wang@intel.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

The vhost-user protocol specification does not define "guest address"
and "user address".  It does not explain how to access memory given such
addresses.

This patch explains how memory access works, including the IOTLB.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 docs/interop/vhost-user.txt | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index fd8ac56..d49444e 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -66,11 +66,14 @@ Depending on the request type, payload can be:
 
    Index: a 32-bit vring index
    Flags: a 32-bit vring flags
-   Descriptor: a 64-bit user address of the vring descriptor table
-   Used: a 64-bit user address of the vring used ring
-   Available: a 64-bit user address of the vring available ring
+   Descriptor: a 64-bit ring address of the vring descriptor table
+   Used: a 64-bit ring address of the vring used ring
+   Available: a 64-bit ring address of the vring available ring
    Log: a 64-bit guest address for logging
 
+   Note that a ring address is an IOVA if VIRTIO_F_IOMMU_PLATFORM has been
+   negotiated.  Otherwise it is a user address.
+
  * Memory regions description
    ---------------------------------------------------
    | num regions | padding | region0 | ... | region7 |
@@ -273,6 +276,30 @@ Once the source has finished migration, rings will be stopped by
 the source. No further update must be done before rings are
 restarted.
 
+Memory access
+-------------
+
+The master sends a list of vhost memory regions to the slave using the
+VHOST_USER_SET_MEM_TABLE message.  Each region has two base addresses: a guest
+address and a user address.
+
+Messages contain guest addresses and/or user addresses to reference locations
+within the shared memory.  The mapping of these addresses works as follows.
+
+User addresses map to the vhost memory region containing that user address.
+
+When the VIRTIO_F_IOMMU_PLATFORM feature has not been negotiated:
+
+ * Guest addresses map to the vhost memory region containing that guest
+   address.
+
+When the VIRTIO_F_IOMMU_PLATFORM feature has been negotiated:
+
+ * Guest addresses are also called I/O virtual addresses (IOVAs).  They are
+   translated to user addresses via the IOTLB.
+
+ * The vhost memory region guest address is not used.
+
 IOMMU support
 -------------
 
-- 
MST
