Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90265C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0F824670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auC4eH5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0F824670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHy4-0002bX-AR
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1idHOf-0001yr-7O
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1idHOd-0003r8-Md
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1idHOd-0003pV-Id
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSQq/C7pHCzkPl8tiWZuEBhfZM9PZ9tXND49zKMJFso=;
 b=auC4eH5FY42YDKcpTP9ic8ih/NWuoeIT4++bCj/B7CsjltpeCjbK272R3QRCFRD0CC4qBP
 DAcYPRhoJmJnbvto7InlVI/gGQxZicOArVnXnMwNI2eTiSS11BV+gDfegQEsaAMVnGykLq
 Uvow8soO1ZMexvJVaqi4kgi6eysEMn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-8c5GEJRsMwWaBaD1nzgbAw-1; Fri, 06 Dec 2019 12:28:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EB4F107ACC7;
 Fri,  6 Dec 2019 17:28:00 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1101760BF4;
 Fri,  6 Dec 2019 17:27:57 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests RFC 06/10] pmu: Test chained counter
Date: Fri,  6 Dec 2019 18:27:20 +0100
Message-Id: <20191206172724.947-7-eric.auger@redhat.com>
In-Reply-To: <20191206172724.947-1-eric.auger@redhat.com>
References: <20191206172724.947-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 8c5GEJRsMwWaBaD1nzgbAw-1
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

Add 2 tests exercising chained counters. The first one uses
CPU_CYCLES and the second one uses SW_INCR.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/pmu.c         | 125 ++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |  12 +++++
 2 files changed, 137 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index 8ffeb93..e185809 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -114,6 +114,8 @@ static void test_event_introspection(void) {}
 static void test_event_counter_config(void) {}
 static void test_basic_event_count(void) {}
 static void test_mem_access(void) {}
+static void test_chained_counters(void) {}
+static void test_chained_sw_incr(void) {}
=20
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -452,6 +454,123 @@ static void test_mem_access(void)
 =09=09=09read_sysreg(pmovsclr_el0));
 }
=20
+static void test_chained_counters(void)
+{
+=09uint32_t events[] =3D { 0x11 /* CPU_CYCLES */, 0x1E /* CHAIN */};
+
+=09if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+=09=09return;
+
+=09pmu_reset();
+
+        write_regn(pmevtyper, 0, events[0] | PMEVTYPER_EXCLUDE_EL0);
+        write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+=09/* enable counters #0 and #1 */
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+=09/* preset counter #0 at 0xFFFFFFF0 */
+=09write_regn(pmevcntr, 0, 0xFFFFFFF0);
+
+=09precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
+
+=09report("CHAIN counter #1 incremented", read_regn(pmevcntr, 1) =3D=3D 1)=
;=20
+=09report("check no overflow is recorded", !read_sysreg(pmovsclr_el0));
+
+=09/* test 64b overflow */
+
+=09pmu_reset();
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+=09write_regn(pmevcntr, 0, 0xFFFFFFF0);
+=09write_regn(pmevcntr, 1, 0x1);
+=09precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
+=09report_info("overflow reg =3D 0x%lx", read_sysreg(pmovsclr_el0));
+=09report("CHAIN counter #1 incremented", read_regn(pmevcntr, 1) =3D=3D 2)=
;=20
+=09report("check no overflow is recorded", !read_sysreg(pmovsclr_el0));
+
+=09write_regn(pmevcntr, 0, 0xFFFFFFF0);
+=09write_regn(pmevcntr, 1, 0xFFFFFFFF);
+
+=09precise_instrs_loop(22, pmu.pmcr_ro | PMU_PMCR_E);
+=09report_info("overflow reg =3D 0x%lx", read_sysreg(pmovsclr_el0));
+=09report("CHAIN counter #1 wrapped", !read_regn(pmevcntr, 1));=20
+=09report("check no overflow is recorded", read_sysreg(pmovsclr_el0) =3D=
=3D 0x2);
+}
+
+static void test_chained_sw_incr(void)
+{
+=09uint32_t events[] =3D { 0x0 /* SW_INCR */, 0x0 /* SW_INCR */};
+=09int i;
+
+=09if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+=09=09return;
+
+=09pmu_reset();
+
+        write_regn(pmevtyper, 0, events[0] | PMEVTYPER_EXCLUDE_EL0);
+        write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+=09/* enable counters #0 and #1 */
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+=09/* preset counter #0 at 0xFFFFFFF0 */
+=09write_regn(pmevcntr, 0, 0xFFFFFFF0);
+
+=09for (i =3D 0; i < 100; i++) {
+=09=09write_sysreg(0x1, pmswinc_el0);
+=09}
+=09report_info("SW_INCR counter #0 has value %ld", read_regn(pmevcntr, 0))=
;=20
+=09report("PWSYNC does not increment if PMCR.E is unset",
+=09=09read_regn(pmevcntr, 0) =3D=3D 0xFFFFFFF0);
+
+=09pmu_reset();
+
+=09write_regn(pmevcntr, 0, 0xFFFFFFF0);
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+=09set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+
+=09for (i =3D 0; i < 100; i++) {
+=09=09write_sysreg(0x3, pmswinc_el0);
+=09}
+=09report("counter #1 after + 100 SW_INCR", read_regn(pmevcntr, 0)  =3D=3D=
 84);
+=09report("counter #0 after + 100 SW_INCR", read_regn(pmevcntr, 1)  =3D=3D=
 100);
+=09report_info(" counter values after 100 SW_INCR #0=3D%ld #1=3D%ld",
+=09=09=09read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
+=09report("overflow reg after 100 SW_INCR", read_sysreg(pmovsclr_el0) =3D=
=3D 0x1);
+
+=09/* 64b SW_INCR */
+=09pmu_reset();
+
+=09events[1] =3D 0x1E /* CHAIN */;
+        write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+=09write_regn(pmevcntr, 0, 0xFFFFFFF0);
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+=09set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+=09for (i =3D 0; i < 100; i++) {
+=09=09write_sysreg(0x3, pmswinc_el0);
+=09}
+=09report("overflow reg after 100 SW_INCR/CHAIN",
+=09=09!read_sysreg(pmovsclr_el0) && (read_regn(pmevcntr, 1) =3D=3D 1));
+=09report_info("overflow=3D0x%lx, #0=3D%ld #1=3D%ld", read_sysreg(pmovsclr=
_el0),
+=09=09    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
+
+=09/* 64b SW_INCR and overflow on CHAIN counter*/
+=09pmu_reset();
+
+        write_regn(pmevtyper, 1, events[1] | PMEVTYPER_EXCLUDE_EL0);
+=09write_regn(pmevcntr, 0, 0xFFFFFFF0);
+=09write_regn(pmevcntr, 1, 0xFFFFFFFF);
+=09write_sysreg_s(0x3, PMCNTENSET_EL0);
+=09set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+=09for (i =3D 0; i < 100; i++) {
+=09=09write_sysreg(0x3, pmswinc_el0);
+=09}
+=09report("overflow reg after 100 SW_INCR/CHAIN",
+=09=09(read_sysreg(pmovsclr_el0) =3D=3D 0x2) &&
+=09=09(read_regn(pmevcntr, 1) =3D=3D 0) &&
+=09=09(read_regn(pmevcntr, 0) =3D=3D 84));
+=09report_info("overflow=3D0x%lx, #0=3D%ld #1=3D%ld", read_sysreg(pmovsclr=
_el0),
+=09=09    read_regn(pmevcntr, 0), read_regn(pmevcntr, 1));
+}
+
 #endif
=20
 /*
@@ -648,6 +767,12 @@ int main(int argc, char *argv[])
 =09} else if (strcmp(argv[1], "mem-access") =3D=3D 0) {
 =09=09report_prefix_push(argv[1]);
 =09=09test_mem_access();
+=09} else if (strcmp(argv[1], "chained-counters") =3D=3D 0) {
+=09=09report_prefix_push(argv[1]);
+=09=09test_chained_counters();
+=09} else if (strcmp(argv[1], "chained-sw-incr") =3D=3D 0) {
+=09=09report_prefix_push(argv[1]);
+=09=09test_chained_sw_incr();
 =09} else {
 =09=09report_abort("Unknown subtest '%s'", argv[1]);
 =09}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 7a59403..1bd4319 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -90,6 +90,18 @@ groups =3D pmu
 arch =3D arm64
 extra_params =3D -append 'mem-access'
=20
+[pmu-chained-counters]
+file =3D pmu.flat
+groups =3D pmu
+arch =3D arm64
+extra_params =3D -append 'chained-counters'
+
+[pmu-chained-sw-incr]
+file =3D pmu.flat
+groups =3D pmu
+arch =3D arm64
+extra_params =3D -append 'chained-sw-incr'
+
 # Test PMU support (TCG) with -icount IPC=3D1
 #[pmu-tcg-icount-1]
 #file =3D pmu.flat
--=20
2.20.1


