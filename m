Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A7620787
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 07:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GT1QNIZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A7620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKGb7-00025Q-NX
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 03:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jKGWo-0004Xg-Aq
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jKGWn-0004Fe-3i
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:14:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jKGWm-0004FO-Va
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 03:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585898048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UlELUc8BfECpYBnXZ2RZ4Fo7yfR5/2QrlCwiuzUqtRs=;
 b=GT1QNIZar+CO41aJYPtXyn7sawOPeJ8xc4r4FgmmN4/JPA01ib/OHUCwuFDmb+ZizWe9kt
 HUdwCW7PQUI/7zNpMVm9V1wHF0ljtuAzyimZtuCrVqEbi/8x+Z089SJ+pM7nDcchyNpuNH
 AYXUFDnph6jjvv/Y6XhFO+TdyfsYi2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-AwAQ_jQENxuPO_SraOuITA-1; Fri, 03 Apr 2020 03:14:07 -0400
X-MC-Unique: AwAQ_jQENxuPO_SraOuITA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8975B477;
 Fri,  3 Apr 2020 07:14:05 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A167248;
 Fri,  3 Apr 2020 07:14:02 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v4 08/12] arm: pmu: Test SW_INCR event count
Date: Fri,  3 Apr 2020 09:13:22 +0200
Message-Id: <20200403071326.29932-9-eric.auger@redhat.com>
In-Reply-To: <20200403071326.29932-1-eric.auger@redhat.com>
References: <20200403071326.29932-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 alexandru.elisei@arm.com, andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add tests dedicated to SW_INCR event counting.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3: new
- Formerly in chained counter tests but as QEMU does not
  support chained counters, the whole test was failing. Peter
  split the test.
---
 arm/pmu.c         | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg |  6 ++++++
 2 files changed, 53 insertions(+)

diff --git a/arm/pmu.c b/arm/pmu.c
index 45dccf7..c954c71 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -140,6 +140,7 @@ static void test_event_introspection(void) {}
 static void test_event_counter_config(void) {}
 static void test_basic_event_count(void) {}
 static void test_mem_access(void) {}
+static void test_sw_incr(void) {}
=20
 #elif defined(__aarch64__)
 #define ID_AA64DFR0_PERFMON_SHIFT 8
@@ -464,6 +465,48 @@ static void test_mem_access(void)
 			read_sysreg(pmovsclr_el0));
 }
=20
+static void test_sw_incr(void)
+{
+	uint32_t events[] =3D {SW_INCR, SW_INCR};
+	int i;
+
+	if (!satisfy_prerequisites(events, ARRAY_SIZE(events)))
+		return;
+
+	pmu_reset();
+
+	write_regn_el0(pmevtyper, 0, SW_INCR | PMEVTYPER_EXCLUDE_EL0);
+	write_regn_el0(pmevtyper, 1, SW_INCR | PMEVTYPER_EXCLUDE_EL0);
+	/* enable counters #0 and #1 */
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+
+	for (i =3D 0; i < 100; i++)
+		write_sysreg(0x1, pmswinc_el0);
+
+	report_info("SW_INCR counter #0 has value %ld", read_regn_el0(pmevcntr,=
 0));
+	report(read_regn_el0(pmevcntr, 0) =3D=3D PRE_OVERFLOW,
+		"PWSYNC does not increment if PMCR.E is unset");
+
+	pmu_reset();
+
+	write_regn_el0(pmevcntr, 0, PRE_OVERFLOW);
+	write_sysreg_s(0x3, PMCNTENSET_EL0);
+	set_pmcr(pmu.pmcr_ro | PMU_PMCR_E);
+
+	for (i =3D 0; i < 100; i++)
+		write_sysreg(0x3, pmswinc_el0);
+
+	report(read_regn_el0(pmevcntr, 0)  =3D=3D 84, "counter #1 after + 100 S=
W_INCR");
+	report(read_regn_el0(pmevcntr, 1)  =3D=3D 100,
+		"counter #0 after + 100 SW_INCR");
+	report_info("counter values after 100 SW_INCR #0=3D%ld #1=3D%ld",
+		    read_regn_el0(pmevcntr, 0), read_regn_el0(pmevcntr, 1));
+	report(read_sysreg(pmovsclr_el0) =3D=3D 0x1,
+		"overflow reg after 100 SW_INCR");
+}
+
 #endif
=20
 /*
@@ -650,6 +693,10 @@ int main(int argc, char *argv[])
 		report_prefix_push(argv[1]);
 		test_mem_access();
 		report_prefix_pop();
+	} else if (strcmp(argv[1], "pmu-sw-incr") =3D=3D 0) {
+		report_prefix_push(argv[1]);
+		test_sw_incr();
+		report_prefix_pop();
 	} else {
 		report_abort("Unknown sub-test '%s'", argv[1]);
 	}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 32ab8c6..175afe6 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -90,6 +90,12 @@ groups =3D pmu
 arch =3D arm64
 extra_params =3D -append 'pmu-mem-access'
=20
+[pmu-sw-incr]
+file =3D pmu.flat
+groups =3D pmu
+arch =3D arm64
+extra_params =3D -append 'pmu-sw-incr'
+
 # Test PMU support (TCG) with -icount IPC=3D1
 #[pmu-tcg-icount-1]
 #file =3D pmu.flat
--=20
2.20.1


