Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D410EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F85120823
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/1yIBNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F85120823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3Ja-0006bt-Ue
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo303-0001hJ-L6
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20339
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo300-0001RT-Cp
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJ1X9tL+8X9iETr0946BQomjGJC2BtyDNZqQzsORQj8=;
 b=b/1yIBNatKaNKZwoq9fBHtzO7gXpCQ0QDgVSGU5U1muGcDePY0huEss/NTj6gMpXJo4a6f
 TV0s+pgLRhbvkZ1YXg/Slf6mU9HGfQvH3WylruHn00yfYidNpKXLU48L3fBwzgnoA2P3w4
 pnB1Yy5TrMdyC1UBXNTcvLPP1VoERPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-aqkOrfpiPwSBR2J7yf5ULA-1; Wed, 24 Jun 2020 06:51:21 -0400
X-MC-Unique: aqkOrfpiPwSBR2J7yf5ULA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 110B718A8220
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 10:51:21 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9527E61169;
 Wed, 24 Jun 2020 10:51:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/31] i386: Mask SVM features if nested SVM is disabled
Date: Wed, 24 Jun 2020 06:50:48 -0400
Message-Id: <20200624105048.375353-31-pbonzini@redhat.com>
In-Reply-To: <20200624104917.375143-1-pbonzini@redhat.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Yanan Fu <yfu@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

QEMU incorrectly validates FEAT_SVM feature flags against
GET_SUPPORTED_CPUID even if SVM features are being masked out by
cpu_x86_cpuid().  This can make QEMU print warnings on most AMD
CPU models, even when SVM nesting is disabled (which is the
default).

This bug was never detected before because of a Linux KVM bug:
until Linux v5.6, KVM was not filtering out SVM features in
GET_SUPPORTED_CPUID when nested was disabled.  This KVM bug was
fixed in Linux v5.7-rc1, on Linux commit a50718cc3f43 ("KVM:
nSVM: Expose SVM features to L1 iff nested is enabled").

Fix the problem by adding a CPUID_EXT3_SVM dependency to all
FEAT_SVM feature flags in the feature_dependencies table.

Reported-by: Yanan Fu <yfu@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200623230116.277409-1-ehabkost@redhat.com>
[Fix testcase. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c                   | 4 ++++
 tests/qtest/test-x86-cpuid-compat.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 06dc013d88..36cbd3d027 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1404,6 +1404,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_VMFUNC },
         .to = { FEAT_VMX_VMFUNC,            ~0ull },
     },
+    {
+        .from = { FEAT_8000_0001_ECX,       CPUID_EXT3_SVM },
+        .to = { FEAT_SVM,                   ~0ull },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 772287bdb4..7ca1883a29 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -256,7 +256,7 @@ int main(int argc, char **argv)
                    "-cpu 486,+invtsc", "xlevel", 0x80000007);
     /* CPUID[8000_000A].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/npt",
-                   "-cpu 486,+npt", "xlevel", 0x8000000A);
+                   "-cpu 486,+svm,+npt", "xlevel", 0x8000000A);
     /* CPUID[C000_0001].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel2/phenom/xstore",
                    "-cpu phenom,+xstore", "xlevel2", 0xC0000001);
@@ -348,7 +348,7 @@ int main(int argc, char **argv)
                    "-machine pc-i440fx-2.4 -cpu SandyBridge,",
                    "xlevel", 0x80000008);
     add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
-                   "-machine pc-i440fx-2.4 -cpu SandyBridge,+npt",
+                   "-machine pc-i440fx-2.4 -cpu SandyBridge,+svm,+npt",
                    "xlevel", 0x80000008);
 
     /* Test feature parsing */
-- 
2.26.2


