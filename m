Received: from eggs.gnu.org ([2001:4830:134:3::10]:44904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uA-00018c-RN
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9u7-0003Hh-M1
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:50 -0500
Received: from mail-eopbgr00098.outbound.protection.outlook.com
	([40.107.0.98]:32000
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9u7-0003GM-F3
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:47 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:35 +0300
Message-Id: <20180206203048.11096-22-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 21/34] vmbus: build configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

From: Evgeny Yakovlev <eyakovlev@virtuozzo.com>

Add option to configure and makefiles to enable building vmbus support
(default to "on" on Linux and "off" otherwise).

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 configure        | 11 +++++++++++
 hw/Makefile.objs |  1 +
 2 files changed, 12 insertions(+)

diff --git a/configure b/configure
index 302fdc92ff..5a0ca5dc4a 100755
--- a/configure
+++ b/configure
@@ -436,6 +436,7 @@ jemalloc="no"
 replication="yes"
 vxhs=""
 libxml2=""
+vmbus="no"
 
 supported_cpu="no"
 supported_os="no"
@@ -804,6 +805,7 @@ Linux)
   vhost_net="yes"
   vhost_scsi="yes"
   vhost_vsock="yes"
+  vmbus="yes"
   QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
 ;;
@@ -1341,6 +1343,10 @@ for opt do
   ;;
   --disable-git-update) git_update=no
   ;;
+  --disable-vmbus) vmbus="no"
+  ;;
+  --enable-vmbus) vmbus="yes"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1592,6 +1598,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   crypto-afalg    Linux AF_ALG crypto backend driver
   vhost-user      vhost-user support
   capstone        capstone disassembler support
+  vmbus           Hyper-V VMBus devices support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -5657,6 +5664,7 @@ echo "avx2 optimization $avx2_opt"
 echo "replication support $replication"
 echo "VxHS block device $vxhs"
 echo "capstone          $capstone"
+echo "vmbus support     $vmbus"
 
 if test "$sdl_too_old" = "yes"; then
 echo "-> Your SDL version is too old - please upgrade to have SDL support"
@@ -6347,6 +6355,9 @@ fi
 if test "$have_static_assert" = "yes" ; then
   echo "CONFIG_STATIC_ASSERT=y" >> $config_host_mak
 fi
+if test "$vmbus" = "yes" ; then
+  echo "CONFIG_VMBUS=y" >> $config_host_mak
+fi
 
 if test "$have_utmpx" = "yes" ; then
   echo "HAVE_UTMPX=y" >> $config_host_mak
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index cf4cb2010b..c12fc0cc22 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -34,6 +34,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
 devices-dirs-$(CONFIG_SOFTMMU) += xen/
 devices-dirs-$(CONFIG_MEM_HOTPLUG) += mem/
 devices-dirs-$(CONFIG_SOFTMMU) += smbios/
+devices-dirs-$(CONFIG_VMBUS) += vmbus/
 devices-dirs-y += core/
 common-obj-y += $(devices-dirs-y)
 obj-y += $(devices-dirs-y)
-- 
2.14.3
