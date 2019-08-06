Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E53CC31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 19:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B2D20C01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 19:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B2D20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv4lU-0004A4-FO
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 15:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sean.j.christopherson@intel.com>) id 1hv4dy-0004Oj-Vw
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 14:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sean.j.christopherson@intel.com>) id 1hv4dx-00075j-5E
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 14:57:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:31802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sean.j.christopherson@intel.com>)
 id 1hv4dw-0006yc-Qq
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 14:57:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Aug 2019 11:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; d="scan'208";a="176715080"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
 by orsmga003.jf.intel.com with ESMTP; 06 Aug 2019 11:56:59 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Date: Tue,  6 Aug 2019 11:56:35 -0700
Message-Id: <20190806185649.2476-7-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190806185649.2476-1-sean.j.christopherson@intel.com>
References: <20190806185649.2476-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [RFC PATCH 06/20] i386: Add SGX CPUID leaf
 FEAT_SGX_12_1_EAX
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CPUID leaf 12_1_EAX is an Intel-defined feature bits leaf enumerating
the platform's SGX capabilities that may be utilized by an enclave, e.g.
whether or not an enclave can gain access to the provision key.
Currently there are six capabilities:

  - INIT: set when the enclave has has been initialized by EINIT.  Cannot
          be set by software, i.e. forced to zero in CPUID.
  - DEBUG: permits a debugger to read/write into the enclave.
  - MODE64BIT: the enclave runs in 64-bit mode
  - PROVISIONKEY: grants has access to the provision key
  - EINITTOKENKEY: grants access to the EINIT token key, i.e. the
                   enclave can generate EINIT tokens
  - KSS: Key Separation and Sharing enabled for the enclave.

Note that the entirety of CPUID.0x12.0x1, i.e. all registers, enumerates
the allowed ATTRIBUTES (128 bits), but only bits 31:0 are directly
exposed to the user (via FEAT_12_1_EAX).  Bits 63:32 are currently all
reserved and bits 127:64 correspond to the allowed XSAVE Feature Request
Mask, which is calculated based on other CPU features, e.g. XSAVE, MPX,
AVX, etc... and is not exposed to the user.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 target/i386/cpu.c | 20 ++++++++++++++++++++
 target/i386/cpu.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e954eca4dd..e3dd76d3ba 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -776,6 +776,7 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           /* missing:
           CPUID_XSAVE_XSAVEC, CPUID_XSAVE_XSAVES */
 #define TCG_SGX_12_0_EAX_FEATURES 0
+#define TCG_SGX_12_1_EAX_FEATURES 0
 
 typedef enum FeatureWordType {
    CPUID_FEATURE_WORD,
@@ -1244,6 +1245,25 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_SGX_12_0_EAX_FEATURES,
     },
+    [FEAT_SGX_12_1_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL /* sgx-init */, "sgx-debug", "sgx-mode64", NULL,
+            "sgx-provisionkey", "sgx-tokenkey", NULL, "sgx-kss",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 0x12,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_EAX,
+        },
+        .tcg_features = TCG_SGX_12_1_EAX_FEATURES,
+    },
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6803b1b41d..fe4660effa 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -507,6 +507,7 @@ typedef enum FeatureWord {
     FEAT_ARCH_CAPABILITIES,
     FEAT_CORE_CAPABILITY,
     FEAT_SGX_12_0_EAX,  /* CPUID[EAX=0x12,ECX=0].EAX (SGX) */
+    FEAT_SGX_12_1_EAX,  /* CPUID[EAX=0x12,ECX=1].EAX (SGX ATTRIBUTES[31:0]) */
     FEATURE_WORDS,
 } FeatureWord;
 
-- 
2.22.0


