Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3985C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95AE20753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLTcE4Jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95AE20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMeYb-0005K4-Qd
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 17:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWV-00028P-Kh
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWU-0005m5-H7
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:43 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMeWU-0005jw-BT
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:42 -0400
Received: by mail-wr1-x42b.google.com with SMTP id c15so13649342wro.11
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Vwwp+7FgPCuWIPWypnjEryUlzyp/CqPviLpa6fHhzs=;
 b=QLTcE4JhzphXKShNK4RN0Od/VFN09fkzpUqPAb+/skkecwnvkFLqeNWzN+ccJm+722
 YBvnCpNbt8NT/baiYiMS2xMmlkbLLAENVQc2DUsJAPcF9q0UeAlos1j9QU9KHGFZ12Mp
 GP4r3d7ETBDH4TgcqqR2fyIC2OqVaMaVjOfg2RfduY0JLeUcrVtucQoHo0GtE6KuiAnN
 g7UljjawR0D8vLtThFNraHMNfn1tUuzlwxMhS9rDclGFzjC4WKL/yePErkx1LOxAEmlx
 1ehVHPlQn1as3H8OO2kpP/E5Ckh6JDUxghN3lf3xGnMWlDKbrAdSleBJlNDKjYpSPYKV
 nFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Vwwp+7FgPCuWIPWypnjEryUlzyp/CqPviLpa6fHhzs=;
 b=c84DVYDUROJTmwen+fx2yH9ZYc0vLYtTlaKMDaMVvJ+isqy6xbEm1a93ieEwmXIFE9
 dDCOjSs/aNmgaZ5Frd+2SbUn4Ysu/zZymYRMDOKuzvEzd2z3BQdzqDyYHCnAgvUeFlSs
 BQeWB1WnEpQkmYwelh1yNntE9S18uJ5g9aLrDaronEvqMj8mjEZ/9byYfGXGu8MYoY9P
 voeyxOx6lmH9rZBxouS7ih9BQAMRWzfgySar8Swiu5Gt4wNB7re7zr4X4tsUfmQIfMDr
 XmpM9YIpq8iCSpLBMytP9gEeicyk8BUChT82QY5AejVDXLS5bbr1ny5W/0XzgEsGX/Tc
 ufqQ==
X-Gm-Message-State: AGi0PuZmmjHl537XeQ0QWiOicsbCWkNDI56PgE0t73rkgpeGkd0bH1WI
 QFMqtPwC6wtFv8PhRbzTChnC43DxRc4=
X-Google-Smtp-Source: APiQypKZ/EJWB1Q8+JY9/gHifqgKo3+6jEig1OJGDmu/J6tKZAk4HR4KkmJZ644+QMMtaDQtV/QGuw==
X-Received: by 2002:a5d:69ce:: with SMTP id s14mr1075308wrw.413.1586466941366; 
 Thu, 09 Apr 2020 14:15:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 127sm5440743wmd.38.2020.04.09.14.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 14:15:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C14B21FF96;
 Thu,  9 Apr 2020 22:15:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 08/11] target/m68k/helper: Fix m68k_fpu_gdb_get_reg() use
 of GByteArray
Date: Thu,  9 Apr 2020 22:15:26 +0100
Message-Id: <20200409211529.5269-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409211529.5269-1-alex.bennee@linaro.org>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since a010bdbe719 the gdbstub API takes a GByteArray*. Unfortunately
we forgot to update the gdb_get_reg*() calls. Do it now.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200409172509.4078-1-philmd@redhat.com>
---
 target/m68k/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 014657c6372..cad40838956 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -109,8 +109,8 @@ static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
 {
     if (n < 8) {
         int len = gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
-        len += gdb_get_reg16(mem_buf + len, 0);
-        len += gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);
+        len += gdb_get_reg16(mem_buf, 0);
+        len += gdb_get_reg64(mem_buf, env->fregs[n].l.lower);
         return len;
     }
     switch (n) {
-- 
2.20.1


