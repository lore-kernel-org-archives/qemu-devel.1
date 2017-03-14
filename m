Received: from eggs.gnu.org ([2001:4830:134:3::10]:48371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cnnNV-0003OR-OO
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cnnNT-0007nV-2w
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:24:45 -0400
Received: from mail-db5eur01on0117.outbound.protection.outlook.com
	([104.47.2.117]:45087
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <janne.huttunen@nokia.com>)
	id 1cnnNS-0007m8-MB
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:24:43 -0400
From: Janne Huttunen <janne.huttunen@nokia.com>
Date: Tue, 14 Mar 2017 14:50:12 +0200
Message-ID: <f8d5a6c541c733527c754f6695bc15080ee4c4f5.1489494746.git.janne.huttunen@nokia.com>
In-Reply-To: <cover.1489494746.git.janne.huttunen@nokia.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC][PATCH 5/6] Support "bootonceindex" property for
 virtio-net interfaces.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: janne.huttunen@nokia.com

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
---
 hw/net/virtio-net.c    | 3 +++
 hw/virtio/virtio-pci.c | 2 ++
 include/net/net.h      | 1 +
 3 files changed, 6 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c321680..928b60b 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2016,6 +2016,9 @@ static void virtio_net_instance_init(Object *obj)
     device_add_bootindex_property(obj, &n->nic_conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
                                   DEVICE(n), NULL);
+    device_add_bootonceindex_property(obj, &n->nic_conf.bootonceindex,
+                                      "bootonceindex", "/ethernet-phy@0",
+                                      DEVICE(n), NULL);
 }
 
 static void virtio_net_pre_save(void *opaque)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5ce42af..abfa5bd 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2322,6 +2322,8 @@ static void virtio_net_pci_instance_init(Object *obj)
                                 TYPE_VIRTIO_NET);
     object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
                               "bootindex", &error_abort);
+    object_property_add_alias(obj, "bootonceindex", OBJECT(&dev->vdev),
+                              "bootonceindex", &error_abort);
 }
 
 static const TypeInfo virtio_net_pci_info = {
diff --git a/include/net/net.h b/include/net/net.h
index 99b28d5..de98b883 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -36,6 +36,7 @@ typedef struct NICConf {
     MACAddr macaddr;
     NICPeers peers;
     int32_t bootindex;
+    int32_t bootonceindex;
 } NICConf;
 
 #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
-- 
2.7.4
