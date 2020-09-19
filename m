Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7BEC43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D6E2076B
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFzzsSV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D6E2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfOy-0005jc-9C
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfGs-00059g-QG
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfGq-0007LL-L4
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/wzb7xrxmd0jOnWHmRqv67gtlC1BQG+wJfikvKBTVHI=;
 b=IFzzsSV7R70Jg7sD5Duzz8/dS0t6dBA18qHNu/tsuKRjIoxlVHCsS1W5cboTDDsebYkUet
 NK6Jb4KZ4tHYs8qBPt8scrNlJjB9lOKjIYNh+iKmfWcvT+gJQAXXSdUUJGZAwkNNcrfh3/
 6LJuEJq3oks3YO3wX9q+bX1M0gbn5NQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273--e1jFTitMjKwBFPcCud7aw-1; Sat, 19 Sep 2020 11:59:25 -0400
X-MC-Unique: -e1jFTitMjKwBFPcCud7aw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DEE456BF2;
 Sat, 19 Sep 2020 15:59:24 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D5551002388;
 Sat, 19 Sep 2020 15:59:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/57] WHPX: vmware cpuid leaf for tsc and apic frequency
Date: Sat, 19 Sep 2020 11:58:26 -0400
Message-Id: <20200919155916.1046398-8-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 06:41:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sunil Muthuswamy <sunilmut@microsoft.com>

Newer versions of WHPX provide the capability to query the tsc
and apic frequency. Expose these through the vmware cpuid leaf.
This patch doesnt support setting the tsc frequency; that will
come as a separate fix.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Message-Id: <SN4PR2101MB08808DFDDC3F442BBEAADFF4C0710@SN4PR2101MB0880.namprd21.prod.outlook.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whp-dispatch.h |  3 +-
 target/i386/whpx-all.c     | 96 +++++++++++++++++++++++++++++++++-----
 2 files changed, 87 insertions(+), 12 deletions(-)

diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
index e4695c349f..b18aba20ed 100644
--- a/target/i386/whp-dispatch.h
+++ b/target/i386/whp-dispatch.h
@@ -2,10 +2,11 @@
 #define WHP_DISPATCH_H
 
 #include <windows.h>
-
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
 
+#define WHV_E_UNKNOWN_CAPABILITY 0x80370300L
+
 #define LIST_WINHVPLATFORM_FUNCTIONS(X) \
   X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, VOID* CapabilityBuffer, UINT32 CapabilityBufferSizeInBytes, UINT32* WrittenSizeInBytes)) \
   X(HRESULT, WHvCreatePartition, (WHV_PARTITION_HANDLE* Partition)) \
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index c78baac6df..3fad7928e8 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -27,6 +27,8 @@
 #include <WinHvPlatform.h>
 #include <WinHvEmulation.h>
 
+#define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
+
 struct whpx_state {
     uint64_t mem_quota;
     WHV_PARTITION_HANDLE partition;
@@ -1061,6 +1063,18 @@ static int whpx_vcpu_run(CPUState *cpu)
             cpu_x86_cpuid(env, cpuid_fn, 0, (UINT32 *)&rax, (UINT32 *)&rbx,
                 (UINT32 *)&rcx, (UINT32 *)&rdx);
             switch (cpuid_fn) {
+            case 0x40000000:
+                /* Expose the vmware cpu frequency cpuid leaf */
+                rax = 0x40000010;
+                rbx = rcx = rdx = 0;
+                break;
+
+            case 0x40000010:
+                rax = env->tsc_khz;
+                rbx = env->apic_bus_freq / 1000; /* Hz to KHz */
+                rcx = rdx = 0;
+                break;
+
             case 0x80000001:
                 /* Remove any support of OSVW */
                 rcx &= ~CPUID_EXT3_OSVW;
@@ -1191,8 +1205,12 @@ int whpx_init_vcpu(CPUState *cpu)
 {
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
-    struct whpx_vcpu *vcpu;
+    struct whpx_vcpu *vcpu = NULL;
     Error *local_error = NULL;
+    struct CPUX86State *env = (CPUArchState *)(cpu->env_ptr);
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    UINT64 freq = 0;
+    int ret;
 
     /* Add migration blockers for all unsupported features of the
      * Windows Hypervisor Platform
@@ -1207,7 +1225,8 @@ int whpx_init_vcpu(CPUState *cpu)
             error_report_err(local_error);
             migrate_del_blocker(whpx_migration_blocker);
             error_free(whpx_migration_blocker);
-            return -EINVAL;
+            ret = -EINVAL;
+            goto error;
         }
     }
 
@@ -1215,7 +1234,8 @@ int whpx_init_vcpu(CPUState *cpu)
 
     if (!vcpu) {
         error_report("WHPX: Failed to allocte VCPU context.");
-        return -ENOMEM;
+        ret = -ENOMEM;
+        goto error;
     }
 
     hr = whp_dispatch.WHvEmulatorCreateEmulator(
@@ -1224,8 +1244,8 @@ int whpx_init_vcpu(CPUState *cpu)
     if (FAILED(hr)) {
         error_report("WHPX: Failed to setup instruction completion support,"
                      " hr=%08lx", hr);
-        g_free(vcpu);
-        return -EINVAL;
+        ret = -EINVAL;
+        goto error;
     }
 
     hr = whp_dispatch.WHvCreateVirtualProcessor(
@@ -1234,17 +1254,72 @@ int whpx_init_vcpu(CPUState *cpu)
         error_report("WHPX: Failed to create a virtual processor,"
                      " hr=%08lx", hr);
         whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
-        g_free(vcpu);
-        return -EINVAL;
+        ret = -EINVAL;
+        goto error;
     }
 
-    vcpu->interruptable = true;
+    /*
+     * vcpu's TSC frequency is either specified by user, or use the value
+     * provided by Hyper-V if the former is not present. In the latter case, we
+     * query it from Hyper-V and record in env->tsc_khz, so that vcpu's TSC
+     * frequency can be migrated later via this field.
+     */
+    if (!env->tsc_khz) {
+        hr = whp_dispatch.WHvGetCapability(
+            WHvCapabilityCodeProcessorClockFrequency, &freq, sizeof(freq),
+                NULL);
+        if (hr != WHV_E_UNKNOWN_CAPABILITY) {
+            if (FAILED(hr)) {
+                printf("WHPX: Failed to query tsc frequency, hr=0x%08lx\n", hr);
+            } else {
+                env->tsc_khz = freq / 1000; /* Hz to KHz */
+            }
+        }
+    }
 
+    env->apic_bus_freq = HYPERV_APIC_BUS_FREQUENCY;
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeInterruptClockFrequency, &freq, sizeof(freq), NULL);
+    if (hr != WHV_E_UNKNOWN_CAPABILITY) {
+        if (FAILED(hr)) {
+            printf("WHPX: Failed to query apic bus frequency hr=0x%08lx\n", hr);
+        } else {
+            env->apic_bus_freq = freq;
+        }
+    }
+
+    /*
+     * If the vmware cpuid frequency leaf option is set, and we have a valid
+     * tsc value, trap the corresponding cpuid's.
+     */
+    if (x86_cpu->vmware_cpuid_freq && env->tsc_khz) {
+        UINT32 cpuidExitList[] = {1, 0x80000001, 0x40000000, 0x40000010};
+
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeCpuidExitList,
+                cpuidExitList,
+                RTL_NUMBER_OF(cpuidExitList) * sizeof(UINT32));
+
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set partition CpuidExitList hr=%08lx",
+                        hr);
+            ret = -EINVAL;
+            goto error;
+        }
+    }
+
+    vcpu->interruptable = true;
     cpu->vcpu_dirty = true;
     cpu->hax_vcpu = (struct hax_vcpu_state *)vcpu;
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, cpu->env_ptr);
 
     return 0;
+
+error:
+    g_free(vcpu);
+
+    return ret;
 }
 
 int whpx_vcpu_exec(CPUState *cpu)
@@ -1493,6 +1568,7 @@ static int whpx_accel_init(MachineState *ms)
     WHV_CAPABILITY whpx_cap;
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
+    UINT32 cpuidExitList[] = {1, 0x80000001};
 
     whpx = &whpx_global;
 
@@ -1551,7 +1627,6 @@ static int whpx_accel_init(MachineState *ms)
         goto error;
     }
 
-    UINT32 cpuidExitList[] = {1, 0x80000001};
     hr = whp_dispatch.WHvSetPartitionProperty(
         whpx->partition,
         WHvPartitionPropertyCodeCpuidExitList,
@@ -1579,14 +1654,13 @@ static int whpx_accel_init(MachineState *ms)
     printf("Windows Hypervisor Platform accelerator is operational\n");
     return 0;
 
-  error:
+error:
 
     if (NULL != whpx->partition) {
         whp_dispatch.WHvDeletePartition(whpx->partition);
         whpx->partition = NULL;
     }
 
-
     return ret;
 }
 
-- 
2.26.2



