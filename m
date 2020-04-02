Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B700C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF0820719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqRlMnEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF0820719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK1GT-00086v-Hp
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jK1Dv-0003Na-W8
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jK1Du-0000lC-Ni
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:53:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28327
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jK1Du-0000kq-HE
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585839218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHJ+AxvcSLzx4i3n8l9F+cJMI9xumbF4sDrg902Tz8c=;
 b=KqRlMnEwPG6UGdP/1352AKFQL/BD6Xc+Fn+cuFI1bqpV7CMDWmw/8y/pvPcyX9pH8kkTgF
 AHqLKWu8TKlnkwuzB+8soonzMgFTNDRRkixeG4uE2l6meR89VFBkV8HlL2LTnwnYpNfzJ/
 i7iox6vSaXyMp2BsiiAef7hmzm9YZLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-BHvh3jjXOUCR-wpOrJRtyQ-1; Thu, 02 Apr 2020 10:53:34 -0400
X-MC-Unique: BHvh3jjXOUCR-wpOrJRtyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B3548017CE;
 Thu,  2 Apr 2020 14:53:33 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1E205D9C9;
 Thu,  2 Apr 2020 14:53:27 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v8 08/13] arm/arm64: ITS: Device and collection
 Initialization
Date: Thu,  2 Apr 2020 16:52:22 +0200
Message-Id: <20200402145227.20109-9-eric.auger@redhat.com>
In-Reply-To: <20200402145227.20109-1-eric.auger@redhat.com>
References: <20200402145227.20109-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Introduce an helper functions to register
- a new device, characterized by its device id and the
  max number of event IDs that dimension its ITT (Interrupt
  Translation Table).  The function allocates the ITT.

- a new collection, characterized by its ID and the
  target processing engine (PE).

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

---

v7 -> v8:
- col_id and col parameter become u16
- added Zenghui's R-b

v3 -> v4:
- remove unused its_baser variable from its_create_device()
- use get_order()
- device->itt becomes a GVA instead of GPA

v2 -> v3:
- s/report_abort/assert

v1 -> v2:
- s/nb_/nr_
---
 lib/arm64/asm/gic-v3-its.h | 19 +++++++++++++++++++
 lib/arm64/gic-v3-its.c     | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/lib/arm64/asm/gic-v3-its.h b/lib/arm64/asm/gic-v3-its.h
index 7e03e4c..628eedf 100644
--- a/lib/arm64/asm/gic-v3-its.h
+++ b/lib/arm64/asm/gic-v3-its.h
@@ -31,6 +31,19 @@ struct its_baser {
 };
=20
 #define GITS_BASER_NR_REGS		8
+#define GITS_MAX_DEVICES		8
+#define GITS_MAX_COLLECTIONS		8
+
+struct its_device {
+	u32 device_id;	/* device ID */
+	u32 nr_ites;	/* Max Interrupt Translation Entries */
+	void *itt;	/* Interrupt Translation Table GVA */
+};
+
+struct its_collection {
+	u64 target_address;
+	u16 col_id;
+};
=20
 struct its_data {
 	void *base;
@@ -39,6 +52,10 @@ struct its_data {
 	struct its_baser coll_baser;
 	struct its_cmd_block *cmd_base;
 	struct its_cmd_block *cmd_write;
+	struct its_device devices[GITS_MAX_DEVICES];
+	u32 nr_devices;		/* Allocated Devices */
+	struct its_collection collections[GITS_MAX_COLLECTIONS];
+	u16 nr_collections;	/* Allocated Collections */
 };
=20
 extern struct its_data its_data;
@@ -93,5 +110,7 @@ extern void its_parse_typer(void);
 extern void its_init(void);
 extern int its_baser_lookup(int i, struct its_baser *baser);
 extern void its_enable_defaults(void);
+extern struct its_device *its_create_device(u32 dev_id, int nr_ites);
+extern struct its_collection *its_create_collection(u16 col_id, u32 targ=
et_pe);
=20
 #endif /* _ASMARM64_GIC_V3_ITS_H_ */
diff --git a/lib/arm64/gic-v3-its.c b/lib/arm64/gic-v3-its.c
index cf176b7..ca91c3d 100644
--- a/lib/arm64/gic-v3-its.c
+++ b/lib/arm64/gic-v3-its.c
@@ -109,3 +109,41 @@ void its_enable_defaults(void)
=20
 	writel(GITS_CTLR_ENABLE, its_data.base + GITS_CTLR);
 }
+
+struct its_device *its_create_device(u32 device_id, int nr_ites)
+{
+	struct its_device *new;
+	unsigned long n;
+
+	assert(its_data.nr_devices < GITS_MAX_DEVICES);
+
+	new =3D &its_data.devices[its_data.nr_devices];
+
+	new->device_id =3D device_id;
+	new->nr_ites =3D nr_ites;
+
+	n =3D (its_data.typer.ite_size * nr_ites) >> PAGE_SHIFT;
+	new->itt =3D alloc_pages(get_order(n));
+
+	its_data.nr_devices++;
+	return new;
+}
+
+struct its_collection *its_create_collection(u16 col_id, u32 pe)
+{
+	struct its_collection *new;
+
+	assert(its_data.nr_collections < GITS_MAX_COLLECTIONS);
+
+	new =3D &its_data.collections[its_data.nr_collections];
+
+	new->col_id =3D col_id;
+
+	if (its_data.typer.pta)
+		new->target_address =3D (u64)gicv3_data.redist_base[pe];
+	else
+		new->target_address =3D pe << 16;
+
+	its_data.nr_collections++;
+	return new;
+}
--=20
2.20.1


