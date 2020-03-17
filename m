Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC949C5ACD8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA5320714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWYoO7GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA5320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGPo-0005fr-Ja
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMx-0000Qd-UE
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMw-0002go-RD
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:11 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGMw-0002cI-K7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id b2so20645168wrj.10
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9z3Uw6JkfA9R4iTRQFeCE4m8VzCTOvZfkwPbB04egSU=;
 b=DWYoO7GSUX2ngYSrdSeftZtjpURerAKPdm5tEAA3NXIx8m8gYKyUiXQ7GgcZ+KcAN1
 osSKJRFgXN2dU85U1TAY9gkVYCmyEZYHAX1MeJikZqy4zNtfBnqTOLt5rmJNgmCI939B
 p6EpMCtX81b/IRmAfqgAQYgOK47Q+VduHF7ySv4BtJFT9TCbpqffPelnP/xiots34GZa
 gjtSYC312lw7l1mwxzNq3+Qka4KAoM4fdJIPxAr3KvGo2IVgGMOVD0UVv5+bfiQ6Z2jN
 S/dzN2PKUm/sF4bbz4luvnMllEQFiJIjmg8+48RIT7kWHpyA/jUYC3l1pWyd9xdVAAJW
 kLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9z3Uw6JkfA9R4iTRQFeCE4m8VzCTOvZfkwPbB04egSU=;
 b=npKLHpCkConTa/1jOVjTSk4+vneSQV1Lz07G6cLeOaHpyWLQKdo6C7C1ntvh0+nvVO
 TDv0rftIXhtRn0B6/V3W4kJ6WrFEsdgp7utdiLYkBNldPDyjw4RB1zKReb9NmViMkQwz
 t8BbJSUWYtYIWQkImBXU9NG+1T/bpqlNstvd6g6taKzvWdliy/vYou3vJIVHX7rSpdWU
 SrkMT+BVVCzPP+GluLTayUAmJbVp9TgpRSz3ZRw11zgi72/tgdvJIkcp24FqUlM04EoP
 vtFPgVt1PHZr/kBQnuB7tyeDiiGWhDYpWcMz5xppfsh5ChGwE5tTD8zvsLTRQEZntwGB
 sEMA==
X-Gm-Message-State: ANhLgQ2A0Z+SddtNuQ4A7+3ACU60LNP2D5/8K03HG2yG5IwxTvzICQf7
 GIFBT0OQaO/dxO790nr9ShGIdw==
X-Google-Smtp-Source: ADFU+vtPyYj9Thfc+7GdQYBR+Fxh3YQwIpi3qyMifni6S//xF5CN6Fz9dyj12MKKZ+UmxoKVquLW0w==
X-Received: by 2002:adf:f30b:: with SMTP id i11mr180722wro.224.1584467469644; 
 Tue, 17 Mar 2020 10:51:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r3sm3817870wrn.35.2020.03.17.10.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:51:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 319A21FF99;
 Tue, 17 Mar 2020 17:50:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/28] gdbstub: add helper for 128 bit registers
Date: Tue, 17 Mar 2020 17:50:35 +0000
Message-Id: <20200317175053.5278-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200316172155.971-11-alex.bennee@linaro.org>

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 08363969c14..59e366ba3af 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -102,6 +102,19 @@ static inline int gdb_get_reg64(uint8_t *mem_buf, uint64_t val)
     return 8;
 }
 
+static inline int gdb_get_reg128(uint8_t *mem_buf, uint64_t val_hi,
+                                 uint64_t val_lo)
+{
+#ifdef TARGET_WORDS_BIGENDIAN
+    stq_p(mem_buf, val_hi);
+    stq_p(mem_buf + 8, val_lo);
+#else
+    stq_p(mem_buf, val_lo);
+    stq_p(mem_buf + 8, val_hi);
+#endif
+    return 16;
+}
+
 #if TARGET_LONG_BITS == 64
 #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
 #define ldtul_p(addr) ldq_p(addr)
-- 
2.20.1


