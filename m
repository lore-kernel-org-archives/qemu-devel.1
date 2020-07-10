Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D853EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA9420725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPT22Pse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA9420725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvzx-0000lp-Sr
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jtvjs-0003JQ-2b
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:19:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57101
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jtvjq-0005dR-CH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594397941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YijAE5P4A/gwOkKyuIpZd1Qqwg6CpaYLc4Ben0Ht0jU=;
 b=EPT22PsegLPsyGHv5tOFdKq6A8FkyDTBbZUrVjue7SjFa79VfPFyeibMemZm6qqY2/5lj6
 NT+8EL/sbT1/hkKP07Q2cKcaOMuMNSkHzbhcmcULbK3uuvoAy+/y6l1t2sQ6RoxG2sTeQZ
 qRrFYlyMSL6lcejGCDRl6jzO9f8qOzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-7CHUtvjYOPqlq-tkaNTZbg-1; Fri, 10 Jul 2020 12:17:12 -0400
X-MC-Unique: 7CHUtvjYOPqlq-tkaNTZbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0ACC106B20F;
 Fri, 10 Jul 2020 16:17:11 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDE2E7EF9E;
 Fri, 10 Jul 2020 16:17:08 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 1/3] x86: lpc9: let firmware negotiate CPU hotplug SMI feature
Date: Fri, 10 Jul 2020 12:17:02 -0400
Message-Id: <20200710161704.309824-2-imammedo@redhat.com>
In-Reply-To: <20200710161704.309824-1-imammedo@redhat.com>
References: <20200710161704.309824-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
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
Cc: lersek@redhat.com, boris.ostrovsky@oracle.com, liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It will allow firmware to notify QEMU that firmware requires SMI
being triggered on CPU hotplug, so that it would be able to account
for hotplugged CPU and relocate it to new SMM base.

Using the negotiated feature, follow up patches will insert SMI upcall
into AML code, to make sure that firmware processes hotplug before
guest OS would attempt to use new CPU.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/i386/ich9.h | 1 +
 hw/i386/pc.c           | 4 +++-
 hw/isa/lpc_ich9.c      | 7 +++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index a98d10b252..422891a152 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -247,5 +247,6 @@ typedef struct ICH9LPCState {
 
 /* bit positions used in fw_cfg SMI feature negotiation */
 #define ICH9_LPC_SMI_F_BROADCAST_BIT            0
+#define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
 
 #endif /* HW_ICH9_H */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d7f27bc16b..6fe80c84d7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -97,7 +97,9 @@
 #include "fw_cfg.h"
 #include "trace.h"
 
-GlobalProperty pc_compat_5_0[] = {};
+GlobalProperty pc_compat_5_0[] = {
+    { "ICH9-LPC", "x-smi-cpu-hotplug", "off" },
+};
 const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
 
 GlobalProperty pc_compat_4_2[] = {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index cd6e169d47..83da7346ab 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -373,6 +373,11 @@ static void smi_features_ok_callback(void *opaque)
         /* guest requests invalid features, leave @features_ok at zero */
         return;
     }
+    if (!(guest_features & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT)) &&
+        guest_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT)) {
+        /* cpu hotplug SMI requires SMI broadcast, leave @features_ok at zero */
+        return;
+    }
 
     /* valid feature subset requested, lock it down, report success */
     lpc->smi_negotiated_features = guest_features;
@@ -747,6 +752,8 @@ static Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, true),
     DEFINE_PROP_BIT64("x-smi-broadcast", ICH9LPCState, smi_host_features,
                       ICH9_LPC_SMI_F_BROADCAST_BIT, true),
+    DEFINE_PROP_BIT64("x-smi-cpu-hotplug", ICH9LPCState, smi_host_features,
+                      ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.26.2


