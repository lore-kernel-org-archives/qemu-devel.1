Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFBDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6E2206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SY96TQkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6E2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUgr-0001FV-AH
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCb-0004GG-Cb
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37051
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUCY-0003ER-An
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+iy9w5X1fz+uCMf5P7FdKYhQZHH1KM7pEmht8ZmxZVA=;
 b=SY96TQkN/UAvlEKpBZABTDAD/ZI8gH6FPzjl3tcC7IENWx1Iok2N1ocNydhDEVF0PfHqgP
 N1CAv4xUkfUHzlOXyIfcstFciC/s78WoE3dOi39516xMm2fFkVzaMiL6FQ9yXPT+ZLEHfb
 sF11WOzFR3doC//C/pJPgij6fio+7xY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-wHsiANIjM5m4jnMTje4Ruw-1; Mon, 06 Jul 2020 12:42:36 -0400
X-MC-Unique: wHsiANIjM5m4jnMTje4Ruw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A52A08015FB;
 Mon,  6 Jul 2020 16:42:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55BD4100238C;
 Mon,  6 Jul 2020 16:42:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 52/53] target/i386: Enable TSX Suspend Load Address Tracking
 feature
Date: Mon,  6 Jul 2020 12:41:54 -0400
Message-Id: <20200706164155.24696-53-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
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
Cc: Cathy Zhang <cathy.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cathy Zhang <cathy.zhang@intel.com>

This instruction aims to give a way to choose which memory accesses
do not need to be tracked in the TSX read set, which is defined as
CPUID.(EAX=7,ECX=0):EDX[bit 16].

The release spec link is as follows:
https://software.intel.com/content/dam/develop/public/us/en/documents/\
architecture-instruction-set-extensions-programming-reference.pdf

The associated kvm patch link is as follows:
https://lore.kernel.org/patchwork/patch/1268026/

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
Message-Id: <1593991036-12183-3-git-send-email-cathy.zhang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fa9353dfba..0df2a2becb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -987,7 +987,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             "avx512-vp2intersect", NULL, "md-clear", NULL,
             NULL, NULL, "serialize", NULL,
-            NULL, NULL, NULL /* pconfig */, NULL,
+            "tsx-ldtrk", NULL, NULL /* pconfig */, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", "stibp",
             NULL, "arch-capabilities", "core-capability", "ssbd",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bd71fe3ef2..37fffa5cac 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -779,6 +779,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_VP2INTERSECT (1U << 8)
 /* SERIALIZE instruction */
 #define CPUID_7_0_EDX_SERIALIZE         (1U << 14)
+/* TSX Suspend Load Address Tracking instruction */
+#define CPUID_7_0_EDX_TSX_LDTRK         (1U << 16)
 /* Speculation Control */
 #define CPUID_7_0_EDX_SPEC_CTRL         (1U << 26)
 /* Single Thread Indirect Branch Predictors */
-- 
2.26.2



