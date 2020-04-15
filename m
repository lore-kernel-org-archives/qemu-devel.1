Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA658C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1969206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiHc3Z+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1969206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfXD-0007DQ-QY
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOfUu-0002Kl-Kv
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOfUt-00039p-Ey
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOfUt-00039H-7e
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:23 -0400
Received: by mail-wr1-x431.google.com with SMTP id h9so18524817wrc.8
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9MYeJGiJJI7VipH3/taczzrj1+vWUn9zJs0HrOL++KI=;
 b=RiHc3Z+hAcJcVjMXi3NwvA/tc7bnOXOaVUuy4RPPZjf6HsuqnovP8vK8zkBy7FBAD6
 wd2MeCJCwr+F6Nag4CBn7Kf71psqjleGmLw5nkMN92GIVtljDao0qrerdY2Jzh2urO2v
 PQbS54ADfdypqGNKFET7goACvzOp9RrRZJkEqyNbO782ajIbCbKy+BVBXlLXMAK91ZJo
 tTchIrC1katcaBpwfNlIM5yN7+jne4tQolQvQ0NeQmiY512rxiDreTOM/aVuEDP5zMbl
 4uL0BGMD5X2Mi8gFdSZeNytEltx7EAnWcD4qobPiaUXJR+WGWsk4lntOEZLfP5i6J3Du
 xfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9MYeJGiJJI7VipH3/taczzrj1+vWUn9zJs0HrOL++KI=;
 b=RKPsI31CgdR6rhaGxFORjZZHcNzbt8QzfsLnlGfLbYEG4P7wBuDQXFdQU/qVXxVK4E
 4/5mied3E/92cpBs7iG4DN937Tpuhj/97qtKuWo2vGlhBNPS9/9/MFOoY8IMl0g+vmUh
 cuYy19wErI/Iihw6qPf+e06f4oX7xuThXYgqY8AAlxdCm4UmzN+iHIGpdreQdwlun1dI
 GppecgTyr+25i0V6OQikgiKgn/52B1DQY3EJdnnXT0oyuYE1wGbAD6MKvfEbCcDzofug
 49/fEsvJmW6vDs+z4VpGXnvZYWjcEFBS6NX4k7g0EiSZgCkKLLnemzDwKR/FJW892NjU
 IAlQ==
X-Gm-Message-State: AGi0PuakaT9RQGOJh/7a6RR5IlF7j8s76E5RiB/i0gLtPSNBLp/E/AOO
 XvtAg9TrYLtXWtMK+R++wFd2wQ==
X-Google-Smtp-Source: APiQypL1B8swHjy8au8FKUlL5iulNwWVdxQJqrhA9XnD/WSKswlQFri8/kaiLQwP072q733uRvGEUw==
X-Received: by 2002:adf:bc05:: with SMTP id s5mr28076971wrg.70.1586947342237; 
 Wed, 15 Apr 2020 03:42:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k8sm20848913wrm.52.2020.04.15.03.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 03:42:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9B38D1FF93;
 Wed, 15 Apr 2020 11:42:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 7/8] gdbstub: Do not use memset() on GByteArray
Date: Wed, 15 Apr 2020 11:42:10 +0100
Message-Id: <20200415104211.9388-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415104211.9388-1-alex.bennee@linaro.org>
References: <20200415104211.9388-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>
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
Message-Id: <20200414200631.12799-13-alex.bennee@linaro.org>

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


