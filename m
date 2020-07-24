Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558D5C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157922065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvaEjf6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157922065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyyvK-00035T-AO
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jyyrn-0005cC-Vt
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:40:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jyyri-0005ms-Dq
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595601601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ie8F7GnIyVaznUpI713S0bySUx9tAt4Ec7k5vHxicQ0=;
 b=NvaEjf6ueeJDCa4/7LgP75Uyk/9ZIO8quUJDzZ9ufbG8KErvj71UUrX4A3vWkPGnziLxhJ
 GyQGa0O/fxsqNw+sYZSiICrRMdr1H3NBTijjGFbFlOK+oWM7eRffLlz4Kq1xR7uk7/2yuY
 8c4yZ969XhICV92EhoeXHy/r8ncY3QE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-E-0g_Pu4MWyCdBksMukxWA-1; Fri, 24 Jul 2020 10:38:30 -0400
X-MC-Unique: E-0g_Pu4MWyCdBksMukxWA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AFCDC7466;
 Fri, 24 Jul 2020 14:38:29 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-94.ams2.redhat.com [10.36.113.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04AE2710AC;
 Fri, 24 Jul 2020 14:38:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFCv3 9/9] s390x: initial support for virtio-mem
Date: Fri, 24 Jul 2020 16:37:50 +0200
Message-Id: <20200724143750.59836-10-david@redhat.com>
In-Reply-To: <20200724143750.59836-1-david@redhat.com>
References: <20200724143750.59836-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 08:55:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's wire up the initial, basic virtio-mem implementation in QEMU. It will
have to see some important extensions (esp., resizeable allocations)
before it can be considered production ready. Also, the focus on the Linux
driver side is on memory hotplug, there are a lot of things optimize in
the future to improve memory unplug capabilities. However, the basics
are in place.

Block migration for now, as we'll have to take proper care of storage
keys and storage attributes. Also, make sure to not hotplug huge pages
to a setup without huge pages.

With a Linux guest that supports virtio-mem (and has
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE set for now), a basic example.

1. Start a VM with 2G initial memory and a virtio-mem device with a maximum
   capacity of 18GB (and an initial size of 300M):
    sudo qemu-system-s390x \
        --enable-kvm \
        -m 2G,maxmem=20G \
        -smp 4 \
        -nographic \
        -chardev socket,id=monitor,path=/var/tmp/monitor,server,nowait \
        -mon chardev=monitor,mode=readline \
        -net nic -net user \
        -hda s390x.cow2 \
        -object memory-backend-ram,id=mem0,size=18G \
        -device virtio-mem-ccw,id=vm0,memdev=mem0,requested-size=300M

2. Query the current size of virtio-mem device:
    (qemu) info memory-devices
    Memory device [virtio-mem]: "vm0"
      memaddr: 0x80000000
      node: 0
      requested-size: 314572800
      size: 314572800
      max-size: 19327352832
      block-size: 1048576
      memdev: /objects/mem0

3. Request to grow it to 8GB:
    (qemu) qom-set vm0 requested-size 8G
    (qemu) info memory-devices
    Memory device [virtio-mem]: "vm0"
      memaddr: 0x80000000
      node: 0
      requested-size: 8589934592
      size: 8589934592
      max-size: 19327352832
      block-size: 1048576
      memdev: /objects/mem0

4. Request to shrink it to 800M (might take a while, might not fully
   succeed, and might not be able to remove memory blocks in Linux):
  (qemu) qom-set vm0 requested-size 800M
  (qemu) info memory-devices
  Memory device [virtio-mem]: "vm0"
    memaddr: 0x80000000
    node: 0
    requested-size: 838860800
    size: 838860800
    max-size: 19327352832
    block-size: 1048576
    memdev: /objects/mem0

Note 1: Due to lack of resizeable allocations, we will go ahead and
reserve a 18GB vmalloc area + size the QEMU RAM slot + KVM mamory slot
18GB. echo 1 > /proc/sys/vm/overcommit_memory might be required for
now. In the future, this area will instead grow on actual demand and shrink
when possible.

Note 2: Although virtio-mem-pci is wired up as well, it does not seem to
work currently on s390x due to lack of MSI-X.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/Kconfig           |   1 +
 hw/s390x/Makefile.objs     |   1 +
 hw/s390x/s390-virtio-ccw.c | 121 ++++++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-mem.c     |   2 +
 4 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 5e7d8a2bae..b8619c1adc 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -10,3 +10,4 @@ config S390_CCW_VIRTIO
     select SCLPCONSOLE
     select VIRTIO_CCW
     select MSI_NONBROKEN
+    select VIRTIO_MEM_SUPPORTED
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 2a35be0cda..279080afb8 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -20,6 +20,7 @@ obj-$(CONFIG_VIRTIO_NET) += virtio-ccw-net.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-ccw-blk.o
 obj-$(call land,$(CONFIG_VIRTIO_9P),$(CONFIG_VIRTFS)) += virtio-ccw-9p.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-ccw.o
+obj-$(CONFIG_VIRTIO_MEM) += virtio-ccw-mem.o
 endif
 obj-y += css-bridge.o
 obj-y += ccw-device.o
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 23b94256e0..7239f5a212 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -44,6 +44,8 @@
 #include "sysemu/sysemu.h"
 #include "hw/s390x/pv.h"
 #include "migration/blocker.h"
+#include "hw/mem/memory-device.h"
+#include "hw/virtio/virtio-mem-pci.h"
 
 static Error *pv_mig_blocker;
 
@@ -488,11 +490,121 @@ static void s390_machine_reset(MachineState *machine)
     s390_ipl_clear_reset_request();
 }
 
+static void s390_virtio_md_pre_plug(HotplugHandler *hotplug_dev,
+                                    DeviceState *dev, Error **errp)
+{
+    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
+    MemoryDeviceState *md = MEMORY_DEVICE(dev);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    Error *local_err = NULL;
+
+    if (!hotplug_dev2 && dev->hotplugged) {
+        /*
+         * Without a bus hotplug handler, we cannot control the plug/unplug
+         * order. We should never reach this point when hotplugging, however,
+         * better add a safety net.
+         */
+        error_setg(errp, "hotplug of virtio based memory devices not supported"
+                         " on this bus.");
+        return;
+    }
+
+    /*
+     * KVM does not support device memory with a bigger page size than initial
+     * memory. The new memory backend is not mapped yet, so
+     * qemu_maxrampagesize() won't consider it.
+     */
+    if (kvm_enabled()) {
+        MemoryRegion *mr = mdc->get_memory_region(md, &local_err);
+
+        if (local_err) {
+            goto out;
+        }
+        if (qemu_ram_pagesize(mr->ram_block) > qemu_maxrampagesize()) {
+            error_setg(&local_err, "Device memory has a bigger page size than"
+                       " initial memory");
+            goto out;
+        }
+    }
+
+    /*
+     * First, see if we can plug this memory device at all. If that
+     * succeeds, branch of to the actual hotplug handler.
+     */
+    memory_device_pre_plug(md, MACHINE(hotplug_dev), NULL, &local_err);
+    if (!local_err && hotplug_dev2) {
+        hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
+    }
+out:
+    error_propagate(errp, local_err);
+}
+
+static void s390_virtio_md_plug(HotplugHandler *hotplug_dev,
+                                DeviceState *dev, Error **errp)
+{
+    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
+    static Error *migration_blocker;
+    bool add_blocker = !migration_blocker;
+    Error *local_err = NULL;
+
+    /*
+     * Until we support migration of storage keys and storage attributes
+     * for anything that's not initial memory, let's block migration.
+     */
+    if (add_blocker) {
+        error_setg(&migration_blocker, "storage keys/attributes not yet"
+                   " migrated for memory devices");
+        migrate_add_blocker(migration_blocker, &local_err);
+        if (local_err) {
+            error_free_or_abort(&migration_blocker);
+            goto out;
+        }
+    }
+
+    /*
+     * Plug the memory device first and then branch off to the actual
+     * hotplug handler. If that one fails, we can easily undo the memory
+     * device bits.
+     */
+    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+    if (hotplug_dev2) {
+        hotplug_handler_plug(hotplug_dev2, dev, &local_err);
+        if (local_err) {
+            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+            if (add_blocker) {
+                migrate_del_blocker(migration_blocker);
+                error_free_or_abort(&migration_blocker);
+            }
+        }
+    }
+out:
+    error_propagate(errp, local_err);
+}
+
+static void s390_virtio_md_unplug_request(HotplugHandler *hotplug_dev,
+                                          DeviceState *dev, Error **errp)
+{
+    /* We don't support hot unplug of virtio based memory devices */
+    error_setg(errp, "virtio based memory devices cannot be unplugged.");
+}
+
+static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
+                                         DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_CCW) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        s390_virtio_md_pre_plug(hotplug_dev, dev, errp);
+    }
+}
+
 static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         s390_cpu_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_CCW) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        s390_virtio_md_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -501,7 +613,9 @@ static void s390_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         error_setg(errp, "CPU hot unplug not supported on this machine");
-        return;
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_CCW) ||
+               object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
+        s390_virtio_md_unplug_request(hotplug_dev, dev, errp);
     }
 }
 
@@ -542,7 +656,9 @@ static const CPUArchIdList *s390_possible_cpu_arch_ids(MachineState *ms)
 static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
                                                 DeviceState *dev)
 {
-    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_CCW) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
         return HOTPLUG_HANDLER(machine);
     }
     return NULL;
@@ -614,6 +730,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->possible_cpu_arch_ids = s390_possible_cpu_arch_ids;
     /* it is overridden with 'host' cpu *in kvm_arch_init* */
     mc->default_cpu_type = S390_CPU_TYPE_NAME("qemu");
+    hc->pre_plug = s390_machine_device_pre_plug;
     hc->plug = s390_machine_device_plug;
     hc->unplug_request = s390_machine_device_unplug_request;
     nc->nmi_monitor_handler = s390_nmi;
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index c12e9f79b0..fce86e4411 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -53,6 +53,8 @@
  */
 #if defined(TARGET_X86_64) || defined(TARGET_I386)
 #define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
+#elif defined(TARGET_S390X)
+#define VIRTIO_MEM_USABLE_EXTENT (2 * (256 * MiB))
 #else
 #error VIRTIO_MEM_USABLE_EXTENT not defined
 #endif
-- 
2.26.2


