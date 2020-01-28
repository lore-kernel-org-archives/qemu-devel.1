Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71742C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5182467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8wufg16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5182467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOFK-000248-FA
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 05:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iwOEJ-0000Ie-8H
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iwOEI-0000f8-4V
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:36:23 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57167
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iwOEI-0000ex-16
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580207781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78G0omYBZtnhpn3J/dduj+Q41/b0ahCr4I2teh8jw18=;
 b=Y8wufg168fsx2zz69IBuywVl65yAc3CR4GfPfE6tpMgYpRGUdGemsjNtMuZl8YvVugyWbM
 9gZhEfUZd1PyVnqaWPi9Y1wStYRO1iVgp5zXCq3s5o4KMW/5WU1Hb9ztxAboU0PgrqzRhJ
 gNXcTk6u849euCuhUVo0eXbyBcj6Ip4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-QHcEkjAAPcSg6VQP7dxRFA-1; Tue, 28 Jan 2020 05:36:07 -0500
X-MC-Unique: QHcEkjAAPcSg6VQP7dxRFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB695107ACC4;
 Tue, 28 Jan 2020 10:36:05 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 50F401001DD8;
 Tue, 28 Jan 2020 10:35:58 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v3 07/14] arm/arm64: gicv3: Enable/Disable LPIs
 at re-distributor level
Date: Tue, 28 Jan 2020 11:34:52 +0100
Message-Id: <20200128103459.19413-8-eric.auger@redhat.com>
In-Reply-To: <20200128103459.19413-1-eric.auger@redhat.com>
References: <20200128103459.19413-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

This helper function controls the signaling of LPIs at
redistributor level.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- move the helper in lib/arm/gic-v3.c
- rename the function with gicv3_lpi_ prefix
- s/report_abort/assert
---
 lib/arm/asm/gic-v3.h |  1 +
 lib/arm/gic-v3.c     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
index ec2a6f0..734c0c0 100644
--- a/lib/arm/asm/gic-v3.h
+++ b/lib/arm/asm/gic-v3.h
@@ -96,6 +96,7 @@ extern void gicv3_lpi_set_config(int n, u8 val);
 extern u8 gicv3_lpi_get_config(int n);
 extern void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set);
 extern void gicv3_lpi_alloc_tables(void);
+extern void gicv3_lpi_rdist_ctrl(u32 redist, bool set);
=20
 static inline void gicv3_do_wait_for_rwp(void *base)
 {
diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
index c33f883..7865d01 100644
--- a/lib/arm/gic-v3.c
+++ b/lib/arm/gic-v3.c
@@ -210,4 +210,21 @@ void gicv3_lpi_set_pending_table_bit(int rdist, int =
n, bool set)
 		byte &=3D ~mask;
 	*ptr =3D byte;
 }
+
+void gicv3_lpi_rdist_ctrl(u32 redist, bool set)
+{
+	void *ptr;
+	u64 val;
+
+	assert(redist < nr_cpus);
+
+	ptr =3D gicv3_data.redist_base[redist];
+	val =3D readl(ptr + GICR_CTLR);
+	if (set)
+		val |=3D GICR_CTLR_ENABLE_LPIS;
+	else
+		val &=3D ~GICR_CTLR_ENABLE_LPIS;
+	writel(val,  ptr + GICR_CTLR);
+}
 #endif /* __aarch64__ */
+
--=20
2.20.1


