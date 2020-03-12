Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AF2C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F0F206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/8G0Gty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F0F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR8O-0003VQ-Sj
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxt-0000x3-T3
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxs-0005KP-MI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxs-0005K4-FR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:44 -0400
Received: by mail-wm1-x341.google.com with SMTP id a5so6859605wmb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Vxng+M8yzsnsXH08YfIVFh29B0ARvhhfBQTx3o0z1vQ=;
 b=U/8G0Gtywpcq2Nr+FZ54HydWbzl9bLG+ed/mvWMkUiFn3Wg5gcv2bj00VMj/djCKlb
 SN/sVwkz4IwUctWtG1CnxfiQzw+uLkuRGx3QLo6twkLa7tAcEtnXJfOgk7a4JKr6cqBG
 7LQbNgu3QxKYJ2X7Vmz44H9bO5SV5a/I6KJMe44qlJI2DDEmuEZQfi3cfAI0S+Kgj6Ur
 oiGIBdNC8fC99KKSTrNiTwijRLpYt2cqgt1aNaIQALObdCl2qmrm4TskCqkIiwmXAaIb
 xVU02xdjFnsrDh7G/cvFeLJQg+8dzQ6J0/JIkqUeOVqLQTOzYOT5Pay/q809IkvdXtpr
 AO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vxng+M8yzsnsXH08YfIVFh29B0ARvhhfBQTx3o0z1vQ=;
 b=fAF6c+DjL2NeqFJjM/O6NgjTspssuzXjEVx/BCMzCqhlqPYO7gQuU7fiEN5pUTyKR4
 WnoCvHB8daLlGuWny05Zkd+oWFkELDKijdpjcdX2Tcddkkdm11K90Oi9c4/u7qqCGBlH
 A8WARvcofO2nQziCMyZfOM/TTIf1Jj0XuWBattDiDaZMu4uEbyMBWN4zMyY9XzsbZzrO
 Di9cJlpcvaO2kl7Ba6Fs3XAEzrzPuXjTxJl5R934/6RfmWi2kuXKq8yKiCGUC9ZGbN/g
 qIQ5sG0TofnBrbI6Ns/SjrQoqW4q8xxIOS6rzX5ImIj/IqGmupV49J9iY/LRabK4lFgl
 4Oug==
X-Gm-Message-State: ANhLgQ0iDCNkWd0UDkexCtltQtEhoUOr7epNc+ZL8s4aHzJ3ii0BAyBp
 4Rqtlyy1KY7fPRg9tAd47FeESrw8WgXVVg==
X-Google-Smtp-Source: ADFU+vu9Os4ok3piNvGPBYHCKDW3MfSIiEr6Ue1yntYMo0bJrxQm30sLX9GAK8R+Oh9PA9ZWVv1xjw==
X-Received: by 2002:a1c:418b:: with SMTP id o133mr5870841wma.165.1584031543183; 
 Thu, 12 Mar 2020 09:45:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/36] hw/arm/virt: kvm: allow gicv3 by default if v2 cannot
 work
Date: Thu, 12 Mar 2020 16:44:58 +0000
Message-Id: <20200312164459.25924-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

At the moment if the end-user does not specify the gic-version along
with KVM acceleration, v2 is set by default. However most of the
systems now have GICv3 and sometimes they do not support GICv2
compatibility.

This patch keeps the default v2 selection in all cases except
in the KVM accelerated mode when either
- the host does not support GICv2 in-kernel emulation or
- number of VCPUS exceeds 8.

Those cases did not work anyway so we do not break any compatibility.
Now we get v3 selected in such a case.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 20200311131618.7187-7-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 90966580a3d..94f93dda54f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1543,6 +1543,8 @@ static void virt_set_memmap(VirtMachineState *vms)
  */
 static void finalize_gic_version(VirtMachineState *vms)
 {
+    unsigned int max_cpus = MACHINE(vms)->smp.max_cpus;
+
     if (kvm_enabled()) {
         int probe_bitmap;
 
@@ -1582,7 +1584,20 @@ static void finalize_gic_version(VirtMachineState *vms)
             }
             return;
         case VIRT_GIC_VERSION_NOSEL:
-            vms->gic_version = VIRT_GIC_VERSION_2;
+            if ((probe_bitmap & KVM_ARM_VGIC_V2) && max_cpus <= GIC_NCPU) {
+                vms->gic_version = VIRT_GIC_VERSION_2;
+            } else if (probe_bitmap & KVM_ARM_VGIC_V3) {
+                /*
+                 * in case the host does not support v2 in-kernel emulation or
+                 * the end-user requested more than 8 VCPUs we now default
+                 * to v3. In any case defaulting to v2 would be broken.
+                 */
+                vms->gic_version = VIRT_GIC_VERSION_3;
+            } else if (max_cpus > GIC_NCPU) {
+                error_report("host only supports in-kernel GICv2 emulation "
+                             "but more than 8 vcpus are requested");
+                exit(1);
+            }
             break;
         case VIRT_GIC_VERSION_2:
         case VIRT_GIC_VERSION_3:
-- 
2.20.1


