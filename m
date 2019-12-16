Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC9DC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:10:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C3F206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgnAcgRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C3F206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igr5A-00050l-Fe
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 09:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1igqyx-0004Sb-8g
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1igqyw-0003z9-4O
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:04:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28034
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1igqyw-0003yt-1T
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576505057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GByE+7FZ7lhIBOmguUpVZ915Jn/DtVoRPXv8rjNpFkQ=;
 b=hgnAcgRXM2x3rXdv1lny5QtNERSCTW4JomaBDwgMUcmZYYD6KAhXO32H0Cyq3AqHGD1k9y
 Y2HTT5zw3ijzFirAP/6B7yyQRwc7bxK1W++wqGnrUCa33/oZ+wfT54PazBRggT5BracnEB
 1wGsRbz1bZ+1/s/hge8tJ3qTCRYzXas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-LL_HqoBOP4e465DgIlVopg-1; Mon, 16 Dec 2019 09:04:15 -0500
X-MC-Unique: LL_HqoBOP4e465DgIlVopg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE9591809A54;
 Mon, 16 Dec 2019 14:04:13 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0512675B8;
 Mon, 16 Dec 2019 14:04:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH 10/16] arm/arm64: ITS: its_enable_defaults
Date: Mon, 16 Dec 2019 15:02:29 +0100
Message-Id: <20191216140235.10751-11-eric.auger@redhat.com>
In-Reply-To: <20191216140235.10751-1-eric.auger@redhat.com>
References: <20191216140235.10751-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

its_enable_defaults() is the top init function that allocates all
the requested tables (device, collection, lpi config and pending
tables), enable LPIs at distributor level and ITS level.

gicv3_enable_defaults must be called before.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 lib/arm/asm/gic-v3-its.h |  1 +
 lib/arm/gic-v3-its.c     | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
index d56a17f..ab639c5 100644
--- a/lib/arm/asm/gic-v3-its.h
+++ b/lib/arm/asm/gic-v3-its.h
@@ -139,6 +139,7 @@ extern void set_lpi_config(int n, u8 val);
 extern u8 get_lpi_config(int n);
 extern void set_pending_table_bit(int rdist, int n, bool set);
 extern void gicv3_rdist_ctrl_lpi(u32 redist, bool set);
+extern void its_enable_defaults(void);
=20
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_V3_ITS_H_ */
diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
index b0f7714..9a51ef4 100644
--- a/lib/arm/gic-v3-its.c
+++ b/lib/arm/gic-v3-its.c
@@ -243,3 +243,44 @@ void gicv3_rdist_ctrl_lpi(u32 redist, bool set)
 		val &=3D ~GICR_CTLR_ENABLE_LPIS;
 	writel(val,  ptr + GICR_CTLR);
 }
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
+			baser->cache =3D GITS_BASER_nCnB;
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
+	alloc_lpi_tables();
+
+	init_cmd_queue();
+
+	for (i =3D 0; i < nr_cpus; i++)
+		gicv3_rdist_ctrl_lpi(i, true);
+
+	writel(GITS_CTLR_ENABLE, its_data.base + GITS_CTLR);
+}
--=20
2.20.1


