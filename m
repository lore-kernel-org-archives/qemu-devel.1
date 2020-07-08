Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB39C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9F9206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUQQVqEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9F9206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIOI-0002vA-Me
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtI1z-00008X-Th
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:55:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36948
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jtI1w-0005UA-8w
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSQN2wd8AGom8QPbQzKv4jp1CAWKOE/xbA8e4d059kA=;
 b=WUQQVqEHO2RIwgw8tFRS29rcYHtUJTZwXSb9O0X2/o18VXdm9ctw2QN6B7AM86WPmfa/eX
 T6ExbjRSQAqccVzBI00z+5HyCVJhh3luACN8EE3y355NdE1h/TUY8LLYf9QrYlSQJBiO7b
 aErJUtAjR3hna3gAEgQV28+PU0WEM+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-jYDfx538O2qUXCYuJUQriA-1; Wed, 08 Jul 2020 14:52:22 -0400
X-MC-Unique: jYDfx538O2qUXCYuJUQriA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCAFE1095;
 Wed,  8 Jul 2020 18:52:20 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-117.ams2.redhat.com [10.36.113.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7307C7880B;
 Wed,  8 Jul 2020 18:52:14 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 3/5] s390x: prepare device memory address space
Date: Wed,  8 Jul 2020 20:51:33 +0200
Message-Id: <20200708185135.46694-4-david@redhat.com>
In-Reply-To: <20200708185135.46694-1-david@redhat.com>
References: <20200708185135.46694-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's allocate the device memory information and setup the device
memory address space. Expose the maximum ramsize via SCLP and the actual
initial ramsize via diag260.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c         | 43 ++++++++++++++++++++++++++++++
 hw/s390x/sclp.c                    | 12 +++++++--
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 target/s390x/diag.c                |  4 +--
 4 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 2e6d292c23..577590e623 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -160,6 +160,35 @@ static void virtio_ccw_register_hcalls(void)
                                    virtio_ccw_hcall_early_printk);
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
+        if (QEMU_ALIGN_UP(machine->maxram_size, MiB) != machine->maxram_size) {
+            error_report("maximum memory size must by aligned to 1 MB");
+            exit(EXIT_FAILURE);
+        }
+
+        machine->device_memory->base = machine->ram_size;
+        if (machine->device_memory->base + device_mem_size < device_mem_size) {
+            error_report("unsupported amount of maximum memory: " RAM_ADDR_FMT,
+                         machine->maxram_size);
+            exit(EXIT_FAILURE);
+        }
+
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
@@ -194,6 +223,11 @@ static void s390_memory_init(MachineState *machine)
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
@@ -617,6 +651,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     s390mc->cpu_model_allowed = true;
     s390mc->css_migration_enabled = true;
     s390mc->hpage_1m_allowed = true;
+    s390mc->memory_devices_allowed = true;
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->hot_add_cpu = s390_hot_add_cpu;
@@ -713,6 +748,11 @@ bool hpage_1m_allowed(void)
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
@@ -831,8 +871,11 @@ static void ccw_machine_5_0_instance_options(MachineState *machine)
 
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
index f59195e15a..85d3505597 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -22,6 +22,7 @@
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 
 static inline SCLPDevice *get_sclp_device(void)
 {
@@ -110,8 +111,15 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
         read_info->rnsize2 = cpu_to_be32(rnsize);
     }
 
-    /* we don't support standby memory, maxram_size is never exposed */
-    rnmax = machine->ram_size >> sclp->increment_size;
+    /*
+     * Support for maxram was added with support for memory devices. The
+     * size of the initial memory is exposed via diag260.
+     */
+    if (memory_devices_allowed()) {
+        rnmax = machine->maxram_size >> sclp->increment_size;
+    } else {
+        rnmax = machine->ram_size >> sclp->increment_size;
+    }
     if (rnmax < 0x10000) {
         read_info->rnmax = cpu_to_be16(rnmax);
     } else {
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index cd1dccc6e3..3a1e7e2a6d 100644
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
+/* Allow memory devices and diag260. */
+bool memory_devices_allowed(void);
 
 /**
  * Returns true if (vmstate based) migration of the channel subsystem
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index c3b1e24b2c..6b33eb0efc 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -32,8 +32,8 @@ void handle_diag_260(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
     ram_addr_t addr, length;
     uint64_t tmp;
 
-    /* TODO: Unlock with new QEMU machine. */
-    if (false) {
+    /* Support for diag260 is glued to support for memory devices. */
+    if (!memory_devices_allowed()) {
         s390_program_interrupt(env, PGM_OPERATION, ra);
         return;
     }
-- 
2.26.2


