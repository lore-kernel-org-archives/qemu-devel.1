Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB58C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1659A20873
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1659A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho6jZ-0000PB-2h
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 09:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39168)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <den@openvz.org>) id 1ho6jN-0008Pz-D1
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@openvz.org>) id 1ho6jM-00024g-CS
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:45:57 -0400
Received: from relay.sw.ru ([185.231.240.75]:47634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@openvz.org>) id 1ho6jM-000235-59
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:45:56 -0400
Received: from [172.16.24.44] (helo=iris.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <den@openvz.org>)
 id 1ho6jF-00073p-Cq; Thu, 18 Jul 2019 16:45:49 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Date: Thu, 18 Jul 2019 16:45:37 +0300
Message-Id: <20190718134537.22356-1-den@openvz.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 1/1] x86: add CPU flags supported inside libvirt
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
Cc: Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are the following flags available in libvirt inside cpu_map.xm
    <feature name='cvt16'>
      <cpuid function='0x80000001' ecx='0x00040000'/>
    </feature>
    <feature name='cmt'> <!-- cqm -->
      <cpuid eax_in='0x07' ecx_in='0x00' ebx='0x00001000'/>
    </feature>
We have faced the problem that QEMU does not start once these flags are
present in the domain.xml.

This patch just adds proper names into the map.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
CC: Peter Krempa <pkrempa@redhat.com>
CC: Daniel P. Berrangé <berrange@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 805ce95247..88ba4dad47 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -870,7 +870,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "lahf-lm", "cmp-legacy", "svm", "extapic",
             "cr8legacy", "abm", "sse4a", "misalignsse",
             "3dnowprefetch", "osvw", "ibs", "xop",
-            "skinit", "wdt", NULL, "lwp",
+            "skinit", "wdt", "cvt16", "lwp",
             "fma4", "tce", NULL, "nodeid-msr",
             NULL, "tbm", "topoext", "perfctr-core",
             "perfctr-nb", NULL, NULL, NULL,
@@ -1044,7 +1044,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fsgsbase", "tsc-adjust", NULL, "bmi1",
             "hle", "avx2", NULL, "smep",
             "bmi2", "erms", "invpcid", "rtm",
-            NULL, NULL, "mpx", NULL,
+            "cmt", NULL, "mpx", NULL,
             "avx512f", "avx512dq", "rdseed", "adx",
             "smap", "avx512ifma", "pcommit", "clflushopt",
             "clwb", "intel-pt", "avx512pf", "avx512er",
-- 
2.17.1


