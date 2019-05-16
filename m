Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E837FC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2A020815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2A020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59287 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHbj-0007uA-0W
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:43:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bwiedemann@suse.de>) id 1hRHWv-0003qp-Vz
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bwiedemann@suse.de>) id 1hRHWu-000378-U2
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:38:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:58076 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bwiedemann@suse.de>) id 1hRHWu-0002wh-OY
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:38:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id EAF47AC32
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 14:38:42 +0000 (UTC)
From: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 16:38:39 +0200
Message-Id: <20190516143839.19173-1-bwiedemann@suse.de>
X-Mailer: git-send-email 2.16.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic]
X-Received-From: 195.135.220.15
Subject: [Qemu-devel] [PATCH] i386: Fix nested SVM on older Opterons
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without this patch, a VM on a Opteron G3 host will have the svm flag, but
the kvm-amd module fails to load in there, complaining that it needs
cpuid 0x8000000a

I have successfully built and tested this for 3+ years in production
on Opteron G3 servers.

Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>
---
 target/i386/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 722c5514d4..df1d81ded8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2723,7 +2723,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_SSE3,
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
-        .xlevel = 0x80000008,
+        .xlevel = 0x8000000A,
         .model_id = "AMD Opteron 240 (Gen 1 Class Opteron)",
     },
     {
@@ -2745,7 +2745,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
-        .xlevel = 0x80000008,
+        .xlevel = 0x8000000A,
         .model_id = "AMD Opteron 22xx (Gen 2 Class Opteron)",
     },
     {
@@ -2770,7 +2770,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A |
             CPUID_EXT3_ABM | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
-        .xlevel = 0x80000008,
+        .xlevel = 0x8000000A,
         .model_id = "AMD Opteron 23xx (Gen 3 Class Opteron)",
     },
     {
-- 
2.16.4


