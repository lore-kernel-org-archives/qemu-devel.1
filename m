Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744AEC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C8D207DE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRPMSfT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C8D207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzsk-0004pF-UN
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNzmo-0007P1-0r
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNzmi-0002Eb-5V
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601563334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYzXqWXgtonVt/u84ke3FsaTsZ2wUQSqwruvuCAoYPY=;
 b=gRPMSfT4TPp9/Oe8pb3nZGSRHbaBhnhqCIlRm2BpXTbrpzRfS33Hq/mWi9//+mwusr0Nll
 Pt9H7QH1oLcRgrLIKFDJM3wIFBexLKiLcqCpzpEARZ0EXUYp1DWAT1FSDUsWGDH/I5BTbC
 VcIjyA+EgnVVUvY6+953zjaj4whFV7M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-cZwLscGIO96G7266rJynLA-1; Thu, 01 Oct 2020 10:42:12 -0400
X-MC-Unique: cZwLscGIO96G7266rJynLA-1
Received: by mail-wr1-f69.google.com with SMTP id s8so2122576wrb.15
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LYzXqWXgtonVt/u84ke3FsaTsZ2wUQSqwruvuCAoYPY=;
 b=gg/jbIJErytY6dOI7tTu8y/HvWsBZ6B63LNr6OaB9xGmNvovBpkpJyHKxTlpxD9jDy
 JztrmRo2kiValmXF3DK4U83xuuSYvBOyKFFejPcsDP0LtP1Dcjv7RZMOJm+1uYS6ZTNP
 A3sDnhCl9UGzdyGYvlOwiOkiLO4mgakpk7E5R07IBfSnBZQNBHO1l8S8rYKt0vuECawn
 mDt8PDFQ/UxuyXVJX5WKl47K6W0bC9tUuoaV8NONBBUaXlXOwJLWY0m4sWmzzh5iuUrP
 qPZ803YEejcQ6UZZy2CBJpfGjqgwQyykJPeKdZ1zuViN78lu0pnWqLS9j3b1Iic7oyyJ
 HKLg==
X-Gm-Message-State: AOAM532h0EI4tV4hVXKfHHqr1cBBdKI9jEiKkCE4z5FhGxxF5IwGKxKz
 bz8W6VOzsRTRk5JSRnP+E1KEJBq5Jf2hgx9vxbfiW69a/XQrbwcfJ8tq8swLhFAk2bCwQZFYmEp
 P5is+KF+3beqcuPY=
X-Received: by 2002:a7b:c111:: with SMTP id w17mr396974wmi.28.1601563330798;
 Thu, 01 Oct 2020 07:42:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfZsOqeK8ZHFNvsrASWtTpI7huwLdL1ZQpRYSjqV4DvIReW346xR/JUEwh2tzoJnIHjL20OQ==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr396947wmi.28.1601563330571;
 Thu, 01 Oct 2020 07:42:10 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id 88sm9710069wrl.76.2020.10.01.07.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:42:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 3/3] target/i386: Restrict X86CPUFeatureWord to X86 targets
Date: Thu,  1 Oct 2020 16:41:52 +0200
Message-Id: <20201001144152.1555659-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001144152.1555659-1-philmd@redhat.com>
References: <20201001144152.1555659-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only qemu-system-FOO and qemu-storage-daemon provide QMP
monitors, therefore such declarations and definitions are
irrelevant for user-mode emulation.

Restricting the x86-specific commands to machine-target.json
pulls less QAPI-generated code into user-mode.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine-target.json | 45 ++++++++++++++++++++++++++++++++++++++++
 qapi/machine.json        | 42 -------------------------------------
 target/i386/cpu.c        |  2 +-
 3 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 698850cc78..b4d769a53b 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -4,6 +4,51 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
 
+##
+# @X86CPURegister32:
+#
+# A X86 32-bit register
+#
+# Since: 1.5
+##
+{ 'enum': 'X86CPURegister32',
+  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ],
+  'if': 'defined(TARGET_I386)' }
+
+##
+# @X86CPUFeatureWordInfo:
+#
+# Information about a X86 CPU feature word
+#
+# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
+#
+# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
+#                   feature word
+#
+# @cpuid-register: Output register containing the feature bits
+#
+# @features: value of output register, containing the feature bits
+#
+# Since: 1.5
+##
+{ 'struct': 'X86CPUFeatureWordInfo',
+  'data': { 'cpuid-input-eax': 'int',
+            '*cpuid-input-ecx': 'int',
+            'cpuid-register': 'X86CPURegister32',
+            'features': 'int' },
+  'if': 'defined(TARGET_I386)' }
+
+##
+# @DummyForceArrays:
+#
+# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally
+#
+# Since: 2.5
+##
+{ 'struct': 'DummyForceArrays',
+  'data': { 'unused': ['X86CPUFeatureWordInfo'] },
+  'if': 'defined(TARGET_I386)' }
+
 ##
 # @CpuModelInfo:
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 756dacb06f..995e972858 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -574,48 +574,6 @@
    'dst': 'uint16',
    'val': 'uint8' }}
 
-##
-# @X86CPURegister32:
-#
-# A X86 32-bit register
-#
-# Since: 1.5
-##
-{ 'enum': 'X86CPURegister32',
-  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ] }
-
-##
-# @X86CPUFeatureWordInfo:
-#
-# Information about a X86 CPU feature word
-#
-# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
-#
-# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
-#                   feature word
-#
-# @cpuid-register: Output register containing the feature bits
-#
-# @features: value of output register, containing the feature bits
-#
-# Since: 1.5
-##
-{ 'struct': 'X86CPUFeatureWordInfo',
-  'data': { 'cpuid-input-eax': 'int',
-            '*cpuid-input-ecx': 'int',
-            'cpuid-register': 'X86CPURegister32',
-            'features': 'int' } }
-
-##
-# @DummyForceArrays:
-#
-# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally
-#
-# Since: 2.5
-##
-{ 'struct': 'DummyForceArrays',
-  'data': { 'unused': ['X86CPUFeatureWordInfo'] } }
-
 ##
 # @NumaCpuOptions:
 #
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9f72342506..848a65ded2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -38,7 +38,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-machine.h"
+#include "qapi/qapi-visit-machine-target.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
-- 
2.26.2


