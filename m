Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6367C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8582C2250F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiiumhRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8582C2250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOxx-0006aj-LD
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iXOxD-0006AD-68
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:19:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iXOxB-0005oo-TF
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:19:27 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iXOxB-0005nc-ND
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:19:25 -0500
Received: by mail-wr1-x442.google.com with SMTP id l7so27890664wrp.6
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 04:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hIoVQwvcW/c90i/NOU0Sv6hdrZK8BmT0y456ire77lk=;
 b=ZiiumhRGfS/zRd3jCrxUhARPwdYM0XruAsmJo67vJVJ8IyXxyv3mxNtPMz04IxSdOi
 DvAYgUF3DrNkzgNyY0pB3qppcXSP/xiG1f18eDAOU/lxbEYayCL77krV/jT2v2Fjenus
 zKGDlU3RQON0WlDnvjX+SEkDoPUJJmU2YQB2IG1MGFx9KKsSJUauI3KiJxqfys8xHYFf
 g5/PHJjnb6U+An2gyxN6BgPpxs18+3N3z9nQ4sUJukLwgpQoh5b9ic0nXyGNUPYnD8Qr
 704+PX6UCH1oi+nNvoH4u6xh20LzmwA2CHjfWCdDLtnN0wofQIJyL/QFd+TpE2Oetmvt
 H+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=hIoVQwvcW/c90i/NOU0Sv6hdrZK8BmT0y456ire77lk=;
 b=DVns7nQbPv33B/kYbD1zIhLyaBFkXfuw8DMYqdL16YldXOBTCZ/r9jr6BBM2Uwc0VN
 CzLwbGqiNuFGw4X98HDm6/ZhrnS+pWzxzsMsGlIu0Fgtc7pOWC9Kv9VC73mmu9jQpSy7
 mEhfgaK4UMPxmoYClqK0tjYUEofQzhfXyAOIzlDXvQZKwDaxLcXGm6XXy6btkwEyZP03
 QX7pSgsSNom7MP9DfTM5yYPWiL9a6JxU4/k3dYkNAQPYJNnj6P6+YDngfQlZqH12Wn6w
 nFBJ7ZuqLM2yXn17H3EnsYhcCjMlgI6Whx+6EwiKx9zZu4lfof9Xc70+K93ZekgvSr1s
 Cxig==
X-Gm-Message-State: APjAAAXBPvexNTqrQnQW5O9z+Qqmb2/RiOGvGVmW8Z/ditjjX019JSn1
 fyVlBXkfKQbRHr5/PQvKgrdF/bdT
X-Google-Smtp-Source: APXvYqzkNsO/OKofAXR4tWBzJlsCFAfZHzPzm0ch7Ob6shfBu5Q0aw5ttqQjmgsePdzEzxNY/Nswgw==
X-Received: by 2002:a5d:5650:: with SMTP id j16mr3047673wrw.106.1574252364115; 
 Wed, 20 Nov 2019 04:19:24 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:dc24:9a59:da87:5724])
 by smtp.gmail.com with ESMTPSA id
 b17sm31483369wru.36.2019.11.20.04.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 04:19:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: add support for MSR_IA32_TSX_CTRL
Date: Wed, 20 Nov 2019 13:19:22 +0100
Message-Id: <20191120121922.6082-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The MSR_IA32_TSX_CTRL MSR can be used to hide TSX (also known as the
Trusty Side-channel Extension).  By virtualizing the MSR, KVM guests
can disable TSX and avoid paying the price of mitigating TSX-based
attacks on microarchitectural side channels.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c     |  2 +-
 target/i386/cpu.h     |  5 +++++
 target/i386/kvm.c     | 13 +++++++++++++
 target/i386/machine.c | 20 ++++++++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 296b491607..8447f4b82c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1204,7 +1204,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
             "rdctl-no", "ibrs-all", "rsba", "skip-l1dfl-vmentry",
-            "ssb-no", "mds-no", "pschange-mc-no", NULL,
+            "ssb-no", "mds-no", "pschange-mc-no", "tsx-ctrl",
             "taa-no", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5352c9ff55..cde2a16b94 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -349,7 +349,11 @@ typedef enum X86Seg {
 #define MSR_VIRT_SSBD                   0xc001011f
 #define MSR_IA32_PRED_CMD               0x49
 #define MSR_IA32_CORE_CAPABILITY        0xcf
+
 #define MSR_IA32_ARCH_CAPABILITIES      0x10a
+#define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
+
+#define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
 
 #define FEATURE_CONTROL_LOCKED                    (1<<0)
@@ -1449,6 +1453,7 @@ typedef struct CPUX86State {
     uint64_t msr_smi_count;
 
     uint32_t pkru;
+    uint32_t tsx_ctrl;
 
     uint64_t spec_ctrl;
     uint64_t virt_ssbd;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index bfd09bd441..bf1655645b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -97,6 +97,7 @@ static bool has_msr_hv_reenlightenment;
 static bool has_msr_xss;
 static bool has_msr_umwait;
 static bool has_msr_spec_ctrl;
+static bool has_msr_tsx_ctrl;
 static bool has_msr_virt_ssbd;
 static bool has_msr_smi_count;
 static bool has_msr_arch_capabs;
@@ -2036,6 +2037,9 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_IA32_SPEC_CTRL:
                 has_msr_spec_ctrl = true;
                 break;
+            case MSR_IA32_TSX_CTRL:
+                has_msr_tsx_ctrl = true;
+                break;
             case MSR_VIRT_SSBD:
                 has_msr_virt_ssbd = true;
                 break;
@@ -2694,6 +2698,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_spec_ctrl) {
         kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, env->spec_ctrl);
     }
+    if (has_msr_tsx_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_IA32_TSX_CTRL, env->tsx_ctrl);
+    }
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, env->virt_ssbd);
     }
@@ -3110,6 +3117,9 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_spec_ctrl) {
         kvm_msr_entry_add(cpu, MSR_IA32_SPEC_CTRL, 0);
     }
+    if (has_msr_tsx_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_IA32_TSX_CTRL, 0);
+    }
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, 0);
     }
@@ -3502,6 +3512,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_SPEC_CTRL:
             env->spec_ctrl = msrs[i].data;
             break;
+        case MSR_IA32_TSX_CTRL:
+            env->tsx_ctrl = msrs[i].data;
+            break;
         case MSR_VIRT_SSBD:
             env->virt_ssbd = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 7bdeb78157..2699eed94e 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1293,6 +1293,25 @@ static const VMStateDescription vmstate_efer32 = {
 };
 #endif
 
+static bool msr_tsx_ctrl_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->features[FEAT_ARCH_CAPABILITIES] & ARCH_CAP_TSX_CTRL_MSR;
+}
+
+static const VMStateDescription vmstate_msr_tsx_ctrl = {
+    .name = "cpu/msr_tsx_ctrl",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = msr_tsx_ctrl_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.tsx_ctrl, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1427,6 +1446,7 @@ VMStateDescription vmstate_x86_cpu = {
 #ifdef CONFIG_KVM
         &vmstate_nested_state,
 #endif
+        &vmstate_msr_tsx_ctrl,
         NULL
     }
 };
-- 
2.21.0


