Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830A6CA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5316C20684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FdLNG+2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5316C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0aY-0001Xq-1U
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Td-0004wb-8E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tb-0001a9-Lx
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:04 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:44165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO0Tb-0001Zu-IO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:03 -0400
Received: by mail-qk1-x744.google.com with SMTP id g21so1875723qkm.11
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6YuVFd/F+N1dkaWyOwwHEzclPuT2QS3X/NJFdWUjnuU=;
 b=FdLNG+2tju8bCKTViuJEg01g+HzjZTN3/JPrrHIAiFKQv0oTvrMaQns/HX0RUvN/dx
 TQnDPp2EWWtCfC2Z1qyYR3stSvi6UG0bLOr03aA1+SU7jpFViPzAjAl96jjdwL8UkswW
 3ajbqJm6xKsW99FFvW9PJcxsGbfVzXWhy6wbdDzES0kqZA+UQ3QBqwrB+8YQUMjSY92X
 4qmGt2dOFHux+3NB1CFjFw91PqeEG1PrEpfWia1IjqrIt4DsvVlDrd1xPLMQthE5md6u
 M6jwkg6tn6xjwHKCQETQW6zfEm75Z7RWt1UxLHhNBzcdP72syrZ5q0VaWoepOrNEZfvn
 mbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6YuVFd/F+N1dkaWyOwwHEzclPuT2QS3X/NJFdWUjnuU=;
 b=ddNZd1l05GpbmqVLkTswrOTHrZQIvfvGYHEDUHW2UZ2kxNxz2eoc/n+jGgMu2euq6T
 0PkAk7P4rqzUym7GH4aHH7nCYor6K0dRT5syjLItMjVBasbjaLiwoVjz47rFg8+51v6U
 xTEa9REHYf/7pOY8p/+VuMmVqnxdjFvvlFmEZKUqnVFbv1yUHOc19ALJHMvZyrbBKhia
 vmz3kjS0edx0QG9HXdxbiYCgwQMpom1CrOOhvB2xpS+hdz+YhYCI/oSKzM6RQKuHeAIB
 X4CbCE7FuY8qENQIQvqg+Se0v+o2IsaSZrpRGxG0pYPpwkv31Q2WiV9NOAlT94AC7SQn
 zA1A==
X-Gm-Message-State: APjAAAWObTY6WxNPtWeavl7fDKjSnPSTI1HjxPBiEgrggB3ZuMLf1Z8j
 1hHbh2Jd18tIAndT4UMaChzXMzUvRkI=
X-Google-Smtp-Source: APXvYqyddPhTA9yWWWJoKOPD9Eu3RViP6Ug9/vTk74nSsot5K8A5bN4ifIZMs6aKqsBLiZwLy8BM3A==
X-Received: by 2002:a05:620a:14bc:: with SMTP id
 x28mr2932768qkj.433.1572013322565; 
 Fri, 25 Oct 2019 07:22:02 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id q17sm1137050qtq.58.2019.10.25.07.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:22:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] tci: Add implementation for INDEX_op_ld16u_i64
Date: Fri, 25 Oct 2019 10:21:48 -0400
Message-Id: <20191025142159.12459-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
References: <20191025142159.12459-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: peter.maydell@linaro.org, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Weil <sw@weilnetz.de>

This fixes "make check-tcg" on a Debian x86_64 host.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190410194838.10123-1-sw@weilnetz.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tcg/tci.c b/tcg/tci.c
index 33edca1903..a6208653e8 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -127,6 +127,12 @@ static void tci_write_reg8(tcg_target_ulong *regs, TCGReg index, uint8_t value)
     tci_write_reg(regs, index, value);
 }
 
+static void
+tci_write_reg16(tcg_target_ulong *regs, TCGReg index, uint16_t value)
+{
+    tci_write_reg(regs, index, value);
+}
+
 static void
 tci_write_reg32(tcg_target_ulong *regs, TCGReg index, uint32_t value)
 {
@@ -585,6 +591,8 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             tci_write_reg8(regs, t0, *(uint8_t *)(t1 + t2));
             break;
         case INDEX_op_ld8s_i32:
+            TODO();
+            break;
         case INDEX_op_ld16u_i32:
             TODO();
             break;
@@ -854,7 +862,14 @@ uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
             tci_write_reg8(regs, t0, *(uint8_t *)(t1 + t2));
             break;
         case INDEX_op_ld8s_i64:
+            TODO();
+            break;
         case INDEX_op_ld16u_i64:
+            t0 = *tb_ptr++;
+            t1 = tci_read_r(regs, &tb_ptr);
+            t2 = tci_read_s32(&tb_ptr);
+            tci_write_reg16(regs, t0, *(uint16_t *)(t1 + t2));
+            break;
         case INDEX_op_ld16s_i64:
             TODO();
             break;
-- 
2.17.1


