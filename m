Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3E0C5ACBF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB142067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 15:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHnJ7ZlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB142067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQ97-0003jH-GR
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 11:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jCQ0j-0005j0-A1
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jCQ0h-0001hu-Oq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:44:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47373
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jCQ0g-0001eJ-TL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 11:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584027874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFpJASfu2ht2gDqiYkt5EXxaGYzykEHenqKpcZ6I3ns=;
 b=jHnJ7ZlOER4ci08FQjP31aPlcOdwdv3w+0+eNdc5uHzrGEouuhLepzg83IXI8tPY+o0zQ8
 l/4QAKqBASWAurYlyQFdexUz9rStef6CE4eIcp9XKm/woB31t6gVOYmf8oOotiW6c71sc1
 O2IUS1ViP5uKmAZZNVuvBSUBm3iUdU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-zBMcV4IrO9OY-tiSY3O0sw-1; Thu, 12 Mar 2020 11:44:33 -0400
X-MC-Unique: zBMcV4IrO9OY-tiSY3O0sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 787EC192299E;
 Thu, 12 Mar 2020 15:44:31 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E25FB5C1B5;
 Thu, 12 Mar 2020 15:44:26 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v3 09/12] arm: pmu: Test chained counters
Date: Thu, 12 Mar 2020 16:42:58 +0100
Message-Id: <20200312154301.9130-10-eric.auger@redhat.com>
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

Add 2 tests exercising chained counters. The first one uses
CPU_CYCLES and the second one uses SW_INCR.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- added prefix pop
- added pmu prefix to the test names
- defines, event array ...
---
 arm/pmu.c         | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg | 12 ++++++
 2 files changed, 109 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index c954c71..ccca31b 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -47,6 +47,7 @@
 #define INST_PREC		0x1B
 #define STALL_FRONTEND		0x23
 #define STALL_BACKEND		0x24
+#define CHAIN			0x1E
=20
 #define COMMON_EVENTS_LOW	0x0
 #define COMMON_EVENTS_HIGH	0x3F
@@ -141,6 +142,8 @@ static void test_event_counter_config(void) {}
 static void test_basic_event_count(void) {}
 static void test_mem_access(void) {}
 static void test_sw_incr(void) {}
+static void test_chained_counters(void) {}
+static void test_chained_sw_incr(void) {}
=20
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -507,6 +510,92 @@ static void test_sw_incr(void)
 		"overflow reg after 100 SW_INCR");
 }
=20
+static void test_chained_counters(void)
+{
+	uint32_t events[] =3D {CPU_CYCLES, CHAIN};
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	pmu_reset();
+
+	write_regn_el0(pmevtyper, 0, CPU_CYCLES | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevtyper, 1, CHAIN | PMEVTYPER_EXCLUDE_EL0);
+	/* enable counters #0 and #1 */
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+
+	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
+
+	report(read_regn_el0(pmevcntr, 1) =3D=3D 1, "CHAIN counter #1 increment=
ed");
+	report(!read_sysreg(pmovsclr_el0), "check no overflow is recorded");
+
+	/* test 64b overflow */
+
+	pmu_reset();
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_regn_el0(pmevcntr, 1, 0x1);
+	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("overflow reg =3D 0x%lx", read_sysreg(pmovsclr_el0));
+	report(read_regn_el0(pmevcntr, 1) =3D=3D 2, "CHAIN counter #1 increment=
ed");
+	report(!read_sysreg(pmovsclr_el0), "check no overflow is recorded");
+
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_regn_el0(pmevcntr, 1, ALL_SET);
+
+	precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
+	report_info("overflow reg =3D 0x%lx", read_sysreg(pmovsclr_el0));
+	report(!read_regn_el0(pmevcntr, 1), "CHAIN counter #1 wrapped");
+	report(read_sysreg(pmovsclr_el0) =3D=3D 0x2,
+		"check no overflow is recorded");
+}
+
+static void test_chained_sw_incr(void)
+{
+	uint32_t events[] =3D {SW_INCR, CHAIN};
+	int i;
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	pmu_reset();
+
+	write_regn_el0(pmevtyper, 0, SW_INCR | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevtyper, 1, CHAIN | PMEVTYPER_EXCLUDE_EL0);
+	/* enable counters #0 and #1 */
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+	for (i =3D 0; i < 100; i++)
+		write_sysreg(0x1, pmswinc_el0);
+
+	report(!read_sysreg(pmovsclr_el0) && (read_regn_el0(pmevcntr, 1) =3D=3D=
 1),
+		"overflow reg after 100 SW_INCR/CHAIN");
+	report_info("overflow=3D0x%lx, #0=3D%ld #1=3D%ld", read_sysreg(pmovsclr=
_el0),
+		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
+
+	/* 64b SW_INCR and overflow on CHAIN counter*/
+	pmu_reset();
+
+	write_regn_el0(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_regn_el0(pmevcntr, 1, ALL_SET);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+	for (i =3D 0; i < 100; i++)
+		write_sysreg(0x1, pmswinc_el0);
+
+	report((read_sysreg(pmovsclr_el0) =3D=3D 0x2) &&
+		(read_regn_el0(pmevcntr, 1) =3D=3D 0) &&
+		(read_regn_el0(pmevcntr, 0) =3D=3D 84),
+		"overflow reg after 100 SW_INCR/CHAIN");
+	report_info("overflow=3D0x%lx, #0=3D%ld #1=3D%ld", read_sysreg(pmovsclr=
_el0),
+		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
+}
+
 #endif
=20
 /*
@@ -697,6 +786,14 @@ int main(int argc, char *argv[])
 		report_prefix_push(argv[1]);
 		test_sw_incr();
 		report_prefix_pop();
+	} else if (strcmp(argv[1], "pmu-chained-counters") =3D=3D 0) {
+		report_prefix_push(argv[1]);
+		test_chained_counters();
+		report_prefix_pop();
+	} else if (strcmp(argv[1], "pmu-chained-sw-incr") =3D=3D 0) {
+		report_prefix_push(argv[1]);
+		test_chained_sw_incr();
+		report_prefix_pop();
 	} else {
 		report_abort("Unknown sub-test '%s'", argv[1]);
 	}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 175afe6..d31dcbf 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -96,6 +96,18 @@ groups =3D pmu
 arch =3D arm64
 extra_params =3D -append 'pmu-sw-incr'
=20
+[pmu-chained-counters]
+file =3D pmu.flat
+groups =3D pmu
+arch =3D arm64
+extra_params =3D -append 'pmu-chained-counters'
+
+[pmu-chained-sw-incr]
+file =3D pmu.flat
+groups =3D pmu
+arch =3D arm64
+extra_params =3D -append 'pmu-chained-sw-incr'
+
 # Test PMU support (TCG) with -icount IPC=3D1
 #[pmu-tcg-icount-1]
 #file =3D pmu.flat
--=20
2.20.1


