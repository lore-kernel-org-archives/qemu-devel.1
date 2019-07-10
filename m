Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FE8C004EF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B2D20665
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lIXILrVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B2D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl9rJ-0005SX-DA
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 06:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41735)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hl9nk-0001J4-Qg
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hl9nj-0000m4-IM
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:26:16 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hl9nj-0000QF-8A
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:26:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id f9so1821865wre.12
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 03:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2xglArbFUfwd3/IFA91rmfZG+5etlym8PqDYDWRMM+M=;
 b=lIXILrVIrja/6LD0fWFP/pJct/hfmtiq9zHnk1fZ9I9H67NADezkqr7abp8xDvnH13
 sIUTYWR9V//i7zttXEu3japECj7zzInkcg4IQS5AaWFYrPUP2RW9bZxtHz/CPBx31Egk
 ZddJmzQcBuwRaCcezDw8ygHQ7rRCQ99VTgAh7eJ35maFiGwFWCetxl4HYZ6+Oc/6Cgoi
 RpgA+oS2W7m/7SSkO/9Ze1Bwffk9SNyBHiPQwIVngXa53LhTpwZEab7dE971lEARn/ZH
 e6DJu1AMooy2x8RcwrV4exL/qhxf68wwlKYFEgLRUYQ3tg27RfFDrpqLyVPE9I2SFudR
 QuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2xglArbFUfwd3/IFA91rmfZG+5etlym8PqDYDWRMM+M=;
 b=rMAS7Z6RDkUKqWj8hh8OJTqX4akqhN+hsnpKsqtcJQZagFtULYeCOcecUfhMkQGiBL
 ekoMj1EGXda0d0UUKKwGUDJXjrAiiWJmZdQXJYtL9v2yCYtGd6b3KTo7T9jkBxtyQWEU
 hc7NmniSMplSgZXl6161iY+Dfs8+j5VIi4dUGY0UwVP1GwWGuHKWA4RdFyfIIMwEQgct
 SuwwCOV97tpzzgRjUHtx9JHFltH375MMyMJuxTE/7F/KkRddOhtJN9p8TOJzaKtuvnAp
 fBLwgPeZxBQmVGSHcTgu75DFrnRmvdOHas2/uWgVq8qXnr/GurPnybLsgB+jSx9FYM9a
 9HUw==
X-Gm-Message-State: APjAAAVytSTTxcdq2GgiPUihRxIbYOV+JZvPu4d7sp2mcjnAHxx2ua9y
 sHxyBAJ35Hz1+PI/V281hN3GQw==
X-Google-Smtp-Source: APXvYqwuW8n3QeE0k2P0biyKm2koBbYc5zxK7caNiHMBpWvfN5i+CSOu57vyEEykMT8pk4MC3Ln3Nw==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr30565732wrq.308.1562754361296; 
 Wed, 10 Jul 2019 03:26:01 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s25sm1575252wmc.21.2019.07.10.03.25.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 03:25:59 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1676A1FF91;
 Wed, 10 Jul 2019 11:25:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Wed, 10 Jul 2019 11:25:57 +0100
Message-Id: <20190710102557.3107-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710102557.3107-1-alex.bennee@linaro.org>
References: <20190710102557.3107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 4/4] gdbstub: revert to previous set_reg
 behaviour
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
Cc: Jon Doron <arilou@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The refactoring of handle_set_reg missed the fact we previously had
responded with an empty packet when we were not using XML based
protocols. This broke the fallback behaviour for architectures that
don't have registers defined in QEMU's gdb-xml directory.

Revert to the previous behaviour and clean up the commentary for what
is going on.

Fixes: 62b3320bddd
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Jon Doron <arilou@gmail.com>

diff --git a/gdbstub.c b/gdbstub.c
index 8363683852..b470aec8ea 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1673,12 +1673,23 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+/*
+ * handle_set/get_reg
+ *
+ * Older gdb are really dumb, and don't use 'G/g' if 'P/p' is available.
+ * This works, but can be very slow. Anything new enough to understand
+ * XML also knows how to use this properly. However to use this we
+ * need to define a local XML file as well as be talking to a
+ * reasonably modern gdb. Responding with an empty packet will cause
+ * the remote gdb to fallback to older methods.
+ */
+
 static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     int reg_size;
 
     if (!gdb_has_xml) {
-        put_packet(gdb_ctx->s, "E00");
+        put_packet(gdb_ctx->s, "");
         return;
     }
 
@@ -1698,11 +1709,6 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     int reg_size;
 
-    /*
-     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
-     * This works, but can be very slow.  Anything new enough to
-     * understand XML also knows how to use this properly.
-     */
     if (!gdb_has_xml) {
         put_packet(gdb_ctx->s, "");
         return;
-- 
2.20.1


