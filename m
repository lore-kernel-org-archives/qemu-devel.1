Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DB9C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B9424673
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwmvMYDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B9424673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idI3X-0001E6-08
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1idHOa-0001rp-R4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1idHOY-0003ZE-9w
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:28:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31025
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1idHOY-0003Xb-1b
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMQUa3khr5jsekFu/skIEP0pnlonAM+9sITcAnn0lGM=;
 b=hwmvMYDlKP+dCIybQFNTsOzW/N6tFV5lvnPlml7BU0mdo4Dy6N6sx8qpernl4xT0EF8mpv
 iGlpGBNNO/P3tRUsaQKW9/TH314jRwqZEsb6PwyowxMPITKBSdGWnBoS3KpOmU1Xl+hoOm
 H2o9EKDEorbwv+34UtSRgkoTcPY4uYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-bNevScXFNg-cmD5S24rlpg-1; Fri, 06 Dec 2019 12:27:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE4C31005502;
 Fri,  6 Dec 2019 17:27:54 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CC286CE40;
 Fri,  6 Dec 2019 17:27:47 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests RFC 04/10] pmu: Check Required Event Support
Date: Fri,  6 Dec 2019 18:27:18 +0100
Message-Id: <20191206172724.947-5-eric.auger@redhat.com>
In-Reply-To: <20191206172724.947-1-eric.auger@redhat.com>
References: <20191206172724.947-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: bNevScXFNg-cmD5S24rlpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If event counters are implemented check the common events
required by the PMUv3 are implemented.

Some are unconditionally required (SW_INCR, CPU_CYCLES,
either INST_RETIRED or INST_SPEC). Some others only are
required if the implementation implements some other features.

Check those wich are unconditionally required.

This test currently fails on TCG as neither INST_RETIRED
or INST_SPEC are supported.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/pmu.c         | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |  6 ++++
 2 files changed, 76 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index 8e95251..f78c43f 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -102,6 +102,10 @@ static inline void precise_instrs_loop(int loop, uint3=
2_t pmcr)
 =09: [pmcr] "r" (pmcr), [z] "r" (0)
 =09: "cc");
 }
+
+/* event counter tests only implemented for aarch64 */
+static void test_event_introspection(void) {}
+
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
 #define ID_AA64DFR0_PERFMON_MASK  0xf
@@ -140,6 +144,69 @@ static inline void precise_instrs_loop(int loop, uint3=
2_t pmcr)
 =09: [pmcr] "r" (pmcr)
 =09: "cc");
 }
+
+#define PMCEID1_EL0 sys_reg(11, 3, 9, 12, 7)
+
+static bool is_event_supported(uint32_t n, bool warn)
+{
+=09uint64_t pmceid0 =3D read_sysreg(pmceid0_el0);
+=09uint64_t pmceid1 =3D read_sysreg_s(PMCEID1_EL0);
+=09bool supported;
+=09uint32_t reg;
+
+=09if (n >=3D 0x0  && n <=3D 0x1F) {
+=09=09reg =3D pmceid0 & 0xFFFFFFFF;
+=09} else if  (n >=3D 0x4000 && n <=3D 0x401F) {
+=09=09reg =3D pmceid0 >> 32;
+=09} else if (n >=3D 0x20  && n <=3D 0x3F) {
+=09=09reg =3D pmceid1 & 0xFFFFFFFF;
+=09} else if (n >=3D 0x4020 && n <=3D 0x403F) {
+=09=09reg =3D pmceid1 >> 32;
+=09} else {
+=09=09abort();
+=09}
+=09supported =3D  reg & (1 << n);
+=09if (!supported && warn)
+=09=09report_info("event %d is not supported", n);
+=09return supported;
+}
+
+static void test_event_introspection(void)
+{
+=09bool required_events;
+
+=09if (!pmu.nb_implemented_counters) {
+=09=09report_skip("No event counter, skip ...");
+=09=09return;
+=09}
+=09if (pmu.nb_implemented_counters < 2)
+=09=09report_info("%d event counters are implemented. "
+                            "ARM recommends to implement at least 2",
+                            pmu.nb_implemented_counters);
+
+=09/* PMUv3 requires an implementation includes some common events */
+=09required_events =3D is_event_supported(0x0, true) /* SW_INCR */ &&
+=09=09=09  is_event_supported(0x11, true) /* CPU_CYCLES */ &&
+=09=09=09  (is_event_supported(0x8, true) /* INST_RETIRED */ ||
+=09=09=09   is_event_supported(0x1B, true) /* INST_PREC */);
+=09if (!is_event_supported(0x8, false))
+=09=09report_info("ARM strongly recomments INST_RETIRED (0x8) event "
+=09=09=09    "to be implemented");
+
+=09if (pmu.version =3D=3D 0x4) {
+=09=09/* ARMv8.1 PMU: STALL_FRONTEND and STALL_BACKEND are required */
+=09=09required_events =3D required_events ||
+=09=09=09=09  is_event_supported(0x23, true) ||
+=09=09=09=09  is_event_supported(0x24, true);
+=09}
+
+=09/* L1D_CACHE_REFILL(0x3) and L1D_CACHE(0x4) are only required if
+=09   L1 data / unified cache. BR_MIS_PRED(0x10), BR_PRED(0x12) are only
+=09   required if program-flow prediction is implemented. */
+
+=09report("Check required events are implemented", required_events);
+}
+
 #endif
=20
 /*
@@ -324,6 +391,9 @@ int main(int argc, char *argv[])
 =09=09report("Monotonically increasing cycle count", check_cycles_increase=
());
 =09=09report("Cycle/instruction ratio", check_cpi(cpi));
 =09=09pmccntr64_test();
+=09} else if (strcmp(argv[1], "event-introspection") =3D=3D 0) {
+=09=09report_prefix_push(argv[1]);
+=09=09test_event_introspection();
 =09} else {
 =09=09report_abort("Unknown subtest '%s'", argv[1]);
 =09}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 79f0d7a..4433ef3 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -66,6 +66,12 @@ file =3D pmu.flat
 groups =3D pmu
 extra_params =3D -append 'cycle-counter 0'
=20
+[pmu-event-introspection]
+file =3D pmu.flat
+groups =3D pmu
+arch =3D arm64
+extra_params =3D -append 'event-introspection'
+
 # Test PMU support (TCG) with -icount IPC=3D1
 #[pmu-tcg-icount-1]
 #file =3D pmu.flat
--=20
2.20.1


