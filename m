Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0F7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295792074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUYeVhsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295792074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisRR-0008NN-Cy
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisL0-00007s-8I
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKz-0008Ij-8v
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aqpkevWS1bn14Aqbrax5GGDgUtTsP9lYBB9gZceP86Y=;
 b=RUYeVhsRbj6VLh+oCu/kGw5PyebDpwvmbOggo0LB1/MU7HK1RF9SL0hQ4AkYoAG43E7PuD
 yvRlKplKI4om9dszKnmxmdaukJkvdzTcxZXdV2QKJQzKIGa+5JuRXu5NSrFnExj96gWB46
 rA+maP22ddYySqc+ObKw6qBcTn01H2k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-5mkY8ig_MqOfSWyM0ln2og-1; Wed, 10 Jun 2020 00:27:38 -0400
X-MC-Unique: 5mkY8ig_MqOfSWyM0ln2og-1
Received: by mail-wr1-f71.google.com with SMTP id e7so505452wrp.14
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aqpkevWS1bn14Aqbrax5GGDgUtTsP9lYBB9gZceP86Y=;
 b=EmPkAUQPbjmfjOxh6ZaD0Cc+CYELHIyIPfYeVJdYGZrgFeujvf8ohTtVVeQY3bOELl
 NxbsMZIgAL+FyCebTvIv97v78W2NXTAL8Z//rgV2ToeG4PCAnZdsl0tTl5itI+y/tHxP
 9iXCDC4UQN6QZ+Vs+5ufN4fz3Q6+rwxztRl+1BsVHrOpUt6jxnNMKJIAnM8XW39hX0cY
 4R29Xp0RdUN0ZeJ6GfWFEYAOmk3JDD9il6EqL4E86tlFtIkxkMh6W1m/e1iIcw8Peftq
 VFZzOCkzEkqqlmxR3FN+yFSlqrzzT+qil3IxgpO2UylT7a044MFjg0iYc48H/4bubNw2
 0mGg==
X-Gm-Message-State: AOAM530k43y3in2O1WWNM135hQxpQy0h3JNw+Sm6Zdo5Og8ZDcWv6Jow
 YtY2kfhulc/8U0swVGlDyJx69HzjG6KoWNhVz7+p/CB7MuwO2X2ShdfKTDmZvYr8uQB7oj7UTtw
 9j2n5e2XDYlZ3Ac0=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr1278762wrm.75.1591763257253; 
 Tue, 09 Jun 2020 21:27:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpPz0tfMBLH6Fu7SNnZXe6mCWlqP1HqueSMZMAnx8WcgFh1+rDA0oGXSmd6Uu3PCsPpkHibA==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr1278747wrm.75.1591763257026; 
 Tue, 09 Jun 2020 21:27:37 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id a3sm5964129wrp.91.2020.06.09.21.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:27:36 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:27:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/56] hw/pci/pcie: Move hot plug capability check to pre_plug
 callback
Message-ID: <20200610042613.1459309-29-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


