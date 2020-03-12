Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71ECC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717D5206B1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auYMxJ/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717D5206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQ5D-0005CI-I2
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jCQ0D-0004d6-QZ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jCQ0C-0000xy-Iq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:44:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47526
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jCQ0C-0000xm-F2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584027844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDpHgRY2PBeuAglXruVQh+Gy7es0EWulYw4xwBVDuzY=;
 b=auYMxJ/piGNGkMiPrzlNhG5W3WmM+UBslZj6obUHLuuoYUE1VGjsvEpuCmdADPwAdIlNWj
 /re48gKgEi3tc/h3FQSgWVwkf3GeWpjrM2HEt7BsB5f4Glbavxc1zmsMKRcwyCwhElugAp
 ysE7ku46YsUNmX1DPkuVT1iWfI1ze3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-J_8iBLY1Or-lvj3aAcTcMw-1; Thu, 12 Mar 2020 11:44:00 -0400
X-MC-Unique: J_8iBLY1Or-lvj3aAcTcMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF2D5801F9D;
 Thu, 12 Mar 2020 15:43:58 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 687B82CE01;
 Thu, 12 Mar 2020 15:43:46 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v3 05/12] arm: pmu: Introduce defines for PMU
 versions
Date: Thu, 12 Mar 2020 16:42:54 +0100
Message-Id: <20200312154301.9130-6-eric.auger@redhat.com>
In-Reply-To: <20200312154301.9130-1-eric.auger@redhat.com>
References: <20200312154301.9130-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: peter.maydell@linaro.org, andrew.murray@arm.com, drjones@redhat.com,
 alexandru.elisei@arm.com, andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce some defines encoding the different PMU versions.
v3 is encoded differently in 32 and 64 bits.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/pmu.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index d827e82..a04588a 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -45,6 +45,15 @@ static struct pmu pmu;
 #define ID_DFR0_PERFMON_SHIFT 24
 #define ID_DFR0_PERFMON_MASK  0xf
=20
+#define ID_DFR0_PMU_NOTIMPL	0b0000
+#define ID_DFR0_PMU_V1		0b0001
+#define ID_DFR0_PMU_V2		0b0010
+#define ID_DFR0_PMU_V3		0b0011
+#define ID_DFR0_PMU_V3_8_1	0b0100
+#define ID_DFR0_PMU_V3_8_4	0b0101
+#define ID_DFR0_PMU_V3_8_5	0b0110
+#define ID_DFR0_PMU_IMPDEF	0b1111
+
 #define PMCR         __ACCESS_CP15(c9, 0, c12, 0)
 #define ID_DFR0      __ACCESS_CP15(c0, 0, c1, 2)
 #define PMSELR       __ACCESS_CP15(c9, 0, c12, 5)
@@ -105,6 +114,13 @@ static inline void precise_instrs_loop(int loop, uin=
t32_t pmcr)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
 #define ID_AA64DFR0_PERFMON_MASK  0xf
=20
+#define ID_DFR0_PMU_NOTIMPL	0b0000
+#define ID_DFR0_PMU_V3		0b0001
+#define ID_DFR0_PMU_V3_8_1	0b0100
+#define ID_DFR0_PMU_V3_8_4	0b0101
+#define ID_DFR0_PMU_V3_8_5	0b0110
+#define ID_DFR0_PMU_IMPDEF	0b1111
+
 static inline uint32_t get_id_aa64dfr0(void) { return read_sysreg(id_aa6=
4dfr0_el1); }
 static inline uint32_t get_pmcr(void) { return read_sysreg(pmcr_el0); }
 static inline void set_pmcr(uint32_t v) { write_sysreg(v, pmcr_el0); }
@@ -116,7 +132,7 @@ static inline void set_pmccfiltr(uint32_t v) { write_=
sysreg(v, pmccfiltr_el0); }
 static inline uint8_t get_pmu_version(void)
 {
 	uint8_t ver =3D (get_id_aa64dfr0() >> ID_AA64DFR0_PERFMON_SHIFT) & ID_A=
A64DFR0_PERFMON_MASK;
-	return ver =3D=3D 1 ? 3 : ver;
+	return ver;
 }
=20
 /*
@@ -249,7 +265,7 @@ static bool check_cpi(int cpi)
 static void pmccntr64_test(void)
 {
 #ifdef __arm__
-	if (pmu.version =3D=3D 0x3) {
+	if (pmu.version =3D=3D ID_DFR0_PMU_V3) {
 		if (ERRATA(9e3f7a296940)) {
 			write_sysreg(0xdead, PMCCNTR64);
 			report(read_sysreg(PMCCNTR64) =3D=3D 0xdead, "pmccntr64");
@@ -262,13 +278,13 @@ static void pmccntr64_test(void)
 /* Return FALSE if no PMU found, otherwise return TRUE */
 static bool pmu_probe(void)
 {
-	uint32_t pmcr;
+	uint32_t pmcr =3D get_pmcr();
=20
 	pmu.version =3D get_pmu_version();
-	if (pmu.version =3D=3D 0 || pmu.version =3D=3D 0xf)
+	if (pmu.version =3D=3D ID_DFR0_PMU_NOTIMPL || pmu.version =3D=3D ID_DFR=
0_PMU_IMPDEF)
 		return false;
=20
-	report_info("PMU version: %d", pmu.version);
+	report_info("PMU version: 0x%x", pmu.version);
=20
 	pmcr =3D get_pmcr();
 	report_info("PMU implementer/ID code: %#x(\"%c\")/%#x",
--=20
2.20.1


