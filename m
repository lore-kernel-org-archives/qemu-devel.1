Received: from eggs.gnu.org ([2001:4830:134:3::10]:41672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqaO-0000fG-U7
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqaL-0003Ay-7l
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fKqaL-00039F-2U
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:09 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Mon, 21 May 2018 12:34:51 -0700
Message-Id: <1526931304-7289-2-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 02/15] xen/pt: use address_space_memory object
 for memory region hooks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Igor Druzhinin <igor.druzhinin@citrix.com>

From: Igor Druzhinin <igor.druzhinin@citrix.com>

Commit 99605175c (xen-pt: Fix PCI devices re-attach failed) introduced
a subtle bug. As soon as the guest switches off Bus Mastering on the
device it immediately causes all the BARs be unmapped due to the DMA
address space of the device being changed. This is undesired behavior
because the guest may try to communicate with the device after that
which triggers the following errors in the logs:

[00:05.0] xen_pt_bar_read: Error: Should not read BAR through QEMU. @0x0000000000000200
[00:05.0] xen_pt_bar_write: Error: Should not write BAR through QEMU. @0x0000000000000200

The issue that the original patch tried to workaround (uneven number of
region_add/del calls on device attach/detach) was fixed in d25836cafd
(memory: do explicit cleanup when remove listeners).

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Reported-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen_pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 9b7a960..e5a6eff 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -907,7 +907,7 @@ out:
         }
     }
 
-    memory_listener_register(&s->memory_listener, &s->dev.bus_master_as);
+    memory_listener_register(&s->memory_listener, &address_space_memory);
     memory_listener_register(&s->io_listener, &address_space_io);
     s->listener_set = true;
     XEN_PT_LOG(d,
-- 
1.9.1
