Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C436C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 19:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30532067C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 19:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7oBMwBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30532067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCpaY-0006qd-Tm
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 15:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kCpZY-0005YS-8F
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 15:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kCpZW-0005eo-4q
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 15:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598902468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vtLyg6lCGileigLzG/AbjWIpEiRqxpxwtXfCaWYW4BQ=;
 b=U7oBMwBKi/nWOdGKZvrkV7XX4PfAnMUu2HJR02rUY0rjtng5Ghxq3Q5NkUwqghVvW395nA
 vXTcFBvnYhmeNtQUzGSiVdGcLDydsmH4yuRNtBtyJhnQzl0+EEDZ8J2v336W1lD+NOyFrc
 +JI1Ysvl9oKsnGIzMYEUirdUmc/jXNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-IZETdFkBPgyuFjCOujLmHQ-1; Mon, 31 Aug 2020 15:34:27 -0400
X-MC-Unique: IZETdFkBPgyuFjCOujLmHQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FF6A802B49;
 Mon, 31 Aug 2020 19:34:25 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-112.ams2.redhat.com [10.36.112.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB7637EB7D;
 Mon, 31 Aug 2020 19:34:22 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, kvm@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, drjones@redhat.com,
 andrew.murray@arm.com, sudeep.holla@arm.com, maz@kernel.org,
 will@kernel.org, haibo.xu@linaro.org
Subject: [kvm-unit-tests RFC 1/4] arm64: Move get_id_aa64dfr0() in processor.h
Date: Mon, 31 Aug 2020 21:34:11 +0200
Message-Id: <20200831193414.6951-2-eric.auger@redhat.com>
In-Reply-To: <20200831193414.6951-1-eric.auger@redhat.com>
References: <20200831193414.6951-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 13:03:24
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

We plan to use get_id_aa64dfr0() for SPE tests.
So let's move this latter in processor.h header.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/pmu.c                 | 1 -
 lib/arm64/asm/processor.h | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arm/pmu.c b/arm/pmu.c
index cece53e..e2cb51e 100644
--- a/arm/pmu.c
+++ b/arm/pmu.c
@@ -167,7 +167,6 @@ static void test_overflow_interrupt(void) {}
 #define ID_DFR0_PMU_V3_8_5	0b0110
 #define ID_DFR0_PMU_IMPDEF	0b1111
 
-static inline uint32_t get_id_aa64dfr0(void) { return read_sysreg(id_aa64dfr0_el1); }
 static inline uint32_t get_pmcr(void) { return read_sysreg(pmcr_el0); }
 static inline void set_pmcr(uint32_t v) { write_sysreg(v, pmcr_el0); }
 static inline uint64_t get_pmccntr(void) { return read_sysreg(pmccntr_el0); }
diff --git a/lib/arm64/asm/processor.h b/lib/arm64/asm/processor.h
index 02665b8..11b7564 100644
--- a/lib/arm64/asm/processor.h
+++ b/lib/arm64/asm/processor.h
@@ -88,6 +88,11 @@ static inline uint64_t get_mpidr(void)
 	return read_sysreg(mpidr_el1);
 }
 
+static inline uint64_t get_id_aa64dfr0(void)
+{
+	return read_sysreg(id_aa64dfr0_el1);
+}
+
 #define MPIDR_HWID_BITMASK 0xff00ffffff
 extern int mpidr_to_cpu(uint64_t mpidr);
 
-- 
2.21.3


