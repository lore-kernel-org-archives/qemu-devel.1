Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CA3C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C2720737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNCHrUh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C2720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60237 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRpR-0003Lf-Jt
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjV-0003Jp-Mx
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjT-0002CF-H9
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:01 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:38124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRjT-00029U-AA
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:11:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id f6so8896975wmj.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IiHiPfqSf5RxTYVWG0ZPN64iJbsFrXxtKKLhTgnCXm4=;
 b=vNCHrUh14ftnala+hX/PRVKkCzQAHERXu+tCmyveg8c0F7d0dGozNsXPo6JHZz2CJO
 LQyMmzrwElE8jJthxbUrDD2FpUJ/e46imTp+nQxzxPaPuqJUMvHrgnBu6vWnIYJ7Sp0J
 y63xaCmLCrd902cr4slNIll7r6PprV76R2BXW7X/AA58aRKBDb9QDB5WfEeoYiSvWwsa
 g14noLR3rwfvn1uahOsr6bE3KT9t506Vzc8jzJOyQsMJQusq2MAcFHMAf3uxtGOEn8O8
 72j1M3++YAY1qINpwWFOsIgnQFoR12ycrqwylW+zURJ0iqDEV8LELcWA8CWRZXxMw1At
 Tsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IiHiPfqSf5RxTYVWG0ZPN64iJbsFrXxtKKLhTgnCXm4=;
 b=cA9VqL+QYWbdFpsfDJZ6UooJ2263svFwMAuwxGN+wvPKJ+PlKL0V24jxvgjFu74h0t
 XV71u6Nz40GQFEvnv8D9lhPS1hx8MCyJHTgQ3a17NIAmA8YT+4auQ/HXVao3DDyoKxbR
 FfOewYXFfKRXDwMj+DRNXf3+EiJzGiKVR/0OLvtUaA4I9iSQbjvAvh8d5j/CYEokvhMx
 qDLF2d1h6470B6sK8B8yK4n+f8HusHTvj019gr6/YbeDzM78gUX29U81zPTZI7nDbuP2
 N8bD+yctL5NVYDn5l/NiQkxwaK4l+M0+B1Zq+RsfoZqDAoC73XoaeVJJnGtIx0GeBaiN
 Se/g==
X-Gm-Message-State: AGi0PubmZSlGQZWSS3Ym+Tb9jVOXDzLtG/gS6PyoJteqP+NagI9LxYj8
 +hurQOKIij/zd0/tGAARFKUwfQ==
X-Google-Smtp-Source: APiQypI0KEM7HYM5R5g6a9WQq5H1bAAZec2aLY9N5dlDUT0KCnfw2J2dim+KkT0J0wsfhArXU/lzPw==
X-Received: by 2002:a05:600c:218d:: with SMTP id
 e13mr10084372wme.148.1585941118248; 
 Fri, 03 Apr 2020 12:11:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t11sm12997902wru.69.2020.04.03.12.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:55 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 31BAA1FF92;
 Fri,  3 Apr 2020 20:11:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 06/12] gdbstub: fix compiler complaining
Date: Fri,  3 Apr 2020 20:11:44 +0100
Message-Id: <20200403191150.863-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403191150.863-1-alex.bennee@linaro.org>
References: <20200403191150.863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

    ./gdbstub.c: In function ‘handle_query_thread_extra’:
        /usr/include/glib-2.0/glib/glib-autocleanups.h:28:10:
    error: ‘cpu_name’ may be used uninitialized in this function
    [-Werror=maybe-uninitialized]
        g_free (*pp);
               ^
    ./gdbstub.c:2063:26: note: ‘cpu_name’ was declared here
        g_autofree char *cpu_name;
                         ^
    cc1: all warnings being treated as errors

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-Id: <20200326151407.25046-1-dplotnikov@virtuozzo.com>
Reported-by: Euler Robot <euler.robot@huawei.com>
Reported-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 013fb1ac0f1..171e1509509 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2060,8 +2060,8 @@ static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
         /* Print the CPU model and name in multiprocess mode */
         ObjectClass *oc = object_get_class(OBJECT(cpu));
         const char *cpu_model = object_class_get_name(oc);
-        g_autofree char *cpu_name;
-        cpu_name  = object_get_canonical_path_component(OBJECT(cpu));
+        g_autofree char *cpu_name =
+            object_get_canonical_path_component(OBJECT(cpu));
         g_string_printf(rs, "%s %s [%s]", cpu_model, cpu_name,
                         cpu->halted ? "halted " : "running");
     } else {
-- 
2.20.1


