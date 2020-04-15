Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A64AC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A2E20737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXCrfySX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A2E20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfXY-0007aC-5s
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45637)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jOfV2-0002iF-J9
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jOfUs-00039D-FF
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:32 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37420)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jOfUs-00038j-9G
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:42:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id k1so11308961wrx.4
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 03:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MK/jC81/8sRpluD3scWqqrQbZZzk/m9KkgnOCQx5tL4=;
 b=SXCrfySXY+B05afPhpSqlY7shjKkEMXLp6BVdiDm1qiz/nt5g0vnhmNmNGoe/4NsZi
 cIoO0FYCiLy09566psoY/M3riT1F9pDUQG/ptxtZnZ1PuZkwWFUvB0KYo1SN37XDQk/F
 vG1qCLb4utntovGhhph9ficu96n1FZgrWio7FEtbKr0Fh13wvuHetrRwlo2NkyzN/GpQ
 6tsJxK7ozCxFf1TBKnMxha7rb5GOflJ2qgbkpgGA47vrcyDnStKTFAJI+x6w6wkErN5w
 sJaQyN5ZlRU2MJ/BxCG8oLYM6agS7OKOxyM320sAN7RLynre+wxQbRXR1RFL9BkbulY6
 YcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MK/jC81/8sRpluD3scWqqrQbZZzk/m9KkgnOCQx5tL4=;
 b=dQ1qcfTMy2q9iBzoP9q6lb23uBxdugwxKB53wuN5EA+dh4Y4IS4MjkDQ9cdv/Rixtf
 6/sEqedePq81iuJPa1Whwcl0JlBXhykRwIh1dJ2FSsXlxZElsNrldfakzk5zESi1Q2mm
 xTAhclUu8FLbvFCqhLs+CBogQdebhiHfZz/pUopi/D9aMTK1TKK2YHbON5N86dw53NeW
 LqJFh+WugN1A9N06pn8sPmX0TzFq1lop85EF27GMKT+gajykkNlFFwCg7otLOr5CvmM5
 TCng5UscudEw30nLLY6W9blGLUYV0u/DvDl9LbvpK72TJItb5aCzvdbUUk4r2HbliGJa
 SxCg==
X-Gm-Message-State: AGi0PuYYW+7V2/Leosljoh80hYQUN0uvIIUJa23XVUom5MyYKL3HPLUJ
 EcJHNnKMh0HRBlHIZW3FHePnOg==
X-Google-Smtp-Source: APiQypIJ7XPn20g5D0NuYknmXtkpL+A8IRmhO38Hdas9EIyyJmkFx/2OKG4SQF6S9rYaAZJxgz2zAg==
X-Received: by 2002:adf:e3ca:: with SMTP id k10mr11722322wrm.53.1586947341200; 
 Wed, 15 Apr 2020 03:42:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z18sm16637303wrw.41.2020.04.15.03.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2020 03:42:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 825CC1FF92;
 Wed, 15 Apr 2020 11:42:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 6/8] gdbstub: i386: Fix gdb_get_reg16() parameter to unbreak gdb
Date: Wed, 15 Apr 2020 11:42:09 +0100
Message-Id: <20200415104211.9388-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415104211.9388-1-alex.bennee@linaro.org>
References: <20200415104211.9388-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
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
Message-Id: <20200414200631.12799-12-alex.bennee@linaro.org>

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


