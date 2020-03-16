Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF443C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975BE20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFaioZp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975BE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxQU-0006u7-Of
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH4-0002Wr-5y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxH1-0000gg-TK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21833)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxH1-0000bp-Mf
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j62ivAGq+cHjzdhXhOseUOUWPMi7FTi7mgcgLS+k3MI=;
 b=LFaioZp/WHDe7ywxp52GVnTnwhv7wmOnaqkByZHeuGqQMV2eh3oiQub4ccqa00QFgpObyS
 oT+k3ajchasBJcjQG6DWtJ1H2D4AonmQwh/Pbkr/toMCmi2zWYBJbhn2yvC2ZTUkcC2t4V
 f/KzUF5sl6P/nPGE98tMd+W6f3y6rWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-h3q9Uo5gNKSFspFxJ23Tiw-1; Mon, 16 Mar 2020 17:27:44 -0400
X-MC-Unique: h3q9Uo5gNKSFspFxJ23Tiw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01880800D5B;
 Mon, 16 Mar 2020 21:27:44 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DF6719C4F;
 Mon, 16 Mar 2020 21:27:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/61] WHPX: TSC get and set should be dependent on VM state
Date: Mon, 16 Mar 2020 22:26:34 +0100
Message-Id: <1584394048-44994-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

Currently, TSC is set as part of the VM runtime state. Setting TSC at
runtime is heavy and additionally can have side effects on the guest,
which are not very resilient to variances in the TSC. This patch uses
the VM state to determine whether to set TSC or not. Some minor
enhancements for getting TSC values as well that considers the VM state.

Additionally, while setting the TSC, the partition is suspended to
reduce the variance in the TSC value across vCPUs.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Message-Id: <SN4PR2101MB08804D23439166E81FF151F7C0EA0@SN4PR2101MB0880.nampr=
d21.prod.outlook.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/whpx.h      |   7 +++
 target/i386/whp-dispatch.h |   9 ++++
 target/i386/whpx-all.c     | 103 +++++++++++++++++++++++++++++++++++++++++=
----
 3 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/include/sysemu/whpx.h b/include/sysemu/whpx.h
index 4794e8e..a84b49e 100644
--- a/include/sysemu/whpx.h
+++ b/include/sysemu/whpx.h
@@ -35,4 +35,11 @@ int whpx_enabled(void);
=20
 #endif /* CONFIG_WHPX */
=20
+/* state subset only touched by the VCPU itself during runtime */
+#define WHPX_SET_RUNTIME_STATE   1
+/* state subset modified during VCPU reset */
+#define WHPX_SET_RESET_STATE     2
+/* full state set, modified during initialization or on vmload */
+#define WHPX_SET_FULL_STATE      3
+
 #endif /* QEMU_WHPX_H */
diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
index 87d049c..e4695c3 100644
--- a/target/i386/whp-dispatch.h
+++ b/target/i386/whp-dispatch.h
@@ -23,6 +23,12 @@
   X(HRESULT, WHvGetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partit=
ion, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 Registe=
rCount, WHV_REGISTER_VALUE* RegisterValues)) \
   X(HRESULT, WHvSetVirtualProcessorRegisters, (WHV_PARTITION_HANDLE Partit=
ion, UINT32 VpIndex, const WHV_REGISTER_NAME* RegisterNames, UINT32 Registe=
rCount, const WHV_REGISTER_VALUE* RegisterValues)) \
=20
+/*
+ * These are supplemental functions that may not be present
+ * on all versions and are not critical for basic functionality.
+ */
+#define LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(X) \
+  X(HRESULT, WHvSuspendPartitionTime, (WHV_PARTITION_HANDLE Partition)) \
=20
 #define LIST_WINHVEMULATION_FUNCTIONS(X) \
   X(HRESULT, WHvEmulatorCreateEmulator, (const WHV_EMULATOR_CALLBACKS* Cal=
lbacks, WHV_EMULATOR_HANDLE* Emulator)) \
@@ -40,10 +46,12 @@
 /* Define function typedef */
 LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
 LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
+LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
=20
 struct WHPDispatch {
     LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
     LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
+    LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
 };
=20
 extern struct WHPDispatch whp_dispatch;
@@ -53,6 +61,7 @@ bool init_whp_dispatch(void);
 typedef enum WHPFunctionList {
     WINHV_PLATFORM_FNS_DEFAULT,
     WINHV_EMULATION_FNS_DEFAULT,
+    WINHV_PLATFORM_FNS_SUPPLEMENTAL
 } WHPFunctionList;
=20
 #endif /* WHP_DISPATCH_H */
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 683d49d..b947eb1 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -114,7 +114,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] =
=3D {
     WHvX64RegisterXmmControlStatus,
=20
     /* X64 MSRs */
-    WHvX64RegisterTsc,
     WHvX64RegisterEfer,
 #ifdef TARGET_X86_64
     WHvX64RegisterKernelGsBase,
@@ -215,7 +214,44 @@ static SegmentCache whpx_seg_h2q(const WHV_X64_SEGMENT=
_REGISTER *hs)
     return qs;
 }
=20
-static void whpx_set_registers(CPUState *cpu)
+static int whpx_set_tsc(CPUState *cpu)
+{
+    struct CPUX86State *env =3D (CPUArchState *)(cpu->env_ptr);
+    WHV_REGISTER_NAME tsc_reg =3D WHvX64RegisterTsc;
+    WHV_REGISTER_VALUE tsc_val;
+    HRESULT hr;
+    struct whpx_state *whpx =3D &whpx_global;
+
+    /*
+     * Suspend the partition prior to setting the TSC to reduce the varian=
ce
+     * in TSC across vCPUs. When the first vCPU runs post suspend, the
+     * partition is automatically resumed.
+     */
+    if (whp_dispatch.WHvSuspendPartitionTime) {
+
+        /*
+         * Unable to suspend partition while setting TSC is not a fatal
+         * error. It just increases the likelihood of TSC variance between
+         * vCPUs and some guest OS are able to handle that just fine.
+         */
+        hr =3D whp_dispatch.WHvSuspendPartitionTime(whpx->partition);
+        if (FAILED(hr)) {
+            warn_report("WHPX: Failed to suspend partition, hr=3D%08lx", h=
r);
+        }
+    }
+
+    tsc_val.Reg64 =3D env->tsc;
+    hr =3D whp_dispatch.WHvSetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index, &tsc_reg, 1, &tsc_val);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set TSC, hr=3D%08lx", hr);
+        return -1;
+    }
+
+    return 0;
+}
+
+static void whpx_set_registers(CPUState *cpu, int level)
 {
     struct whpx_state *whpx =3D &whpx_global;
     struct whpx_vcpu *vcpu =3D get_whpx_vcpu(cpu);
@@ -230,6 +266,14 @@ static void whpx_set_registers(CPUState *cpu)
=20
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
=20
+    /*
+     * Following MSRs have side effects on the guest or are too heavy for
+     * runtime. Limit them to full state update.
+     */
+    if (level >=3D WHPX_SET_RESET_STATE) {
+        whpx_set_tsc(cpu);
+    }
+
     memset(&vcxt, 0, sizeof(struct whpx_register_set));
=20
     v86 =3D (env->eflags & VM_MASK);
@@ -330,8 +374,6 @@ static void whpx_set_registers(CPUState *cpu)
     idx +=3D 1;
=20
     /* MSRs */
-    assert(whpx_register_names[idx] =3D=3D WHvX64RegisterTsc);
-    vcxt.values[idx++].Reg64 =3D env->tsc;
     assert(whpx_register_names[idx] =3D=3D WHvX64RegisterEfer);
     vcxt.values[idx++].Reg64 =3D env->efer;
 #ifdef TARGET_X86_64
@@ -379,6 +421,25 @@ static void whpx_set_registers(CPUState *cpu)
     return;
 }
=20
+static int whpx_get_tsc(CPUState *cpu)
+{
+    struct CPUX86State *env =3D (CPUArchState *)(cpu->env_ptr);
+    WHV_REGISTER_NAME tsc_reg =3D WHvX64RegisterTsc;
+    WHV_REGISTER_VALUE tsc_val;
+    HRESULT hr;
+    struct whpx_state *whpx =3D &whpx_global;
+
+    hr =3D whp_dispatch.WHvGetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index, &tsc_reg, 1, &tsc_val);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get TSC, hr=3D%08lx", hr);
+        return -1;
+    }
+
+    env->tsc =3D tsc_val.Reg64;
+    return 0;
+}
+
 static void whpx_get_registers(CPUState *cpu)
 {
     struct whpx_state *whpx =3D &whpx_global;
@@ -394,6 +455,11 @@ static void whpx_get_registers(CPUState *cpu)
=20
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
=20
+    if (!env->tsc_valid) {
+        whpx_get_tsc(cpu);
+        env->tsc_valid =3D !runstate_is_running();
+    }
+
     hr =3D whp_dispatch.WHvGetVirtualProcessorRegisters(
         whpx->partition, cpu->cpu_index,
         whpx_register_names,
@@ -492,8 +558,6 @@ static void whpx_get_registers(CPUState *cpu)
     idx +=3D 1;
=20
     /* MSRs */
-    assert(whpx_register_names[idx] =3D=3D WHvX64RegisterTsc);
-    env->tsc =3D vcxt.values[idx++].Reg64;
     assert(whpx_register_names[idx] =3D=3D WHvX64RegisterEfer);
     env->efer =3D vcxt.values[idx++].Reg64;
 #ifdef TARGET_X86_64
@@ -896,7 +960,7 @@ static int whpx_vcpu_run(CPUState *cpu)
=20
     do {
         if (cpu->vcpu_dirty) {
-            whpx_set_registers(cpu);
+            whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
             cpu->vcpu_dirty =3D false;
         }
=20
@@ -1074,14 +1138,14 @@ static void do_whpx_cpu_synchronize_state(CPUState =
*cpu, run_on_cpu_data arg)
 static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
                                                run_on_cpu_data arg)
 {
-    whpx_set_registers(cpu);
+    whpx_set_registers(cpu, WHPX_SET_RESET_STATE);
     cpu->vcpu_dirty =3D false;
 }
=20
 static void do_whpx_cpu_synchronize_post_init(CPUState *cpu,
                                               run_on_cpu_data arg)
 {
-    whpx_set_registers(cpu);
+    whpx_set_registers(cpu, WHPX_SET_FULL_STATE);
     cpu->vcpu_dirty =3D false;
 }
=20
@@ -1123,6 +1187,15 @@ void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu)
=20
 static Error *whpx_migration_blocker;
=20
+static void whpx_cpu_update_state(void *opaque, int running, RunState stat=
e)
+{
+    CPUX86State *env =3D opaque;
+
+    if (running) {
+        env->tsc_valid =3D false;
+    }
+}
+
 int whpx_init_vcpu(CPUState *cpu)
 {
     HRESULT hr;
@@ -1178,6 +1251,7 @@ int whpx_init_vcpu(CPUState *cpu)
=20
     cpu->vcpu_dirty =3D true;
     cpu->hax_vcpu =3D (struct hax_vcpu_state *)vcpu;
+    qemu_add_vm_change_state_handler(whpx_cpu_update_state, cpu->env_ptr);
=20
     return 0;
 }
@@ -1367,6 +1441,10 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
=20
     #define WINHV_PLATFORM_DLL "WinHvPlatform.dll"
     #define WINHV_EMULATION_DLL "WinHvEmulation.dll"
+    #define WHP_LOAD_FIELD_OPTIONAL(return_type, function_name, signature)=
 \
+        whp_dispatch.function_name =3D \
+            (function_name ## _t)GetProcAddress(hLib, #function_name); \
+
     #define WHP_LOAD_FIELD(return_type, function_name, signature) \
         whp_dispatch.function_name =3D \
             (function_name ## _t)GetProcAddress(hLib, #function_name); \
@@ -1394,6 +1472,11 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
         WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
         LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
         break;
+
+    case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
+        WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
+        LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_LOAD_FIELD_OPTIONAL)
+        break;
     }
=20
     *handle =3D hLib;
@@ -1554,6 +1637,8 @@ bool init_whp_dispatch(void)
         goto error;
     }
=20
+    assert(load_whp_dispatch_fns(&hWinHvPlatform,
+        WINHV_PLATFORM_FNS_SUPPLEMENTAL));
     whp_dispatch_initialized =3D true;
=20
     return true;
--=20
1.8.3.1



