Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB67C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42E622074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2mHlBoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E622074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAC7J-0003hU-JN
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 09:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kAC6e-0003FE-4E
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:01:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48969
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kAC6c-0006wN-E5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598274105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=esL1dkHZinACs22qmxIaFrjRQ3jGjWpeBvTqQ19GGJ8=;
 b=d2mHlBoFa+3hJuoUtN+XP/teVi7Eq1vNxsHfScyJwqcg8DSEmepsWihnW2bUCHcnm2cx1U
 3mOmkihXoMBCVYig5ub0m2PbvMgp8+qmKU6wlb8CIR6W8Ga8sgnegM+wB6lU+253t+txi5
 i9GiJgIwn78Ff0enIxUZtgGoIwIpLyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-WEYbk-JXNlGKI9cGCSlJOA-1; Mon, 24 Aug 2020 09:01:18 -0400
X-MC-Unique: WEYbk-JXNlGKI9cGCSlJOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91C8380F043;
 Mon, 24 Aug 2020 13:01:17 +0000 (UTC)
Received: from thuth.com (ovpn-114-8.ams2.redhat.com [10.36.114.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 514FF5D9E4;
 Mon, 24 Aug 2020 13:01:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] disas/libvixl: Fix fall-through annotation for GCC >= 7
Date: Mon, 24 Aug 2020 15:01:14 +0200
Message-Id: <20200824130114.41368-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 03:41:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For compiling with -Wimplicit-fallthrough we need to fix the
fallthrough annotations in the libvixl code. This is based on
the following upstream vixl commit by Martyn Capewell:

 https://git.linaro.org/arm/vixl.git/commit/?id=de326f850f736c3a337

 "GCC 7 enables switch/case fallthrough checking, but this fails in
  VIXL, because the annotation we use is Clang specific.

  Also, fix a missing annotation in the disassembler."

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 disas/libvixl/vixl/a64/disasm-a64.cc | 4 ++++
 disas/libvixl/vixl/globals.h         | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/disas/libvixl/vixl/a64/disasm-a64.cc b/disas/libvixl/vixl/a64/disasm-a64.cc
index 7a58a5c087..f34d1d68da 100644
--- a/disas/libvixl/vixl/a64/disasm-a64.cc
+++ b/disas/libvixl/vixl/a64/disasm-a64.cc
@@ -2985,6 +2985,10 @@ int Disassembler::SubstituteImmediateField(const Instruction* instr,
           }
           return 3;
         }
+        default: {
+          VIXL_UNIMPLEMENTED();
+          return 0;
+        }
       }
     }
     case 'C': {  // ICondB - Immediate Conditional Branch.
diff --git a/disas/libvixl/vixl/globals.h b/disas/libvixl/vixl/globals.h
index 61dc9f7f7e..7099aa599f 100644
--- a/disas/libvixl/vixl/globals.h
+++ b/disas/libvixl/vixl/globals.h
@@ -108,10 +108,12 @@ inline void USE(T1, T2, T3, T4) {}
   #define __has_warning(x)  0
 #endif
 
-// Note: This option is only available for Clang. And will only be enabled for
-// C++11(201103L).
+// Fallthrough annotation for Clang and C++11(201103L).
 #if __has_warning("-Wimplicit-fallthrough") && __cplusplus >= 201103L
   #define VIXL_FALLTHROUGH() [[clang::fallthrough]] //NOLINT
+// Fallthrough annotation for GCC >= 7.
+#elif __GNUC__ >= 7
+  #define VIXL_FALLTHROUGH() __attribute__((fallthrough))
 #else
   #define VIXL_FALLTHROUGH() do {} while (0)
 #endif
-- 
2.18.2


