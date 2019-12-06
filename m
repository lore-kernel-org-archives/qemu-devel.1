Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94354C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED57206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+c9/k5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED57206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idI5I-0002kw-Ja
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1idHOi-00025O-Hi
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1idHOh-00043U-4q
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41412
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1idHOg-00041s-V7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ws3xaERf1779J4gNkymE+bAzmPMolefs3O1wIlcUpJo=;
 b=Z+c9/k5WUxFlrmhMZtZIT+HdTL9dU7irnnTOFtvHyN5hxLOWZSJio+BU8Uo02k4z86vHkV
 +qSjZOH+EIgGUKwz6ebGJKUAeVwX2SoBs7AjVV92lzEMUcoVnIiUCD5etKDnanq2qhkie/
 ZEy/ZyTItvVVdR19edkVaNBuNjlnrLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-F-9tv1RVOcePy6CWYZVclw-1; Fri, 06 Dec 2019 12:28:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 697F7107ACC4;
 Fri,  6 Dec 2019 17:28:03 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3D7160BF4;
 Fri,  6 Dec 2019 17:28:00 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests RFC 07/10] arm: pmu: test 32-bit <-> 64-bit
 transitions
Date: Fri,  6 Dec 2019 18:27:21 +0100
Message-Id: <20191206172724.947-8-eric.auger@redhat.com>
In-Reply-To: <20191206172724.947-1-eric.auger@redhat.com>
References: <20191206172724.947-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: F-9tv1RVOcePy6CWYZVclw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
 andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---
 arm/pmu.c         | 125 +++++++++++++++++++++++++++++++++++++++++++++-
 arm/unittests.cfg |   6 +++
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index e185809..47d46a2 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -116,6 +116,7 @@ static void test_basic_event_count(void) {}
 static void test_mem_access(void) {}
 static void test_chained_counters(void) {}
 static void test_chained_sw_incr(void) {}
+static void test_chain_promotion(void) {}
=20
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -262,7 +263,6 @@ asm volatile(
 =09: );
 }
=20
-
 static void pmu_reset(void)
 {
 =09/* reset all counters, counting disabled at PMCR level*/
@@ -571,6 +571,126 @@ static void test_chained_sw_incr(void)
 =09=09    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
 }
=20
+static void test_chain_promotion(void)
+{
+=09uint32_t events[] =3D { 0x13 /* MEM_ACCESS */, 0x1E /* CHAIN */};
+=09void *addr =3D malloc(PAGE_SIZE);
+
+=09if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+=09=09return;
+
+=09/* Only enable CHAIN counter */
+=09pmu_reset();
+        write_regn(pmevtyper, 0, events[0] | PMEVTYPER_EXCLUDE_EL0);
+        write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+=09write_sysreg_s(0x2, PMCNTENSET_EL0);
+=09isb();
+
+=09mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+=09report("chain counter not counting if even counter is disabled",
+=09=09!read_regn(pmevcntr, 0));
+
+=09/* Only enable even counter */
+=09pmu_reset();
+=09write_regn(pmevcntr, 0, 0xFFFFFFF0);
+=09write_sysreg_s(0x1, PMCNTENSET_EL0);
+=09isb();
+
+=09mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+=09report("odd counter did not increment on overflow if disabled",
+=09=09!read_regn(pmevcntr, 1) && (read_sysreg(pmovsclr_el0) =3D=3D 0x1));
+=09report_info("MEM_ACCESS counter #0 has value %ld", read_regn(pmevcntr, =
0));=20
+=09report_info("CHAIN counter #1 has value %ld", read_regn(pmevcntr, 1));=
=20
+=09report_info("overflow counter %ld", read_sysreg(pmovsclr_el0));
+
+=09/* start at 0xFFFFFFDC, +20 with CHAIN enabled, +20 with CHAIN disabled=
 */
+=09pmu_reset();
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+=09write_regn(pmevcntr, 0, 0xFFFFFFDC);
+=09isb();
+
+=09mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+=09report_info("MEM_ACCESS counter #0 has value 0x%lx", read_regn(pmevcntr=
, 0));=20
+
+=09/* disable the CHAIN event */
+=09write_sysreg_s(0x2, PMCNTENCLR_EL0);
+=09mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+=09report_info("MEM_ACCESS counter #0 has value 0x%lx", read_regn(pmevcntr=
, 0));=20
+=09report("should have triggered an overflow on #0", read_sysreg(pmovsclr_=
el0) =3D=3D 0x1);
+=09report("CHAIN counter #1 shouldn't have incremented", !read_regn(pmevcn=
tr, 1));
+
+=09/* start at 0xFFFFFFDC, +20 with CHAIN disabled, +20 with CHAIN enabled=
 */
+
+=09pmu_reset();
+=09write_sysreg_s(0x1, PMCNTENSET_EL0);
+=09write_regn(pmevcntr, 0, 0xFFFFFFDC);
+=09isb();
+=09report_info("counter #0 =3D 0x%lx, counter #1 =3D 0x%lx overflow=3D0x%l=
x",
+=09=09    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1),
+=09=09    read_sysreg(pmovsclr_el0));
+
+=09mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+=09report_info("MEM_ACCESS counter #0 has value 0x%lx", read_regn(pmevcntr=
, 0));=20
+
+=09/* enable the CHAIN event */
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+=09isb();
+=09mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+=09report_info("MEM_ACCESS counter #0 has value 0x%lx", read_regn(pmevcntr=
, 0));=20
+
+=09report("CHAIN counter #1 should have incremented and no overflow expect=
ed",
+=09=09(read_regn(pmevcntr, 1) =3D=3D 1) && !read_sysreg(pmovsclr_el0));
+
+=09report_info("CHAIN counter #1 =3D 0x%lx, overflow=3D0x%lx",
+=09=09read_regn(pmevcntr, 1), read_sysreg(pmovsclr_el0));
+
+=09/* start as MEM_ACCESS/CPU_CYCLES and move to CHAIN/MEM_ACCESS */
+=09pmu_reset();
+        write_regn(pmevtyper, 0, 0x13 /* MEM_ACCESS */ | PMEVTYPER_EXCLUDE=
_EL0);
+        write_regn(pmevtyper, 1, 0x11 /* CPU_CYCLES */ | PMEVTYPER_EXCLUDE=
_EL0);
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+=09write_regn(pmevcntr, 0, 0xFFFFFFDC);
+=09isb();
+
+=09mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+=09report_info("MEM_ACCESS counter #0 has value 0x%lx", read_regn(pmevcntr=
, 0));=20
+
+=09/* 0 becomes CHAINED */
+=09write_sysreg_s(0x0, PMCNTENSET_EL0);
+        write_regn(pmevtyper, 1, 0x1E /* CHAIN */ | PMEVTYPER_EXCLUDE_EL0)=
;
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+=09mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+=09report_info("MEM_ACCESS counter #0 has value 0x%lx", read_regn(pmevcntr=
, 0));=20
+
+=09report("CHAIN counter #1 should have incremented and no overflow expect=
ed",
+=09=09(read_regn(pmevcntr, 1) =3D=3D 1) && !read_sysreg(pmovsclr_el0));
+
+=09report_info("CHAIN counter #1 =3D 0x%lx, overflow=3D0x%lx",
+=09=09read_regn(pmevcntr, 1), read_sysreg(pmovsclr_el0));
+
+=09/* start as CHAIN/MEM_ACCESS and move to MEM_ACCESS/CPU_CYCLES */
+=09pmu_reset();
+        write_regn(pmevtyper, 0, 0x13 /* MEM_ACCESS */ | PMEVTYPER_EXCLUDE=
_EL0);
+        write_regn(pmevtyper, 1, 0x1E /* CHAIN */ | PMEVTYPER_EXCLUDE_EL0)=
;
+=09write_regn(pmevcntr, 0, 0xFFFFFFDC);
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+=09mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+=09report_info("counter #0=3D0x%lx, counter #1=3D0x%lx",
+=09=09=09read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
+
+=09write_sysreg_s(0x0, PMCNTENSET_EL0);
+        write_regn(pmevtyper, 1, 0x11 /* CPU_CYCLES */ | PMEVTYPER_EXCLUDE=
_EL0);
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+=09mem_access_loop(addr, 20, pmu.pmcr_ro | PMU_PMCR_E);
+=09report("overflow is expected on counter 0", read_sysreg(pmovsclr_el0) =
=3D=3D 1);
+=09report_info("counter #0=3D0x%lx, counter #1=3D0x%lx overflow=3D0x%lx",
+=09=09=09read_regn(pmevcntr, 0), read_regn(pmevcntr, 1),
+=09=09=09read_sysreg(pmovsclr_el0));
+}
+
 #endif
=20
 /*
@@ -773,6 +893,9 @@ int main(int argc, char *argv[])
 =09} else if (strcmp(argv[1], "chained-sw-incr") =3D=3D 0) {
 =09=09report_prefix_push(argv[1]);
 =09=09test_chained_sw_incr();
+=09} else if (strcmp(argv[1], "chain-promotion") =3D=3D 0) {
+=09=09report_prefix_push(argv[1]);
+=09=09test_chain_promotion();
 =09} else {
 =09=09report_abort("Unknown subtest '%s'", argv[1]);
 =09}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 1bd4319..eb6e87e 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -102,6 +102,12 @@ groups =3D pmu
 arch =3D arm64
 extra_params =3D -append 'chained-sw-incr'
=20
+[pmu-chain-promotion]
+file =3D pmu.flat
+groups =3D pmu
+arch =3D arm64
+extra_params =3D -append 'chain-promotion'
+
 # Test PMU support (TCG) with -icount IPC=3D1
 #[pmu-tcg-icount-1]
 #file =3D pmu.flat
--=20
2.20.1


