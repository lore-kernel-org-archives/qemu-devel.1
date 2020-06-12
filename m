Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1664EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87DB20691
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjPziS7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87DB20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlCD-0007D9-W7
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2U-00076N-N0
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2S-0001Tm-7o
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aqpkevWS1bn14Aqbrax5GGDgUtTsP9lYBB9gZceP86Y=;
 b=CjPziS7prsAQ3SE52S6rvnBAY5fXZnSR5H+7CGJaRMUvu2FbnSiFl72pp9ztFK7lHopSFu
 7xa3SdbeL7CN7yt9En19VKen1niBHyunkSxeY3EBwCwSNnUTPYpxj+URbpqsGhzQZUtoUU
 fgF3KYoVrOKzV6L/8SUX2w4Ptg2rlOM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-kMF8hMYBO8CLDPfsb_Tk1w-1; Fri, 12 Jun 2020 10:52:08 -0400
X-MC-Unique: kMF8hMYBO8CLDPfsb_Tk1w-1
Received: by mail-wm1-f71.google.com with SMTP id p24so2548146wmc.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aqpkevWS1bn14Aqbrax5GGDgUtTsP9lYBB9gZceP86Y=;
 b=knUyygpqRQWF9+ZImlKxFoYs8NfzvdpNRiovDwymxD8+OtB/VG2cTgOcQpai0EplE5
 3YK2xhN/+v1WRoDmLE/epiMPiIbmRVPeafgHjLIn/QD0JVuPTWbkkMeMfkS3W6ua3t7G
 AK4qp84NfR5Z4f3VjxLnGfSD2nAoITgtg7n+kqI87zc4i4VudURMegB1xChI8A5m/Vb5
 7R6G/DPrYAvhwDMplHK15b0C2uIclP0fwE1Pl5JsHtm7ttF5D9IcjK2em6/P1N10MFzw
 k0qJFZlzmkjgirGj348qqw8SO8/H0lJlEuta5sucPdCEmZBXf1huSVgesBgOSGCXWDbr
 Y4Tw==
X-Gm-Message-State: AOAM530qGuItfK22XLxfL8YZgv31Eh5hjYMF3XgLHLgjhqzUPnJAZMOx
 niVUVgAFFa6lAuIkrhRgImFxtWzbQK9UX0HOHyX6e7pCve6KzMKcpWohny/mdE9WXZQ+cnPEbe7
 adZGqmwD4zn4AsZI=
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr15167147wrm.258.1591973527027; 
 Fri, 12 Jun 2020 07:52:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykdR7oFAZ1wWvTIy3aU7Osf7Xyg0PSOb8SGp/5sYfY4BQx7yekOL9KF5wrltQF0j6REeOpmw==
X-Received: by 2002:adf:dcd2:: with SMTP id x18mr15167137wrm.258.1591973526854; 
 Fri, 12 Jun 2020 07:52:06 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id b18sm10081990wrn.88.2020.06.12.07.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:06 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 28/58] hw/pci/pcie: Move hot plug capability check to
 pre_plug callback
Message-ID: <20200612141917.9446-29-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julia Suvorova <jusual@redhat.com>

Check for hot plug capability earlier to avoid removing devices attached
during the initialization process.

Run qemu with an unattached drive:
  -drive file=$FILE,if=none,id=drive0 \
  -device pcie-root-port,id=rp0,slot=3,bus=pcie.0,hotplug=off
Hotplug a block device:
  device_add virtio-blk-pci,id=blk0,drive=drive0,bus=rp0
If hotplug fails on plug_cb, drive0 will be deleted.

Fixes: 0501e1aa1d32a6 ("hw/pci/pcie: Forbid hot-plug if it's disabled on the slot")

Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Julia Suvorova <jusual@redhat.com>
Message-Id: <20200604125947.881210-1-jusual@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index f50e10b8fb..5b9c022d91 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -407,6 +407,17 @@ static void pcie_cap_slot_plug_common(PCIDevice *hotplug_dev, DeviceState *dev,
 void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
+    PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
+    uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
+    uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
+
+    /* Check if hot-plug is disabled on the slot */
+    if (dev->hotplugged && (sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
+        error_setg(errp, "Hot-plug failed: unsupported by the port device '%s'",
+                         DEVICE(hotplug_pdev)->id);
+        return;
+    }
+
     pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, errp);
 }
 
@@ -415,7 +426,6 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     PCIDevice *hotplug_pdev = PCI_DEVICE(hotplug_dev);
     uint8_t *exp_cap = hotplug_pdev->config + hotplug_pdev->exp.exp_cap;
-    uint32_t sltcap = pci_get_word(exp_cap + PCI_EXP_SLTCAP);
     PCIDevice *pci_dev = PCI_DEVICE(dev);
 
     /* Don't send event when device is enabled during qemu machine creation:
@@ -431,13 +441,6 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    /* Check if hot-plug is disabled on the slot */
-    if ((sltcap & PCI_EXP_SLTCAP_HPC) == 0) {
-        error_setg(errp, "Hot-plug failed: unsupported by the port device '%s'",
-                         DEVICE(hotplug_pdev)->id);
-        return;
-    }
-
     /* To enable multifunction hot-plug, we just ensure the function
      * 0 added last. When function 0 is added, we set the sltsta and
      * inform OS via event notification.
-- 
MST


