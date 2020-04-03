Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B084C2D0E8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A352206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ej6Q1IPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A352206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKGg7-0008C6-H1
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 03:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jKGX5-00054n-GL
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jKGX4-0004SK-45
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:14:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28512
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jKGX3-0004Qy-WF
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585898063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=99It+CBFhqKUVxYHC9eg5j17thBCvs97W0OysR3tyFg=;
 b=ej6Q1IPR66zXb8mR5XBEPsZdiXkANyS5O6hF+8qLVEld79yoADICY/qQaYr1xOk+LOuEFX
 u9IQAauTNDtBrUfLMYIj6bL+U+agD2pUur4cfaG7vg5Uwy+10vpJfln9PiwiDl1qtTM93J
 rDoSHEMzsMGy/sn0xa6zq4JcrWG+gnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-AbSVQ4DHOG6P_qupZ-GpoA-1; Fri, 03 Apr 2020 03:14:22 -0400
X-MC-Unique: AbSVQ4DHOG6P_qupZ-GpoA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 973D2477;
 Fri,  3 Apr 2020 07:14:20 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA0AD5C1C6;
 Fri,  3 Apr 2020 07:14:17 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v4 12/12] arm: pmu: Test overflow interrupts
Date: Fri,  3 Apr 2020 09:13:26 +0200
Message-Id: <20200403071326.29932-13-eric.auger@redhat.com>
In-Reply-To: <20200403071326.29932-1-eric.auger@redhat.com>
References: <20200403071326.29932-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Test overflows for MEM_ACCESS and SW_INCR events. Also tests
overflows with 64-bit events.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v3 -> v4:
- all report messages are different

v2 -> v3:
- added prefix pop
- added pmu_stats.unexpected
- added pmu- prefix
- remove traces in irq_handler()

v1 -> v2:
- inline setup_irq() code
---
 arm/pmu.c         | 139 ++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |   6 ++
 2 files changed, 145 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index f8d9a18..39831c3 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -59,12 +59,20 @@
 #define PRE_OVERFLOW		0xFFFFFFF0
 #define PRE_OVERFLOW2		0xFFFFFFDC
=20
+#define PMU_PPI			23
+
 struct pmu {
 	unsigned int version;
 	unsigned int nb_implemented_counters;
 	uint32_t pmcr_ro;
 };
=20
+struct pmu_stats {
+	unsigned long bitmap;
+	uint32_t interrupts[32];
+	bool unexpected;
+};
+
 static struct pmu pmu;
=20
 #if defined(__arm__)
@@ -146,6 +154,7 @@ static void test_sw_incr(void) {}
 static void test_chained_counters(void) {}
 static void test_chained_sw_incr(void) {}
 static void test_chain_promotion(void) {}
+static void test_overflow_interrupt(void) {}
=20
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -276,6 +285,43 @@ asm volatile(
 	: "x9", "x10", "cc");
 }
=20
+static struct pmu_stats pmu_stats;
+
+static void irq_handler(struct pt_regs *regs)
+{
+	uint32_t irqstat, irqnr;
+
+	irqstat =3D gic_read_iar();
+	irqnr =3D gic_iar_irqnr(irqstat);
+
+	if (irqnr =3D=3D PMU_PPI) {
+		unsigned long overflows =3D read_sysreg(pmovsclr_el0);
+		int i;
+
+		for (i =3D 0; i < 32; i++) {
+			if (test_and_clear_bit(i, &overflows)) {
+				pmu_stats.interrupts[i]++;
+				pmu_stats.bitmap |=3D 1 << i;
+			}
+		}
+		write_sysreg(ALL_SET, pmovsclr_el0);
+	} else {
+		pmu_stats.unexpected =3D true;
+	}
+	gic_write_eoir(irqstat);
+}
+
+static void pmu_reset_stats(void)
+{
+	int i;
+
+	for (i =3D 0; i < 32; i++)
+		pmu_stats.interrupts[i] =3D 0;
+
+	pmu_stats.bitmap =3D 0;
+	pmu_stats.unexpected =3D false;
+}
+
 static void pmu_reset(void)
 {
 	/* reset all counters, counting disabled at PMCR level*/
@@ -286,6 +332,7 @@ static void pmu_reset(void)
 	write_sysreg(ALL_SET, pmovsclr_el0);
 	/* disable overflow interrupts on all counters */
 	write_sysreg(ALL_SET, pmintenclr_el1);
+	pmu_reset_stats();
 	isb();
 }
=20
@@ -729,6 +776,94 @@ static void test_chain_promotion(void)
 			read_sysreg(pmovsclr_el0));
 }
=20
+static bool expect_interrupts(uint32_t bitmap)
+{
+	int i;
+
+	if (pmu_stats.bitmap ^ bitmap || pmu_stats.unexpected)
+		return false;
+
+	for (i =3D 0; i < 32; i++) {
+		if (test_and_clear_bit(i, &pmu_stats.bitmap))
+			if (pmu_stats.interrupts[i] !=3D 1)
+				return false;
+	}
+	return true;
+}
+
+static void test_overflow_interrupt(void)
+{
+	uint32_t events[] =3D {MEM_ACCESS, SW_INCR};
+	void *addr =3D malloc(PAGE_SIZE);
+	int i;
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	gic_enable_defaults();
+	install_irq_handler(EL1H_IRQ, irq_handler);
+	local_irq_enable();
+	gic_enable_irq(23);
+
+	pmu_reset();
+
+	write_regn_el0(pmevtyper, 0, MEM_ACCESS | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevtyper, 1, SW_INCR | PMEVTYPER_EXCLUDE_EL0);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_regn_el0(pmevcntr, 1, PRE_OVERFLOW);
+	isb();
+
+	/* interrupts are disabled */
+
+	mem_access_loop(addr, 200, pmu.pmcr_ro | PMU_PMCR_E);
+	report(expect_interrupts(0), "no overflow interrupt after preset");
+
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+	for (i =3D 0; i < 100; i++)
+		write_sysreg(0x2, pmswinc_el0);
+
+	set_pmcr(pmu.pmcr_ro);
+	report(expect_interrupts(0), "no overflow interrupt after counting");
+
+	/* enable interrupts */
+
+	pmu_reset_stats();
+
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_regn_el0(pmevcntr, 1, PRE_OVERFLOW);
+	write_sysreg(ALL_SET, pmintenset_el1);
+	isb();
+
+	mem_access_loop(addr, 200, pmu.pmcr_ro | PMU_PMCR_E);
+	for (i =3D 0; i < 100; i++)
+		write_sysreg(0x3, pmswinc_el0);
+
+	mem_access_loop(addr, 200, pmu.pmcr_ro);
+	report_info("overflow=3D0x%lx", read_sysreg(pmovsclr_el0));
+	report(expect_interrupts(0x3),
+		"overflow interrupts expected on #0 and #1");
+
+	/* promote to 64-b */
+
+	pmu_reset_stats();
+
+	write_regn_el0(pmevtyper, 1, CHAIN | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	isb();
+	mem_access_loop(addr, 200, pmu.pmcr_ro | PMU_PMCR_E);
+	report(expect_interrupts(0),
+		"no overflow interrupt expected on 32b boundary");
+
+	/* overflow on odd counter */
+	pmu_reset_stats();
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_regn_el0(pmevcntr, 1, ALL_SET);
+	isb();
+	mem_access_loop(addr, 400, pmu.pmcr_ro | PMU_PMCR_E);
+	report(expect_interrupts(0x2),
+		"expect overflow interrupt on odd counter");
+}
 #endif
=20
 /*
@@ -931,6 +1066,10 @@ int main(int argc, char *argv[])
 		report_prefix_push(argv[1]);
 		test_chain_promotion();
 		report_prefix_pop();
+	} else if (strcmp(argv[1], "pmu-overflow-interrupt") =3D=3D 0) {
+		report_prefix_push(argv[1]);
+		test_overflow_interrupt();
+		report_prefix_pop();
 	} else {
 		report_abort("Unknown sub-test '%s'", argv[1]);
 	}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 1b0c8c8..455fd10 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -114,6 +114,12 @@ groups =3D pmu
 arch =3D arm64
 extra_params =3D -append 'pmu-chain-promotion'
=20
+[pmu-overflow-interrupt]
+file =3D pmu.flat
+groups =3D pmu
+arch =3D arm64
+extra_params =3D -append 'pmu-overflow-interrupt'
+
 # Test PMU support (TCG) with -icount IPC=3D1
 #[pmu-tcg-icount-1]
 #file =3D pmu.flat
--=20
2.20.1


