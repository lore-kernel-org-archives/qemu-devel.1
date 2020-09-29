Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853DCC4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4F92083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOjNSRHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4F92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAC0-00060Y-Ap
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xa-0003UZ-DY
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xU-0001fM-F1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XP1uoqzxcM1hmJV5OQbd/+8s4eonWOchAJJaT/NifAw=;
 b=UOjNSRHUJ0NuViOLbJymz9Wq7a7Sa+9simJIHtxZZ7VZhp0k09IbDSsdPhAYOPB4s0KQx6
 yC73GX/QndgSGCOI2jcqzcmf3U27ySu/0884QK5VgMFpzTCjNU4GFK8YcLLScUuZOmQG/E
 h7mEUvzc8+U1btKFxLcPN4BE83PHqY8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-RLF2rPzPPd-youJCCE8Baw-1; Tue, 29 Sep 2020 03:21:52 -0400
X-MC-Unique: RLF2rPzPPd-youJCCE8Baw-1
Received: by mail-wm1-f70.google.com with SMTP id m19so1454160wmg.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XP1uoqzxcM1hmJV5OQbd/+8s4eonWOchAJJaT/NifAw=;
 b=KyEPP25NxnlIu6dVDDwtCz4KdT8mulTyh9TASolZ9nO1HNo9BIE7yoj1wnTNvGCmxC
 Qll5vohYlu1IWnO/5Dw8tbLQ/Z8UOS8Z8vmfjXY4glY9ZvQOaW1e8GJOm1V8co9lQFp1
 sCRcpJnzWjQyigabzntcRoSJ80xSnvi+RmAYN+/OYIm27uX5sNjocB9C0xEiwOQv9HEZ
 Eh/ETp1Hx21HcrbLD4RT4mCCf8wf9howhvivHeV42oUoDDOi2YPiRwVtdADpk4fiXSxo
 arRDVFyyFh2BJcwzlYYsDauayDCNepQa3UYMrWgnBO2aWSbnSJkw6d5T3rFZ6orzfEY0
 ROPQ==
X-Gm-Message-State: AOAM533xDzFWxJS2IiPm+wuhgkW1eqkXkHoHBPRzEN8LjShhruw8ZFaV
 FmPINKdqijK03x6Sb+j3u2qWrbsRCcjyutwiEPO56pISs1GdpnKemD4hH2KFtk9o7c9+6bidxID
 4brzOSd93XC7nDdM=
X-Received: by 2002:a1c:4455:: with SMTP id r82mr2918096wma.60.1601364111330; 
 Tue, 29 Sep 2020 00:21:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbaXUMUQwo0oS1R6LyOyt/qJo+Eun0eQsgrYjqyd+DfdV/KFP1Lbz2V4KjiVsCIGj4ivUedg==
X-Received: by 2002:a1c:4455:: with SMTP id r82mr2918084wma.60.1601364111114; 
 Tue, 29 Sep 2020 00:21:51 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id g8sm3949827wmd.12.2020.09.29.00.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:50 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 21/48] x86: lpc9: let firmware negotiate 'CPU hotplug with
 SMI' features
Message-ID: <20200929071948.281157-22-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

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
Message-Id: <20200923094650.1301166-2-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index 50e8317342..2c6194e57f 100644
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
MST


