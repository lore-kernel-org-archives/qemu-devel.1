Received: from eggs.gnu.org ([2001:4830:134:3::10]:54353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cREQG-0004jv-FL
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cREQD-0004nU-A4
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:38:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cREQD-0004n6-2Y
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:38:17 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2EDF61B92
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 08:38:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 09:38:15 +0100
Message-Id: <20170111083815.19941-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-net: enable ioeventfd even if vhost=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com

virtio-net-pci does not enable ioeventfd for historical reasons (and
nobody ever checked whether it should be revisited).  Note that other
backends do enable ioeventfd for virtio-net.

However, it has a major effect on performance.  On Windows, throughput is
_multiplied_ by 2 or 3 on TCP_STREAM (on small packets it is "only" a 30%
improvement) and a little less so on TCP_MAERTS albeit still very much
statistically significant.  Latency also has a single digit improvement.

This is not visible when using vhost, which forces ioeventfd=on, but it
is substantial without vhost.  In addition, also on Windows and with the
RHEL 7.3 kernel, APICv seems to slow down virtio-net performance a bit,
but the penalty with this patch goes from -25% to -7%.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 023a020..0cd42ae 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2278,7 +2278,7 @@ static const TypeInfo virtio_serial_pci_info = {
 
 static Property virtio_net_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, false),
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 3),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.9.3
