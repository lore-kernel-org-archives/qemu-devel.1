Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84E8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 19:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CB520678
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 19:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQmTAuw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CB520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCpac-00072C-Bm
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 15:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kCpZb-0005d7-G6
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 15:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kCpZZ-0005f1-Fm
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 15:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598902472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dlm+r41ohHjW30i+MQ1d9KTTnOYk1vHfisVWqLyZbwo=;
 b=HQmTAuw9Tw4lLMIsrOHv09BFcX41RwgEJSJnwGKyNgFx5dypnh1JjbzQbyEC9BjYlAsL7C
 oygY8hH+w0927YHilMXW0/V+gx4tNng1p7N5IjMaPBSQXyYmniRNZkBQpUJNTg7Tz1MR8T
 Wewoyg3bQrxgePBRuIl+Eb2GXovTBwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-2z1t971-N1-8k9kKIHOPfA-1; Mon, 31 Aug 2020 15:34:29 -0400
X-MC-Unique: 2z1t971-N1-8k9kKIHOPfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C3C3100747B;
 Mon, 31 Aug 2020 19:34:28 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-112.ams2.redhat.com [10.36.112.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5ACA7EB69;
 Mon, 31 Aug 2020 19:34:25 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, drjones@redhat.com,
 andrew.murray@arm.com, sudeep.holla@arm.com, maz@kernel.org,
 will@kernel.org, haibo.xu@linaro.org
Subject: [kvm-unit-tests RFC 2/4] spe: Probing and Introspection Test
Date: Mon, 31 Aug 2020 21:34:12 +0200
Message-Id: <20200831193414.6951-3-eric.auger@redhat.com>
In-Reply-To: <20200831193414.6951-1-eric.auger@redhat.com>
References: <20200831193414.6951-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 15:34:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test whether Statistical Profiling Extensions (SPE) are
supported and in the positive collect dimensioning data from
the IDR registers. The First test only validates those.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/Makefile.common |   1 +
 arm/spe.c           | 163 ++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg   |   8 +++
 3 files changed, 172 insertions(+)
 create mode 100644 arm/spe.c

diff --git a/arm/Makefile.common b/arm/Makefile.common
index a123e85..4e7e4eb 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -8,6 +8,7 @@ tests-common  = $(TEST_DIR)/selftest.flat
 tests-common += $(TEST_DIR)/spinlock-test.flat
 tests-common += $(TEST_DIR)/pci-test.flat
 tests-common += $(TEST_DIR)/pmu.flat
+tests-common += $(TEST_DIR)/spe.flat
 tests-common += $(TEST_DIR)/gic.flat
 tests-common += $(TEST_DIR)/psci.flat
 tests-common += $(TEST_DIR)/sieve.flat
diff --git a/arm/spe.c b/arm/spe.c
new file mode 100644
index 0000000..153c182
--- /dev/null
+++ b/arm/spe.c
@@ -0,0 +1,163 @@
+/*
+ * Copyright (C) 2020, Red Hat Inc, Eric Auger <eric.auger@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU Lesser General Public License version 2.1 and
+ * only version 2.1 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License
+ * for more details.
+ */
+#include "libcflat.h"
+#include "errata.h"
+#include "asm/barrier.h"
+#include "asm/sysreg.h"
+#include "asm/processor.h"
+#include "alloc_page.h"
+#include <bitops.h>
+
+struct spe {
+	int min_interval;
+	int maxsize;
+	int countsize;
+	bool fl_cap;
+	bool ft_cap;
+	bool fe_cap;
+	int align;
+	void *buffer;
+	bool unique_record_size;
+};
+
+static struct spe spe;
+
+#ifdef __arm__
+
+static bool spe_probe(void) { return false; }
+static void test_spe_introspection(void) { }
+
+#else
+
+#define ID_DFR0_PMSVER_SHIFT	32
+#define ID_DFR0_PMSVER_MASK	0xF
+
+#define PMBIDR_EL1_ALIGN_MASK	0xF
+#define PMBIDR_EL1_P		0x10
+#define PMBIDR_EL1_F		0x20
+
+#define PMSIDR_EL1_FE		0x1
+#define PMSIDR_EL1_FT		0x2
+#define PMSIDR_EL1_FL		0x4
+#define PMSIDR_EL1_ARCHINST	0x8
+#define PMSIDR_EL1_LDS		0x10
+#define PMSIDR_EL1_ERND		0x20
+#define PMSIDR_EL1_INTERVAL_SHIFT	8
+#define PMSIDR_EL1_INTERVAL_MASK	0xFUL
+#define PMSIDR_EL1_MAXSIZE_SHIFT	12
+#define PMSIDR_EL1_MAXSIZE_MASK		0xFUL
+#define PMSIDR_EL1_COUNTSIZE_SHIFT	16
+#define PMSIDR_EL1_COUNTSIZE_MASK	0xFUL
+
+#define PMSIDR_EL1	sys_reg(3, 0, 9, 9, 7)
+
+#define PMBIDR_EL1	sys_reg(3, 0, 9, 10, 7)
+
+static int min_interval(uint8_t idr_bits)
+{
+	switch (idr_bits) {
+	case 0x0:
+		return 256;
+	case 0x2:
+		return 512;
+	case 0x3:
+		return 768;
+	case 0x4:
+		return 1024;
+	case 0x5:
+		return 1536;
+	case 0x6:
+		return 2048;
+	case 0x7:
+		return 3072;
+	case 0x8:
+		return 4096;
+	default:
+		return -1;
+	}
+}
+
+static bool spe_probe(void)
+{
+	uint64_t pmbidr_el1, pmsidr_el1;
+	uint8_t pmsver;
+
+	pmsver = (get_id_aa64dfr0() >> ID_DFR0_PMSVER_SHIFT) & ID_DFR0_PMSVER_MASK;
+
+	report_info("PMSVer = %d", pmsver);
+	if (!pmsver || pmsver > 2)
+		return false;
+
+	pmbidr_el1 = read_sysreg_s(PMBIDR_EL1);
+	if (pmbidr_el1 & PMBIDR_EL1_P) {
+		report_info("MBIDR_EL1: Profiling buffer owned by this exception level");
+		return false;
+	}
+
+	spe.align = 1 << (pmbidr_el1 & PMBIDR_EL1_ALIGN_MASK);
+
+	pmsidr_el1 = read_sysreg_s(PMSIDR_EL1);
+
+	spe.min_interval = min_interval((pmsidr_el1 >> PMSIDR_EL1_INTERVAL_SHIFT) & PMSIDR_EL1_INTERVAL_MASK);
+	spe.maxsize = 1 << ((pmsidr_el1 >> PMSIDR_EL1_MAXSIZE_SHIFT) & PMSIDR_EL1_MAXSIZE_MASK);
+	spe.countsize = (pmsidr_el1 >> PMSIDR_EL1_COUNTSIZE_SHIFT) & PMSIDR_EL1_COUNTSIZE_MASK;
+
+	spe.fl_cap = pmsidr_el1 & PMSIDR_EL1_FL;
+	spe.ft_cap = pmsidr_el1 & PMSIDR_EL1_FT;
+	spe.fe_cap = pmsidr_el1 & PMSIDR_EL1_FE;
+
+	report_info("Align= %d bytes, Min Interval=%d Single record Max Size = %d bytes",
+			spe.align, spe.min_interval, spe.maxsize);
+	report_info("Filtering Caps: Lat=%d Type=%d Events=%d", spe.fl_cap, spe.ft_cap, spe.fe_cap);
+	if (spe.align == spe.maxsize) {
+		report_info("Each record is exactly %d bytes", spe.maxsize);
+		spe.unique_record_size = true;
+	}
+
+	spe.buffer = alloc_pages(0);
+
+	return true;
+}
+
+static void test_spe_introspection(void)
+{
+	report(spe.countsize == 0x2, "PMSIDR_EL1: CountSize = 0b0010");
+	report(spe.maxsize >= 16 && spe.maxsize <= 2048,
+		"PMSIDR_EL1: Single record max size = %d bytes", spe.maxsize);
+	report(spe.min_interval >= 256 && spe.min_interval <= 4096,
+		"PMSIDR_EL1: Minimal sampling interval = %d", spe.min_interval);
+}
+
+#endif
+
+int main(int argc, char *argv[])
+{
+	if (!spe_probe()) {
+		printf("SPE not supported, test skipped...\n");
+		return report_summary();
+	}
+
+	if (argc < 2)
+		report_abort("no test specified");
+
+	report_prefix_push("spe");
+
+	if (strcmp(argv[1], "spe-introspection") == 0) {
+		report_prefix_push(argv[1]);
+		test_spe_introspection();
+		report_prefix_pop();
+	} else {
+		report_abort("Unknown sub-test '%s'", argv[1]);
+	}
+	return report_summary();
+}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index f776b66..c070939 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -134,6 +134,14 @@ extra_params = -append 'pmu-overflow-interrupt'
 #groups = pmu
 #accel = tcg
 
+[spe-introspection]
+file = spe.flat
+groups = spe
+arch = arm64
+extra_params = -append 'spe-introspection'
+accel = kvm
+arch = arm64
+
 # Test GIC emulation
 [gicv2-ipi]
 file = gic.flat
-- 
2.21.3


