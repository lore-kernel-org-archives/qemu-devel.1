Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E868C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6F020409
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4A8f+GB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6F020409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFjG-0004ph-91
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jBFax-0000Ib-6e
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jBFav-00029P-AZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:25:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42280
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jBFav-00028n-6D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583749508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHE2jaHMx2EkPvI2/FqDuVO4fkyIww/LmhYOOZFcS78=;
 b=J4A8f+GBx+2gssrQ94S9BNXuh57nDsmdanpkN4+VbYGtTfECM4U4g04qZZoR5D/h8DzLj8
 dszczB9cerkCT8BCtBCHi7uCrw6glauS/cgDmSbqWlpayVpeWrjySgkpDvFQGf57yjq/31
 8lW/zuzn4+RAZSF7+bgE6+tS24tCmh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-ZnfUZy5rOuqfB01fqZXnvQ-1; Mon, 09 Mar 2020 06:25:05 -0400
X-MC-Unique: ZnfUZy5rOuqfB01fqZXnvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA15C477;
 Mon,  9 Mar 2020 10:25:03 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B508F87B08;
 Mon,  9 Mar 2020 10:25:00 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v4 07/13] arm/arm64: ITS: its_enable_defaults
Date: Mon,  9 Mar 2020 11:24:14 +0100
Message-Id: <20200309102420.24498-8-eric.auger@redhat.com>
In-Reply-To: <20200309102420.24498-1-eric.auger@redhat.com>
References: <20200309102420.24498-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

its_enable_defaults() enable LPIs at distributor level
and ITS level.

gicv3_enable_defaults must be called before.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v3 -> v4:
- use GITS_BASER_INDIRECT & GITS_BASER_VALID in its_setup_baser()
- don't parse BASERs again in its_enable_defaults
- rename its_setup_baser into its_baser_alloc_table
- All allocations moved to the init function
- squashed "arm/arm64: gicv3: Enable/Disable LPIs at re-distributor level=
"
  into this patch
- introduce gicv3_lpi_rdist_enable and gicv3_lpi_rdist_disable
- pend and prop table bases stored as virt addresses
- move some init functions from enable() to its_init
- removed GICR_PROPBASER_IDBITS_MASK
- introduced LPI_OFFSET
- lpi_prop becomes u8 *
- gicv3_lpi_set_config/get_config became macro
- renamed gicv3_lpi_set_pending_table_bit into gicv3_lpi_set_clr_pending

v2 -> v3:
- introduce its_setup_baser in this patch
- squash "arm/arm64: ITS: Init the command queue" in this patch.
---
 lib/arm/asm/gic-v3.h       | 28 +++++++++++------
 lib/arm/gic-v3.c           | 64 ++++++++++++++++++++++----------------
 lib/arm64/asm/gic-v3-its.h |  1 +
 lib/arm64/gic-v3-its.c     | 16 ++++++++--
 4 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/lib/arm/asm/gic-v3.h b/lib/arm/asm/gic-v3.h
index 12134ef..ea9ae8e 100644
--- a/lib/arm/asm/gic-v3.h
+++ b/lib/arm/asm/gic-v3.h
@@ -50,15 +50,16 @@
 #define MPIDR_TO_SGI_AFFINITY(cluster_id, level) \
 	(MPIDR_AFFINITY_LEVEL(cluster_id, level) << ICC_SGI1R_AFFINITY_## level=
 ## _SHIFT)
=20
-#define GICR_PROPBASER_IDBITS_MASK                      (0x1f)
+#define GICR_PENDBASER_PTZ		BIT_ULL(62)
=20
-#define GICR_PENDBASER_PTZ                              BIT_ULL(62)
+#define LPI_PROP_GROUP1			(1 << 1)
+#define LPI_PROP_ENABLED		(1 << 0)
+#define LPI_PROP_DEFAULT_PRIO		0xa0
+#define LPI_PROP_DEFAULT		(LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1 | LPI=
_PROP_ENABLED)
=20
-#define LPI_PROP_GROUP1		(1 << 1)
-#define LPI_PROP_ENABLED	(1 << 0)
-#define LPI_PROP_DEFAULT_PRIO   0xa0
-#define LPI_PROP_DEFAULT	(LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1 | \
-				 LPI_PROP_ENABLED)
+#define LPI_ID_BASE			8192
+#define LPI(lpi)			((lpi) + LPI_ID_BASE)
+#define LPI_OFFSET(intid)		((intid) - LPI_ID_BASE)
=20
 #include <asm/arch_gicv3.h>
=20
@@ -76,7 +77,7 @@ struct gicv3_data {
 	void *dist_base;
 	void *redist_bases[GICV3_NR_REDISTS];
 	void *redist_base[NR_CPUS];
-	void *lpi_prop;
+	u8 *lpi_prop;
 	void *lpi_pend[NR_CPUS];
 	unsigned int irq_nr;
 };
@@ -96,8 +97,10 @@ extern void gicv3_ipi_send_mask(int irq, const cpumask=
_t *dest);
 extern void gicv3_set_redist_base(size_t stride);
 extern void gicv3_lpi_set_config(int n, u8 val);
 extern u8 gicv3_lpi_get_config(int n);
-extern void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set);
+extern void gicv3_lpi_set_clr_pending(int rdist, int n, bool set);
 extern void gicv3_lpi_alloc_tables(void);
+extern void gicv3_lpi_rdist_enable(int redist);
+extern void gicv3_lpi_rdist_disable(int redist);
=20
 static inline void gicv3_do_wait_for_rwp(void *base)
 {
@@ -143,5 +146,12 @@ static inline u64 mpidr_uncompress(u32 compressed)
 	return mpidr;
 }
=20
+#define gicv3_lpi_set_config(intid, value) ({		\
+	gicv3_data.lpi_prop[LPI_OFFSET(intid)] =3D value; \
+})
+
+#define gicv3_lpi_get_config(intid) (gicv3_data.lpi_prop[LPI_OFFSET(inti=
d)])
+
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_V3_H_ */
diff --git a/lib/arm/gic-v3.c b/lib/arm/gic-v3.c
index 949a986..a3b55b2 100644
--- a/lib/arm/gic-v3.c
+++ b/lib/arm/gic-v3.c
@@ -150,7 +150,14 @@ void gicv3_ipi_send_single(int irq, int cpu)
 }
=20
 #if defined(__aarch64__)
-/* alloc_lpi_tables: Allocate LPI config and pending tables */
+
+/**
+ * alloc_lpi_tables - Allocate LPI config and pending tables
+ * and set PROPBASER (shared by all rdistributors) and per
+ * redistributor PENDBASER.
+ *
+ * gicv3_set_redist_base() must be called before
+ */
 void gicv3_lpi_alloc_tables(void)
 {
 	unsigned long n =3D SZ_64K >> PAGE_SHIFT;
@@ -161,13 +168,9 @@ void gicv3_lpi_alloc_tables(void)
 	gicv3_data.lpi_prop =3D alloc_pages(order);
=20
 	/* ID bits =3D 13, ie. up to 14b LPI INTID */
-	prop_val =3D (u64)virt_to_phys(gicv3_data.lpi_prop) | 13;
+	prop_val =3D (u64)(virt_to_phys(gicv3_data.lpi_prop)) | 13;
=20
-	/*
-	 * Allocate pending tables for each redistributor
-	 * and set PROPBASER and PENDBASER
-	 */
-	for_each_present_cpu(cpu) {
+	for (cpu =3D 0; cpu < nr_cpus; cpu++) {
 		u64 pend_val;
 		void *ptr;
=20
@@ -176,30 +179,14 @@ void gicv3_lpi_alloc_tables(void)
 		writeq(prop_val, ptr + GICR_PROPBASER);
=20
 		gicv3_data.lpi_pend[cpu] =3D alloc_pages(order);
-
-		pend_val =3D (u64)virt_to_phys(gicv3_data.lpi_pend[cpu]);
-
+		pend_val =3D (u64)(virt_to_phys(gicv3_data.lpi_pend[cpu]));
 		writeq(pend_val, ptr + GICR_PENDBASER);
 	}
 }
=20
-void gicv3_lpi_set_config(int n, u8 value)
+void gicv3_lpi_set_clr_pending(int rdist, int n, bool set)
 {
-	u8 *entry =3D (u8 *)(gicv3_data.lpi_prop + (n - 8192));
-
-	*entry =3D value;
-}
-
-u8 gicv3_lpi_get_config(int n)
-{
-	u8 *entry =3D (u8 *)(gicv3_data.lpi_prop + (n - 8192));
-
-	return *entry;
-}
-
-void gicv3_lpi_set_pending_table_bit(int rdist, int n, bool set)
-{
-	u8 *ptr =3D phys_to_virt((phys_addr_t)gicv3_data.lpi_pend[rdist]);
+	u8 *ptr =3D gicv3_data.lpi_pend[rdist];
 	u8 mask =3D 1 << (n % 8), byte;
=20
 	ptr +=3D (n / 8);
@@ -210,4 +197,29 @@ void gicv3_lpi_set_pending_table_bit(int rdist, int =
n, bool set)
 		byte &=3D ~mask;
 	*ptr =3D byte;
 }
+
+static void gicv3_lpi_rdist_ctrl(u32 redist, bool set)
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
+
+void gicv3_lpi_rdist_enable(int redist)
+{
+	gicv3_lpi_rdist_ctrl(redist, true);
+}
+void gicv3_lpi_rdist_disable(int redist)
+{
+	gicv3_lpi_rdist_ctrl(redist, false);
+}
 #endif /* __aarch64__ */
diff --git a/lib/arm64/asm/gic-v3-its.h b/lib/arm64/asm/gic-v3-its.h
index 331ba0e..1e95977 100644
--- a/lib/arm64/asm/gic-v3-its.h
+++ b/lib/arm64/asm/gic-v3-its.h
@@ -88,5 +88,6 @@ extern struct its_data its_data;
 extern void its_parse_typer(void);
 extern void its_init(void);
 extern int its_baser_lookup(int i, struct its_baser *baser);
+extern void its_enable_defaults(void);
=20
 #endif /* _ASMARM64_GIC_V3_ITS_H_ */
diff --git a/lib/arm64/gic-v3-its.c b/lib/arm64/gic-v3-its.c
index 23b0d06..2f480ae 100644
--- a/lib/arm64/gic-v3-its.c
+++ b/lib/arm64/gic-v3-its.c
@@ -94,9 +94,19 @@ void its_init(void)
 	its_baser_alloc_table(&its_data.device_baser, SZ_64K);
 	its_baser_alloc_table(&its_data.coll_baser, SZ_64K);
=20
-	/* Allocate LPI config and pending tables */
-	gicv3_lpi_alloc_tables();
-
 	its_cmd_queue_init();
 }
=20
+/* must be called after gicv3_enable_defaults */
+void its_enable_defaults(void)
+{
+	int i;
+
+	/* Allocate LPI config and pending tables */
+	gicv3_lpi_alloc_tables();
+
+	for (i =3D 0; i < nr_cpus; i++)
+		gicv3_lpi_rdist_enable(i);
+
+	writel(GITS_CTLR_ENABLE, its_data.base + GITS_CTLR);
+}
--=20
2.20.1


