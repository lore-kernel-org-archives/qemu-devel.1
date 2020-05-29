Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5435EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD5320776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZntzHWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD5320776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeg33-0004sX-Ai
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jefiv-00068B-Sm
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:11:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43269
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jefit-0006Xb-DF
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590761458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bz9b5juc7V9v2vJKnzXvYtlE5iOj/g+oFZdIycEig90=;
 b=iZntzHWT4PTh4cnolk3mNKjAy6dtv8PstqgUtfHF3URuMoloUjpHLHP3Iv0tbGdyVpo0/v
 QGYdkaYlcDq3suq965nNCIvHg92ntqzd/bDd9vr8i5E6OCHs4x/JlqHHYXqYA/9N90+u0i
 aN9oKUDzbgRtIGdmEuVY1PuYD8XXyow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-IDJvz7tWPxWE7D3lJmeU2g-1; Fri, 29 May 2020 10:10:51 -0400
X-MC-Unique: IDJvz7tWPxWE7D3lJmeU2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EE7918A8231;
 Fri, 29 May 2020 14:10:48 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-13-84.pek2.redhat.com [10.72.13.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DF385D9D5;
 Fri, 29 May 2020 14:10:30 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [RFC v3 7/8] vhost-vdpa: introduce vhost-vdpa backend
Date: Fri, 29 May 2020 22:06:19 +0800
Message-Id: <20200529140620.28759-8-lulu@redhat.com>
In-Reply-To: <20200529140620.28759-1-lulu@redhat.com>
References: <20200529140620.28759-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, lulu@redhat.com, hanand@xilinx.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 Tiwei Bie <tiwei.bie@intel.com>, aadam@redhat.com, rdunlap@infradead.org,
 maxime.coquelin@redhat.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tiwei Bie <tiwei.bie@intel.com>

Currently we have 2 types of vhost backends in QEMU: vhost kernel and
vhost-user. The above patch provides a generic device for vDPA purpose,
this vDPA device exposes to user space a non-vendor-specific configuration
interface for setting up a vhost HW accelerator, this patch set introduces
a third vhost backend called vhost-vdpa based on the vDPA interface.

Vhost-vdpa usage:

  qemu-system-x86_64 -cpu host -enable-kvm \
    ......
  -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-id,id=vhost-vdpa0 \
  -device virtio-net-pci,netdev=vhost-vdpa0,page-per-vq=on \

Co-Authored-By: Lingshan zhu <lingshan.zhu@intel.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 configure                         |  21 ++
 hw/net/vhost_net-stub.c           |   5 +
 hw/net/vhost_net.c                |  47 +++-
 hw/virtio/Makefile.objs           |   1 +
 hw/virtio/vhost-backend.c         |   5 +
 hw/virtio/vhost-vdpa.c            | 399 ++++++++++++++++++++++++++++++
 hw/virtio/vhost.c                 |  37 ++-
 include/hw/virtio/vhost-backend.h |  10 +-
 include/hw/virtio/vhost-vdpa.h    |  26 ++
 include/hw/virtio/vhost.h         |   2 +
 include/net/vhost_net.h           |   4 +-
 qemu-options.hx                   |  15 ++
 12 files changed, 566 insertions(+), 6 deletions(-)
 create mode 100644 hw/virtio/vhost-vdpa.c
 create mode 100644 include/hw/virtio/vhost-vdpa.h

diff --git a/configure b/configure
index 23b5e93752..53679ee57f 100755
--- a/configure
+++ b/configure
@@ -1557,6 +1557,10 @@ for opt do
   ;;
   --enable-vhost-user) vhost_user="yes"
   ;;
+  --disable-vhost-vdpa) vhost_vdpa="no"
+  ;;
+  --enable-vhost-vdpa) vhost_vdpa="yes"
+  ;;
   --disable-vhost-kernel) vhost_kernel="no"
   ;;
   --enable-vhost-kernel) vhost_kernel="yes"
@@ -1846,6 +1850,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vhost-crypto    vhost-user-crypto backend support
   vhost-kernel    vhost kernel backend support
   vhost-user      vhost-user backend support
+  vhost-vdpa      vhost-vdpa kernel backend support
   spice           spice
   rbd             rados block device (rbd)
   libiscsi        iscsi support
@@ -2336,6 +2341,10 @@ test "$vhost_user" = "" && vhost_user=yes
 if test "$vhost_user" = "yes" && test "$mingw32" = "yes"; then
   error_exit "vhost-user isn't available on win32"
 fi
+test "$vhost_vdpa" = "" && vhost_vdpa=$linux
+if test "$vhost_vdpa" = "yes" && test "$linux" != "yes"; then
+  error_exit "vhost-vdpa is only available on Linux"
+fi
 test "$vhost_kernel" = "" && vhost_kernel=$linux
 if test "$vhost_kernel" = "yes" && test "$linux" != "yes"; then
   error_exit "vhost-kernel is only available on Linux"
@@ -2364,6 +2373,11 @@ test "$vhost_user_fs" = "" && vhost_user_fs=$vhost_user
 if test "$vhost_user_fs" = "yes" && test "$vhost_user" = "no"; then
   error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
 fi
+#vhost-vdpa backends
+test "$vhost_net_vdpa" = "" && vhost_net_vdpa=$vhost_vdpa
+if test "$vhost_net_vdpa" = "yes" && test "$vhost_vdpa" = "no"; then
+  error_exit "--enable-vhost-net-vdpa requires --enable-vhost-vdpa"
+fi
 
 # OR the vhost-kernel and vhost-user values for simplicity
 if test "$vhost_net" = ""; then
@@ -6673,6 +6687,7 @@ echo "vhost-scsi support $vhost_scsi"
 echo "vhost-vsock support $vhost_vsock"
 echo "vhost-user support $vhost_user"
 echo "vhost-user-fs support $vhost_user_fs"
+echo "vhost-vdpa support $vhost_vdpa"
 echo "Trace backends    $trace_backends"
 if have_backend "simple"; then
 echo "Trace output file $trace_file-<pid>"
@@ -7170,6 +7185,9 @@ fi
 if test "$vhost_net_user" = "yes" ; then
   echo "CONFIG_VHOST_NET_USER=y" >> $config_host_mak
 fi
+if test "$vhost_net_vdpa" = "yes" ; then
+  echo "CONFIG_VHOST_NET_VDPA=y" >> $config_host_mak
+fi
 if test "$vhost_crypto" = "yes" ; then
   echo "CONFIG_VHOST_CRYPTO=y" >> $config_host_mak
 fi
@@ -7182,6 +7200,9 @@ fi
 if test "$vhost_user" = "yes" ; then
   echo "CONFIG_VHOST_USER=y" >> $config_host_mak
 fi
+if test "$vhost_vdpa" = "yes" ; then
+  echo "CONFIG_VHOST_VDPA=y" >> $config_host_mak
+fi
 if test "$vhost_user_fs" = "yes" ; then
   echo "CONFIG_VHOST_USER_FS=y" >> $config_host_mak
 fi
diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index 43e93e1a9a..ab77a92a7d 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -94,3 +94,8 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
 {
     return 0;
 }
+int vhost_net_get_device_id(struct vhost_net *net, uint32_t * device_id)
+{
+    return 0;
+}
+
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e2bc7de2eb..25045cff59 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -17,8 +17,10 @@
 #include "net/net.h"
 #include "net/tap.h"
 #include "net/vhost-user.h"
+#include "net/vhost-vdpa.h"
 
 #include "standard-headers/linux/vhost_types.h"
+#include "linux-headers/linux/vhost.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
 #include "qemu/error-report.h"
@@ -85,6 +87,30 @@ static const int user_feature_bits[] = {
     VHOST_INVALID_FEATURE_BIT
 };
 
+static const int vdpa_feature_bits[] = {
+    VIRTIO_F_NOTIFY_ON_EMPTY,
+    VIRTIO_RING_F_INDIRECT_DESC,
+    VIRTIO_RING_F_EVENT_IDX,
+    VIRTIO_F_ANY_LAYOUT,
+    VIRTIO_F_VERSION_1,
+    VIRTIO_NET_F_CSUM,
+    VIRTIO_NET_F_GUEST_CSUM,
+    VIRTIO_NET_F_GSO,
+    VIRTIO_NET_F_GUEST_TSO4,
+    VIRTIO_NET_F_GUEST_TSO6,
+    VIRTIO_NET_F_GUEST_ECN,
+    VIRTIO_NET_F_GUEST_UFO,
+    VIRTIO_NET_F_HOST_TSO4,
+    VIRTIO_NET_F_HOST_TSO6,
+    VIRTIO_NET_F_HOST_ECN,
+    VIRTIO_NET_F_HOST_UFO,
+    VIRTIO_NET_F_MRG_RXBUF,
+    VIRTIO_NET_F_MTU,
+    VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_RING_PACKED,
+    VIRTIO_NET_F_GUEST_ANNOUNCE,
+    VHOST_INVALID_FEATURE_BIT
+};
 static const int *vhost_net_get_feature_bits(struct vhost_net *net)
 {
     const int *feature_bits = 0;
@@ -96,6 +122,9 @@ static const int *vhost_net_get_feature_bits(struct vhost_net *net)
     case NET_CLIENT_DRIVER_VHOST_USER:
         feature_bits = user_feature_bits;
         break;
+    case NET_CLIENT_DRIVER_VHOST_VDPA:
+        feature_bits = vdpa_feature_bits;
+        break;
     default:
         error_report("Feature bits not defined for this type: %d",
                 net->nc->info->type);
@@ -110,7 +139,10 @@ uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
     return vhost_get_features(&net->dev, vhost_net_get_feature_bits(net),
             features);
 }
-
+int vhost_net_get_device_id(struct vhost_net *net, uint32_t * device_id)
+{
+    return vhost_dev_get_device_id(&net->dev, device_id);
+}
 void vhost_net_ack_features(struct vhost_net *net, uint64_t features)
 {
     net->dev.acked_features = net->dev.backend_features;
@@ -337,6 +369,11 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     }
 
     for (i = 0; i < total_queues; i++) {
+
+        if (virtio_queue_enabled(dev, i)) {
+            vhost_set_vring_ready(peer);
+        }
+
         peer = qemu_get_peer(ncs, i);
         r = vhost_net_start_one(get_vhost_net(peer), dev);
 
@@ -433,6 +470,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
         vhost_net = vhost_user_get_vhost_net(nc);
         assert(vhost_net);
         break;
+#endif
+#ifdef CONFIG_VHOST_NET_VDPA
+    case NET_CLIENT_DRIVER_VHOST_VDPA:
+        vhost_net = vhost_vdpa_get_vhost_net(nc);
+        assert(vhost_net);
+        break;
 #endif
     default:
         break;
@@ -474,3 +517,5 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
 
     return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
 }
+
+
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 4e4d39a0a4..6b1b1a5fce 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -5,6 +5,7 @@ obj-y += virtio.o
 obj-$(CONFIG_VHOST) += vhost.o vhost-backend.o
 common-obj-$(call lnot,$(CONFIG_VHOST)) += vhost-stub.o
 obj-$(CONFIG_VHOST_USER) += vhost-user.o
+obj-$(CONFIG_VHOST_VDPA) += vhost-vdpa.o
 
 common-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng.o
 common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 42efb4967b..420341e8c5 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -291,6 +291,11 @@ int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
     case VHOST_BACKEND_TYPE_USER:
         dev->vhost_ops = &user_ops;
         break;
+#endif
+#ifdef CONFIG_VHOST_VDPA
+    case VHOST_BACKEND_TYPE_VDPA:
+        dev->vhost_ops = &vdpa_ops;
+        break;
 #endif
     default:
         error_report("Unknown vhost backend type");
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
new file mode 100644
index 0000000000..2d136a8565
--- /dev/null
+++ b/hw/virtio/vhost-vdpa.c
@@ -0,0 +1,399 @@
+/*
+ * vhost-vdpa
+ *
+ *  Copyright(c) 2017-2018 Intel Corporation.
+ *  Copyright(c) 2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include <linux/vhost.h>
+#include <linux/vfio.h>
+#include <sys/eventfd.h>
+#include <sys/ioctl.h>
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-backend.h"
+#include "hw/virtio/virtio-net.h"
+#include "hw/virtio/vhost-vdpa.h"
+#include "qemu/main-loop.h"
+#include <linux/kvm.h>
+#include "sysemu/kvm.h"
+
+
+static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section)
+{
+    return (!memory_region_is_ram(section->mr) &&
+            !memory_region_is_iommu(section->mr)) ||
+           /*
+            * Sizing an enabled 64-bit BAR can cause spurious mappings to
+            * addresses in the upper part of the 64-bit address space.  These
+            * are never accessed by the CPU and beyond the address width of
+            * some IOMMU hardware.  TODO: VDPA should tell us the IOMMU width.
+            */
+           section->offset_within_address_space & (1ULL << 63);
+}
+
+static int vhost_vdpa_dma_map(struct vhost_vdpa *v, hwaddr iova, hwaddr size,
+                              void *vaddr, bool readonly)
+{
+    struct vhost_msg_v2 msg;
+    int fd = v->device_fd;
+    int ret = 0;
+
+    msg.type =  v->msg_type;
+    msg.iotlb.iova = iova;
+    msg.iotlb.size = size;
+    msg.iotlb.uaddr = (uint64_t)vaddr;
+    msg.iotlb.perm = readonly ? VHOST_ACCESS_RO : VHOST_ACCESS_RW;
+    msg.iotlb.type = VHOST_IOTLB_UPDATE;
+
+    if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
+        error_report("failed to write, fd=%d, errno=%d (%s)",
+            fd, errno, strerror(errno));
+        return -EIO ;
+    }
+
+    return ret;
+}
+
+static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
+                                hwaddr size)
+{
+    struct vhost_msg_v2 msg;
+    int fd = v->device_fd;
+    int ret = 0;
+
+    msg.type =  v->msg_type;
+    msg.iotlb.iova = iova;
+    msg.iotlb.size = size;
+    msg.iotlb.type = VHOST_IOTLB_INVALIDATE;
+
+    if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
+        error_report("failed to write, fd=%d, errno=%d (%s)",
+            fd, errno, strerror(errno));
+        return -EIO ;
+    }
+
+    return ret;
+}
+
+static void vhost_vdpa_listener_region_add(MemoryListener *listener,
+                                           MemoryRegionSection *section)
+{
+    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+    hwaddr iova;
+    Int128 llend, llsize;
+    void *vaddr;
+    int ret;
+
+    if (vhost_vdpa_listener_skipped_section(section)) {
+        return;
+    }
+
+    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
+                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
+        error_report("%s received unaligned region", __func__);
+        return;
+    }
+
+    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    llend = int128_make64(section->offset_within_address_space);
+    llend = int128_add(llend, section->size);
+    llend = int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
+
+    if (int128_ge(int128_make64(iova), llend)) {
+        return;
+    }
+
+    memory_region_ref(section->mr);
+
+    /* Here we assume that memory_region_is_ram(section->mr)==true */
+
+    vaddr = memory_region_get_ram_ptr(section->mr) +
+            section->offset_within_region +
+            (iova - section->offset_within_address_space);
+
+    llsize = int128_sub(llend, int128_make64(iova));
+
+    ret = vhost_vdpa_dma_map(v, iova, int128_get64(llsize),
+                             vaddr, section->readonly);
+    if (ret) {
+        error_report("vhost vdpa map fail!");
+        if (memory_region_is_ram_device(section->mr)) {
+            /* Allow unexpected mappings not to be fatal for RAM devices */
+            error_report("map ram fail!");
+          return ;
+        }
+        goto fail;
+    }
+
+    return;
+
+fail:
+    if (memory_region_is_ram_device(section->mr)) {
+        error_report("failed to vdpa_dma_map. pci p2p may not work");
+        return;
+
+    }
+    /*
+     * On the initfn path, store the first error in the container so we
+     * can gracefully fail.  Runtime, there's not much we can do other
+     * than throw a hardware error.
+     */
+    error_report("vhost-vdpa: DMA mapping failed, unable to continue");
+    return;
+
+}
+
+static void vhost_vdpa_listener_region_del(MemoryListener *listener,
+                                           MemoryRegionSection *section)
+{
+    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+    hwaddr iova;
+    Int128 llend, llsize;
+    int ret;
+    bool try_unmap = true;
+
+    if (vhost_vdpa_listener_skipped_section(section)) {
+        return;
+    }
+
+    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
+                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
+        error_report("%s received unaligned region", __func__);
+        return;
+    }
+
+    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    llend = int128_make64(section->offset_within_address_space);
+    llend = int128_add(llend, section->size);
+    llend = int128_and(llend, int128_exts64(TARGET_PAGE_MASK));
+
+    if (int128_ge(int128_make64(iova), llend)) {
+        return;
+    }
+
+    llsize = int128_sub(llend, int128_make64(iova));
+
+    if (try_unmap) {
+        ret = vhost_vdpa_dma_unmap(v, iova, int128_get64(llsize));
+        if (ret) {
+            error_report("vhost_vdpa dma unmap error!");
+        }
+    }
+
+    memory_region_unref(section->mr);
+}
+/* Register a new memory listener, only to get diffs from qemu,
+ * this help to reduce the tricky codes in vhost
+ * (e.g generating diffs of two rbtree as usnic did).*/
+static const MemoryListener vhost_vdpa_memory_listener = {
+    .region_add = vhost_vdpa_listener_region_add,
+    .region_del = vhost_vdpa_listener_region_del,
+};
+
+static int vhost_vdpa_call(struct vhost_dev *dev, unsigned long int request,
+                             void *arg)
+{
+    struct vhost_vdpa *v = dev->opaque;
+    int fd = v->device_fd;
+
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
+
+    return ioctl(fd, request, arg);
+}
+
+static void vhost_vdpa_add_status(struct vhost_dev *dev, uint8_t status)
+{
+    uint8_t s;
+
+    if (vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &s)) {
+        return;
+    }
+
+    s |= status;
+
+    vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &s);
+}
+
+static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque)
+{
+    struct vhost_vdpa *v;
+
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
+
+    v = opaque;
+    dev->opaque =  opaque ;
+
+    v->listener = vhost_vdpa_memory_listener;
+    v->msg_type = VHOST_IOTLB_MSG_V2;
+    memory_listener_register(&v->listener, &address_space_memory);
+
+    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
+                               VIRTIO_CONFIG_S_DRIVER);
+
+    return 0;
+}
+
+static int vhost_vdpa_cleanup(struct vhost_dev *dev)
+{
+    struct vhost_vdpa *v;
+    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
+
+    v = dev->opaque;
+    memory_listener_unregister(&v->listener);
+
+    dev->opaque = NULL;
+    return 0;
+}
+
+static int vhost_vdpa_memslots_limit(struct vhost_dev *dev)
+{
+    return INT_MAX;
+}
+
+static int vhost_vdpa_set_mem_table(struct vhost_dev *dev,
+                                    struct vhost_memory *mem)
+{
+
+    if (mem->padding) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int vhost_vdpa_set_features(struct vhost_dev *dev,
+                                   uint64_t features)
+{
+    int ret = vhost_vdpa_call(dev, VHOST_SET_FEATURES, &features);
+    uint8_t status = 0;
+
+    if (ret) {
+        return ret;
+    }
+    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
+    vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &status);
+
+    return !(status & VIRTIO_CONFIG_S_FEATURES_OK);
+}
+
+int vhost_vdpa_get_device_id(struct vhost_dev *dev,
+                                   uint32_t *device_id)
+{
+    return vhost_vdpa_call(dev, VHOST_VDPA_GET_DEVICE_ID, device_id);
+}
+
+static int vhost_vdpa_reset_device(struct vhost_dev *dev)
+{
+    uint8_t status = 0;
+
+    return vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
+}
+
+static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
+{
+    assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
+
+    return idx - dev->vq_index;
+}
+
+static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
+{
+    int i;
+    for (i = 0; i < dev->nvqs; ++i) {
+        struct vhost_vring_state state = {
+            .index = dev->vq_index + i,
+            .num = 1,
+        };
+        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
+    }
+    return 0;
+}
+
+static int vhost_vdpa_set_config(struct vhost_dev *dev, const uint8_t *data,
+                                   uint32_t offset, uint32_t size,
+                                   uint32_t flags)
+{
+    struct vhost_vdpa_config config;
+    int ret;
+    if ((size > VHOST_VDPA_MAX_CONFIG_SIZE) || (data == NULL)) {
+        return -1;
+    }
+    memset(&config, 0, sizeof(struct vhost_vdpa_config));
+    config.off = 0;
+    config.len = size;
+    memcpy(&config.buf, data, size);
+    ret = vhost_vdpa_call(dev, VHOST_VDPA_SET_CONFIG, &config);
+    return ret;
+}
+
+static int vhost_vdpa_get_config(struct vhost_dev *dev, uint8_t *config,
+                                   uint32_t config_len)
+{
+    struct vhost_vdpa_config v_config;
+    int ret;
+
+    memset(&v_config, 0, sizeof(struct vhost_vdpa_config));
+    if (config == NULL) {
+        return -1;
+    }
+    ret = vhost_vdpa_call(dev, VHOST_VDPA_GET_CONFIG, &v_config);
+    if ((v_config.len > config_len) || (v_config.len == 0)) {
+        return -EINVAL;
+    }
+    memcpy(config, &v_config.buf, config_len);
+    return ret;
+ }
+
+static int vhost_vdpa_set_state(struct vhost_dev *dev, bool started)
+{
+    if (started) {
+        uint8_t status = 0;
+
+        vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
+        vhost_vdpa_call(dev, VHOST_VDPA_GET_STATUS, &status);
+
+        return !(status & VIRTIO_CONFIG_S_DRIVER_OK);
+    } else {
+        vhost_vdpa_reset_device(dev);
+        vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
+                                   VIRTIO_CONFIG_S_DRIVER);
+        return 0;
+    }
+}
+
+const VhostOps vdpa_ops = {
+        .backend_type = VHOST_BACKEND_TYPE_VDPA,
+        .vhost_backend_init = vhost_vdpa_init,
+        .vhost_backend_cleanup = vhost_vdpa_cleanup,
+        .vhost_set_log_base = vhost_kernel_set_log_base,
+        .vhost_set_vring_addr = vhost_kernel_set_vring_addr,
+        .vhost_set_vring_num = vhost_kernel_set_vring_num,
+        .vhost_set_vring_base = vhost_kernel_set_vring_base,
+        .vhost_get_vring_base = vhost_kernel_get_vring_base,
+        .vhost_set_vring_kick = vhost_kernel_set_vring_kick,
+        .vhost_set_vring_call = vhost_kernel_set_vring_call,
+        .vhost_get_features = vhost_kernel_get_features,
+        .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_set_vring_endian = NULL,
+        .vhost_backend_memslots_limit = vhost_vdpa_memslots_limit,
+        .vhost_set_mem_table = vhost_vdpa_set_mem_table,
+        .vhost_set_features = vhost_vdpa_set_features,
+        .vhost_reset_device = vhost_vdpa_reset_device,
+        .vhost_get_vq_index = vhost_vdpa_get_vq_index,
+        .vhost_set_vring_ready = vhost_vdpa_set_vring_ready,
+        .vhost_get_config  = vhost_vdpa_get_config,
+        .vhost_set_config = vhost_vdpa_set_config,
+        .vhost_requires_shm_log = NULL,
+        .vhost_migration_done = NULL,
+        .vhost_backend_can_merge = NULL,
+        .vhost_net_set_mtu = NULL,
+        .vhost_set_iotlb_callback = NULL,
+        .vhost_send_device_iotlb_msg = NULL,
+        .vhost_set_state = vhost_vdpa_set_state,
+        .vhost_get_device_id = vhost_vdpa_get_device_id,
+};
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 01ebe12f28..b97aa02a4c 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -756,6 +756,12 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
         .log_guest_addr = vq->used_phys,
         .flags = enable_log ? (1 << VHOST_VRING_F_LOG) : 0,
     };
+    /*vDPA need to use the phys address here to set to hardware*/
+    if (dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA) {
+        addr.desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
+        addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
+        addr.used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
+    }
     int r = dev->vhost_ops->vhost_set_vring_addr(dev, &addr);
     if (r < 0) {
         VHOST_OPS_DEBUG("vhost_set_vring_addr failed");
@@ -1506,6 +1512,14 @@ int vhost_dev_set_config(struct vhost_dev *hdev, const uint8_t *data,
     return -1;
 }
 
+int vhost_dev_get_device_id(struct vhost_dev *hdev, uint32_t *device_id)
+{
+    assert(hdev->vhost_ops);
+    if (hdev->vhost_ops->vhost_get_device_id) {
+        return hdev->vhost_ops->vhost_get_device_id(hdev, device_id);
+    }
+    return -1;
+}
 void vhost_dev_set_config_notifier(struct vhost_dev *hdev,
                                    const VhostDevConfigOps *ops)
 {
@@ -1661,7 +1675,13 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
         }
     }
 
-    if (vhost_dev_has_iommu(hdev)) {
+    r = vhost_set_state(hdev, true);
+    if (r) {
+        goto fail_log;
+    }
+
+    if (vhost_dev_has_iommu(hdev) &&
+        hdev->vhost_ops->vhost_set_iotlb_callback) {
         hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
 
         /* Update used ring information for IOTLB to work correctly,
@@ -1697,6 +1717,8 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
     /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
 
+    vhost_set_state(hdev, false);
+
     for (i = 0; i < hdev->nvqs; ++i) {
         vhost_virtqueue_stop(hdev,
                              vdev,
@@ -1705,7 +1727,9 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
     }
 
     if (vhost_dev_has_iommu(hdev)) {
-        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
+        if (hdev->vhost_ops->vhost_set_iotlb_callback) {
+            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
+        }
         memory_listener_unregister(&hdev->iommu_listener);
     }
     vhost_log_put(hdev, true);
@@ -1722,3 +1746,12 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
 
     return -1;
 }
+
+int vhost_set_state(struct vhost_dev *hdev, bool started)
+{
+    if (hdev->vhost_ops->vhost_set_state) {
+        return hdev->vhost_ops->vhost_set_state(hdev, started);
+    }
+
+    return 0;
+}
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 300b59c172..1ebe3785cf 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -17,7 +17,8 @@ typedef enum VhostBackendType {
     VHOST_BACKEND_TYPE_NONE = 0,
     VHOST_BACKEND_TYPE_KERNEL = 1,
     VHOST_BACKEND_TYPE_USER = 2,
-    VHOST_BACKEND_TYPE_MAX = 3,
+    VHOST_BACKEND_TYPE_VDPA = 3,
+    VHOST_BACKEND_TYPE_MAX = 4,
 } VhostBackendType;
 
 typedef enum VhostSetConfigType {
@@ -77,6 +78,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
                                          int enable);
+typedef int (*vhost_set_vring_ready_op)(struct vhost_dev *dev);
 typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
 typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
                                        char *mac_addr);
@@ -112,6 +114,8 @@ typedef int (*vhost_get_inflight_fd_op)(struct vhost_dev *dev,
 typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
                                         struct vhost_inflight *inflight);
 
+typedef int (*vhost_set_state_op)(struct vhost_dev *dev, bool started);
+typedef int (*vhost_get_device_id_op)(struct vhost_dev *dev, uint32_t *dev_id);
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -138,6 +142,7 @@ typedef struct VhostOps {
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
+    vhost_set_vring_ready_op vhost_set_vring_ready;
     vhost_requires_shm_log_op vhost_requires_shm_log;
     vhost_migration_done_op vhost_migration_done;
     vhost_backend_can_merge_op vhost_backend_can_merge;
@@ -152,9 +157,12 @@ typedef struct VhostOps {
     vhost_backend_mem_section_filter_op vhost_backend_mem_section_filter;
     vhost_get_inflight_fd_op vhost_get_inflight_fd;
     vhost_set_inflight_fd_op vhost_set_inflight_fd;
+    vhost_set_state_op vhost_set_state;
+    vhost_get_device_id_op vhost_get_device_id;
 } VhostOps;
 
 extern const VhostOps user_ops;
+extern const VhostOps vdpa_ops;
 
 int vhost_set_backend_type(struct vhost_dev *dev,
                            VhostBackendType backend_type);
diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
new file mode 100644
index 0000000000..6455663388
--- /dev/null
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -0,0 +1,26 @@
+/*
+ * vhost-vdpa.h
+ *
+ * Copyright(c) 2017-2018 Intel Corporation.
+ * Copyright(c) 2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef HW_VIRTIO_VHOST_VDPA_H
+#define HW_VIRTIO_VHOST_VDPA_H
+
+#include "hw/virtio/virtio.h"
+
+typedef struct vhost_vdpa {
+    int device_fd;
+    uint32_t msg_type;
+    MemoryListener listener;
+} VhostVDPA;
+
+extern AddressSpace address_space_memory;
+extern int vhost_vdpa_get_device_id(struct vhost_dev *dev,
+                                   uint32_t *device_id);
+#endif
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 085450c6f8..b682545f51 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -124,6 +124,7 @@ int vhost_dev_get_config(struct vhost_dev *dev, uint8_t *config,
                          uint32_t config_len);
 int vhost_dev_set_config(struct vhost_dev *dev, const uint8_t *data,
                          uint32_t offset, uint32_t size, uint32_t flags);
+int vhost_dev_get_device_id(struct vhost_dev *hdev, uint32_t *device_id);
 /* notifier callback in case vhost device config space changed
  */
 void vhost_dev_set_config_notifier(struct vhost_dev *dev,
@@ -137,4 +138,5 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
                            struct vhost_inflight *inflight);
 int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
                            struct vhost_inflight *inflight);
+int vhost_set_state(struct vhost_dev *dev, bool started);
 #endif
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 8a6f208189..56e67fe164 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -40,5 +40,5 @@ int vhost_set_vring_ready(NetClientState *nc);
 uint64_t vhost_net_get_acked_features(VHostNetState *net);
 
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
-
-#endif
+int vhost_net_get_device_id(struct vhost_net *net, uint32_t *device_id);
+endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 292d4e7c0c..c19e10ce9c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2409,6 +2409,10 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
 #ifdef CONFIG_POSIX
     "-netdev vhost-user,id=str,chardev=dev[,vhostforce=on|off]\n"
     "                configure a vhost-user network, backed by a chardev 'dev'\n"
+#endif
+#ifdef CONFIG_POSIX
+    "-netdev vhost-vdpa,id=str,vhostdev=/path/to/dev\n"
+    "                configure a vhost-vdpa network,Establish a vhost-vdpa netdev\n"
 #endif
     "-netdev hubport,id=str,hubid=n[,netdev=nd]\n"
     "                configure a hub port on the hub with ID 'n'\n", QEMU_ARCH_ALL)
@@ -2428,6 +2432,9 @@ DEF("nic", HAS_ARG, QEMU_OPTION_nic,
 #endif
 #ifdef CONFIG_POSIX
     "vhost-user|"
+#endif
+#ifdef CONFIG_POSIX
+    "vhost-vdpa|"
 #endif
     "socket][,option][,...][mac=macaddr]\n"
     "                initialize an on-board / default host NIC (using MAC address\n"
@@ -2896,6 +2903,14 @@ SRST
     hubport to another netdev with ID nd by using the ``netdev=nd``
     option.
 
+``-netdev vhost-vdpa,vhostdev=/path/to/dev ``
+    Establish a vhost-vdpa netdev.
+
+    vDPA device is a device that uses a datapath which complies with
+    the virtio specifications with a vendor specific control path.
+    vDPA devices can be both physically located on the hardware or
+    emulated by software.
+
 ``-net nic[,netdev=nd][,macaddr=mac][,model=type] [,name=name][,addr=addr][,vectors=v]``
     Legacy option to configure or create an on-board (or machine
     default) Network Interface Card(NIC) and connect it either to the
-- 
2.21.1


