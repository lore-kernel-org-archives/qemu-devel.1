Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48995C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1815624670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h47tVp+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1815624670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIa4-0001Ad-Am
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1idHOt-0002GY-B9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1idHOr-0004VV-Ql
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1idHOr-0004TQ-Lo
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHy6JtDFNgRRZUOE/EOkjvVUEne6jqUvFOy591Cbfrs=;
 b=h47tVp+4Tc3SrZw+tDX0LUm6aXF0pOMfmv17POB1nphloPJPl8RyvKxB8UgODdFdMl/157
 b7UPOFIeD/Mdkuy1hL51B7TskLoDapmRfJEMmseKXOjVsi5NzfbtJjNfibPj0yZZ+5vkXX
 XB+fId0uzLRbyYM3xHahohw5dTrvnQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-BOXZZEcbPF-QJRXfsfQH8w-1; Fri, 06 Dec 2019 12:28:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 925BC800EB9;
 Fri,  6 Dec 2019 17:28:14 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15F6560BF4;
 Fri,  6 Dec 2019 17:28:11 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests RFC 10/10] pmu: Test overflow interrupts
Date: Fri,  6 Dec 2019 18:27:24 +0100
Message-Id: <20191206172724.947-11-eric.auger@redhat.com>
In-Reply-To: <20191206172724.947-1-eric.auger@redhat.com>
References: <20191206172724.947-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: BOXZZEcbPF-QJRXfsfQH8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
 andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test overflows for MEM_ACESS and SW_INCR events. Also tests
overflows with 64-bit events.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/pmu.c         | 133 +++++++++++++++++++++++++++++++++++++++++++++-
 arm/unittests.cfg |   6 +++
 2 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index 47d46a2..a63b93e 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -45,8 +45,12 @@ struct pmu {
 =09uint32_t pmcr_ro;
 };
=20
-static struct pmu pmu;
+struct pmu_stats {
+=09unsigned long bitmap;
+=09uint32_t interrupts[32];
+};
=20
+static struct pmu pmu;
=20
 #if defined(__arm__)
 #define ID_DFR0_PERFMON_SHIFT 24
@@ -117,6 +121,7 @@ static void test_mem_access(void) {}
 static void test_chained_counters(void) {}
 static void test_chained_sw_incr(void) {}
 static void test_chain_promotion(void) {}
+static void test_overflow_interrupt(void) {}
=20
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -263,6 +268,43 @@ asm volatile(
 =09: );
 }
=20
+static struct pmu_stats pmu_stats;
+
+static void irq_handler(struct pt_regs *regs)
+{
+        uint32_t irqstat, irqnr;
+
+        irqstat =3D gic_read_iar();
+        irqnr =3D gic_iar_irqnr(irqstat);
+        gic_write_eoir(irqstat);
+
+        if (irqnr =3D=3D 23) {
+                unsigned long overflows =3D read_sysreg(pmovsclr_el0);
+=09=09int i;
+
+                report_info("--> PMU overflow interrupt %d (counter bitmas=
k 0x%lx)", irqnr, overflows);
+=09=09for (i =3D 0; i < 32; i++) {
+=09=09=09if (test_and_clear_bit(i, &overflows)) {
+=09=09=09=09pmu_stats.interrupts[i]++;
+=09=09=09=09pmu_stats.bitmap |=3D 1 << i;
+=09=09=09}
+=09=09}
+                write_sysreg(0xFFFFFFFF, pmovsclr_el0);
+        } else {
+                report_info("Unexpected interrupt: %d\n", irqnr);
+        }
+}
+
+static void pmu_reset_stats(void)
+{
+=09int i;
+
+=09for (i =3D 0; i < 32; i++) {
+=09=09pmu_stats.interrupts[i] =3D 0;
+=09}
+=09pmu_stats.bitmap =3D 0;
+}
+
 static void pmu_reset(void)
 {
 =09/* reset all counters, counting disabled at PMCR level*/
@@ -273,6 +315,7 @@ static void pmu_reset(void)
 =09write_sysreg(0xFFFFFFFF, pmovsclr_el0);
 =09/* disable overflow interrupts on all counters */
 =09write_sysreg(0xFFFFFFFF, pmintenclr_el1);
+=09pmu_reset_stats();
 =09isb();
 }
=20
@@ -691,8 +734,93 @@ static void test_chain_promotion(void)
 =09=09=09read_sysreg(pmovsclr_el0));
 }
=20
+static bool expect_interrupts(uint32_t bitmap)
+{
+=09int i;
+
+=09if (pmu_stats.bitmap ^ bitmap)
+=09=09return false;
+
+=09for (i =3D 0; i < 32; i++) {
+=09=09if (test_and_clear_bit(i, &pmu_stats.bitmap))
+=09=09=09if (pmu_stats.interrupts[i] !=3D 1)
+=09=09=09=09return false;
+=09}
+=09return true;
+}
+
+static void test_overflow_interrupt(void)
+{
+=09uint32_t events[] =3D { 0x13 /* MEM_ACCESS */, 0x00 /* SW_INCR */};
+=09void *addr =3D malloc(PAGE_SIZE);
+=09int i;
+
+=09if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+=09=09return;
+
+=09setup_irq(irq_handler);
+=09gic_enable_irq(23);
+
+=09pmu_reset();
+
+        write_regn(pmevtyper, 0, events[0] | PMEVTYPER_EXCLUDE_EL0);
+        write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+=09write_regn(pmevcntr, 0, 0xFFFFFFF0);
+=09write_regn(pmevcntr, 1, 0xFFFFFFF0);
+=09isb();
+
+=09/* interrupts are disabled */
+
+=09mem_access_loop(addr, 200, pmu.pmcr_ro | PMU_PMCR_E);
+=09report("no overflow interrupt received", expect_interrupts(0));
+
+=09set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+=09for (i =3D 0; i < 100; i++) {
+=09=09write_sysreg(0x2, pmswinc_el0);
+=09}
+=09set_pmcr(pmu.pmcr_ro);
+=09report("no overflow interrupt received", expect_interrupts(0));
+
+=09/* enable interrupts */
+
+=09pmu_reset_stats();
+
+=09write_regn(pmevcntr, 0, 0xFFFFFFF0);
+=09write_regn(pmevcntr, 1, 0xFFFFFFF0);
+=09write_sysreg(0xFFFFFFFF, pmintenset_el1);
+=09isb();
+
+=09mem_access_loop(addr, 200, pmu.pmcr_ro | PMU_PMCR_E);
+=09for (i =3D 0; i < 100; i++) {
+=09=09write_sysreg(0x3, pmswinc_el0);
+=09}
+=09mem_access_loop(addr, 200, pmu.pmcr_ro);
+=09report_info("overflow=3D0x%lx", read_sysreg(pmovsclr_el0));
+=09report("overflow interrupts expected on #0 and #1", expect_interrupts(0=
x3));
+
+=09/* promote to 64-b */
+
+=09pmu_reset_stats();
+
+=09events[1] =3D 0x1E /* CHAIN */;
+        write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+=09write_regn(pmevcntr, 0, 0xFFFFFFF0);
+=09isb();
+=09mem_access_loop(addr, 200, pmu.pmcr_ro | PMU_PMCR_E);
+=09report("no overflow interrupt expected on 32b boundary", expect_interru=
pts(0));
+
+=09/* overflow on odd counter */
+=09pmu_reset_stats();
+=09write_regn(pmevcntr, 0, 0xFFFFFFF0);
+=09write_regn(pmevcntr, 1, 0xFFFFFFFF);
+=09isb();
+=09mem_access_loop(addr, 200, pmu.pmcr_ro | PMU_PMCR_E);
+=09report("expect overflow interrupt on odd counter", expect_interrupts(0x=
2));
+}
 #endif
=20
+
 /*
  * As a simple sanity check on the PMCR_EL0, ensure the implementer field =
isn't
  * null. Also print out a couple other interesting fields for diagnostic
@@ -896,6 +1024,9 @@ int main(int argc, char *argv[])
 =09} else if (strcmp(argv[1], "chain-promotion") =3D=3D 0) {
 =09=09report_prefix_push(argv[1]);
 =09=09test_chain_promotion();
+=09} else if (strcmp(argv[1], "overflow-interrupt") =3D=3D 0) {
+=09=09report_prefix_push(argv[1]);
+=09=09test_overflow_interrupt();
 =09} else {
 =09=09report_abort("Unknown subtest '%s'", argv[1]);
 =09}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index eb6e87e..31b4c7a 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -108,6 +108,12 @@ groups =3D pmu
 arch =3D arm64
 extra_params =3D -append 'chain-promotion'
=20
+[pmu-chain-promotion]
+file =3D pmu.flat
+groups =3D pmu
+arch =3D arm64
+extra_params =3D -append 'overflow-interrupt'
+
 # Test PMU support (TCG) with -icount IPC=3D1
 #[pmu-tcg-icount-1]
 #file =3D pmu.flat
--=20
2.20.1


