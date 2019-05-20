Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9350C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1BF2173C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1BF2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43395 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrVU-0002Z4-SG
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:15:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQk-0007CS-KQ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQj-00082x-IN
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:54 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:36118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrQj-00082k-DE
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:53 -0400
Received: by mail-qk1-f178.google.com with SMTP id c14so9942623qke.3
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=1LcfTJcuB3Ujwz9dZ8Eu+v5gSvOIHMjPL+YsRyxSFVc=;
	b=lOhyFQiS9j6d+mKVBVIuydFbeyBCZGFM+pWc1+ob79Xt62f4mEXSxCeA6/n6GSEo9x
	I5ni4Yw94YNGpLEffJbxB7K9L8Awp5Ktk5AYmDdm/65wrv5yjMnAwCEohjEJHsLmluSW
	mtp3ycsEp4KQDVYznkZlXaqlSRCm4Kq1dwDfEsI2ggjk4WfIpqSO7ifAQPaP9sEGbbmp
	VRAJ4StUX3td5kQTueAHmr1j2qeIRtCSWeYCRMvaPAXHu89ce/yNgAKNGA7vPkg2v2mm
	9pdAHAggwpjXJPN2kNztBxJeoEGvO8WZUpkU30T1kKArwABbGEPgG4ouqHnLWqqCSHIo
	Joeg==
X-Gm-Message-State: APjAAAXILdorU6xbJHCbX59pisPNqc4oztR16AnERAgP+TGlAgS4oldm
	0YtlQhwozGXZfYvRxqqw8Y6ZgtBs48Q=
X-Google-Smtp-Source: APXvYqx30KeO7RwRFM4f2OhYeMG0m0g9+U8aULW6Ohx1i6h+5sfC1jWIQ/YQ7xMWWsapns3gtWHYaw==
X-Received: by 2002:a37:4ad7:: with SMTP id
	x206mr47632231qka.129.1558393852655; 
	Mon, 20 May 2019 16:10:52 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id u5sm8745266qkk.85.2019.05.20.16.10.51
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:10:51 -0700 (PDT)
Date: Mon, 20 May 2019 19:10:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190402161900.7374-3-armbru@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.178
Subject: [Qemu-devel] [PULL v2 12/36] acpi/pcihp: Convert debug printf()s to
 trace events
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231050.Zzjd-N_XgwM6zXjcMUHJNFkRX1m0w1f0C2vFegaTaGI@z>

From: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190402161900.7374-3-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/acpi/pcihp.c      | 25 ++++++++-----------------
 hw/acpi/trace-events |  9 +++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 88e4ae1bcd..7729c5338b 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -37,14 +37,7 @@
 #include "hw/pci/pci_bus.h"
 #include "qapi/error.h"
 #include "qom/qom-qobject.h"
-
-//#define DEBUG
-
-#ifdef DEBUG
-# define ACPI_PCIHP_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
-#else
-# define ACPI_PCIHP_DPRINTF(format, ...)     do { } while (0)
-#endif
+#include "trace.h"
 
 #define ACPI_PCIHP_ADDR 0xae00
 #define ACPI_PCIHP_SIZE 0x0014
@@ -306,23 +299,23 @@ static uint64_t pci_read(void *opaque, hwaddr addr, unsigned int size)
         if (!s->legacy_piix) {
             s->acpi_pcihp_pci_status[bsel].up = 0;
         }
-        ACPI_PCIHP_DPRINTF("pci_up_read %" PRIu32 "\n", val);
+        trace_acpi_pci_up_read(val);
         break;
     case PCI_DOWN_BASE:
         val = s->acpi_pcihp_pci_status[bsel].down;
-        ACPI_PCIHP_DPRINTF("pci_down_read %" PRIu32 "\n", val);
+        trace_acpi_pci_down_read(val);
         break;
     case PCI_EJ_BASE:
         /* No feature defined yet */
-        ACPI_PCIHP_DPRINTF("pci_features_read %" PRIu32 "\n", val);
+        trace_acpi_pci_features_read(val);
         break;
     case PCI_RMV_BASE:
         val = s->acpi_pcihp_pci_status[bsel].hotplug_enable;
-        ACPI_PCIHP_DPRINTF("pci_rmv_read %" PRIu32 "\n", val);
+        trace_acpi_pci_rmv_read(val);
         break;
     case PCI_SEL_BASE:
         val = s->hotplug_select;
-        ACPI_PCIHP_DPRINTF("pci_sel_read %" PRIu32 "\n", val);
+        trace_acpi_pci_sel_read(val);
     default:
         break;
     }
@@ -340,13 +333,11 @@ static void pci_write(void *opaque, hwaddr addr, uint64_t data,
             break;
         }
         acpi_pcihp_eject_slot(s, s->hotplug_select, data);
-        ACPI_PCIHP_DPRINTF("pciej write %" HWADDR_PRIx " <== %" PRIu64 "\n",
-                      addr, data);
+        trace_acpi_pci_ej_write(addr, data);
         break;
     case PCI_SEL_BASE:
         s->hotplug_select = s->legacy_piix ? ACPI_PCIHP_BSEL_DEFAULT : data;
-        ACPI_PCIHP_DPRINTF("pcisel write %" HWADDR_PRIx " <== %" PRIu64 "\n",
-                      addr, data);
+        trace_acpi_pci_sel_write(addr, data);
     default:
         break;
     }
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 825b25cbb0..98a56baa6f 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -31,6 +31,15 @@ cpuhp_acpi_ejecting_cpu(uint32_t idx) "0x%"PRIx32
 cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT: 0x%"PRIx32
 cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
 
+# pcihp.c
+acpi_pci_up_read(uint32_t val) "%" PRIu32
+acpi_pci_down_read(uint32_t val) "%" PRIu32
+acpi_pci_features_read(uint32_t val) "%" PRIu32
+acpi_pci_rmv_read(uint32_t val) "%" PRIu32
+acpi_pci_sel_read(uint32_t val) "%" PRIu32
+acpi_pci_ej_write(uint64_t addr, uint64_t data) "0x%" PRIx64 " <== %" PRIu64
+acpi_pci_sel_write(uint64_t addr, uint64_t data) "0x%" PRIx64 " <== %" PRIu64
+
 # piix4.c
 piix4_gpe_readb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d ==> 0x%" PRIx64
 piix4_gpe_writeb(uint64_t addr, unsigned width, uint64_t val) "addr: 0x%" PRIx64 " width: %d <== 0x%" PRIx64
-- 
MST


