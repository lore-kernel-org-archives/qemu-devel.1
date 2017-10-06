Received: from eggs.gnu.org ([2001:4830:134:3::10]:43701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSO-0002Jw-Er
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cSN-00085j-Na
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:55:04 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:11 -0300
Message-Id: <20171006235023.11952-77-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 76/88] dma: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: added hw/dma/etraxfs_dma.c]
---
 dma-helpers.c        | 4 ++--
 hw/dma/etraxfs_dma.c | 2 +-
 hw/dma/rc4030.c      | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/dma-helpers.c b/dma-helpers.c
index 2d7e02d35e..e327fc21c4 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -40,7 +40,7 @@ int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len)
 void qemu_sglist_init(QEMUSGList *qsg, DeviceState *dev, int alloc_hint,
                       AddressSpace *as)
 {
-    qsg->sg = g_malloc(alloc_hint * sizeof(ScatterGatherEntry));
+    qsg->sg = g_new(ScatterGatherEntry, alloc_hint);
     qsg->nsg = 0;
     qsg->nalloc = alloc_hint;
     qsg->size = 0;
@@ -53,7 +53,7 @@ void qemu_sglist_add(QEMUSGList *qsg, dma_addr_t base, dma_addr_t len)
 {
     if (qsg->nsg == qsg->nalloc) {
         qsg->nalloc = 2 * qsg->nalloc + 1;
-        qsg->sg = g_realloc(qsg->sg, qsg->nalloc * sizeof(ScatterGatherEntry));
+        qsg->sg = g_renew(ScatterGatherEntry, qsg->sg, qsg->nalloc);
     }
     qsg->sg[qsg->nsg].base = base;
     qsg->sg[qsg->nsg].len = len;
diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index d5650eb885..97951a2abe 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -768,7 +768,7 @@ void *etraxfs_dmac_init(hwaddr base, int nr_channels)
 {
 	struct fs_dma_ctrl *ctrl = NULL;
 
-	ctrl = g_malloc0(sizeof *ctrl);
+	ctrl = g_new0(struct fs_dma_ctrl, 1);
 
         ctrl->bh = qemu_bh_new(DMA_run, ctrl);
 
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 5d4833eeca..14bcab9fb3 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -636,8 +636,8 @@ static rc4030_dma *rc4030_allocate_dmas(void *opaque, int n)
     struct rc4030DMAState *p;
     int i;
 
-    s = (rc4030_dma *)g_malloc0(sizeof(rc4030_dma) * n);
-    p = (struct rc4030DMAState *)g_malloc0(sizeof(struct rc4030DMAState) * n);
+    s = g_new0(rc4030_dma, n);
+    p = g_new0(struct rc4030DMAState, n);
     for (i = 0; i < n; i++) {
         p->opaque = opaque;
         p->n = i;
-- 
2.14.2
