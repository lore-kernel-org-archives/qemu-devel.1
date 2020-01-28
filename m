Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E7AC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24B12467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfU4+uf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24B12467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOIk-0001kd-7c
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 05:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iwOEG-0000Bu-C2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iwOEF-0000dh-3a
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:36:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36089
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iwOEE-0000dL-VQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580207778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54NPiD/s7NhXdHaaTgCUqqDcRiDlHdCFtYHnxyYOpT4=;
 b=VfU4+uf0eGdW8Nsk1hU2aAaus7IH2Br4UmxWhIj22nxKG+nBUN+byu//5H/uG2B/c6Iw+I
 oPYRuWLp0DT5hdH6KLjzi8z6RZj92xrBTNaCAx3sla2wP40OgSaAJZpfvfLq5cMnlD8sQX
 bsq3pnktRa/p/FPblFKkjmbETIIZvK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-rD51XNLdNO2IvgzW0-stYg-1; Tue, 28 Jan 2020 05:36:17 -0500
X-MC-Unique: rD51XNLdNO2IvgzW0-stYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73910100550E;
 Tue, 28 Jan 2020 10:36:15 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F6981001B30;
 Tue, 28 Jan 2020 10:36:06 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v3 08/14] arm/arm64: ITS: its_enable_defaults
Date: Tue, 28 Jan 2020 11:34:53 +0100
Message-Id: <20200128103459.19413-9-eric.auger@redhat.com>
In-Reply-To: <20200128103459.19413-1-eric.auger@redhat.com>
References: <20200128103459.19413-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, andre.przywara@arm.com,
 thuth@redhat.com, yuzenghui@huawei.com, alexandru.elisei@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

its_enable_defaults() is the top init function that allocates the
command queue and all the requested tables (device, collection,
lpi config and pending tables), enable LPIs at distributor level
and ITS level.

gicv3_enable_defaults must be called before.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- introduce its_setup_baser in this patch
- squash "arm/arm64: ITS: Init the command queue" in this patch.
---
 lib/arm/asm/gic-v3-its.h |  8 ++++
 lib/arm/gic-v3-its.c     | 89 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
index 815c515..fe73c04 100644
--- a/lib/arm/asm/gic-v3-its.h
+++ b/lib/arm/asm/gic-v3-its.h
@@ -36,6 +36,8 @@ struct its_data {
 	void *base;
 	struct its_typer typer;
 	struct its_baser baser[GITS_BASER_NR_REGS];
+	struct its_cmd_block *cmd_base;
+	struct its_cmd_block *cmd_write;
 };
=20
 extern struct its_data its_data;
@@ -88,10 +90,16 @@ extern struct its_data its_data;
 #define GITS_BASER_TYPE_DEVICE		1
 #define GITS_BASER_TYPE_COLLECTION	4
=20
+
+struct its_cmd_block {
+	u64 raw_cmd[4];
+};
+
 extern void its_parse_typer(void);
 extern void its_init(void);
 extern int its_parse_baser(int i, struct its_baser *baser);
 extern struct its_baser *its_lookup_baser(int type);
+extern void its_enable_defaults(void);
=20
 #else /* __arm__ */
=20
diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
index 2c0ce13..d1e7e52 100644
--- a/lib/arm/gic-v3-its.c
+++ b/lib/arm/gic-v3-its.c
@@ -86,3 +86,92 @@ void its_init(void)
 		its_parse_baser(i, &its_data.baser[i]);
 }
=20
+static void its_setup_baser(int i, struct its_baser *baser)
+{
+	unsigned long n =3D (baser->nr_pages * baser->psz) >> PAGE_SHIFT;
+	unsigned long order =3D is_power_of_2(n) ? fls(n) : fls(n) + 1;
+	u64 val;
+
+	baser->table_addr =3D (u64)virt_to_phys(alloc_pages(order));
+
+	val =3D ((u64)baser->table_addr					|
+		((u64)baser->type	<< GITS_BASER_TYPE_SHIFT)	|
+		((u64)(baser->esz - 1)	<< GITS_BASER_ENTRY_SIZE_SHIFT)	|
+		((baser->nr_pages - 1)	<< GITS_BASER_PAGES_SHIFT)	|
+		(u64)baser->indirect	<< 62				|
+		(u64)baser->valid	<< 63);
+
+	switch (baser->psz) {
+	case SZ_4K:
+		val |=3D GITS_BASER_PAGE_SIZE_4K;
+		break;
+	case SZ_16K:
+		val |=3D GITS_BASER_PAGE_SIZE_16K;
+		break;
+	case SZ_64K:
+		val |=3D GITS_BASER_PAGE_SIZE_64K;
+		break;
+	}
+
+	writeq(val, gicv3_its_base() + GITS_BASER + i * 8);
+}
+
+/**
+ * init_cmd_queue: Allocate the command queue and initialize
+ * CBASER, CREADR, CWRITER
+ */
+static void its_cmd_queue_init(void)
+{
+	unsigned long n =3D SZ_64K >> PAGE_SHIFT;
+	unsigned long order =3D fls(n);
+	u64 cbaser;
+
+	its_data.cmd_base =3D (void *)virt_to_phys(alloc_pages(order));
+
+	cbaser =3D ((u64)its_data.cmd_base | (SZ_64K / SZ_4K - 1)	| GITS_CBASER=
_VALID);
+
+	writeq(cbaser, its_data.base + GITS_CBASER);
+
+	its_data.cmd_write =3D its_data.cmd_base;
+	writeq(0, its_data.base + GITS_CWRITER);
+}
+
+void its_enable_defaults(void)
+{
+	unsigned int i;
+
+	its_parse_typer();
+
+	/* Allocate BASER tables (device and collection tables) */
+	for (i =3D 0; i < GITS_BASER_NR_REGS; i++) {
+		struct its_baser *baser =3D &its_data.baser[i];
+		int ret;
+
+		ret =3D its_parse_baser(i, baser);
+		if (ret)
+			continue;
+
+		switch (baser->type) {
+		case GITS_BASER_TYPE_DEVICE:
+			baser->valid =3D true;
+			its_setup_baser(i, baser);
+			break;
+		case GITS_BASER_TYPE_COLLECTION:
+			baser->valid =3D true;
+			its_setup_baser(i, baser);
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* Allocate LPI config and pending tables */
+	gicv3_lpi_alloc_tables();
+
+	its_cmd_queue_init();
+
+	for (i =3D 0; i < nr_cpus; i++)
+		gicv3_lpi_rdist_ctrl(i, true);
+
+	writel(GITS_CTLR_ENABLE, its_data.base + GITS_CTLR);
+}
--=20
2.20.1


