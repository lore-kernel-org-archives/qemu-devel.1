Received: from eggs.gnu.org ([209.51.188.92]:33906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1guL4L-0002HG-Ao
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1guKvb-0003Kf-Pd
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:36:04 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1guKvb-0003Ja-Iq
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:36:03 -0500
Received: by mail-wm1-x344.google.com with SMTP id q21so6915494wmc.5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:36:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 14 Feb 2019 18:35:52 +0100
Message-Id: <1550165756-21617-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1550165756-21617-1-git-send-email-pbonzini@redhat.com>
References: <1550165756-21617-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/9] vhost-net: compile it on all targets that
 have virtio-net.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, mst@redhat.com

This shows a preexisting bug: if a KVM target did not have virtio-net enabled,
it would fail with undefined symbols when vhost was enabled.  This must now
be fixed, lest targets that have no virtio-net fail to compile.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1543851204-41186-5-git-send-email-pbonzini@redhat.com>
---
 configure               | 11 ++++-------
 hw/net/Makefile.objs    |  4 ++--
 hw/net/vhost_net.c      |  4 +---
 include/exec/poison.h   |  1 -
 tests/Makefile.include  |  5 +----
 tests/vhost-user-test.c | 16 +++++++++++-----
 6 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/configure b/configure
index 7ac76ec..4553c17 100755
--- a/configure
+++ b/configure
@@ -6578,7 +6578,10 @@ fi
 if test "$vhost_scsi" = "yes" ; then
   echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
 fi
-if test "$vhost_net" = "yes" && test "$vhost_user" = "yes"; then
+if test "$vhost_net" = "yes" ; then
+  echo "CONFIG_VHOST_NET=y" >> $config_host_mak
+fi
+if test "$vhost_net_user" = "yes" ; then
   echo "CONFIG_VHOST_NET_USER=y" >> $config_host_mak
 fi
 if test "$vhost_crypto" = "yes" ; then
@@ -7354,12 +7357,6 @@ if supported_xen_target $target; then
 fi
 if supported_kvm_target $target; then
     echo "CONFIG_KVM=y" >> $config_target_mak
-    if test "$vhost_net" = "yes" ; then
-        echo "CONFIG_VHOST_NET=y" >> $config_target_mak
-        if test "$vhost_user" = "yes" ; then
-            echo "CONFIG_VHOST_USER_NET_TEST_$target_name=y" >> $config_host_mak
-        fi
-    fi
 fi
 if supported_hax_target $target; then
     echo "CONFIG_HAX=y" >> $config_target_mak
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index acfaea5..ea63715 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -37,8 +37,8 @@ obj-$(CONFIG_PSERIES) += spapr_llan.o
 obj-$(CONFIG_XILINX_ETHLITE) += xilinx_ethlite.o
 
 obj-$(CONFIG_VIRTIO_NET) += virtio-net.o
-obj-$(CONFIG_VHOST_NET) += vhost_net.o
-common-obj-$(call lnot,$(CONFIG_VHOST_NET)) += vhost_net-stub.o
+common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET)) += vhost_net.o
+common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET))) += vhost_net-stub.o
 common-obj-$(CONFIG_ALL) += vhost_net-stub.o
 
 obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index ae3ca23..be3cc88 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -25,8 +25,6 @@
 
 
 #include <sys/socket.h>
-#include <netpacket/packet.h>
-#include <net/ethernet.h>
 #include <net/if.h>
 #include <netinet/in.h>
 
@@ -134,7 +132,7 @@ static int vhost_net_get_fd(NetClientState *backend)
         return tap_get_fd(backend);
     default:
         fprintf(stderr, "vhost-net requires tap backend\n");
-        return -EBADFD;
+        return -ENOSYS;
     }
 }
 
diff --git a/include/exec/poison.h b/include/exec/poison.h
index ecdc83c..1a7a57b 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -86,7 +86,6 @@
 #pragma GCC poison CONFIG_XTENSA_DIS
 
 #pragma GCC poison CONFIG_LINUX_USER
-#pragma GCC poison CONFIG_VHOST_NET
 #pragma GCC poison CONFIG_KVM
 #pragma GCC poison CONFIG_SOFTMMU
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index b39e989..048cf56 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -209,10 +209,7 @@ check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
 check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
 check-qtest-i386-y += tests/q35-test$(EXESUF)
 check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
-check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
-ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
-check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
-endif
+check-qtest-i386-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-swtpm-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-swtpm-test$(EXESUF)
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index d961bd0..cdbdf3d 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -27,10 +27,13 @@
 #include "libqos/malloc-pc.h"
 #include "hw/virtio/virtio-net.h"
 
-#include <linux/vhost.h>
-#include <linux/virtio_ids.h>
-#include <linux/virtio_net.h>
+#include "standard-headers/linux/vhost_types.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_net.h"
+
+#ifdef CONFIG_LINUX
 #include <sys/vfs.h>
+#endif
 
 
 #define QEMU_CMD_MEM    " -m %d -object memory-backend-file,id=mem,size=%dM," \
@@ -459,6 +462,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     g_mutex_unlock(&s->data_mutex);
 }
 
+#ifdef CONFIG_LINUX
 static const char *init_hugepagefs(const char *path)
 {
     struct statfs fs;
@@ -485,6 +489,7 @@ static const char *init_hugepagefs(const char *path)
 
     return path;
 }
+#endif
 
 static TestServer *test_server_new(const gchar *name)
 {
@@ -983,13 +988,14 @@ int main(int argc, char **argv)
     }
     g_assert(tmpfs);
 
+    root = tmpfs;
+#ifdef CONFIG_LINUX
     hugefs = getenv("QTEST_HUGETLBFS_PATH");
     if (hugefs) {
         root = init_hugepagefs(hugefs);
         g_assert(root);
-    } else {
-        root = tmpfs;
     }
+#endif
 
     loop = g_main_loop_new(NULL, FALSE);
     /* run the main loop thread so the chardev may operate */
-- 
1.8.3.1
