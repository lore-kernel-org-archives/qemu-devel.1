Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECE2C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE6621924
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 07:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ymji9RoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE6621924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKzdc-0007ox-9c
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 03:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1kKzcm-0007No-HK
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 03:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1kKzcj-0000tN-0V
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 03:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600847731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZHVYKwknniTPNGAb4nQdDjl8rZhzzftwSeYlket+3OQ=;
 b=Ymji9RoOHaeZlq8EQ92T35MAghEqDWfSffS7EdKcwYOLjb2a/V8wHcy/3RZvJgDRe/dFcI
 U8k7TxroK3oeX3MEjiWNkN2tTZOhyh7RKWfIQZTSVtK1XVWYuyzLOKdcl0ofkulksGu01l
 TUlAOIzgX60ea9w1sAhblAfMIsoKEDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-tOhfZv_GPMOVrQCg9p-OsA-1; Wed, 23 Sep 2020 03:55:27 -0400
X-MC-Unique: tOhfZv_GPMOVrQCg9p-OsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34FAF9CC1F;
 Wed, 23 Sep 2020 07:55:26 +0000 (UTC)
Received: from pc-72.home.com (unknown [10.40.194.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64BC11A914;
 Wed, 23 Sep 2020 07:55:18 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/i386/acpi-build: Explain bits in OSC method
Date: Wed, 23 Sep 2020 09:55:14 +0200
Message-Id: <20200923075514.110478-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jusual@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jusual@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a better explanation for the enabled bits in the _OSC control
field. Base it on the latest specification due to new bits 5 and 6.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 hw/i386/acpi-build.h | 11 +++++++++++
 hw/i386/acpi-build.c |  7 ++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 74df5fc612..bb5269d162 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -5,6 +5,17 @@
 
 extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 
+/* PCI Firmware Specification 3.2, Table 4-5 */
+typedef enum {
+    ACPI_OSC_NATIVE_HP_EN = 0,
+    ACPI_OSC_SHPC_EN = 1,
+    ACPI_OSC_PME_EN = 2,
+    ACPI_OSC_AER_EN = 3,
+    ACPI_OSC_PCIE_CAP_EN = 4,
+    ACPI_OSC_LTR_EN = 5,
+    ACPI_OSC_ALLONES_INVALID = 6,
+} AcpiOSCField;
+
 void acpi_setup(void);
 
 #endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0e0535d2e3..b08f005a35 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1417,6 +1417,7 @@ static Aml *build_q35_osc_method(void)
     Aml *method;
     Aml *a_cwd1 = aml_name("CDW1");
     Aml *a_ctrl = aml_local(0);
+    unsigned osc_ctrl;
 
     method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
     aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
@@ -1432,7 +1433,11 @@ static Aml *build_q35_osc_method(void)
      * Always allow native PME, AER (no dependencies)
      * Allow SHPC (PCI bridges can have SHPC controller)
      */
-    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
+    osc_ctrl = BIT(ACPI_OSC_PME_EN) | BIT(ACPI_OSC_AER_EN) |
+               BIT(ACPI_OSC_PCIE_CAP_EN) | BIT(ACPI_OSC_NATIVE_HP_EN) |
+               BIT(ACPI_OSC_SHPC_EN);
+
+    aml_append(if_ctx, aml_and(a_ctrl, aml_int(osc_ctrl), a_ctrl));
 
     if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
     /* Unknown revision */
-- 
2.25.4


