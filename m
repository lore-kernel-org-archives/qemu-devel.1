Received: from eggs.gnu.org ([2001:4830:134:3::10]:59793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfb-0000XI-3r
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfS-00070C-KI
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:38 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:05:54 +0100
Message-Id: <20181112170603.23986-6-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/14] nvme: free cmbuf in nvme_exit
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

From: Li Qiang <liq3ea@gmail.com>

This avoid a memory leak in unhotplug nvme device.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 359a06d0ad..09d7c90259 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1332,6 +1332,9 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->cq);
     g_free(n->sq);
=20
+    if (n->cmb_size_mb) {
+        g_free(n->cmbuf);
+    }
     msix_uninit_exclusive_bar(pci_dev);
 }
=20
--=20
2.19.1
