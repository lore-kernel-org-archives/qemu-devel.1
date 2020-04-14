Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07860C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98EA2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUXplBNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98EA2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORtg-0005xZ-00
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpY-0006Ag-OG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpX-0005yQ-JD
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:54470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORpX-0005xz-CK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id h2so14492110wmb.4
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aZ6FKx87IIsaQ+fv9HHif36FthP5pDUoqk2AxtvgmQ8=;
 b=eUXplBNYodG6JvFBONo8L2tEaI/kp6eZoywXUqbyebmAcDcuCDcAeR0YJYW95D5TaH
 0RNJJwZpd3ggMQ/YHnfJGW72P1lZk0wVjw7RWju1wmk/LB2XZtag/CxNHYbBpDDcqYyq
 1hlP7oX7jJxTMPnELJTdLeg3hkiyyFtsBeuttFJT5tuIk86jyxkVhgNjv4saKw+uRsfn
 F007fJBxomr6EKdpnxoRpIjjnAmQsOFKEaU3/lnOR8p3lGjven6DckXymUNTdqDz610z
 8X35a5na7Rav/ANxVFULQgDnsw55VRFt6+KfllhSogx72uBa5fR3gbQT4JDnxlwfCOh9
 t6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aZ6FKx87IIsaQ+fv9HHif36FthP5pDUoqk2AxtvgmQ8=;
 b=b4NDhEZnHBO25iBElobheZm0ggRpAlM3SfUIc+cfwznOI3LrwRmqyPacr/z+TuZ3wO
 t8/eE304Ko2g4jyabb3bYna+AVHayChut/9+f75cARVYelQBnYv1hyf5JV8ee6PnGTvH
 bAp6OwVz+zDrMmRuLkXQeTkVWqFLbCl3egta08p0tYpE7UB9gOLSuQQXDjhCUU0W4DIZ
 P6GwhXLSutLcGstW13xPUR/u93H0hhkPRLitBMrfmQ6SXpnx66uK4q0dGjkouh8GV3/p
 sxebk5xG2aOlZS+wBwsaxMPb1GbFHIntt3J0+9fDjbrxWOp8kOwHEoGtXbkz2m9uvUrj
 2K+Q==
X-Gm-Message-State: AGi0PuZsTXPUut4DWGqYFi4Yd49f6TUlcejK1C/S9F+azTfQDkDU/6Rw
 mI1erRPgPfaUuce1sMuwc2PKOQ==
X-Google-Smtp-Source: APiQypIjq+bOv/fD6Tg0a0tqQj+Pv+Ssu1MFdXasDH/p9VfEpXuxFlYElcFgMoNkUfcyGdzr9yZeBg==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr1472289wma.24.1586894806418; 
 Tue, 14 Apr 2020 13:06:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q17sm11836553wmj.45.2020.04.14.13.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:06:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 87CFB1FF9B;
 Tue, 14 Apr 2020 21:06:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 12/17] gdbstub: Do not use memset() on GByteArray
Date: Tue, 14 Apr 2020 21:06:26 +0100
Message-Id: <20200414200631.12799-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Introduce gdb_get_zeroes() to fill a GByteArray with zeroes.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200414102427.7459-1-philmd@redhat.com>
[AJB: used slightly more gliby set_size approach]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/gdbstub.h  | 9 +++++++++
 target/arm/gdbstub.c    | 3 +--
 target/xtensa/gdbstub.c | 6 ++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 30b909ebd27..3c452fc50c0 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -125,6 +125,15 @@ static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
     return 16;
 }
 
+static inline int gdb_get_zeroes(GByteArray *array, size_t len)
+{
+    guint oldlen = array->len;
+    g_byte_array_set_size(array, oldlen + len);
+    memset(array->data + oldlen, 0, len);
+
+    return len;
+}
+
 /**
  * gdb_get_reg_ptr: get pointer to start of last element
  * @len: length of element
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 8efc535f2a0..063551df234 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -47,8 +47,7 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         if (gdb_has_xml) {
             return 0;
         }
-        memset(mem_buf, 0, 12);
-        return 12;
+        return gdb_get_zeroes(mem_buf, 12);
     }
     switch (n) {
     case 24:
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index 0ee3feabe54..4d43f1340ae 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -105,8 +105,7 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         default:
             qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported size %d\n",
                           __func__, n, reg->size);
-            memset(mem_buf, 0, reg->size);
-            return reg->size;
+            return gdb_get_zeroes(mem_buf, reg->size);
         }
 
     case xtRegisterTypeWindow: /*a*/
@@ -115,8 +114,7 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     default:
         qemu_log_mask(LOG_UNIMP, "%s from reg %d of unsupported type %d\n",
                       __func__, n, reg->type);
-        memset(mem_buf, 0, reg->size);
-        return reg->size;
+        return gdb_get_zeroes(mem_buf, reg->size);
     }
 }
 
-- 
2.20.1


