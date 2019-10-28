Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89978CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F5F217D6
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d26sLpzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F5F217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6hP-0006Xc-Qt
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Us-0007Zc-4l
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Uq-00046R-SQ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iP6Uq-00045p-MU
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:52 -0400
Received: by mail-wr1-x431.google.com with SMTP id a11so10230997wra.6
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jWCHT8imM+uT8t8z8pCnUo/8+221GMTt3GzK0VnZBfQ=;
 b=d26sLpzvhO1E0TrFTuZ2mirSgGGVKv7FsN+fUq7Nuv0yhm3H66dT9psyNGbt6GMWuK
 V4fNkiNB1af8og4AcJ6kK57qpfXE95EFQRVRd0iHdeqSpmBUsmFnoQ4pYs5vard1I/AX
 2mYk0yQapIsCZv7UPguJS3RoNq8rs5YjgCEEm2EY1pQ6SEEMwPiww+bcoG65R/CJCBSM
 NDDNP+Qo95IqEVE33peYRyeinKgs+kFdAq+wN5E+26uk5CFMWRFd1tla5kchCbAMHewg
 sIgHKKEwV0mNOnOvlxDf4VvNgQnDrQEWx8RzgmOe8LuF7uydkX6tXZ9XZaLHsF8u1ENd
 KVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jWCHT8imM+uT8t8z8pCnUo/8+221GMTt3GzK0VnZBfQ=;
 b=N3hMSe0EU+ZkTZEHtzlEWgR5TxC9vrOo2XMD2dwtiVvr1Q8TRMgiXVDD5P3jQl/UMc
 Ov3OEA1ZdIiSactNlfBqyJR7sWrXjvfH/abVRAR+KVPTIPh17B7R2w8TPzEC6ohKLdbj
 XLw+xhsLaKKHhyoaG4IwGrrw58sosbbQG7j9bs+DllGszZhkbckPCXJbM5NtrSU6+vWj
 F2M9LK/Q36b3hOjYNiaHgWHdU0EtLLN9ba8OkTNBRB5T97yJhXZKicdpS+2fewA2Co5o
 wbqqRALkq5iT1Z/YXgtusl8iZna3tKbUj6Gf69RMf0KwJNU9vJBo26rYjpc602Ep2TOj
 KZ/g==
X-Gm-Message-State: APjAAAXTx0HlLoGI+ohHok5d6eN7aCEfMGW0FOOVI2pip6cP9bKDbVA/
 q+fajXMwbWsM1se7O92xPayfp3wYg8kWug==
X-Google-Smtp-Source: APXvYqwSA4TcElajz+0RgleTlAcwVr0JGBhIdgpBC/Tyf9sV2rZVBA6Xr6XttqSCSHDPE8XeBilOog==
X-Received: by 2002:a5d:6747:: with SMTP id l7mr14797530wrw.328.1572274790726; 
 Mon, 28 Oct 2019 07:59:50 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net.
 [88.138.106.230])
 by smtp.gmail.com with ESMTPSA id 143sm14842876wmb.33.2019.10.28.07.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 07:59:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/12] translate-all: fix uninitialized tb->orig_tb
Date: Mon, 28 Oct 2019 15:59:36 +0100
Message-Id: <20191028145937.10914-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028145937.10914-1-richard.henderson@linaro.org>
References: <20191028145937.10914-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org,
 Clement Deschamps <clement.deschamps@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Clement Deschamps <clement.deschamps@greensocs.com>

This fixes a segmentation fault in icount mode when executing
from an IO region.

TB is marked as CF_NOCACHE but tb->orig_tb is not initialized
(equals previous value in code_gen_buffer).

The issue happens in cpu_io_recompile() when it tries to invalidate orig_tb.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Clement Deschamps <clement.deschamps@greensocs.com>
Message-Id: <20191022140016.918371-1-clement.deschamps@greensocs.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 66d4bc4341..f9b7ba159d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1722,6 +1722,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cs_base = cs_base;
     tb->flags = flags;
     tb->cflags = cflags;
+    tb->orig_tb = NULL;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
     tcg_ctx->tb_cflags = cflags;
  tb_overflow:
-- 
2.17.1


