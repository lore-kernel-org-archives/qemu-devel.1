Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796D2C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474F020C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POyAZCZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474F020C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw176-0004mq-Fq
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48074)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13s-0005zo-19
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw13r-0007e1-10
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw13q-0007cv-Q7
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:19:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id b16so864691wrq.9
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ECv7P3HJHBY/e1Rr1VXbOKCzKrV4OGAXQsEe8ka+MiU=;
 b=POyAZCZo37L7qmzJ2UiFAtXuV52U+/+i4UscFsPLALzPiWP9jFiCZO3Z415eD8TNgN
 egZ9HD9uJUJzs/lBfi7+PHYOpKqOm8toJ90fSrkPlbTNYxPU0UUGNkFVXzMVehUuSYUj
 KaTOYp/nN6S9NuEozulvRnjJOUFSkKGtGOv5J1MqPZfm4ekfp+ZDOyObGnHem3Lz7D6p
 DpIjSsFaJw8ee3zcLbGU0BwjGQZyz3DGjPr8tNWEh6v1EBQOLtEYOeGPFtNzcemRFLMP
 LpKlIc9a7RyESKZEQWPtFSi+EWvc/3+Vd/QO4j/I+ytSLNC68xEt3NqYmLaf0LlZ2K3Y
 NHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ECv7P3HJHBY/e1Rr1VXbOKCzKrV4OGAXQsEe8ka+MiU=;
 b=NFvMQjDLchY+ittPwH5cyL00rQru6Osij+zj8QLYDv+gWV7+FJ0WrkEH8MQtKY3O01
 liN6FEU8nYX9loVA+ZivgRRt38y3wH9S4+XdrMMbsZSZQaeDZL+J30gPMo7XczOxipBK
 F2d2F0Yyk+NNeMJmqXRIAoHX/w6QYc1eLAV3Be7Bzh/PDXuHTUeiZmkH5pH5uPKRGSNW
 tGh+pi2Hh+m7kstY+vz9poaisp6AnBzlhCizguAsggQ6SghgF+ISYDnNOOdbNXOHiyqZ
 iUzA+MSO8s2ltZK7xC60hxn7SLGSzddk5kLZu7iWSLYlvjMyqshaoyxqV37QevOju8Y1
 oYWg==
X-Gm-Message-State: APjAAAV4LYkDuiG5e/Je0M+AGpANk+LeJNgWZAUKhj0QqS4rD3QyDgV6
 HFA5ab0FzaCwqjfK+Xst6yLAr5qWkLo=
X-Google-Smtp-Source: APXvYqwhVWDecAFxQcrBYFm0lfO3vwJQhv27lTk4b+5Vsi3ylJv7VFX+Pv5lsAWnAr38LSHPgMQl8A==
X-Received: by 2002:adf:eb49:: with SMTP id u9mr23604502wrn.215.1565342385660; 
 Fri, 09 Aug 2019 02:19:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q18sm121726388wrw.36.2019.08.09.02.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:19:43 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 70F571FF93;
 Fri,  9 Aug 2019 10:19:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 10:19:39 +0100
Message-Id: <20190809091940.1223-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809091940.1223-1-alex.bennee@linaro.org>
References: <20190809091940.1223-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 6/7] target/riscv: rationalise softfloat
 includes
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>, armbru@redhat.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should avoid including the whole of softfloat headers in cpu.h and
explicitly include it only where we will be calling softfloat
functions. We can use the -types.h and -helpers.h in cpu.h for the few
bits that are global.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c        | 1 +
 target/riscv/cpu.h        | 2 +-
 target/riscv/fpu_helper.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8d07bd20ad..6d52f97d7c3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "fpu/softfloat-helpers.h"
 
 /* RISC-V CPU definitions */
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0adb307f329..240b31e2ebb 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -22,7 +22,7 @@
 
 #include "qom/cpu.h"
 #include "exec/cpu-defs.h"
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-types.h"
 
 #define TCG_GUEST_DEFAULT_MO 0
 
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index b4f818a6465..0b79562a690 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
 
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
 {
-- 
2.20.1


