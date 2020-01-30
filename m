Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40553C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C06A206D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQ6n/yX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C06A206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix80s-0001qj-6f
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ix7xD-0004nq-OB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ix7xC-0004Aq-Bw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:25:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37707
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ix7xC-00049N-8o
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580383544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dznikfzn+n4WX4926tiKNygB6iX1YlaEs/0YdUiJxdA=;
 b=bQ6n/yX0Ri0wNGJxHqdrMBuGPmEWXaNgU84JyBbr49XeshDA6KPValmP3LBwVuacsW/p1L
 1GW6X+MweORBrdfnFrtq2pFc4zDSnw0QymhH2T9Bflcuta/otENqmSGlTD41PHGRrZYipz
 9GfPS16oRPqEcUpk6bj0DGTea4B9HJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-_Y_XUO7FPfSKxTMMMmJhiA-1; Thu, 30 Jan 2020 06:25:42 -0500
X-MC-Unique: _Y_XUO7FPfSKxTMMMmJhiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C1FC18B9FC3;
 Thu, 30 Jan 2020 11:25:41 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3C441036B20;
 Thu, 30 Jan 2020 11:25:33 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v2 3/9] arm: pmu: Add a pmu struct
Date: Thu, 30 Jan 2020 12:25:04 +0100
Message-Id: <20200130112510.15154-4-eric.auger@redhat.com>
In-Reply-To: <20200130112510.15154-1-eric.auger@redhat.com>
References: <20200130112510.15154-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: peter.maydell@linaro.org, andrew.murray@arm.com, drjones@redhat.com,
 alexandru.elisei@arm.com, andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This struct aims at storing information potentially used by
all tests such as the pmu version, the read-only part of the
PMCR, the number of implemented event counters, ...

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/pmu.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index e5e012d..d24857e 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -33,7 +33,14 @@
=20
 #define NR_SAMPLES 10
=20
-static unsigned int pmu_version;
+struct pmu {
+	unsigned int version;
+	unsigned int nb_implemented_counters;
+	uint32_t pmcr_ro;
+};
+
+static struct pmu pmu;
+
 #if defined(__arm__)
 #define ID_DFR0_PERFMON_SHIFT 24
 #define ID_DFR0_PERFMON_MASK  0xf
@@ -265,7 +272,7 @@ static bool check_cpi(int cpi)
 static void pmccntr64_test(void)
 {
 #ifdef __arm__
-	if (pmu_version =3D=3D 0x3) {
+	if (pmu.version =3D=3D 0x3) {
 		if (ERRATA(9e3f7a296940)) {
 			write_sysreg(0xdead, PMCCNTR64);
 			report(read_sysreg(PMCCNTR64) =3D=3D 0xdead, "pmccntr64");
@@ -278,9 +285,22 @@ static void pmccntr64_test(void)
 /* Return FALSE if no PMU found, otherwise return TRUE */
 static bool pmu_probe(void)
 {
-	pmu_version =3D get_pmu_version();
-	report_info("PMU version: %d", pmu_version);
-	return pmu_version !=3D 0 && pmu_version !=3D 0xf;
+	uint32_t pmcr;
+
+	pmu.version =3D get_pmu_version();
+	report_info("PMU version: %d", pmu.version);
+
+	if (pmu.version =3D=3D 0 || pmu.version =3D=3D 0xF)
+		return false;
+
+	pmcr =3D get_pmcr();
+	pmu.pmcr_ro =3D pmcr & 0xFFFFFF80;
+	pmu.nb_implemented_counters =3D
+		(pmcr >> PMU_PMCR_N_SHIFT) & PMU_PMCR_N_MASK;
+	report_info("Implements %d event counters",
+		    pmu.nb_implemented_counters);
+
+	return true;
 }
=20
 int main(int argc, char *argv[])
--=20
2.20.1


