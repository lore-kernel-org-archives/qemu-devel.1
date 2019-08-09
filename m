Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E137C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8DA217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6knsPHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8DA217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw14X-0007wL-Dv
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13t-00063F-PX
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13s-0007gX-O2
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw13s-0007fL-Gv
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:48 -0400
Received: by mail-wr1-x441.google.com with SMTP id p13so22980931wru.10
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jg/eQC5u9xh3QI/xnJki4J/dDhPvHCNndIskUdzw8E8=;
 b=F6knsPHgbPXLBvUFks8QHXu9m4XQHH2xVA5M6n4ENY46YQBWlTQPO7xHYzYUQnwiTT
 8Npc1+Oio0opINc8Xw81bXd5bjizSms8+RjBm1N+tqmUXT3nxDhYMcC5Mj7z2VHh3n+K
 GnwDFeGzXnWDb5ClSADwvcL5EvxQ/lV1DHm18KqaaybsQD8k0YTnqCZX+nMJSkdTUqiQ
 yNMxRWzpImSVCU7BjR/XP+dgMEuhQwhfgZeeGAhaKjRNqfosd9xXMEvTN53XbckRthxr
 XVuCXJCIrMNivpyZtIGdGskK7GcL+OQ8TBhk3Ujos7PXqRypo5+FK/ShJCpooS7kwoF3
 WE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jg/eQC5u9xh3QI/xnJki4J/dDhPvHCNndIskUdzw8E8=;
 b=uc2r1zrGWgBgkSbVweEdYo5Q+Aa33yHSoZ6HOO78i3wm3oxDHV6AcapFHJzBzrmSiO
 5NmhTeEkOEt6S4KlhiR0QDfaBx4k12o8wQ9cyQswBNF9ujETP/TutRQfEAqBb1BE73Xw
 QsveAAbvpNcHPvGLb8hKEQAfhx7h6xy2xjSs0N2+z7c+venpvqcN0gejmpdDkcNzsi2u
 mIth3uRwoNPWsKJZpywVYdBQgvfqdOImDrlL43xXBhnZJzCVNaEvbeypaeemeCAyQWc3
 eRjwBGZyp55+aGsgZFmGgIGLDNcX8wa5A5lLlrLlIFdQ+PY2YQTJ29WX4SQu/mopQerm
 8N1g==
X-Gm-Message-State: APjAAAXk+pwIOmfQDheZTZYczfSDCWDIDO9U4ZXmsi+QZrSBZhbIgYxv
 5TmHyTDz7CCSTQvi2YhlN8UuYyY8M7E=
X-Google-Smtp-Source: APXvYqy9cIYZAjGACCUC65d+paJni9COdNQ1xy+YZz/nfebrWTJqL4BcTfBnhLYQZ25sogmyZAp+dw==
X-Received: by 2002:adf:e710:: with SMTP id c16mr13188156wrm.292.1565342387409; 
 Fri, 09 Aug 2019 02:19:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r4sm63281255wrq.82.2019.08.09.02.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:19:44 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D86C1FF96;
 Fri,  9 Aug 2019 10:19:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 10:19:40 +0100
Message-Id: <20190809091940.1223-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809091940.1223-1-alex.bennee@linaro.org>
References: <20190809091940.1223-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v2 7/7] targets (various): use
 softfloat-helpers.h where we can
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
Cc: David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, armbru@redhat.com,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generally the cpu and non-FP helper files just want to manipulate the
softfloat flags. For this they can just use the -helpers.h include
which brings in a minimal number of inline helpers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c   | 2 +-
 target/microblaze/cpu.c | 2 +-
 target/s390x/cpu.c      | 2 +-
 target/sh4/cpu.c        | 3 +--
 target/tricore/helper.c | 2 +-
 target/unicore32/cpu.c  | 1 -
 6 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 93b8e788b18..c6998348df4 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -21,7 +21,7 @@
 
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-types.h"
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 0bec54b2f8a..9cfd7445e7d 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -28,7 +28,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-helpers.h"
 
 static const struct {
     const char *name;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 736a7903e22..5db016672bb 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -42,7 +42,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
 #endif
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-helpers.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 816d6d7f311..d0a7707991f 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -25,8 +25,7 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
-#include "fpu/softfloat.h"
-
+#include "fpu/softfloat-helpers.h"
 
 static void superh_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index a6803368506..d5db7b2c03f 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -19,7 +19,7 @@
 
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-helpers.h"
 #include "qemu/qemu-print.h"
 
 enum {
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 802e2f1eba5..b27fb9689ff 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -17,7 +17,6 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
-#include "fpu/softfloat.h"
 
 static void uc32_cpu_set_pc(CPUState *cs, vaddr value)
 {
-- 
2.20.1


