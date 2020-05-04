Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B169CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779CE2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxKhngb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779CE2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVeuv-0001Dw-Md
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVeq0-00024g-G1
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:25:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46782
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVepz-0005HA-BN
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588613102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eR31adTdMPk4TFbTKxXjmfRO49TpZn7uiMipPa9bRA=;
 b=dxKhngb32EtjQnQ/14gUp9YRdrIVJUa1nmmOdQRumPmZoj6x4zVTj7r1XgJWeY5PimOyGw
 FBxq3GT8zeRB4lIWLhGf2UK8tiEmQqGqN5e7sYuwsbdnOGSFBf94b8F/HWN9P3NGyDiCEk
 HqeZnWgf+AqpGa6V+yTTTLQSTlh3k3s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-ONMZYmmaM2GeuY7zTtdr8A-1; Mon, 04 May 2020 13:25:00 -0400
X-MC-Unique: ONMZYmmaM2GeuY7zTtdr8A-1
Received: by mail-wm1-f71.google.com with SMTP id u11so299280wmc.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mNLhxG+rF1DxUCrUPPEOBQrTLpnVUshkFFUK77pGukA=;
 b=d+btMXs0WaFElnp5bs2m6GcagcBK9GsNHBodd9HHViXVdg/2h1Fs7KJl5CwSllKEWQ
 YKbC9tgBJjAH4gnYX64uxDUMFjnMuKVikOKmmSRthT5nS2bQrxXHVVQuMIE/NjuuUs/n
 VZX1OLcdlANWMoV4Fk1rQC1YV0H4PKo8gRMKK0jIBJTOHa7r/iTH6nRrLcBERLkgyBRN
 ti3qPeqipt3+A1+qHcFZpwYC3w0ubQaQu6hHPivkdAw2K5O96nF3/UVm10BXIZVULlrK
 3AzcaKxUMt0RSRQCAp0EbOjTS3cHsFVowlIlGeMj0jchpS1E7zgN1Abc/RF2WPOXJfL/
 /CIA==
X-Gm-Message-State: AGi0PuaSR1/tCtqmntjYwKJ67y03qPp/N4jFvuY8VbtRiHWZMpOtHsMN
 3DGNPhZtJShO4RN21xSk22gpWLwGqMydbOpTwBHNaXcroO5MobFww+KBaq+FAtCGbc7iGf8jDQR
 ofPbwHYfQZifJCzY=
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr388721wrn.82.1588613099356;
 Mon, 04 May 2020 10:24:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypLZVvDcO44TACYDWQQAmaJS8qI3Q4z1yf+lQvTHetygcJ4NlHQCnA2+QHUvEuJUimV2gJ9y/g==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr388704wrn.82.1588613099127;
 Mon, 04 May 2020 10:24:59 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id f7sm18486704wrt.10.2020.05.04.10.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 10:24:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/5] target/arm: Make set_feature() available for other
 files
Date: Mon,  4 May 2020 19:24:45 +0200
Message-Id: <20200504172448.9402-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504172448.9402-1-philmd@redhat.com>
References: <20200504172448.9402-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Move the common set_feature() and unset_feature() functions
from cpu.c and cpu64.c to cpu.h.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-ID: <20190921150420.30743-2-thuth@redhat.com>
[PMD: Split Thomas's patch in two: set_feature, cpu_register]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/cpu.h   | 10 ++++++++++
 target/arm/cpu.c   | 10 ----------
 target/arm/cpu64.c | 10 ----------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8608da6b6f..676f216b67 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -696,6 +696,16 @@ typedef struct CPUARMState {
     void *gicv3state;
 } CPUARMState;
=20
+static inline void set_feature(CPUARMState *env, int feature)
+{
+    env->features |=3D 1ULL << feature;
+}
+
+static inline void unset_feature(CPUARMState *env, int feature)
+{
+    env->features &=3D ~(1ULL << feature);
+}
+
 /**
  * ARMELChangeHookFn:
  * type of a function which can be registered via arm_register_el_change_h=
ook()
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5d64adfe76..13959cb643 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -725,16 +725,6 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
=20
 #endif
=20
-static inline void set_feature(CPUARMState *env, int feature)
-{
-    env->features |=3D 1ULL << feature;
-}
-
-static inline void unset_feature(CPUARMState *env, int feature)
-{
-    env->features &=3D ~(1ULL << feature);
-}
-
 static int
 print_insn_thumb1(bfd_vma pc, disassemble_info *info)
 {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9bdf75b1ab..cbaa5ed228 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -29,16 +29,6 @@
 #include "kvm_arm.h"
 #include "qapi/visitor.h"
=20
-static inline void set_feature(CPUARMState *env, int feature)
-{
-    env->features |=3D 1ULL << feature;
-}
-
-static inline void unset_feature(CPUARMState *env, int feature)
-{
-    env->features &=3D ~(1ULL << feature);
-}
-
 #ifndef CONFIG_USER_ONLY
 static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *=
ri)
 {
--=20
2.21.3


