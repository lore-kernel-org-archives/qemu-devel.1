Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_FAKE_HELO_DOTCOM,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAE2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:03:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CD4206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiyL9vmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CD4206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJ6b-0001kq-5E
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1jtIpz-000225-F2
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:46:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51808
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1jtIpx-0004TI-RE
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594248404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/A3Chz1ln5q+MvD3cpUxiOAXEzEo/CWpJ5SgurclSY=;
 b=KiyL9vmxVGyDKjU8Gm53uZBSBlQka6k+rf7F6ygI12UGMTo2VVdxu3GtPGtDjZtf/D+zzC
 U4L/LC7U3xYzDu+tfEUdwzYnwibxP8znMdg/UKv1dLkIucIpOYvUKQvSGm7gogpo1/snAG
 i6IZLG30EkL2jHMe8cakFlwq8ckGk64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-qQ1LGX-MPRqHFrTUFUFpbg-1; Wed, 08 Jul 2020 18:46:43 -0400
X-MC-Unique: qQ1LGX-MPRqHFrTUFUFpbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B8F7802788;
 Wed,  8 Jul 2020 22:46:42 +0000 (UTC)
Received: from localhost.com (unknown [10.40.192.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D9D910016E8;
 Wed,  8 Jul 2020 22:46:40 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/5] hw/acpi/pcihp: Introduce find_host()
Date: Thu,  9 Jul 2020 00:46:11 +0200
Message-Id: <20200708224615.114077-2-jusual@redhat.com>
In-Reply-To: <20200708224615.114077-1-jusual@redhat.com>
References: <20200708224615.114077-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jusual@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jusual@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_FAKE_HELO_DOTCOM=1.189, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Returns the current host bus with ACPI PCI hot-plug support: q35 or i440fx.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 hw/i386/acpi-build.h |  2 ++
 hw/acpi/pcihp.c      | 13 +++++++++++++
 hw/i386/acpi-build.c |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 74df5fc612..0696b4e48d 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -7,4 +7,6 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 
 void acpi_setup(void);
 
+Object *acpi_get_i386_pci_host(void);
+
 #endif
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index d42906ea19..3d4ee3af72 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -33,10 +33,12 @@
 #include "hw/acpi/acpi.h"
 #include "exec/address-spaces.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_host.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
 #include "trace.h"
+#include "hw/i386/acpi-build.h"
 
 #define ACPI_PCIHP_ADDR 0xae00
 #define ACPI_PCIHP_SIZE 0x0014
@@ -86,6 +88,17 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
     return bsel_alloc;
 }
 
+static PCIBus *find_host(void)
+{
+    Object *obj = acpi_get_i386_pci_host();
+
+    if (obj) {
+        return PCI_HOST_BRIDGE(obj)->bus;
+    }
+
+    return NULL;
+}
+
 static void acpi_set_pci_info(void)
 {
     static bool bsel_is_set;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 900f786d08..11c598f955 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -270,7 +270,7 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
  * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
  * On i386 arch we only have two pci hosts, so we can look only for them.
  */
-static Object *acpi_get_i386_pci_host(void)
+Object *acpi_get_i386_pci_host(void)
 {
     PCIHostState *host;
 
-- 
2.25.4


