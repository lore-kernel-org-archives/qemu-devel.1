Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53351C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F56A2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0KMxZPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F56A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8m0w-0000WR-C6
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 10:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k8lzi-0007lJ-Ke
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:56:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21105
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k8lzf-0004nc-Lb
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597935402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NC++NtjTUjLqrZsdejut/3jP6IIQ/Aq21Gsu3Qj3h1M=;
 b=L0KMxZPd1iXg7FFQCF8fCzz1/eULKT8D5QsYD26A777aZRi2Kx5wHd5Xhe+OLhk30hCzLn
 6S/dG0LOE/VrnVVmvWLgXI2ya/+CDg6WHHOlok33hDU2wYaeMsFH7eNR6RzA6MMyz2hdw6
 kKUzsXKGbHsa51n5Gs4MGIhFHzVgzIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-Mvgj6ne0MGyXprYnr_6DVg-1; Thu, 20 Aug 2020 10:56:40 -0400
X-MC-Unique: Mvgj6ne0MGyXprYnr_6DVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71CE21005E5B;
 Thu, 20 Aug 2020 14:56:39 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A13817567;
 Thu, 20 Aug 2020 14:56:38 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/7] x86: lpc9: let firmware negotiate 'CPU hotplug with
 SMI' features
Date: Thu, 20 Aug 2020 10:56:35 -0400
Message-Id: <20200820145635.1305276-1-imammedo@redhat.com>
In-Reply-To: <20200818122208.1243901-2-imammedo@redhat.com>
References: <20200818122208.1243901-2-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 08:28:03
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
Cc: boris.ostrovsky@oracle.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It will allow firmware to notify QEMU that firmware requires SMI
being triggered on CPU hot[un]plug, so that it would be able to account
for hotplugged CPU and relocate it to new SMM base and/or safely remove
CPU on unplug.

Using negotiated features, follow up patches will insert SMI upcall
into AML code, to make sure that firmware processes hotplug before
guest OS would attempt to use new CPU.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v3:
  - rebase on top of "[PATCH v2] hw: add compat machines for 5.2"
    so apply that before this patch
v2:
  - rebase on top of 5.1 (move compat values to 5.1 machine)
  - make "x-smi-cpu-hotunplug" false by default (Laszlo Ersek <lersek@redhat.com>)
---
 include/hw/i386/ich9.h |  2 ++
 hw/i386/pc.c           |  4 +++-
 hw/i386/pc_piix.c      |  1 +
 hw/i386/pc_q35.c       |  1 +
 hw/isa/lpc_ich9.c      | 13 +++++++++++++
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index a98d10b252..d1bb3f7bf0 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -247,5 +247,7 @@ typedef struct ICH9LPCState {
 
 /* bit positions used in fw_cfg SMI feature negotiation */
 #define ICH9_LPC_SMI_F_BROADCAST_BIT            0
+#define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
+#define ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT       2
 
 #endif /* HW_ICH9_H */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9aa813949c..583db11d28 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -97,7 +97,9 @@
 #include "fw_cfg.h"
 #include "trace.h"
 
-GlobalProperty pc_compat_5_1[] = {};
+GlobalProperty pc_compat_5_1[] = {
+    { "ICH9-LPC", "x-smi-cpu-hotplug", "off" },
+};
 const size_t pc_compat_5_1_len = G_N_ELEMENTS(pc_compat_5_1);
 
 GlobalProperty pc_compat_5_0[] = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c5ba70ca17..68f8ba1bf9 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -433,6 +433,7 @@ static void pc_i440fx_5_2_machine_options(MachineClass *m)
     m->alias = "pc";
     m->is_default = true;
     pcmc->default_cpu_version = 1;
+    compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
 }
 
 DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0cb9c18cd4..b729cf9a58 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -359,6 +359,7 @@ static void pc_q35_5_2_machine_options(MachineClass *m)
     pc_q35_machine_options(m);
     m->alias = "q35";
     pcmc->default_cpu_version = 1;
+    compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
 }
 
 DEFINE_Q35_MACHINE(v5_2, "pc-q35-5.2", NULL,
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index cd6e169d47..19f32bed3e 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -373,6 +373,15 @@ static void smi_features_ok_callback(void *opaque)
         /* guest requests invalid features, leave @features_ok at zero */
         return;
     }
+    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) &&
+        guest_features & (BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT) |
+                          BIT_ULL(ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT))) {
+        /*
+         * cpu hot-[un]plug with SMI requires SMI broadcast,
+         * leave @features_ok at zero
+         */
+        return;
+    }
 
     /* valid feature subset requested, lock it down, report success */
     lpc->smi_negotiated_features = guest_features;
@@ -747,6 +756,10 @@ static Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, true),
     DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
                       ICH9_LPC_SMI_F_BROADCAST_BIT, true),
+    DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_features,
+                      ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
+    DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_features,
+                      ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.26.2


