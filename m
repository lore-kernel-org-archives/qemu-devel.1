Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D700C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7A1235F7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wjmt9wsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7A1235F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLKq-0006VB-EY
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1kLLFJ-0000ml-VQ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1kLLFH-0005Hi-UO
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600930847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IL7nzAh7Mf9HR3Z9mYJS5y5wKlSwZthpUxqWFbQmTzM=;
 b=Wjmt9wshxiziH9BGdSn73ClOTUWSstot8pjdNE+bANX60oM9G8yPXb4UMbgpPN0oomGFXx
 A0aLgpPzvPfZyprNFXMNktijJvXaYVU/U79i/E5kv1iRRyiKwTjNxiMLE2FVfKgkyeNnHF
 5d9a1+YPujmGVZEzaWHmBoqEsBXGiuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-3SGnW4NzOBiEyHxyYYUmfQ-1; Thu, 24 Sep 2020 03:00:45 -0400
X-MC-Unique: 3SGnW4NzOBiEyHxyYYUmfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 639041008307;
 Thu, 24 Sep 2020 07:00:44 +0000 (UTC)
Received: from pc-72.home.com (unknown [10.40.194.10])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A20973668;
 Thu, 24 Sep 2020 07:00:36 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 3/7] hw/pci/pcie: Do not initialize slot capability if
 acpihp is used
Date: Thu, 24 Sep 2020 09:00:09 +0200
Message-Id: <20200924070013.165026-4-jusual@redhat.com>
In-Reply-To: <20200924070013.165026-1-jusual@redhat.com>
References: <20200924070013.165026-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jusual@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jusual@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of changing the hot-plug type in _OSC register, do not
initialize the slot capability or set the 'Slot Implemented' flag.
This way guest will choose ACPI hot-plug if it is preferred and leave
the option to use SHPC with pcie-pci-bridge.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 hw/i386/acpi-build.h |  2 ++
 hw/i386/acpi-build.c |  2 +-
 hw/pci/pcie.c        | 16 ++++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 487ec7710f..4c5bfb3d0b 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -11,4 +11,6 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 
 void acpi_setup(void);
 
+Object *object_resolve_type_unambiguous(const char *typename);
+
 #endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index cf503b16af..b7811a8912 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -174,7 +174,7 @@ static void init_common_fadt_data(MachineState *ms, Object *o,
     *data = fadt;
 }
 
-static Object *object_resolve_type_unambiguous(const char *typename)
+Object *object_resolve_type_unambiguous(const char *typename)
 {
     bool ambig;
     Object *o = object_resolve_path_type("", typename, &ambig);
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 5b48bae0f6..c1a082e8b9 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -27,6 +27,8 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pcie_regs.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/i386/ich9.h"
+#include "hw/i386/acpi-build.h"
 #include "qemu/range.h"
 
 //#define DEBUG_PCIE
@@ -515,12 +517,26 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
     pcie_cap_slot_push_attention_button(hotplug_pdev);
 }
 
+static bool acpi_pcihp_enabled(void)
+{
+    Object *lpc = object_resolve_type_unambiguous(TYPE_ICH9_LPC_DEVICE);
+
+    return lpc &&
+           object_property_get_bool(lpc, "acpi-pci-hotplug-with-bridge-support",
+                                    NULL);
+
+}
+
 /* pci express slot for pci express root/downstream port
    PCI express capability slot registers */
 void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
 {
     uint32_t pos = dev->exp.exp_cap;
 
+    if (acpi_pcihp_enabled()) {
+        return;
+    }
+
     pci_word_test_and_set_mask(dev->config + pos + PCI_EXP_FLAGS,
                                PCI_EXP_FLAGS_SLOT);
 
-- 
2.25.4


