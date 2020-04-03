Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA35C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE37206F6
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9wVE7ov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE37206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKGaI-00013h-VX
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 03:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jKGWa-00040X-Q9
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jKGWZ-00047Z-L3
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:13:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jKGWZ-00047D-HU
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585898035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMgw7fPRvswGtz0UWDZWno+rhI8xWDdMNwR6QWL2h2w=;
 b=P9wVE7ovAz8EAzZ5n0jrzyM5XzmeWQiM88FOBzvp2cZo6F3uItjFEhtDTFQr+rj5VbD9kh
 umXdHEP/Gu++WggNxU8kq00s5+hKGu/Pq13FnD8vTMtZcOtK6gRGNYN/tuLSH9KBsRz+22
 hBWSYS6CoQCj1J7pqjpTQ6O3T4Y0EeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-vVHercPyPrOkiD-P-tOYzw-1; Fri, 03 Apr 2020 03:13:51 -0400
X-MC-Unique: vVHercPyPrOkiD-P-tOYzw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47285800D5B;
 Fri,  3 Apr 2020 07:13:50 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FC575C1C6;
 Fri,  3 Apr 2020 07:13:46 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v4 04/12] arm: pmu: Add a pmu struct
Date: Fri,  3 Apr 2020 09:13:18 +0200
Message-Id: <20200403071326.29932-5-eric.auger@redhat.com>
In-Reply-To: <20200403071326.29932-1-eric.auger@redhat.com>
References: <20200403071326.29932-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: peter.maydell@linaro.org, andrew.murray@arm.com, drjones@redhat.com,
 alexandru.elisei@arm.com, andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This struct aims at storing information potentially used by
all tests such as the pmu version, the read-only part of the
PMCR, the number of implemented event counters, ...

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

---

v2 -> v3:
- Fix pmcr_ro and add a comment
---
 arm/pmu.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index 44f3543..d827e82 100644
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
@@ -242,7 +249,7 @@ static bool check_cpi(int cpi)
 static void pmccntr64_test(void)
 {
 #ifdef __arm__
-	if (pmu_version =3D=3D 0x3) {
+	if (pmu.version =3D=3D 0x3) {
 		if (ERRATA(9e3f7a296940)) {
 			write_sysreg(0xdead, PMCCNTR64);
 			report(read_sysreg(PMCCNTR64) =3D=3D 0xdead, "pmccntr64");
@@ -257,18 +264,24 @@ static bool pmu_probe(void)
 {
 	uint32_t pmcr;
=20
-	pmu_version =3D get_pmu_version();
-	if (pmu_version =3D=3D 0 || pmu_version =3D=3D 0xf)
+	pmu.version =3D get_pmu_version();
+	if (pmu.version =3D=3D 0 || pmu.version =3D=3D 0xf)
 		return false;
=20
-	report_info("PMU version: %d", pmu_version);
+	report_info("PMU version: %d", pmu.version);
=20
 	pmcr =3D get_pmcr();
-	report_info("PMU implementer/ID code/counters: %#x(\"%c\")/%#x/%d",
+	report_info("PMU implementer/ID code: %#x(\"%c\")/%#x",
 		    (pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK,
 		    ((pmcr >> PMU_PMCR_IMP_SHIFT) & PMU_PMCR_IMP_MASK) ? : ' ',
-		    (pmcr >> PMU_PMCR_ID_SHIFT) & PMU_PMCR_ID_MASK,
-		    (pmcr >> PMU_PMCR_N_SHIFT) & PMU_PMCR_N_MASK);
+		    (pmcr >> PMU_PMCR_ID_SHIFT) & PMU_PMCR_ID_MASK);
+
+	/* store read-only and RES0 fields of the PMCR bottom-half*/
+	pmu.pmcr_ro =3D pmcr & 0xFFFFFF00;
+	pmu.nb_implemented_counters =3D
+		(pmcr >> PMU_PMCR_N_SHIFT) & PMU_PMCR_N_MASK;
+	report_info("Implements %d event counters",
+		    pmu.nb_implemented_counters);
=20
 	return true;
 }
--=20
2.20.1


