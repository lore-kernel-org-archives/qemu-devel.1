Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C2EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABD42076A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHMUifD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABD42076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1QD-0002yL-Gl
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kL1Mg-0006XP-N1
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kL1Me-0007UC-Va
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600854424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GoW/qE+i0LwwkHjanLNRpSZyIljNlGdSZOSjJtcnZfM=;
 b=GHMUifD22xsmRLACQ2M12diHxoyjK22yWcqvZ0eGpCc2yR5RFZ88xo4TZ0rzqMCKnhEeLI
 8ss62YGU8vqhd5XV8gEuTg1+0TNqRgBLLjQ48DNuFj8zzW3n+zFmXe4F/6fN8/XJQCS+D3
 obg4V2BoykmkkXzXtdy5pdhcHfcPw/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-z5P6GzvZOOuV9G4fUbT9_A-1; Wed, 23 Sep 2020 05:47:02 -0400
X-MC-Unique: z5P6GzvZOOuV9G4fUbT9_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89C571074645;
 Wed, 23 Sep 2020 09:47:01 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77C5455778;
 Wed, 23 Sep 2020 09:47:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 01/11] x86: lpc9: let firmware negotiate 'CPU hotplug with
 SMI' features
Date: Wed, 23 Sep 2020 05:46:40 -0400
Message-Id: <20200923094650.1301166-2-imammedo@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
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

It will allow firmware to notify QEMU that firmware requires SMI
being triggered on CPU hot[un]plug, so that it would be able to account
for hotplugged CPU and relocate it to new SMM base and/or safely remove
CPU on unplug.

Using negotiated features, follow up patches will insert SMI upcall
into AML code, to make sure that firmware processes hotplug before
guest OS would attempt to use new CPU.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
---
v4:
  - fix 5.2 machine types so they won't apply pc_compat_5_1
     (Laszlo Ersek <lersek@redhat.com>)
v3:
  - rebase on top of "[PATCH v2] hw: add compat machines for 5.2"
    so apply that before this patch
v2:
  - rebase on top of 5.1 (move compat values to 5.1 machine)
  - make "x-smi-cpu-hotunplug" false by default (Laszlo Ersek <lersek@redhat.com>)

fixup
---
 include/hw/i386/ich9.h |  2 ++
 hw/i386/pc.c           |  4 +++-
 hw/isa/lpc_ich9.c      | 13 +++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index 48b442bc0b..703d56036a 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -247,5 +247,7 @@ struct ICH9LPCState {
 
 /* bit positions used in fw_cfg SMI feature negotiation */
 #define ICH9_LPC_SMI_F_BROADCAST_BIT            0
+#define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
+#define ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT       2
 
 #endif /* HW_ICH9_H */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b55369357e..2af660c55e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -97,7 +97,9 @@
 #include "trace.h"
 #include CONFIG_DEVICES
 
-GlobalProperty pc_compat_5_1[] = {};
+GlobalProperty pc_compat_5_1[] = {
+    { "ICH9-LPC", "x-smi-cpu-hotplug", "off" },
+};
 const size_t pc_compat_5_1_len = G_N_ELEMENTS(pc_compat_5_1);
 
 GlobalProperty pc_compat_5_0[] = {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 3303d2eab6..a54b3ec8bd 100644
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
2.27.0


