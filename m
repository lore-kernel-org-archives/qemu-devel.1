Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01EEC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 06:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3788206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 06:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3788206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieCjQ-0008O3-RZ
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 01:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1ieCh2-0005LE-3t
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 01:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1ieCh0-0004cF-QM
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 01:38:52 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60990 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1ieCgx-0004aL-Pe; Mon, 09 Dec 2019 01:38:48 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id AE692E26B1E13D5F2F62;
 Mon,  9 Dec 2019 14:38:42 +0800 (CST)
Received: from linux-XCyijm.huawei.com (10.175.104.212) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 9 Dec 2019 14:38:34 +0800
From: Heyi Guo <guoheyi@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [PATCH v6 1/2] hw/arm/acpi: simplify AML bit and/or statement
Date: Mon, 9 Dec 2019 14:37:18 +0800
Message-ID: <20191209063719.23086-2-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191209063719.23086-1-guoheyi@huawei.com>
References: <20191209063719.23086-1-guoheyi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Heyi Guo <guoheyi@huawei.com>,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/arm/virt-acpi-build.c          |  16 ++++++++--------
 tests/data/acpi/virt/DSDT         | Bin 18470 -> 18462 bytes
 tests/data/acpi/virt/DSDT.memhp   | Bin 19807 -> 19799 bytes
 tests/data/acpi/virt/DSDT.numamem | Bin 18470 -> 18462 bytes
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4cd50175e0..51b293e0a1 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -267,17 +267,17 @@ static void acpi_dsdt_add_pci(Aml *scope, const Mem=
MapEntry *memmap,
         aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
     aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
     aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
-    aml_append(ifctx, aml_store(aml_and(aml_name("CTRL"), aml_int(0x1D),=
 NULL),
-                                aml_name("CTRL")));
+    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1D),
+                              aml_name("CTRL")));
=20
     ifctx1 =3D aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
-    aml_append(ifctx1, aml_store(aml_or(aml_name("CDW1"), aml_int(0x08),=
 NULL),
-                                 aml_name("CDW1")));
+    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
+                              aml_name("CDW1")));
     aml_append(ifctx, ifctx1);
=20
     ifctx1 =3D aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTR=
L"))));
-    aml_append(ifctx1, aml_store(aml_or(aml_name("CDW1"), aml_int(0x10),=
 NULL),
-                                 aml_name("CDW1")));
+    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
+                              aml_name("CDW1")));
     aml_append(ifctx, ifctx1);
=20
     aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
@@ -285,8 +285,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMa=
pEntry *memmap,
     aml_append(method, ifctx);
=20
     elsectx =3D aml_else();
-    aml_append(elsectx, aml_store(aml_or(aml_name("CDW1"), aml_int(4), N=
ULL),
-                                  aml_name("CDW1")));
+    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
+                               aml_name("CDW1")));
     aml_append(elsectx, aml_return(aml_arg(3)));
     aml_append(method, elsectx);
     aml_append(dev, method);
diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
index bce76e3d23e99e6c5ef64c94c770282dd30ecdd0..05bcfc8a912f58f266aa90656=
3ea01c24906717e 100644
GIT binary patch
delta 133
zcmZ2BfpOjhMlP3Nmk>D*1_q|2iCof5o%I{lJ2{y;?{412x!p#<jWgaq*qNm(o59&7
z+;D-%<VrV7_iE>mARjJS5V=3D5L(&S9WT970c2Uv;Nq{%?q7$gZ1761tsfcPNsCD{x4
MAmS{W8QoPG0j8@bzW@LL

delta 141
zcmbO?fpOUcMlP3Nmk>1%1_q`n6S<_B8XGpMcXBc{-rKy1bGwazA7{LOuro_nHiNTE
zxZwi7$(3%F{sq;}AwfP|vJ4<<fzYJMnT!RsAbBnhh%$*ulYv}gkTg_604z}e5&_99
R$zCV`m0@An{L@X95dZ+BD!u>!

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.=
memhp
index b4b153fcdc30d211237fced6be1e99d3500bd276..c041a910fdf272cb89263bb63=
6239ae3a5e1708d 100644
GIT binary patch
delta 132
zcmcaVi}Cs_MlP3NmymE@1_ma@iCof*O&is^IGH-{Zr;SX-A2HTGu}VgnWZb6!PzC;
zaDm6<N;gaQYUhw3A1+xCxj<mj<V?m|kR%reSc%xA$w1l|Bnc4~00|d>_#p8m*$ep~
L;w+mP-Q(B*s{AMU

delta 140
zcmcaUi}C&}MlP3Nmymd01_maViCof*T^rT9IGGynZQjJW-A2HVGu}VgnWZb6!PzC;
zaDm_CN;gaYf@<fGARjJS1`xGCXwu|N#)4XqJQoK<nZ%^YK&~-J8Y&?GmM8#;fMk|r
QFBE{vurO@?=3D@!QZ00dYn_y7O^

diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/DSD=
T.numamem
index bce76e3d23e99e6c5ef64c94c770282dd30ecdd0..05bcfc8a912f58f266aa90656=
3ea01c24906717e 100644
GIT binary patch
delta 133
zcmZ2BfpOjhMlP3Nmk>D*1_q|2iCof5o%I{lJ2{y;?{412x!p#<jWgaq*qNm(o59&7
z+;D-%<VrV7_iE>mARjJS5V=3D5L(&S9WT970c2Uv;Nq{%?q7$gZ1761tsfcPNsCD{x4
MAmS{W8QoPG0j8@bzW@LL

delta 141
zcmbO?fpOUcMlP3Nmk>1%1_q`n6S<_B8XGpMcXBc{-rKy1bGwazA7{LOuro_nHiNTE
zxZwi7$(3%F{sq;}AwfP|vJ4<<fzYJMnT!RsAbBnhh%$*ulYv}gkTg_604z}e5&_99
R$zCV`m0@An{L@X95dZ+BD!u>!

--=20
2.19.1


