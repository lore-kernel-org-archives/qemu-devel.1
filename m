Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007A7C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00112176D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWvssBwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00112176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igxJP-0000Oq-EF
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 15:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1igxI3-00076V-Hj
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1igxI2-0006SF-7g
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:48:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1igxI2-0006SB-4P
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576529305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RjCVoMYbyhxjOhuGwZyyYSLknIArKPWpJID9BdwLtBQ=;
 b=EWvssBwAfF3kiNCaCHP/LtVmyytVcJOFoi/rO5523lPY4xaj3ZKizHEEQUL7S+OxXHY/nB
 K0fmYedCWCmsvpc1/qV3CzmJaUClivNmrG9PUVn+sAKXW4LxltWrJ/l2s60BTdfmt+X3O/
 gyOFNgVJulAaUJ5olHlrTcBUgT+5z3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-mAQz2_z2MAmqowES4roMzw-1; Mon, 16 Dec 2019 15:48:24 -0500
X-MC-Unique: mAQz2_z2MAmqowES4roMzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B6C98024E5;
 Mon, 16 Dec 2019 20:48:21 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C42505D9C9;
 Mon, 16 Dec 2019 20:48:18 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH 04/10] arm: pmu: Check Required Event Support
Date: Mon, 16 Dec 2019 21:47:51 +0100
Message-Id: <20191216204757.4020-5-eric.auger@redhat.com>
In-Reply-To: <20191216204757.4020-1-eric.auger@redhat.com>
References: <20191216204757.4020-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 alexandru.elisei@arm.com, andre.przywara@arm.com
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

v1 ->v2:
- add a comment to explain the PMCEID0/1 splits
---
 arm/pmu.c         | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |  6 ++++
 2 files changed, 77 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index d24857e..d88ef22 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -101,6 +101,10 @@ static inline void precise_instrs_loop(int loop, uin=
t32_t pmcr)
 	: [pmcr] "r" (pmcr), [z] "r" (0)
 	: "cc");
 }
+
+/* event counter tests only implemented for aarch64 */
+static void test_event_introspection(void) {}
+
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
 #define ID_AA64DFR0_PERFMON_MASK  0xf
@@ -139,6 +143,70 @@ static inline void precise_instrs_loop(int loop, uin=
t32_t pmcr)
 	: [pmcr] "r" (pmcr)
 	: "cc");
 }
+
+#define PMCEID1_EL0 sys_reg(11, 3, 9, 12, 7)
+
+static bool is_event_supported(uint32_t n, bool warn)
+{
+	uint64_t pmceid0 =3D read_sysreg(pmceid0_el0);
+	uint64_t pmceid1 =3D read_sysreg_s(PMCEID1_EL0);
+	bool supported;
+	uint32_t reg;
+
+	/*
+	 * The low 32-bits of PMCEID0/1 respectly describe
+	 * event support for events 0-31/32-63. Their High
+	 * 32-bits describe support for extended events
+	 * starting at 0x4000, using the same split.
+	 */
+	if (n >=3D 0x0  && n <=3D 0x1F)
+		reg =3D pmceid0 & 0xFFFFFFFF;
+	else if  (n >=3D 0x4000 && n <=3D 0x401F)
+		reg =3D pmceid0 >> 32;
+	else if (n >=3D 0x20  && n <=3D 0x3F)
+		reg =3D pmceid1 & 0xFFFFFFFF;
+	else if (n >=3D 0x4020 && n <=3D 0x403F)
+		reg =3D pmceid1 >> 32;
+	else
+		abort();
+
+	supported =3D  reg & (1 << n);
+	if (!supported && warn)
+		report_info("event %d is not supported", n);
+	return supported;
+}
+
+static void test_event_introspection(void)
+{
+	bool required_events;
+
+	if (!pmu.nb_implemented_counters) {
+		report_skip("No event counter, skip ...");
+		return;
+	}
+
+	/* PMUv3 requires an implementation includes some common events */
+	required_events =3D is_event_supported(0x0, true) /* SW_INCR */ &&
+			  is_event_supported(0x11, true) /* CPU_CYCLES */ &&
+			  (is_event_supported(0x8, true) /* INST_RETIRED */ ||
+			   is_event_supported(0x1B, true) /* INST_PREC */);
+
+	if (pmu.version =3D=3D 0x4) {
+		/* ARMv8.1 PMU: STALL_FRONTEND and STALL_BACKEND are required */
+		required_events =3D required_events ||
+				  is_event_supported(0x23, true) ||
+				  is_event_supported(0x24, true);
+	}
+
+	/*
+	 * L1D_CACHE_REFILL(0x3) and L1D_CACHE(0x4) are only required if
+	 * L1 data / unified cache. BR_MIS_PRED(0x10), BR_PRED(0x12) are only
+	 * required if program-flow prediction is implemented.
+	 */
+
+	report(required_events, "Check required events are implemented");
+}
+
 #endif
=20
 /*
@@ -326,6 +394,9 @@ int main(int argc, char *argv[])
 		       "Monotonically increasing cycle count");
 		report(check_cpi(cpi), "Cycle/instruction ratio");
 		pmccntr64_test();
+	} else if (strcmp(argv[1], "event-introspection") =3D=3D 0) {
+		report_prefix_push(argv[1]);
+		test_event_introspection();
 	} else {
 		report_abort("Unknown sub-test '%s'", argv[1]);
 	}
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


