Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A7C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4010C20717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 09:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4010C20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihVJu-0006rA-CW
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 04:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ani.sinha@nutanix.com>) id 1ihVJI-0006LR-VU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1ihVJG-0005pg-R4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:08:00 -0500
Received: from [192.146.154.1] (port=62175 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ani.sinha@nutanix.com>) id 1ihVJG-0005lw-I7
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 04:07:58 -0500
Received: from ani-devvm.user.nutanix.com (ani-sinha.user.nutanix.com
 [10.4.194.34])
 by mcp01.nutanix.com (Postfix) with ESMTP id 5CD631007A4B;
 Wed, 18 Dec 2019 09:07:57 +0000 (UTC)
From: Ani Sinha <ani.sinha@nutanix.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD ZEN
 platform
Date: Wed, 18 Dec 2019 01:05:33 -0800
Message-Id: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.146.154.1
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
Cc: ani.sinha@nutanix.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CLZERO CPUID should be passed on to the guests that use EPYC or EPYC-IBPB CPU
model when the AMD ZEN based host supports it. This change makes it recognize
this CPUID for guests which use EPYC or EPYC-IBPB CPU model.

Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
---
 target/i386/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69f518a..55f0691 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3813,6 +3813,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
             CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
             CPUID_EXT3_TOPOEXT,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_CLZERO,
         .features[FEAT_7_0_EBX] =
             CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
             CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
-- 
1.9.4


