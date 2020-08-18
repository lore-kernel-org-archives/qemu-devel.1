Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DF3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C683F20709
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AB3sUqeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C683F20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k89af-0002at-W6
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 17:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1k89ZU-00018W-3Y
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:55:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1k89ZS-0007fY-2Z
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597787704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfwKsgv1pr3VNv+KNxWVmDBJUEBXl7vg3Sao8TH9IOU=;
 b=AB3sUqeEDsV6/uplMkl35euzVw5S/zAtJ0pUKqT49uEJT9I7YqbPj3KcExcI1znvShQFDe
 NdpflsI3E5XoAPihHdVnoTN/IdMGjYdUXhT9idSMyT4GOUuD0P/Xr0m+h3Lmio/TvcJp7D
 FqsmByUcYh0e2B0pHmVfemF1viKd6/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-b_KLuUXPPaidj1KjHgclpg-1; Tue, 18 Aug 2020 17:55:02 -0400
X-MC-Unique: b_KLuUXPPaidj1KjHgclpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEC02801AE7;
 Tue, 18 Aug 2020 21:55:01 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87CDD101417D;
 Tue, 18 Aug 2020 21:55:00 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 1/4] hw/acpi/ich9: Trace ich9_gpe_readb()/writeb()
Date: Tue, 18 Aug 2020 23:52:24 +0200
Message-Id: <20200818215227.181654-2-jusual@redhat.com>
In-Reply-To: <20200818215227.181654-1-jusual@redhat.com>
References: <20200818215227.181654-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jusual@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jusual@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 17:55:04
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
Cc: Igor Mammedov <imammedo@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add trace events similar to piix4_gpe_readb() to check gpe status.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ich9.c       | 7 ++++++-
 hw/acpi/trace-events | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 6a19070cec..a2a1742aa6 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -36,6 +36,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/tco.h"
 #include "exec/address-spaces.h"
+#include "trace.h"
 
 #include "hw/i386/ich9.h"
 #include "hw/mem/pc-dimm.h"
@@ -59,13 +60,17 @@ static void ich9_pm_update_sci_fn(ACPIREGS *regs)
 static uint64_t ich9_gpe_readb(void *opaque, hwaddr addr, unsigned width)
 {
     ICH9LPCPMRegs *pm = opaque;
-    return acpi_gpe_ioport_readb(&pm->acpi_regs, addr);
+    uint64_t val = acpi_gpe_ioport_readb(&pm->acpi_regs, addr);
+
+    trace_ich9_gpe_readb(addr, width, val);
+    return val;
 }
 
 static void ich9_gpe_writeb(void *opaque, hwaddr addr, uint64_t val,
                             unsigned width)
 {
     ICH9LPCPMRegs *pm = opaque;
+    trace_ich9_gpe_writeb(addr, width, val);
     acpi_gpe_ioport_writeb(&pm->acpi_regs, addr, val);
     acpi_update_sci(&pm->acpi_regs, pm->irq);
 }
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index afbc77de1c..b9f4827afc 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -32,6 +32,10 @@ cpuhp_acpi_ejecting_cpu(uint32_t idx) "0x%"PRIx32
 cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT: 0x%"PRIx32
 cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
 
+# ich9.c
+ich9_gpe_readb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d ==> 0x%" PRIx64
+ich9_gpe_writeb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d <== 0x%" PRIx64
+
 # pcihp.c
 acpi_pci_eject_slot(unsigned bsel, unsigned slot) "bsel: %u slot: %u"
 acpi_pci_unplug(int bsel, int slot) "bsel: %d slot: %d"
-- 
2.25.4


