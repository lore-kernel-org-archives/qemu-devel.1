Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_FAKE_HELO_DOTCOM,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9638BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6148A206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPNpUIB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6148A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIuY-0003l5-L5
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1jtIq3-0002AN-4r
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:46:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39884
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jusual@redhat.com>) id 1jtIq1-0004Tz-MJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594248409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ouWdXdrIeKkuQRCrlFCUv9l/hCha8V8+dalKpOSQXDo=;
 b=LPNpUIB+UcrHwIab52xwnsnpBZrv1FWKigNoaZsxnmDq87MJr4xUPh0XwF4O5fZNzISCku
 Ss5/dDr39kgJqDv+TfYZZ0YH+K10tROtoS0tdH9FozQjG/vwtMIskjth9iMuo8ZFmrRlxl
 Y3jCDqxqn7VR9OND5PkirWKJZdRRygU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-gGXQsHSwOtG4kAQH7UmIhw-1; Wed, 08 Jul 2020 18:46:47 -0400
X-MC-Unique: gGXQsHSwOtG4kAQH7UmIhw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 483FA1089;
 Wed,  8 Jul 2020 22:46:45 +0000 (UTC)
Received: from localhost.com (unknown [10.40.192.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0BBA10016E8;
 Wed,  8 Jul 2020 22:46:43 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/5] hw/acpi/ich9: Trace ich9_gpe_readb()/writeb()
Date: Thu,  9 Jul 2020 00:46:12 +0200
Message-Id: <20200708224615.114077-3-jusual@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jusual@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_FAKE_HELO_DOTCOM=1.189, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add trace events similar to piix4_gpe_readb() to check gpe status.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 hw/acpi/ich9.c       | 7 ++++++-
 hw/acpi/trace-events | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 2d204babc6..0fdd736da4 100644
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


