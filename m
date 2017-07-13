Received: from eggs.gnu.org ([2001:4830:134:3::10]:59149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeA2-0008WA-VA
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeA2-0001O5-2n
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:06 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Jul 2017 15:27:48 +0200
Message-Id: <1499952476-3454-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1499952476-3454-1-git-send-email-armbru@redhat.com>
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] xilinx: Fix latent error handling bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org

From: Eduardo Habkost <ehabkost@redhat.com>

Assigning directly to *errp is not valid, as errp may be null,
&error_fatal, or &error_abort.  The !*errp conditional protects
against the latter two, but we then leak @local_err.  Fortunately,
the qdev core always passes pointer to null, so this is "merely" a
latent bug.

Use error_propagate() instead.

Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-arm@nongnu.org
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170608133906.12737-2-ehabkost@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message clarified]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/dma/xilinx_axidma.c  | 4 +---
 hw/net/xilinx_axienet.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 6065689..3987b5f 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -554,9 +554,7 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
     return;
 
 xilinx_axidma_realize_fail:
-    if (!*errp) {
-        *errp = local_err;
-    }
+    error_propagate(errp, local_err);
 }
 
 static void xilinx_axidma_init(Object *obj)
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index b670184..5ffa739 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -981,9 +981,7 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
     return;
 
 xilinx_enet_realize_fail:
-    if (!*errp) {
-        *errp = local_err;
-    }
+    error_propagate(errp, local_err);
 }
 
 static void xilinx_enet_init(Object *obj)
-- 
2.7.5
