Received: from eggs.gnu.org ([2001:4830:134:3::10]:34833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ec9I6-0004II-6V
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:27:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ec9I1-0003tb-GY
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:27:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2151 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ec9I0-0003qY-Sf
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:27:29 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Thu, 18 Jan 2018 20:25:36 +0800
Message-ID: <97c7a886a8569b785d9fec7d4d6b7c182a6b8421.1516277913.git.arei.gonglei@huawei.com>
In-Reply-To: <cover.1516277913.git.arei.gonglei@huawei.com>
References: <cover.1516277913.git.arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 5/5] cryptodev-vhost-user: depend on
 CONFIG_VHOST_CRYPTO and CONFIG_VHOST_USER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, xin.zeng@intel.com, roy.fan.zhang@intel.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com

From: Gonglei <arei.gonglei@huawei.com>

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 backends/Makefile.objs     |  4 +++-
 backends/cryptodev-vhost.c | 57 +++++++++++++++++++++++++++++++++++++++++++---
 configure                  | 15 ++++++++++++
 vl.c                       |  2 ++
 4 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 9e1fb76..ea4f630 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -10,5 +10,7 @@ common-obj-y += cryptodev.o
 common-obj-y += cryptodev-builtin.o
 
 ifeq ($(CONFIG_VIRTIO),y)
-common-obj-$(CONFIG_LINUX) += cryptodev-vhost.o cryptodev-vhost-user.o
+common-obj-$(CONFIG_LINUX) += cryptodev-vhost.o
+common-obj-$(call land,$(CONFIG_VHOST_CRYPTO),$(CONFIG_VHOST_USER)) += \
+    cryptodev-vhost-user.o
 endif
diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 830fb53..ad1f415 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -23,14 +23,18 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/virtio/virtio-bus.h"
+#include "sysemu/cryptodev-vhost.h"
+
+#ifdef CONFIG_VHOST_CRYPTO
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
-#include "sysemu/cryptodev-vhost.h"
 #include "hw/virtio/virtio-crypto.h"
-#include "hw/virtio/virtio-bus.h"
-#include "sysemu/cryptodev-vhost-user.h"
 
+#ifdef CONFIG_VHOST_USER
+#include "sysemu/cryptodev-vhost-user.h"
+#endif
 
 uint64_t
 cryptodev_vhost_get_max_queues(
@@ -123,9 +127,11 @@ cryptodev_get_vhost(CryptoDevBackendClient *cc,
     }
 
     switch (cc->type) {
+#ifdef CONFIG_VHOST_USER
     case CRYPTODEV_BACKEND_TYPE_VHOST_USER:
         vhost_crypto = cryptodev_vhost_user_get_vhost(cc, b, queue);
         break;
+#endif
     default:
         break;
     }
@@ -295,3 +301,48 @@ bool cryptodev_vhost_virtqueue_pending(VirtIODevice *dev,
 
     return vhost_virtqueue_pending(&vhost_crypto->dev, idx);
 }
+
+#else
+uint64_t
+cryptodev_vhost_get_max_queues(CryptoDevBackendVhost *crypto)
+{
+    return 0;
+}
+
+void cryptodev_vhost_cleanup(CryptoDevBackendVhost *crypto)
+{
+}
+
+struct CryptoDevBackendVhost *
+cryptodev_vhost_init(CryptoDevBackendVhostOptions *options)
+{
+    return NULL;
+}
+
+CryptoDevBackendVhost *
+cryptodev_get_vhost(CryptoDevBackendClient *cc, CryptoDevBackend *b,
+                    uint16_t queue)
+{
+    return NULL;
+}
+
+int cryptodev_vhost_start(VirtIODevice *dev, int total_queues)
+{
+    return -1;
+}
+
+void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues)
+{
+}
+
+void cryptodev_vhost_virtqueue_mask(VirtIODevice *dev, int queue,
+                                    int idx, bool mask)
+{
+}
+
+bool cryptodev_vhost_virtqueue_pending(VirtIODevice *dev,
+                                       int queue, int idx)
+{
+    return false;
+}
+#endif
diff --git a/configure b/configure
index b272a03..e4cece3 100755
--- a/configure
+++ b/configure
@@ -332,6 +332,7 @@ xfs=""
 tcg="yes"
 
 vhost_net="no"
+vhost_crypto="no"
 vhost_scsi="no"
 vhost_vsock="no"
 vhost_user=""
@@ -801,6 +802,7 @@ Linux)
   linux_user="yes"
   kvm="yes"
   vhost_net="yes"
+  vhost_crypto="yes"
   vhost_scsi="yes"
   vhost_vsock="yes"
   QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
@@ -1163,6 +1165,14 @@ for opt do
   ;;
   --enable-vhost-net) vhost_net="yes"
   ;;
+  --disable-vhost-crypto) vhost_crypto="no"
+  ;;
+  --enable-vhost-crypto)
+      vhost_crypto="yes"
+      if test "$mingw32" = "yes"; then
+          error_exit "vhost-crypto isn't available on win32"
+      fi
+  ;;
   --disable-vhost-scsi) vhost_scsi="no"
   ;;
   --enable-vhost-scsi) vhost_scsi="yes"
@@ -1555,6 +1565,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   cap-ng          libcap-ng support
   attr            attr and xattr support
   vhost-net       vhost-net acceleration support
+  vhost-crypto    vhost-crypto acceleration support
   spice           spice
   rbd             rados block device (rbd)
   libiscsi        iscsi support
@@ -5579,6 +5590,7 @@ echo "madvise           $madvise"
 echo "posix_madvise     $posix_madvise"
 echo "libcap-ng support $cap_ng"
 echo "vhost-net support $vhost_net"
+echo "vhost-crypto support $vhost_crypto"
 echo "vhost-scsi support $vhost_scsi"
 echo "vhost-vsock support $vhost_vsock"
 echo "vhost-user support $vhost_user"
@@ -6640,6 +6652,9 @@ if supported_kvm_target $target; then
             echo "CONFIG_VHOST_USER_NET_TEST_$target_name=y" >> $config_host_mak
         fi
     fi
+    if test "$vhost_crypto" = "yes"; then
+        echo "CONFIG_VHOST_CRYPTO=y" >> $config_target_mak
+    fi
 fi
 if supported_hax_target $target; then
     echo "CONFIG_HAX=y" >> $config_target_mak
diff --git a/vl.c b/vl.c
index 3e9d86f..9f9727d 100644
--- a/vl.c
+++ b/vl.c
@@ -2867,9 +2867,11 @@ static bool object_create_initial(const char *type)
         return false;
     }
 
+#if defined(CONFIG_VHOST_CRYPTO) && defined(CONFIG_VHOST_USER)
     if (g_str_equal(type, "cryptodev-vhost-user")) {
         return false;
     }
+#endif
 
     /*
      * return false for concrete netfilters since
-- 
1.8.3.1
