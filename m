Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E793C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA72420737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzIcVGou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA72420737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihSk-0002Ed-TW
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHr-00049P-N0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20911
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHp-0003CO-FH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M6WeoxnivIxQ9XuQJlRGjsrwhnGrfJG3aBPYwXMTlso=;
 b=FzIcVGouJyOGJs608HeU6iceUblp+p6pWBWTaieeC/fr09NKn5kimw35HQ6Oe8h8eoe8ZU
 M37iXxldeU9xKpxiwnqSXo/Xmc9+LnoyVTgi77ON+qxnwedxRIBbXVuQnWjWxwFjP89JDN
 uZGN8Xc9LlbZvNzrHeJYwrY2yr41ZpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379--A7ZMqWSO1SRKxrES_oY4Q-1; Tue, 09 Jun 2020 12:39:38 -0400
X-MC-Unique: -A7ZMqWSO1SRKxrES_oY4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C3A7100CCC1
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 16:39:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1C3F89290;
 Tue,  9 Jun 2020 16:39:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A134B1138463; Tue,  9 Jun 2020 18:39:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/39] hw/ppc: Eliminate two superfluous QOM casts
Date: Tue,  9 Jun 2020 18:39:07 +0200
Message-Id: <20200609163932.1566209-15-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/mac_newworld.c | 4 ++--
 hw/ppc/mac_oldworld.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 69281d7834..2d069dcc59 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -122,7 +122,7 @@ static void ppc_core99_init(MachineState *machine)
     long kernel_size, initrd_size;
     UNINHostState *uninorth_pci;
     PCIBus *pci_bus;
-    NewWorldMacIOState *macio;
+    PCIDevice *macio;
     bool has_pmu, has_adb;
     MACIOIDEState *macio_ide;
     BusState *adb_bus;
@@ -375,7 +375,7 @@ static void ppc_core99_init(MachineState *machine)
     pci_bus = PCI_HOST_BRIDGE(uninorth_pci)->bus;
 
     /* MacIO */
-    macio = NEWWORLD_MACIO(pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO));
+    macio = pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO);
     dev = DEVICE(macio);
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     qdev_prop_set_bit(dev, "has-pmu", has_pmu);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index cfc2eae1d9..f73ec5f3a9 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -94,7 +94,7 @@ static void ppc_heathrow_init(MachineState *machine)
     uint32_t kernel_base, initrd_base, cmdline_base = 0;
     int32_t kernel_size, initrd_size;
     PCIBus *pci_bus;
-    OldWorldMacIOState *macio;
+    PCIDevice *macio;
     MACIOIDEState *macio_ide;
     SysBusDevice *s;
     DeviceState *dev, *pic_dev;
@@ -278,7 +278,7 @@ static void ppc_heathrow_init(MachineState *machine)
     ide_drive_get(hd, ARRAY_SIZE(hd));
 
     /* MacIO */
-    macio = OLDWORLD_MACIO(pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO));
+    macio = pci_create(pci_bus, -1, TYPE_OLDWORLD_MACIO);
     dev = DEVICE(macio);
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
-- 
2.26.2


