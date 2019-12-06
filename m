Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F60C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3DC2053B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUPCMfIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3DC2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42591 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHmE-0004Kl-RJ
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1idHOU-0001j6-RR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1idHOT-0003JT-M7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:27:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39011
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1idHOT-0003H3-Dc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqTunPkxwrcyQFOxDUNzfOp1hv1TJYsH7F1IJZPhTJo=;
 b=GUPCMfIKF/NWK5pNJR+nw4t8tI35nE0kVEHbQBwq3GIctmI2xGM1ydTOAYXVFGOXu7Lkan
 4F6NA3RqJTvSWP41bQqzaW5Jw2O2Ym/jyBsUmDCFPNaeJ4T4jiY9YQeFz5DzzjmgQLNsGY
 WHzQc/CIyfBYdiU/9dXuX33hG0tAtMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-RwGInhliOwmo9mMSBC3FqA-1; Fri, 06 Dec 2019 12:27:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35E9A1005502;
 Fri,  6 Dec 2019 17:27:47 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 540D86CE40;
 Fri,  6 Dec 2019 17:27:42 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests RFC 03/10] pmu: Add a pmu struct
Date: Fri,  6 Dec 2019 18:27:17 +0100
Message-Id: <20191206172724.947-4-eric.auger@redhat.com>
In-Reply-To: <20191206172724.947-1-eric.auger@redhat.com>
References: <20191206172724.947-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: RwGInhliOwmo9mMSBC3FqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This struct aims at storing information potentially used by
all tests such as the pmu version, the read-only part of the
PMCR, the number of implemented event counters, ...

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/pmu.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index 2ad6469..8e95251 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -33,7 +33,15 @@
=20
 #define NR_SAMPLES 10
=20
-static unsigned int pmu_version;
+struct pmu {
+=09unsigned int version;
+=09unsigned int nb_implemented_counters;
+=09uint32_t pmcr_ro;
+};
+
+static struct pmu pmu;
+
+
 #if defined(__arm__)
 #define ID_DFR0_PERFMON_SHIFT 24
 #define ID_DFR0_PERFMON_MASK  0xf
@@ -265,7 +273,7 @@ static bool check_cpi(int cpi)
 static void pmccntr64_test(void)
 {
 #ifdef __arm__
-=09if (pmu_version =3D=3D 0x3) {
+=09if (pmu.version =3D=3D 0x3) {
 =09=09if (ERRATA(9e3f7a296940)) {
 =09=09=09write_sysreg(0xdead, PMCCNTR64);
 =09=09=09report("pmccntr64", read_sysreg(PMCCNTR64) =3D=3D 0xdead);
@@ -278,9 +286,20 @@ static void pmccntr64_test(void)
 /* Return FALSE if no PMU found, otherwise return TRUE */
 static bool pmu_probe(void)
 {
-=09pmu_version =3D get_pmu_version();
-=09report_info("PMU version: %d", pmu_version);
-=09return pmu_version !=3D 0 && pmu_version !=3D 0xf;
+=09uint32_t pmcr;
+
+=09pmu.version =3D get_pmu_version();
+=09report_info("PMU version: %d", pmu.version);
+
+=09if (pmu.version =3D=3D 0 || pmu.version  =3D=3D 0xF)
+=09=09return false;
+
+=09pmcr =3D get_pmcr();
+=09pmu.pmcr_ro =3D pmcr & 0xFFFFFF80;
+=09pmu.nb_implemented_counters =3D (pmcr >> PMU_PMCR_N_SHIFT) & PMU_PMCR_N=
_MASK;
+=09report_info("Implements %d event counters", pmu.nb_implemented_counters=
);
+
+=09return true;
 }
=20
 int main(int argc, char *argv[])
--=20
2.20.1


