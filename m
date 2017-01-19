Received: from eggs.gnu.org ([2001:4830:134:3::10]:36513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxJ-000056-1T
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxE-0007Tn-TL
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:12 -0500
Received: from mail.kernel.org ([198.145.29.136]:56484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxE-0007Qs-Lo
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:08 -0500
Date: Thu, 19 Jan 2017 23:09:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484860116-25361-2-git-send-email-mst@redhat.com>
References: <1484860116-25361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484860116-25361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 01/17] virtio-net: enable ioeventfd even if
 vhost=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 854b8f2..8baaf2b 100644
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
MST
