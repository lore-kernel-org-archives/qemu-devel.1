Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312D8C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F083B218A3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLz/uHrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F083B218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4LZ-0004AD-6Y
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44132)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4HK-0007s6-ED
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4HJ-00021B-BW
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj4HJ-00020F-5C
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:09 -0400
Received: by mail-wm1-x336.google.com with SMTP id f17so6686070wme.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VE11EFgntOX7Py1z1pIxszbPG3fn/oQDUqV4xv6+5lo=;
 b=PLz/uHrqH7NhLrA0ptL+BMwzByMhnXEx1PEocfmIeYN6gVyxX+Pk7gClle0ATmDKSF
 XAbI8XuyRCRr1NoF0ZFYnQdlpTjXDt9onHxAVRTiX40DJf1cg58tnRzg8i3CWirBj/wm
 yEGWdp3d3EWkftLFg+V3j+qvSg+FRTSP3JkUtWyn9fL+Y/U5zsfyIG8pH394LuWcawMd
 qFLD1sjx63/XZFnED5YcbzMIi3mAoblahSqr2kH4jQNDtqbTYYEImAJD7HWmOR/CFNoh
 /xpa3NhqIhX8WurMtOU5LL7Xbrkz1jYHrxFbdN3OYU2hQlzjSvztjWb7bCq+9x2CDuew
 1g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VE11EFgntOX7Py1z1pIxszbPG3fn/oQDUqV4xv6+5lo=;
 b=L3Y5RSjavaiYkwcU065UME+0eXEvU0j29BZpFSj88yDrm7yVEVSenF/vVCUNmzhy+/
 5RecwIarUK3gNhiVDy6KvvC609oy2N9dZxdK3sHqV/H5m5KC/0e0HcA/UeRNk4mNsynD
 VbY5VRQU3pREPv/tjssIWc13JXQ0hLUiOT/oeGm3NCAmfcnPQun9SOlv+FsH9HfQOnhT
 rpuHwjzvY7MLPY7d3dogpsJ1xw/HwUbv9LYzT5T/lfo992INkdWhhSb2vusfaFaTbk9D
 oHXeRw+wfrzI/qVlokdOSVWW01A/PX0iDS40m8PfFY4fwgb5wMcFl0N++97+JiLxOpbz
 yRyQ==
X-Gm-Message-State: APjAAAX6FvIJF7uy0nnH5agvVjUNQfovM93OC6Kzg8JJ+vU4CvTojtjS
 r6ix+AtTnsoeOnq82nFFhsUOHJNQpf18nA==
X-Google-Smtp-Source: APXvYqzQGXk1mEgOjrpVlEjyrQnD6ITeu4+Be+QwHmow2AxPrYo5B75OC/EL827veeOtvfOwcoeJDA==
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr184033wmi.73.1562256487826; 
 Thu, 04 Jul 2019 09:08:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s2sm3849690wmj.33.2019.07.04.09.08.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 09:08:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 17:07:55 +0100
Message-Id: <20190704160802.12419-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704160802.12419-1-peter.maydell@linaro.org>
References: <20190704160802.12419-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 2/9] target/arm: Restrict semi-hosting to TCG
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Per Peter Maydell:

  Semihosting hooks either SVC or HLT instructions, and inside KVM
  both of those go to EL1, ie to the guest, and can't be trapped to
  KVM.

Let check_for_semihosting() return False when not running on TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701194942.10092-3-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/Makefile.objs | 2 +-
 target/arm/cpu.h         | 7 +++++++
 target/arm/helper.c      | 8 +++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 294433da880..82bedefc3d0 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += arm-semi.o
+obj-$(CONFIG_TCG) += arm-semi.o
 obj-y += helper.o vfp_helper.o
 obj-y += cpu.o gdbstub.o
 obj-$(TARGET_AARCH64) += cpu64.o gdbstub64.o
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a9be18660fd..94c990cddbd 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -964,7 +964,14 @@ static inline void aarch64_sve_change_el(CPUARMState *env, int o,
 { }
 #endif
 
+#if !defined(CONFIG_TCG)
+static inline target_ulong do_arm_semihosting(CPUARMState *env)
+{
+    g_assert_not_reached();
+}
+#else
 target_ulong do_arm_semihosting(CPUARMState *env);
+#endif
 void aarch64_sync_32_to_64(CPUARMState *env);
 void aarch64_sync_64_to_32(CPUARMState *env);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9a1fe3b72ed..055bf831a61 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -20,7 +20,6 @@
 #include "qemu/qemu-print.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
-#include "arm_ldst.h"
 #include <zlib.h> /* For crc32 */
 #include "hw/semihosting/semihost.h"
 #include "sysemu/cpus.h"
@@ -29,6 +28,9 @@
 #include "qapi/qapi-commands-machine-target.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
+#ifdef CONFIG_TCG
+#include "arm_ldst.h"
+#endif
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
@@ -10399,6 +10401,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
 
 static inline bool check_for_semihosting(CPUState *cs)
 {
+#ifdef CONFIG_TCG
     /* Check whether this exception is a semihosting call; if so
      * then handle it and return true; otherwise return false.
      */
@@ -10474,6 +10477,9 @@ static inline bool check_for_semihosting(CPUState *cs)
         env->regs[0] = do_arm_semihosting(env);
         return true;
     }
+#else
+    return false;
+#endif
 }
 
 /* Handle a CPU exception for A and R profile CPUs.
-- 
2.20.1


