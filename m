Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1149C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC872073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCNapBG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC872073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTKL-0001U9-Py
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8d-0007cp-LQ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37962
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8Y-0000uV-MB
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocL89FGGKbmVMoIaKKI8IoyvSt8Z4cxyeOb9yEuX8ow=;
 b=GCNapBG2KFBYVrJH5aju2IijJ16FPpk835e9yeITFb4KB0qmWTOwPvGKSx/r7n/4vrnOSR
 GAsqfbJTbXtbUZ2QPoR+0pnwQLSovwh/1MYzeBmp1gfjt2PatW0AVtZHajbVxmbfPDhB9m
 22Lu595YdzNIfw9v2MtQVmWVa9OMXEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-WfwU4piBMyS9FxFlhZd1ow-1; Thu, 11 Jun 2020 15:45:14 -0400
X-MC-Unique: WfwU4piBMyS9FxFlhZd1ow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58E3A107ACCA;
 Thu, 11 Jun 2020 19:45:13 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBB415D9DC;
 Thu, 11 Jun 2020 19:45:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 023/115] target/i386: Fix the CPUID leaf CPUID_Fn80000008
Date: Thu, 11 Jun 2020 15:43:17 -0400
Message-Id: <20200611194449.31468-24-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Babu Moger <babu.moger@amd.com>,
 Philipp Eppelt <1871842@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

CPUID leaf CPUID_Fn80000008_ECX provides information about the
number of threads supported by the processor. It was found that
the field ApicIdSize(bits 15-12) was not set correctly.

ApicIdSize is defined as the number of bits required to represent
all the ApicId values within a package.

Valid Values: Value Description
3h-0h		Reserved.
4h		up to 16 threads.
5h		up to 32 threads.
6h		up to 64 threads.
7h		up to 128 threads.
Fh-8h		Reserved.

Fix the bit appropriately.

This came up during following thread.
https://lore.kernel.org/qemu-devel/158643709116.17430.15995069125716778943.malonedeb@wampee.canonical.com/#t

Refer the Processor Programming Reference (PPR) for AMD Family 17h
Model 01h, Revision B1 Processors. The documentation is available
from the bugzilla Link below.
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

Reported-by: Philipp Eppelt <1871842@bugs.launchpad.net>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Message-Id: <20200417215345.64800.73351.stgit@localhost.localdomain>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ba05da3f2e..25a8f6b1ad 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5837,11 +5837,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *eax = cpu->phys_bits;
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
-        *ecx = 0;
-        *edx = 0;
         if (cs->nr_cores * cs->nr_threads > 1) {
-            *ecx |= (cs->nr_cores * cs->nr_threads) - 1;
+            /*
+             * Bits 15:12 is "The number of bits in the initial
+             * Core::X86::Apic::ApicId[ApicId] value that indicate
+             * thread ID within a package". This is already stored at
+             * CPUX86State::pkg_offset.
+             * Bits 7:0 is "The number of threads in the package is NC+1"
+             */
+            *ecx = (env->pkg_offset << 12) |
+                   ((cs->nr_cores * cs->nr_threads) - 1);
+        } else {
+            *ecx = 0;
         }
+        *edx = 0;
         break;
     case 0x8000000A:
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
-- 
2.26.2



