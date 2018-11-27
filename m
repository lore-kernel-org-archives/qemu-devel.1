Received: from eggs.gnu.org ([2001:4830:134:3::10]:55660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRe1I-0008Gk-Lq
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRe1C-0007Xo-Sy
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:07:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 27 Nov 2018 15:06:40 +0100
Message-Id: <20181127140640.24830-4-kwolf@redhat.com>
In-Reply-To: <20181127140640.24830-1-kwolf@redhat.com>
References: <20181127140640.24830-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] nvme: Fix spurious interrupts
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

From: Keith Busch <keith.busch@intel.com>

The code had asserted an interrupt every time it was requested to check
for new completion queue entries.This can result in spurious interrupts
seen by the guest OS.

Fix this by asserting an interrupt only if there are un-acknowledged
completion queue entries available.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9fbe5673cb..7c8c63e8f5 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -272,7 +272,9 @@ static void nvme_post_cqes(void *opaque)
             sizeof(req->cqe));
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
-    nvme_irq_assert(n, cq);
+    if (cq->tail !=3D cq->head) {
+        nvme_irq_assert(n, cq);
+    }
 }
=20
 static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req=
)
--=20
2.19.1
