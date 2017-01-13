Received: from eggs.gnu.org ([2001:4830:134:3::10]:59675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvxK-00008Q-Dr
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvxF-0001uD-VS
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:22 -0500
Received: from [59.151.112.132] (port=13743 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cRvxF-0001qP-KE
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:07:17 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Fri, 13 Jan 2017 15:12:01 +0800
Message-ID: <1484291524-1261-8-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1484291524-1261-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 07/10] vmxnet3: fix reference leak issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On migration target, msix_vector_use() will be called in vmxnet3_post_load()
in second time, without a matching second call to msi_vector_unuse(),
which results in vector reference leak.

CC: Dmitry Fleytman <dmitry@daynix.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/net/vmxnet3.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index a433cc017cb1..45e125e92c8a 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2552,21 +2552,11 @@ static void vmxnet3_put_rxq_descr(QEMUFile *f, void *pv, size_t size)
 static int vmxnet3_post_load(void *opaque, int version_id)
 {
     VMXNET3State *s = opaque;
-    PCIDevice *d = PCI_DEVICE(s);
 
     net_tx_pkt_init(&s->tx_pkt, PCI_DEVICE(s),
                     s->max_tx_frags, s->peer_has_vhdr);
     net_rx_pkt_init(&s->rx_pkt, s->peer_has_vhdr);
 
-    if (s->msix_used) {
-        if  (!vmxnet3_use_msix_vectors(s, VMXNET3_MAX_INTRS)) {
-            VMW_WRPRN("Failed to re-use MSI-X vectors");
-            msix_uninit(d, &s->msix_bar, &s->msix_bar);
-            s->msix_used = false;
-            return -1;
-        }
-    }
-
     vmxnet3_validate_queues(s);
     vmxnet3_validate_interrupts(s);
 
-- 
2.1.0
