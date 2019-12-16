Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D84C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6F7206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cjc13Ye3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6F7206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igomQ-0002yb-Fm
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoG0-00088v-CK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFy-0000EA-1r
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:44 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:47047)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFx-0000CW-RJ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:41 -0500
Received: by mail-wr1-x42e.google.com with SMTP id z7so6675338wrl.13
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KorzsVCuWzHJTDSVPZb5E19X40B2KWRXTCyI70IOxPk=;
 b=Cjc13Ye30XpoC333x5D5WROOjURTuFrMo6Y4jiojrqfW5q+cR/aWdBddDMpIg6L8+H
 lSORsxM8ucunnfBLlFplo2Qc7pxTwMMixXRB7lgRt0FhiThW3uUo2JFe8WCsIMX6ipz9
 wLUqkpK2vk2C4DJ+Ef67/Ycdtdxj9o/3oqRXcT70sXVcpjcxaTIstDjeV2vDMIzCHZQv
 wiuNoG9/BrGcYzHGNzoqemxdHa63XmB8i2RFE3Ws1Gv6/Ek+Tq24iwzdMSbjyELmyhEv
 DqVvUh5iHJQeh4oI0cUHK3NttpddmRgj2+eycAaiDaACVr8j+E5J2pvXhRZx6EqyHNnb
 r69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KorzsVCuWzHJTDSVPZb5E19X40B2KWRXTCyI70IOxPk=;
 b=bsotZVTkprk7ebNOdGW2hJo11iJr1fCsvO1CqwuqRlyzZxTYhN3erkSDni/LszWwm9
 dDBTI3Gv5eAuwrmkMCY1kGvnZTlLm+eNguA3JVAt8/e7lhQoKXieNxUQFn/PFHe++SSN
 Xm2gjPsyUW1cIec/NaqhLuZLvBtRVp1/AoSbKrI/dKtdnzb7/p4haBbCnL9H+7TFOW8K
 YuEpqeiwy1qboXTT2CBbh57RrFWDPhlpqsA4mYVsP0Tv0PyQsFQRcpGGCn1rBonsRFhf
 EKl//YMfbhXAD1dvaRHETODqFq+99kphbYIcHQyNOMwfNYKXgyMpQPkkmFSYETqtn4Ij
 PB8Q==
X-Gm-Message-State: APjAAAUjqVL2fcVEApXtjR2YzV4cfDJ6vePl8sDEwSrBIBdrnOezutR9
 b98lbWt8paoT7lQg75bkftmcp6wxda54mQ==
X-Google-Smtp-Source: APXvYqz2U2bfH3PvEbUYgTVoT4nm+CR3MJxKSGhn8xxglAWDUYv3hM4woUpBuwwe2IEq3agbhnIILg==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr30003411wrm.394.1576494580425; 
 Mon, 16 Dec 2019 03:09:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/34] hw/arm/acpi: simplify AML bit and/or statement
Date: Mon, 16 Dec 2019 11:09:01 +0000
Message-Id: <20191216110904.30815-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Heyi Guo <guoheyi@huawei.com>

The last argument of AML bit and/or statement is the target variable,
so we don't need to use a NULL target and then an additional store
operation; using just aml_and() or aml_or() statement is enough.

Also update tests/data/acpi/virt/DSDT* to pass "make check".

Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Message-id: 20191209063719.23086-2-guoheyi@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c          |  16 ++++++++--------
 tests/data/acpi/virt/DSDT         | Bin 18470 -> 18462 bytes
 tests/data/acpi/virt/DSDT.memhp   | Bin 19807 -> 19799 bytes
 tests/data/acpi/virt/DSDT.numamem | Bin 18470 -> 18462 bytes
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4cd50175e04..51b293e0a1e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -267,17 +267,17 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
         aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
     aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
     aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
-    aml_append(ifctx, aml_store(aml_and(aml_name("CTRL"), aml_int(0x1D), NULL),
-                                aml_name("CTRL")));
+    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1D),
+                              aml_name("CTRL")));
 
     ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
-    aml_append(ifctx1, aml_store(aml_or(aml_name("CDW1"), aml_int(0x08), NULL),
-                                 aml_name("CDW1")));
+    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
+                              aml_name("CDW1")));
     aml_append(ifctx, ifctx1);
 
     ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTRL"))));
-    aml_append(ifctx1, aml_store(aml_or(aml_name("CDW1"), aml_int(0x10), NULL),
-                                 aml_name("CDW1")));
+    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
+                              aml_name("CDW1")));
     aml_append(ifctx, ifctx1);
 
     aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
@@ -285,8 +285,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     aml_append(method, ifctx);
 
     elsectx = aml_else();
-    aml_append(elsectx, aml_store(aml_or(aml_name("CDW1"), aml_int(4), NULL),
-                                  aml_name("CDW1")));
+    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
+                               aml_name("CDW1")));
     aml_append(elsectx, aml_return(aml_arg(3)));
     aml_append(method, elsectx);
     aml_append(dev, method);
diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
index bce76e3d23e99e6c5ef64c94c770282dd30ecdd0..05bcfc8a912f58f266aa906563ea01c24906717e 100644
GIT binary patch
delta 133
zcmZ2BfpOjhMlP3Nmk>D*1_q|2iCof5o%I{lJ2{y;?{412x!p#<jWgaq*qNm(o59&7
z+;D-%<VrV7_iE>mARjJS5V=5L(&S9WT970c2Uv;Nq{%?q7$gZ1761tsfcPNsCD{x4
MAmS{W8QoPG0j8@bzW@LL

delta 141
zcmbO?fpOUcMlP3Nmk>1%1_q`n6S<_B8XGpMcXBc{-rKy1bGwazA7{LOuro_nHiNTE
zxZwi7$(3%F{sq;}AwfP|vJ4<<fzYJMnT!RsAbBnhh%$*ulYv}gkTg_604z}e5&_99
R$zCV`m0@An{L@X95dZ+BD!u>!

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.memhp
index b4b153fcdc30d211237fced6be1e99d3500bd276..c041a910fdf272cb89263bb636239ae3a5e1708d 100644
GIT binary patch
delta 132
zcmcaVi}Cs_MlP3NmymE@1_ma@iCof*O&is^IGH-{Zr;SX-A2HTGu}VgnWZb6!PzC;
zaDm6<N;gaQYUhw3A1+xCxj<mj<V?m|kR%reSc%xA$w1l|Bnc4~00|d>_#p8m*$ep~
L;w+mP-Q(B*s{AMU

delta 140
zcmcaUi}C&}MlP3Nmymd01_maViCof*T^rT9IGGynZQjJW-A2HVGu}VgnWZb6!PzC;
zaDm_CN;gaYf@<fGARjJS1`xGCXwu|N#)4XqJQoK<nZ%^YK&~-J8Y&?GmM8#;fMk|r
QFBE{vurO@?=@!QZ00dYn_y7O^

diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/DSDT.numamem
index bce76e3d23e99e6c5ef64c94c770282dd30ecdd0..05bcfc8a912f58f266aa906563ea01c24906717e 100644
GIT binary patch
delta 133
zcmZ2BfpOjhMlP3Nmk>D*1_q|2iCof5o%I{lJ2{y;?{412x!p#<jWgaq*qNm(o59&7
z+;D-%<VrV7_iE>mARjJS5V=5L(&S9WT970c2Uv;Nq{%?q7$gZ1761tsfcPNsCD{x4
MAmS{W8QoPG0j8@bzW@LL

delta 141
zcmbO?fpOUcMlP3Nmk>1%1_q`n6S<_B8XGpMcXBc{-rKy1bGwazA7{LOuro_nHiNTE
zxZwi7$(3%F{sq;}AwfP|vJ4<<fzYJMnT!RsAbBnhh%$*ulYv}gkTg_604z}e5&_99
R$zCV`m0@An{L@X95dZ+BD!u>!

-- 
2.20.1


