Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D3C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92D5206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZHs6+T8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92D5206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORxq-00027Z-0U
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpd-0006CK-LK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpa-0005zn-4N
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORpZ-0005zK-UZ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id g12so7907648wmh.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bPwQhRdvGibSgM9jwxm8brESu2WKcPxrBlyVkpOMlqE=;
 b=ZHs6+T8P2V4NE5qGEv4Tz+U6rxgh9AG50KbjQDc/JCEXQbcKQXxH74p/9wXdbq8m3T
 FJqr+Ntsr+W9Wp1O/3HZMOkrHunP0sjl97W0fX9FqMQpNKgc7ikz2v5Jp1NScH1JHb6K
 mI/gYrdv4geJ/PKpUiF0A5uIGp5esL/iKB5aFfBYFJH0Ntm9hdyRGns69F84B8yK0Uj7
 00eGNVDPH0/8avgkOUI3SWrQPvAuDwfqQ9kxAe2rcHWCy2w9WxCzWyPKGul2+vo/SYhN
 nwzez2xyveo79KiD+9qkXK+s+R9qDILnrHhQAOiub5u1K+BCtzvu3THlwhz4GTGRVW4C
 xPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bPwQhRdvGibSgM9jwxm8brESu2WKcPxrBlyVkpOMlqE=;
 b=RPT2sncdYeHZO10O0lwzXZNKrOcQau1d5c04GHq6M29x3pfQAsamp3ZOaXpuFNXASZ
 EC8tcDR0hMUs3ZVVT4RP+zSkuet8R18Ca28dhO0RzLEK4hZy3wTrDVbiD2BkyCQoA/i/
 GKI9eKHx3QG0l/cUWoyrssLVPSlQ7OrtVO+Zrb3gtJlV7ar2Vm080Co7pzT7iScIMIY4
 0Ow0ugLnYI+ARjijs36KOk6a2ilQvJf4rcz9oTmzoWnIOpo3Bvcby8bg0NepRmQrh9lX
 ncQIrKGiuxWhxj8dLr+qaEAJo3YopK4sWAgJ63o7hVFby05zrBJj7zelCFfz2QCetOZM
 GiNA==
X-Gm-Message-State: AGi0PuYGa/q6TuWH0CVyDHxXE8bs1J9iwoE+j+B6pwutREiK29MJ8zlB
 d9vdpZSRWTQcAd49wL4T6nqW5A==
X-Google-Smtp-Source: APiQypLF+7Hb1JbiLgu9Jecullk+r5OV6x3N5GcjwrmnSqmSUtLByTYR1yMftF30io3ddg9Gnnyc6A==
X-Received: by 2002:a1c:dfc2:: with SMTP id w185mr1427740wmg.1.1586894808896; 
 Tue, 14 Apr 2020 13:06:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a205sm15483375wmh.29.2020.04.14.13.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:06:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 585D81FF9A;
 Tue, 14 Apr 2020 21:06:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/17] gdbstub: i386: Fix gdb_get_reg16() parameter to
 unbreak gdb
Date: Tue, 14 Apr 2020 21:06:25 +0100
Message-Id: <20200414200631.12799-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

We should only pass in gdb_get_reg16() with the GByteArray* object
itself, no need to shift.  Without this patch, gdb remote attach will
crash QEMU:

  (gdb) target remote :1234
  Remote debugging using :1234
  Remote communication error.  Target disconnected.: Connection reset by peer.
  $ qemu-system-x86_64 -m 1G -smp 4 ... -s
  ERROR:qemu/gdbstub.c:1843:handle_read_all_regs: assertion failed: (len == gdbserver_state.mem_buf->len)
  Bail out! ERROR:qemu/gdbstub.c:1843:handle_read_all_regs: assertion failed: (len == gdbserver_state.mem_buf->len)

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200409164954.36902-3-peterx@redhat.com>

---
v2
  - tags and expand comment
---
 target/i386/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f3d23b614ee..b98a99500ae 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
         floatx80 *fp = (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
         int len = gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
-        len += gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
+        len += gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
         return len;
     } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -= IDX_XMM_REGS;
-- 
2.20.1


