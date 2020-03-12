Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3553C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69891206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8oOSdcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69891206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQ6G-0007WJ-In
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jCQ0u-0006Bu-T8
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jCQ0t-0002BL-8R
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:44:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41662
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jCQ0t-00028h-1Y
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584027885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XarQ6PV/N2BikZiOVzMV46m8k60fx8JOioXu8+pZywQ=;
 b=V8oOSdcpLhNIBWTH8ETvN+3/DJf/zR7drQ18HFHtp0nTtAs8jfHIF8s76b/6H0m7CRc8aq
 D0QfSNdeNqD7ZIhbnq+CVaddQXZkO4EK86+bsBhegciw2+A2fmv6Up0lGpGn5EkNtB4cks
 ST2d7GcvbSV4P3FmGwdx6+3NVpCJfeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-UAZ-rGDKN1ODer1zvlhl9w-1; Thu, 12 Mar 2020 11:44:41 -0400
X-MC-Unique: UAZ-rGDKN1ODer1zvlhl9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2165F19251D1;
 Thu, 12 Mar 2020 15:44:40 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A2775C1B5;
 Thu, 12 Mar 2020 15:44:31 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v3 10/12] arm: pmu: test 32-bit <-> 64-bit
 transitions
Date: Thu, 12 Mar 2020 16:42:59 +0100
Message-Id: <20200312154301.9130-11-eric.auger@redhat.com>
In-Reply-To: <20200312154301.9130-1-eric.auger@redhat.com>
References: <20200312154301.9130-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Test configurations where we transit from 32b to 64b
counters and conversely. Also tests configuration where
chain counters are configured but only one counter is
enabled.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- added prefix pop
---
 arm/pmu.c         | 138 ++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |   6 ++
 2 files changed, 144 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index ccca31b..79c2a0f 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -57,6 +57,7 @@
 #define ALL_SET			0xFFFFFFFF
 #define ALL_CLEAR		0x0
 #define PRE_OVERFLOW		0xFFFFFFF0
+#define PRE_OVERFLOW2		0xFFFFFFDC
=20
 struct pmu {
 	unsigned int version;
@@ -144,6 +145,7 @@ static void test_mem_access(void) {}
 static void test_sw_incr(void) {}
 static void test_chained_counters(void) {}
 static void test_chained_sw_incr(void) {}
+static void test_chain_promotion(void) {}
=20
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -596,6 +598,138 @@ static void test_chained_sw_incr(void)
 		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
 }
=20
+static void test_chain_promotion(void)
+{
+	uint32_t events[] =3D {MEM_ACCESS, CHAIN};
+	void *addr =3D malloc(PAGE_SIZE);
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	/* Only enable CHAIN counter */
+	pmu_reset();
+	write_regn_el0(pmevtyper, 0, MEM_ACCESS | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevtyper, 1, CHAIN | PMEVTYPER_EXCLUDE_EL0);
+	write_sysreg_s(0x2, PMCNTENSET_EL0);
+	isb();
+
+	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+	report(!read_regn_el0(pmevcntr, 0),
+		"chain counter not counting if even counter is disabled");
+
+	/* Only enable even counter */
+	pmu_reset();
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_sysreg_s(0x1, PMCNTENSET_EL0);
+	isb();
+
+	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+	report(!read_regn_el0(pmevcntr, 1) && (read_sysreg(pmovsclr_el0) =3D=3D=
 0x1),
+		"odd counter did not increment on overflow if disabled");
+	report_info("MEM_ACCESS counter #0 has value %ld",
+		    read_regn_el0(pmevcntr, 0));
+	report_info("CHAIN counter #1 has value %ld",
+		    read_regn_el0(pmevcntr, 1));
+	report_info("overflow counter %ld", read_sysreg(pmovsclr_el0));
+
+	/* start at 0xFFFFFFDC, +20 with CHAIN enabled, +20 with CHAIN disabled=
 */
+	pmu_reset();
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW2);
+	isb();
+
+	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("MEM_ACCESS counter #0 has value 0x%lx",
+		    read_regn_el0(pmevcntr, 0));
+
+	/* disable the CHAIN event */
+	write_sysreg_s(0x2, PMCNTENCLR_EL0);
+	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("MEM_ACCESS counter #0 has value 0x%lx",
+		    read_regn_el0(pmevcntr, 0));
+	report(read_sysreg(pmovsclr_el0) =3D=3D 0x1,
+		"should have triggered an overflow on #0");
+	report(!read_regn_el0(pmevcntr, 1),
+		"CHAIN counter #1 shouldn't have incremented");
+
+	/* start at 0xFFFFFFDC, +20 with CHAIN disabled, +20 with CHAIN enabled=
 */
+
+	pmu_reset();
+	write_sysreg_s(0x1, PMCNTENSET_EL0);
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW2);
+	isb();
+	report_info("counter #0 =3D 0x%lx, counter #1 =3D 0x%lx overflow=3D0x%l=
x",
+		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1),
+		    read_sysreg(pmovsclr_el0));
+
+	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("MEM_ACCESS counter #0 has value 0x%lx",
+		    read_regn_el0(pmevcntr, 0));
+
+	/* enable the CHAIN event */
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	isb();
+	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("MEM_ACCESS counter #0 has value 0x%lx",
+		    read_regn_el0(pmevcntr, 0));
+
+	report((read_regn_el0(pmevcntr, 1) =3D=3D 1) && !read_sysreg(pmovsclr_e=
l0),
+		"CHAIN counter #1 should have incremented and no overflow expected");
+
+	report_info("CHAIN counter #1 =3D 0x%lx, overflow=3D0x%lx",
+		read_regn_el0(pmevcntr, 1), read_sysreg(pmovsclr_el0));
+
+	/* start as MEM_ACCESS/CPU_CYCLES and move to CHAIN/MEM_ACCESS */
+	pmu_reset();
+	write_regn_el0(pmevtyper, 0, MEM_ACCESS | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevtyper, 1, CPU_CYCLES | PMEVTYPER_EXCLUDE_EL0);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW2);
+	isb();
+
+	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("MEM_ACCESS counter #0 has value 0x%lx",
+		    read_regn_el0(pmevcntr, 0));
+
+	/* 0 becomes CHAINED */
+	write_sysreg_s(0x0, PMCNTENSET_EL0);
+	write_regn_el0(pmevtyper, 1, CHAIN | PMEVTYPER_EXCLUDE_EL0);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	write_regn_el0(pmevcntr, 1, 0x0);
+
+	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("MEM_ACCESS counter #0 has value 0x%lx",
+		    read_regn_el0(pmevcntr, 0));
+
+	report((read_regn_el0(pmevcntr, 1) =3D=3D 1) && !read_sysreg(pmovsclr_e=
l0),
+		"CHAIN counter #1 should have incremented and no overflow expected");
+
+	report_info("CHAIN counter #1 =3D 0x%lx, overflow=3D0x%lx",
+		read_regn_el0(pmevcntr, 1), read_sysreg(pmovsclr_el0));
+
+	/* start as CHAIN/MEM_ACCESS and move to MEM_ACCESS/CPU_CYCLES */
+	pmu_reset();
+	write_regn_el0(pmevtyper, 0, MEM_ACCESS | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevtyper, 1, CHAIN | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW2);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("counter #0=3D0x%lx, counter #1=3D0x%lx",
+			read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
+
+	write_sysreg_s(0x0, PMCNTENSET_EL0);
+	write_regn_el0(pmevtyper, 1, CPU_CYCLES | PMEVTYPER_EXCLUDE_EL0);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+	mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+	report(read_sysreg(pmovsclr_el0) =3D=3D 1,
+		"overflow is expected on counter 0");
+	report_info("counter #0=3D0x%lx, counter #1=3D0x%lx overflow=3D0x%lx",
+			read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1),
+			read_sysreg(pmovsclr_el0));
+}
+
 #endif
=20
 /*
@@ -794,6 +928,10 @@ int main(int argc, char *argv[])
 		report_prefix_push(argv[1]);
 		test_chained_sw_incr();
 		report_prefix_pop();
+	} else if (strcmp(argv[1], "pmu-chain-promotion") =3D=3D 0) {
+		report_prefix_push(argv[1]);
+		test_chain_promotion();
+		report_prefix_pop();
 	} else {
 		report_abort("Unknown sub-test '%s'", argv[1]);
 	}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index d31dcbf..1b0c8c8 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -108,6 +108,12 @@ groups =3D pmu
 arch =3D arm64
 extra_params =3D -append 'pmu-chained-sw-incr'
=20
+[pmu-chain-promotion]
+file =3D pmu.flat
+groups =3D pmu
+arch =3D arm64
+extra_params =3D -append 'pmu-chain-promotion'
+
 # Test PMU support (TCG) with -icount IPC=3D1
 #[pmu-tcg-icount-1]
 #file =3D pmu.flat
--=20
2.20.1


