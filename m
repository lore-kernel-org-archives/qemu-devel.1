Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051A6C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37DB205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUu+Fci/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37DB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49737 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhDu-0001bL-FP
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hzggg-0000h2-3f
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hzggd-0001W0-Cx
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:23:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hzggc-0001Tw-AT
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:22:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id g17so8520086wrr.5
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3EgZAgrLHmvjFmEihZ2FxaGJcoIsHosX2efs7meYYq8=;
 b=iUu+Fci/hO0Elm1PK6rlbzXcG2nxwvk3KeNotk+hOPwxKIJ3i6hxw8+0yaaOp4DAfl
 X9dbvTw3EJtPK3eze6OVJMn+Z144JMtsVR8Vx3BvwnwEBwdXlQbgbkh42+UkFALNcWSf
 W0zmCpZyD2AzEfbSw2rVuRYinzsALZ97sgJPuKSrMX8AJndH/V8td4iytXEBBOccSr0C
 Ial+SiPzm0d+SMicif5GyS+nczdLSAWb2wpky+qy9WE2otWOOykA1htgvt/acUZSHJES
 uhqja74AykbvMlOGHXfEtJLT5aGJLO8dvGy9nWV1FscUq9dBFUbRJ2B2ElL3RkIWtvh2
 bERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3EgZAgrLHmvjFmEihZ2FxaGJcoIsHosX2efs7meYYq8=;
 b=hDJFNOKisQN4Y8VCUdqDR65nw9ws074M3pVuyNIU7b7dzNgu1wD/4clv5wWADrXvE9
 Neu/40B+sQWi6kPerUqJziemu34h2UOzwGXiziEoPnYT4Fcwdnn1kotuduYwy0IfUe9h
 FNUJIuh+gINhseFsV8DncjT0h14hK6wl/n8VVxacjmwVdAdkviVPoETHwb6f+d7fJbgE
 EUgHOu03kNQV6a5CkR9pP5fpYsnCxy5TgMhtgSD9RKdsOEA26WlOpezPagKk6kgOZucI
 NYFsEH87GHZYS+fZBy1aYgnlN3qrcwz6cp68pCeNsSW3M5C8kW+wsn3v7Suyniuk/Lym
 QcPA==
X-Gm-Message-State: APjAAAWXQn4+WR0BvL2FKMkI9mMwcN0z5bKRen0vX05LloiXCMM/uPH+
 qtr1yt8oetAkuLGrjY/yE2HTNQ==
X-Google-Smtp-Source: APXvYqxLBq0b51ntTj8r8cc0yss4XyNdH+Z5SET2o2He3ApZSJAj1YjHmdHyYL86mnBzgXW6yR0Mjg==
X-Received: by 2002:a5d:6a49:: with SMTP id t9mr2290783wrw.134.1566217373446; 
 Mon, 19 Aug 2019 05:22:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id e6sm15359993wrr.14.2019.08.19.05.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 05:22:52 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 08CBA1FF87;
 Mon, 19 Aug 2019 13:17:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 19 Aug 2019 13:17:09 +0100
Message-Id: <20190819121709.31597-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819121709.31597-1-alex.bennee@linaro.org>
References: <20190819121709.31597-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 12/12] targets (various): use
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generally the cpu and non-FP helper files just want to manipulate the
softfloat flags. For this they can just use the -helpers.h include
which brings in a minimal number of inline helpers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
index 9466cd832d4..3abe7e80fd0 100644
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


