Received: from eggs.gnu.org ([209.51.188.92]:59937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5z-0000FQ-JX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5t-0008C9-JA
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:59:24 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:58:06 +0100
Message-Id: <20190308125823.32535-17-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/33] qcow2: Prepare qcow2_get_cluster_type()
 for external data file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 7a34bd0c53..8fe2d55005 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -521,7 +521,15 @@ static inline QCow2ClusterType qcow2_get_cluster_typ=
e(BlockDriverState *bs,
         }
         return QCOW2_CLUSTER_ZERO_PLAIN;
     } else if (!(l2_entry & L2E_OFFSET_MASK)) {
-        return QCOW2_CLUSTER_UNALLOCATED;
+        /* Offset 0 generally means unallocated, but it is ambiguous wit=
h
+         * external data files because 0 is a valid offset there. Howeve=
r, all
+         * clusters in external data files always have refcount 1, so we=
 can
+         * rely on QCOW_OFLAG_COPIED to disambiguate. */
+        if (has_data_file(bs) && (l2_entry & QCOW_OFLAG_COPIED)) {
+            return QCOW2_CLUSTER_NORMAL;
+        } else {
+            return QCOW2_CLUSTER_UNALLOCATED;
+        }
     } else {
         return QCOW2_CLUSTER_NORMAL;
     }
--=20
2.20.1
