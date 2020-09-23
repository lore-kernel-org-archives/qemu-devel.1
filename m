Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924F1C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F405214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPzrw9o0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F405214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1YF-0003jk-5N
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kL1N1-00079Z-Ub
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kL1Mz-0007YC-Ji
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600854444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqGqtKQYjl+BZQtaCUdh1odL9kYy1L6L1FDqXYexFg0=;
 b=KPzrw9o0Z0HKkGNxo7YlqUiz8YGXyYP/grdnXWxJM3K3qkWxwjbj/dbwrLJeJ+KntKEwkk
 UGRaG+SShhBPUiGW44jNcrGvdxohM9uMHGGI967fUpEweJX8AWzhu/46mHyugtd2c6q+gB
 zKlDQZ6UVW40GddcwtQKOpMhcCIYofc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-mK-ltPyAOG6Cs9UQKriZHg-1; Wed, 23 Sep 2020 05:47:22 -0400
X-MC-Unique: mK-ltPyAOG6Cs9UQKriZHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB13F107465A;
 Wed, 23 Sep 2020 09:47:21 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA41455768;
 Wed, 23 Sep 2020 09:47:20 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/11] x68: acpi: trigger SMI before sending hotplug Notify
 event to OSPM
Date: Wed, 23 Sep 2020 05:46:48 -0400
Message-Id: <20200923094650.1301166-10-imammedo@redhat.com>
In-Reply-To: <20200923094650.1301166-1-imammedo@redhat.com>
References: <20200923094650.1301166-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lersek@redhat.com, ankur.a.arora@oracle.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case firmware has negotiated CPU hotplug SMI feature, generate
AML to describe SMI IO port region and send SMI to firmware
on each CPU hotplug SCI in case new CPUs were hotplugged.

Since new CPUs can be hotplugged while CPU_SCAN_METHOD is running
we can't send SMI before new CPUs are fetched from QEMU as it
could cause sending Notify to a CPU that firmware hasn't seen yet.
So fetch new CPUs into local cache first, then send SMI and
after that send Notify events to cached CPUs. This should ensure
that Notify is sent only to CPUs which were processed by firmware
first.
Any CPUs that were hotplugged after caching will be processed
by the next CPU_SCAN_METHOD, when pending SCI is handled.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
---
v6:
 - Add comment explaining why while_ctx2 restarts from the last processed CPU.
v5:
 - fix hotplug on Windows when there is more than 256 possible CPUs
   (Windows isn't able to handle VarPackage over 255 elements
    so process CPUs in batches)
 - (Laszlo Ersek <lersek@redhat.com>)
   - fix off-by-one in package length
   - fix not selecting CPU before clearing insert event
   - use aml_lgreater() instead of aml_lnot(aml_equal(num_added_cpus, zero)
   - split off in separate patches:
     - making smi_negotiated_features a property
     - introduction of AcpiPmInfo.smi_on_cpuhp
     - introduction of PCI0.SMI0 ACPI device
v2:
 - clear insert event after firmware has returned
   control from SMI. (Laszlo Ersek <lersek@redhat.com>)
v1:
 - make sure that Notify is sent only to CPUs seen by FW
 - (Laszlo Ersek <lersek@redhat.com>)
    - use macro instead of x-smi-negotiated-features
    - style fixes
    - reserve whole SMI block (0xB2, 0xB3)
v0:
 - s/aml_string/aml_eisaid/
   /fixes Windows BSOD, on nonsense value/ (Laszlo Ersek <lersek@redhat.com>)
 - put SMI device under PCI0 like the rest of hotplug IO port
 - do not generate SMI AML if CPU hotplug SMI feature hasn't been negotiated
---
 hw/acpi/cpu.c | 165 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 138 insertions(+), 27 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 3d6a500fb7..8dd4d8ebbf 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -14,6 +14,8 @@
 #define ACPI_CPU_CMD_DATA_OFFSET_RW 8
 #define ACPI_CPU_CMD_DATA2_OFFSET_R 0
 
+#define OVMF_CPUHP_SMI_CMD 4
+
 enum {
     CPHP_GET_NEXT_CPU_WITH_EVENT_CMD = 0,
     CPHP_OST_EVENT_CMD = 1,
@@ -321,6 +323,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_NOTIFY_METHOD "CTFY"
 #define CPU_EJECT_METHOD  "CEJ0"
 #define CPU_OST_METHOD    "COST"
+#define CPU_ADDED_LIST    "CNEW"
 
 #define CPU_ENABLED       "CPEN"
 #define CPU_SELECTOR      "CSEL"
@@ -465,42 +468,150 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
 
         method = aml_method(CPU_SCAN_METHOD, 0, AML_SERIALIZED);
         {
+            const uint8_t max_cpus_per_pass = 255;
             Aml *else_ctx;
-            Aml *while_ctx;
+            Aml *while_ctx, *while_ctx2;
             Aml *has_event = aml_local(0);
             Aml *dev_chk = aml_int(1);
             Aml *eject_req = aml_int(3);
             Aml *next_cpu_cmd = aml_int(CPHP_GET_NEXT_CPU_WITH_EVENT_CMD);
+            Aml *num_added_cpus = aml_local(1);
+            Aml *cpu_idx = aml_local(2);
+            Aml *uid = aml_local(3);
+            Aml *has_job = aml_local(4);
+            Aml *new_cpus = aml_name(CPU_ADDED_LIST);
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
-            aml_append(method, aml_store(one, has_event));
-            while_ctx = aml_while(aml_equal(has_event, one));
+
+            /*
+             * Windows versions newer than XP (including Windows 10/Windows
+             * Server 2019), do support* VarPackageOp but, it is cripled to hold
+             * the same elements number as old PackageOp.
+             * For compatibility with Windows XP (so it won't crash) use ACPI1.0
+             * PackageOp which can hold max 255 elements.
+             *
+             * use named package as old Windows don't support it in local var
+             */
+            aml_append(method, aml_name_decl(CPU_ADDED_LIST,
+                                             aml_package(max_cpus_per_pass)));
+
+            aml_append(method, aml_store(zero, uid));
+            aml_append(method, aml_store(one, has_job));
+            /*
+             * CPU_ADDED_LIST can hold limited number of elements, outer loop
+             * allows to process CPUs in batches which let us to handle more
+             * CPUs than CPU_ADDED_LIST can hold.
+             */
+            while_ctx2 = aml_while(aml_equal(has_job, one));
             {
-                 /* clear loop exit condition, ins_evt/rm_evt checks
-                  * will set it to 1 while next_cpu_cmd returns a CPU
-                  * with events */
-                 aml_append(while_ctx, aml_store(zero, has_event));
-                 aml_append(while_ctx, aml_store(next_cpu_cmd, cpu_cmd));
-                 ifctx = aml_if(aml_equal(ins_evt, one));
-                 {
-                     aml_append(ifctx,
-                         aml_call2(CPU_NOTIFY_METHOD, cpu_data, dev_chk));
-                     aml_append(ifctx, aml_store(one, ins_evt));
-                     aml_append(ifctx, aml_store(one, has_event));
-                 }
-                 aml_append(while_ctx, ifctx);
-                 else_ctx = aml_else();
-                 ifctx = aml_if(aml_equal(rm_evt, one));
-                 {
-                     aml_append(ifctx,
-                         aml_call2(CPU_NOTIFY_METHOD, cpu_data, eject_req));
-                     aml_append(ifctx, aml_store(one, rm_evt));
-                     aml_append(ifctx, aml_store(one, has_event));
-                 }
-                 aml_append(else_ctx, ifctx);
-                 aml_append(while_ctx, else_ctx);
+                aml_append(while_ctx2, aml_store(zero, has_job));
+
+                aml_append(while_ctx2, aml_store(one, has_event));
+                aml_append(while_ctx2, aml_store(zero, num_added_cpus));
+
+                /*
+                 * Scan CPUs, till there are CPUs with events or
+                 * CPU_ADDED_LIST capacity is exhausted
+                 */
+                while_ctx = aml_while(aml_land(aml_equal(has_event, one),
+                                      aml_lless(uid, aml_int(arch_ids->len))));
+                {
+                     /*
+                      * clear loop exit condition, ins_evt/rm_evt checks will
+                      * set it to 1 while next_cpu_cmd returns a CPU with events
+                      */
+                     aml_append(while_ctx, aml_store(zero, has_event));
+
+                     aml_append(while_ctx, aml_store(uid, cpu_selector));
+                     aml_append(while_ctx, aml_store(next_cpu_cmd, cpu_cmd));
+
+                     /*
+                      * wrap around case, scan is complete, exit loop.
+                      * It happens since events are not cleared in scan loop,
+                      * so next_cpu_cmd continues to find already processed CPUs
+                      */
+                     ifctx = aml_if(aml_lless(cpu_data, uid));
+                     {
+                         aml_append(ifctx, aml_break());
+                     }
+                     aml_append(while_ctx, ifctx);
+
+                     /*
+                      * if CPU_ADDED_LIST is full, exit inner loop and process
+                      * collected CPUs
+                      */
+                     ifctx = aml_if(
+                         aml_equal(num_added_cpus, aml_int(max_cpus_per_pass)));
+                     {
+                         aml_append(ifctx, aml_store(one, has_job));
+                         aml_append(ifctx, aml_break());
+                     }
+                     aml_append(while_ctx, ifctx);
+
+                     aml_append(while_ctx, aml_store(cpu_data, uid));
+                     ifctx = aml_if(aml_equal(ins_evt, one));
+                     {
+                         /* cache added CPUs to Notify/Wakeup later */
+                         aml_append(ifctx, aml_store(uid,
+                             aml_index(new_cpus, num_added_cpus)));
+                         aml_append(ifctx, aml_increment(num_added_cpus));
+                         aml_append(ifctx, aml_store(one, has_event));
+                     }
+                     aml_append(while_ctx, ifctx);
+                     else_ctx = aml_else();
+                     ifctx = aml_if(aml_equal(rm_evt, one));
+                     {
+                         aml_append(ifctx,
+                             aml_call2(CPU_NOTIFY_METHOD, uid, eject_req));
+                         aml_append(ifctx, aml_store(one, rm_evt));
+                         aml_append(ifctx, aml_store(one, has_event));
+                     }
+                     aml_append(else_ctx, ifctx);
+                     aml_append(while_ctx, else_ctx);
+                     aml_append(while_ctx, aml_increment(uid));
+                }
+                aml_append(while_ctx2, while_ctx);
+
+                /*
+                 * in case FW negotiated ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT,
+                 * make upcall to FW, so it can pull in new CPUs before
+                 * OS is notified and wakes them up
+                 */
+                if (opts.smi_path) {
+                    ifctx = aml_if(aml_lgreater(num_added_cpus, zero));
+                    {
+                        aml_append(ifctx, aml_store(aml_int(OVMF_CPUHP_SMI_CMD),
+                            aml_name("%s", opts.smi_path)));
+                    }
+                    aml_append(while_ctx2, ifctx);
+                }
+
+                /* Notify OSPM about new CPUs and clear insert events */
+                aml_append(while_ctx2, aml_store(zero, cpu_idx));
+                while_ctx = aml_while(aml_lless(cpu_idx, num_added_cpus));
+                {
+                    aml_append(while_ctx,
+                        aml_store(aml_derefof(aml_index(new_cpus, cpu_idx)),
+                                  uid));
+                    aml_append(while_ctx,
+                        aml_call2(CPU_NOTIFY_METHOD, uid, dev_chk));
+                    aml_append(while_ctx, aml_store(uid, aml_debug()));
+                    aml_append(while_ctx, aml_store(uid, cpu_selector));
+                    aml_append(while_ctx, aml_store(one, ins_evt));
+                    aml_append(while_ctx, aml_increment(cpu_idx));
+                }
+                aml_append(while_ctx2, while_ctx);
+                /*
+                 * If another batch is needed, then it will resume scanning
+                 * exactly at -- and not after -- the last CPU that's currently
+                 * in CPU_ADDED_LIST. In other words, the last CPU in
+                 * CPU_ADDED_LIST is going to be re-checked. That's OK: we've
+                 * just cleared the insert event for *all* CPUs in
+                 * CPU_ADDED_LIST, including the last one. So the scan will
+                 * simply seek past it.
+                 */
             }
-            aml_append(method, while_ctx);
+            aml_append(method, while_ctx2);
             aml_append(method, aml_release(ctrl_lock));
         }
         aml_append(cpus_dev, method);
-- 
2.27.0


