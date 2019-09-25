Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D21AC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F1F2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F1F2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFHQ-0001KB-0k
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 17:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bigeasy@linutronix.de>) id 1iDFBu-0003fW-29
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bigeasy@linutronix.de>) id 1iDFBs-0002pU-2U
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:51:17 -0400
Received: from galois.linutronix.de ([193.142.43.55]:42174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bigeasy@linutronix.de>)
 id 1iDFBr-0002Z9-SK
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:51:16 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
 by Galois.linutronix.de with esmtp (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1iDFAf-0002LY-Ry; Wed, 25 Sep 2019 23:50:01 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: qemu-devel@nongnu.org
Subject: [PATCH] i386: Add CPUID bit for CLZERO and XSAVEERPTR
Date: Wed, 25 Sep 2019 23:49:48 +0200
Message-Id: <20190925214948.22212-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 193.142.43.55
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CPUID bits CLZERO and XSAVEERPTR are availble on AMD's ZEN platform
and could be passed to the guest.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

I tweaked the kernel to expose these flags and figured out that this is
also missing in order see those bits in the guest.

 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fbed2eb804e32..e00ef3c917391 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1113,7 +1113,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORD=
S] =3D {
     [FEAT_8000_0008_EBX] =3D {
         .type =3D CPUID_FEATURE_WORD,
         .feat_names =3D {
-            NULL, NULL, NULL, NULL,
+            "clzero", NULL, "xsaveerptr", NULL,
             NULL, NULL, NULL, NULL,
             NULL, "wbnoinvd", NULL, NULL,
             "ibpb", NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0732e059ec989..cc475c703fc4d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -689,6 +689,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypa=
ss Disable */
=20
+#define CPUD_800_008_EBX_CLZERO		(1U << 0) /* CLZERO instruction */
+#define CPUD_800_008_EBX_XSAVEERPTR	(1U << 2) /* Always save/restore FP er=
ror pointers */
 #define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
                                                                           =
   do not invalidate cache */
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Predicti=
on Barrier */
--=20
2.23.0


