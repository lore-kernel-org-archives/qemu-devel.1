Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35665C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3D7020753
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTA9XP+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D7020753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQspl-0002nf-3r
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 09:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQsoS-00011t-LA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQsoR-0007Ta-Pu
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQsoR-0007Sp-DK
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587475182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MB+KcpzEineBQraMabNomRZxm0WGxSq/4mX06L66IW8=;
 b=KTA9XP+D9PZNyYAktUskcO13qQ0PrbRkZ9L+V6Y8YDF/LktIpzgRgrvx4oesWTjBonT5m7
 rfLRk1jkRvzLQ8R0UskEyDDXcqdHH6VBO+1qyu3YHVI4sdz1j0eE6Vd5KlJ4Yspb2Aw/xu
 J3EbHNZXMLfH6cYuVIMfJqR4KqzHBVs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-QI4TxWVBMnW-TFqYY5s2uw-1; Tue, 21 Apr 2020 09:19:41 -0400
X-MC-Unique: QI4TxWVBMnW-TFqYY5s2uw-1
Received: by mail-wr1-f70.google.com with SMTP id d17so7446150wrr.17
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 06:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tByUF6YONCD4gqGP4f3pAvFwLd8JVDzJFormU5gNpuE=;
 b=syP+VgqVmm+fKTtiYDii7RzM7CXuyV9lwwZ5Ma0VGPVGCJliGf1K1u9cA+7GTuRTAF
 mWAmacKx+FwBz31BPFu8w8gDPwFNbPW/GekX2CBuy+jJbrXECPk/S7ZiCP5OfUeY0Fky
 aUSZ489q9zUiQKI28563zF5sY/VY+OX3pCpjuFq6Ytir9xmHoJcVhqqCW7u0k+kv+Ni6
 fbuhNonFcIGXOrUKBIsrBaI98x1daKcrAdqTiCqOPxyIlpXu7gC4Hjb9tDxhfvvkmgBJ
 NborhYRTwUJy6suKwEo4NBDk3fyZp41ndJc4xBX0wAu2Q5jq48g9y4oC+S/OFtOlxfXo
 4YOQ==
X-Gm-Message-State: AGi0PubwFmB/TFCdXSSxpbmvW7CQU1NXOLWHdiyQaUPG/sN88WqufQxp
 +/Z5cdkt1raEV90yw4yZZ+1dRS3r7W85dF/YAmy/hdtWYWEunvUDKhMsg3OJeVtyrJWnk3+B14O
 PnZ0JOHmua+91DuE=
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr26222156wrn.0.1587475178633; 
 Tue, 21 Apr 2020 06:19:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypLY7VVo0T+M1kriR9MW4uQc9UFP0hXNVeOtx8QeDV8L28NN3tVov1QD9OsVJBj0qmn/46cgPQ==
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr26222141wrn.0.1587475178468; 
 Tue, 21 Apr 2020 06:19:38 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j11sm3780321wrr.62.2020.04.21.06.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 06:19:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] target/arm: Make set_feature() available for other files
Date: Tue, 21 Apr 2020 15:19:22 +0200
Message-Id: <20200421131926.12116-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421131926.12116-1-philmd@redhat.com>
References: <20200421131926.12116-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
[PMD: Split Thomas's patch in two: set_feature, cpu_register (later)]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/cpu.h   | 10 ++++++++++
 target/arm/cpu.c   | 10 ----------
 target/arm/cpu64.c | 11 +----------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8b9f2961ba..5e32fe7518 100644
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
index a79f233b17..37f18d1648 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -724,16 +724,6 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
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
index 62d36f9e8d..622082eae2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "internals.h"
 #include "qemu/module.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
@@ -29,16 +30,6 @@
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
2.21.1


