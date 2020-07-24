Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9853FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62BD32065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 14:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4iq6H2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BD32065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyytt-0000GC-Lb
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 10:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jyyrO-0004jD-Jp
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:39:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31261
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jyyrM-0005ju-QH
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 10:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595601580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sDRRmQOugDOxphOywKhw1N5ppoc8F1FHE/wSOqAP6k=;
 b=V4iq6H2a1GKrECtq4iPTrppyR4RwX629vm+HeglNoezvgQdkhy0hlZDmeKQGRm0l2Sc1Cv
 +QmgZMoRq42y5dZcHcbqbCX4TF6eLNkcwxQopOVv0FcEkAKarX+XdDSNylDUNv8YcdEhHQ
 sA3M9/lpYFtAPwS3dJdjSS0e8I6AYcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-HULqiz0lOGGi-bp7Q4c7cg-1; Fri, 24 Jul 2020 10:38:24 -0400
X-MC-Unique: HULqiz0lOGGi-bp7Q4c7cg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74D49107ACCA;
 Fri, 24 Jul 2020 14:38:23 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-94.ams2.redhat.com [10.36.113.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2FFC726A4;
 Fri, 24 Jul 2020 14:38:20 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFCv3 7/9] s390x: prepare device memory address space
Date: Fri, 24 Jul 2020 16:37:48 +0200
Message-Id: <20200724143750.59836-8-david@redhat.com>
In-Reply-To: <20200724143750.59836-1-david@redhat.com>
References: <20200724143750.59836-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Let's allocate the device memory information and setup the device
memory address space. The RAM size returned via SCLP is not modified. Guest
OSs which support memory devices (like virtio-mem) are expected to
consult diag500(4).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c         | 37 ++++++++++++++++++++++++++++++
 hw/s390x/sclp.c                    |  6 ++++-
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index b481e5e5bd..23b94256e0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -115,6 +115,29 @@ static void subsystem_reset(void)
     }
 }
 
+static void s390_device_memory_init(MachineState *machine)
+{
+    MemoryRegion *sysmem = get_system_memory();
+
+    machine->device_memory = g_malloc0(sizeof(*machine->device_memory));
+
+    /* initialize device memory address space */
+    if (machine->ram_size < machine->maxram_size) {
+        ram_addr_t device_mem_size = machine->maxram_size - machine->ram_size;
+
+        if (!QEMU_IS_ALIGNED(machine->maxram_size, MiB)) {
+            error_report("maximum memory size must be aligned to 1 MB");
+            exit(EXIT_FAILURE);
+        }
+
+        machine->device_memory->base = machine->ram_size;
+        memory_region_init(&machine->device_memory->mr, OBJECT(machine),
+                           "device-memory", device_mem_size);
+        memory_region_add_subregion(sysmem, machine->device_memory->base,
+                                    &machine->device_memory->mr);
+    }
+}
+
 static void s390_memory_init(MachineState *machine)
 {
     MemoryRegion *sysmem = get_system_memory();
@@ -149,6 +172,11 @@ static void s390_memory_init(MachineState *machine)
     s390_skeys_init();
     /* Initialize storage attributes device */
     s390_stattrib_init();
+
+    /* Support for memory devices is glued to compat machines. */
+    if (memory_devices_allowed()) {
+        s390_device_memory_init(machine);
+    }
 }
 
 static void s390_init_ipl_dev(const char *kernel_filename,
@@ -569,6 +597,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     s390mc->cpu_model_allowed = true;
     s390mc->css_migration_enabled = true;
     s390mc->hpage_1m_allowed = true;
+    s390mc->memory_devices_allowed = true;
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->hot_add_cpu = s390_hot_add_cpu;
@@ -665,6 +694,11 @@ bool hpage_1m_allowed(void)
     return get_machine_class()->hpage_1m_allowed;
 }
 
+bool memory_devices_allowed(void)
+{
+    return get_machine_class()->memory_devices_allowed;
+}
+
 static char *machine_get_loadparm(Object *obj, Error **errp)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
@@ -783,8 +817,11 @@ static void ccw_machine_5_0_instance_options(MachineState *machine)
 
 static void ccw_machine_5_0_class_options(MachineClass *mc)
 {
+    S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
+
     ccw_machine_5_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
+    s390mc->memory_devices_allowed = false;
 }
 DEFINE_CCW_MACHINE(5_0, "5.0", false);
 
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index f59195e15a..316ff9c218 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -22,6 +22,7 @@
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 
 static inline SCLPDevice *get_sclp_device(void)
 {
@@ -110,7 +111,10 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
         read_info->rnsize2 = cpu_to_be32(rnsize);
     }
 
-    /* we don't support standby memory, maxram_size is never exposed */
+    /*
+     * We don't support standby memory. Currently, maxram_size is only
+     * implicitly exposed via diag500(4) to indicate the device memory region.
+     */
     rnmax = machine->ram_size >> sclp->increment_size;
     if (rnmax < 0x10000) {
         read_info->rnmax = cpu_to_be16(rnmax);
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index cd1dccc6e3..960eb9344f 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -41,6 +41,7 @@ typedef struct S390CcwMachineClass {
     bool cpu_model_allowed;
     bool css_migration_enabled;
     bool hpage_1m_allowed;
+    bool memory_devices_allowed;
 } S390CcwMachineClass;
 
 /* runtime-instrumentation allowed by the machine */
@@ -49,6 +50,8 @@ bool ri_allowed(void);
 bool cpu_model_allowed(void);
 /* 1M huge page mappings allowed by the machine */
 bool hpage_1m_allowed(void);
+/* memory devices are allowed by the machine (device memory region created). */
+bool memory_devices_allowed(void);
 
 /**
  * Returns true if (vmstate based) migration of the channel subsystem
-- 
2.26.2


