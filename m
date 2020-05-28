Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DE7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FD92088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahrnakuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FD92088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGUH-0007sV-Uv
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLP-0005u1-I2
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:05:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51655
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLF-0006jo-LT
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590663892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H83OaysL/sZWH5evVwMxpINm9CXFIom9c+q8wa7qfx4=;
 b=ahrnakuhGtmGwyK8+KVG3083XSiSui7y98apr4n2+XXTpCRJi/mTaff0tWOQXURiDIwkWd
 3hhLocz8Q9iDUr2oXb4RzK0dau6owORC0LijzLrY3C+F2xEeSWocwzYXtFCNQj1oIfdbJ7
 NVH1FYiO1fXvB8i59fHNil0j+iGtFNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-bHgttIUHMSuqd-nfiH2rYA-1; Thu, 28 May 2020 07:04:50 -0400
X-MC-Unique: bHgttIUHMSuqd-nfiH2rYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59CAC835B45;
 Thu, 28 May 2020 11:04:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27A3B19D71;
 Thu, 28 May 2020 11:04:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 117AE11358CF; Thu, 28 May 2020 13:04:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/24] pnv/psi: Correct the pnv-psi* devices not to be
 sysbus devices
Date: Thu, 28 May 2020 13:04:37 +0200
Message-Id: <20200528110444.20456-18-armbru@redhat.com>
In-Reply-To: <20200528110444.20456-1-armbru@redhat.com>
References: <20200528110444.20456-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, pbonzini@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pnv_chip_power8_instance_init() creates a "pnv-psi-POWER8" sysbus
device in a way that leaves it unplugged.
pnv_chip_power9_instance_init() and pnv_chip_power10_instance_init()
do the same for "pnv-psi-POWER9" and "pnv-psi-POWER10", respectively.

These devices aren't actually sysbus devices.  Correct that.

Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_psi.h | 2 +-
 hw/ppc/pnv_psi.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index f0f5b55197..979fc59f33 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -31,7 +31,7 @@
 #define PSIHB_XSCOM_MAX         0x20
 
 typedef struct PnvPsi {
-    SysBusDevice parent;
+    DeviceState parent;
 
     MemoryRegion regs_mr;
     uint64_t bar;
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index cfd5b7bc25..82f0769465 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -943,7 +943,7 @@ static void pnv_psi_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo pnv_psi_info = {
     .name          = TYPE_PNV_PSI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
+    .parent        = TYPE_DEVICE,
     .instance_size = sizeof(PnvPsi),
     .class_init    = pnv_psi_class_init,
     .class_size    = sizeof(PnvPsiClass),
-- 
2.21.3


