Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76299C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B4A721855
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J93qOcmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4A721855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44213 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCRRr-0004vs-Gw
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 12:12:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQY-00047x-7k
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQR-0001qN-Pf
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hCRPf-0000Ox-EW
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:40 -0400
Received: by mail-wm1-x341.google.com with SMTP id 4so7294842wmf.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=HwAzUy9jgueFnDzBLUqeKI7O6SSf30iPm3xF3eIhtAg=;
	b=J93qOcmw+McO/t+WTf3A2QIJZenY7P9X+Y16pGK6S/jg/w09BCbf+0tNpAJR3KOaNp
	53zpd9vU2KozDJYdQaXrJwuVm5ZM3o4sLMwcLrPS4N2AvdugpwrcWMKCUAHjnKPi+Tat
	gedjjBwcfvxF5a9yK4tYQQHFXPWk2qkHKn5xOTooRVdwAbdp0pzvtVNl5fuWLAadyTxf
	KIS88bW7JREvmCk7T8cxzuY8PeJO7DvYM6UoLzk9qazG8HGOCJ0wnWN7UR9U9MZA4xDv
	fa/YJWXXBHKUWXzWq4pi6PuITwh03DyEhU2Zwu9BtkQKhcuVdGqysRIbKKEZ0LqIa7ZZ
	9uBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=HwAzUy9jgueFnDzBLUqeKI7O6SSf30iPm3xF3eIhtAg=;
	b=V+reXSFxBIcFMfEHcpm0X2YzYO56HlT2Bdbta1ZDBB/xGfIMVYPXGjGUGNj+6/Yq+3
	bt8PgNOqg1YijXM1Kch1BSzQct7iUwhOf1vLOhxkt/vhTeOVDY3kq08tPQdSLYBLwFg2
	/SxJY/NDt6Mr7yPrUVD0pZWHAmrUvHfRiSzJoiGktnucq3nZNGxwSbcJWKfV/Af7uI4j
	xRSxyOQbNABTVEFa4AZojQz+MUYDMEVfPG7WxfP9+DajM8YR/KtaFKfVY0B/EL6qJk/Y
	7WoSSy4E8SE9YuuR9Vc/K7kExivdMlm8MVasMtz7p1Z38xKsBDSeS9C69Cu6LJhXnYWg
	gn+g==
X-Gm-Message-State: APjAAAXwvuTjWXgkzUoV+BV3HExCoeGfBtuJrjxnJwnOKWWkUMO+0nVb
	7tozlsJHy2jBg04O/S2BlRi7c3w=
X-Google-Smtp-Source: APXvYqzPArFMT/GYeNbeeCxrZbq5nOv+si2s3Vk7oUGbAq784yTT55yN2AZKEoEHzKP+HFaJym7n6A==
X-Received: by 2002:a1c:35c3:: with SMTP id c186mr8393272wma.135.1554480593843;
	Fri, 05 Apr 2019 09:09:53 -0700 (PDT)
Received: from ninjatsu.lan (host-2-103-80-5.as13285.net. [2.103.80.5])
	by smtp.gmail.com with ESMTPSA id
	z10sm2966029wmi.15.2019.04.05.09.09.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 09:09:53 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
To: amarkovic@wavecomp.com
Date: Fri,  5 Apr 2019 17:09:37 +0100
Message-Id: <20190405160938.27494-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405160938.27494-1-jbi.octave@gmail.com>
References: <20190405160938.27494-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v3 3/4] target/mips: wrap lines to fix
 checkpatch errors
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405160937.AW_u9eQawOoe_nxUqa9rmM4YEKu-Wxt5k1Uu73aO31o@z>

Wrap lines to fix errors issued by checkpatch.pl tool
"ERROR: line over 90 characters"
within "target/mips/cpu.h" file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 target/mips/cpu.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 0d2718d7bf..e2f421359a 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -72,15 +72,28 @@ struct CPUMIPSFPUContext {
 #define FCR31_FS 24
 #define FCR31_ABS2008 19
 #define FCR31_NAN2008 18
-#define SET_FP_COND(num, env)     do { ((env).fcr31) |= ((num) ? (1 << ((num) + 24)) : (1 << 23)); } while (0)
-#define CLEAR_FP_COND(num, env)   do { ((env).fcr31) &= ~((num) ? (1 << ((num) + 24)) : (1 << 23)); } while (0)
-#define GET_FP_COND(env)         ((((env).fcr31 >> 24) & 0xfe) | (((env).fcr31 >> 23) & 0x1))
+#define SET_FP_COND(num, env)     do { ((env).fcr31) |= \
+                                       ((num) ? (1 << ((num) + 24)) : \
+                                                       (1 << 23)); \
+                                      } while (0)
+#define CLEAR_FP_COND(num, env)   do { ((env).fcr31) &= \
+                                         ~((num) ? (1 << ((num) + 24)) :\
+                                                          (1 << 23)); \
+                                      } while (0)
+#define GET_FP_COND(env)         ((((env).fcr31 >> 24) & 0xfe) | \
+                                  (((env).fcr31 >> 23) & 0x1))
 #define GET_FP_CAUSE(reg)        (((reg) >> 12) & 0x3f)
 #define GET_FP_ENABLE(reg)       (((reg) >>  7) & 0x1f)
 #define GET_FP_FLAGS(reg)        (((reg) >>  2) & 0x1f)
-#define SET_FP_CAUSE(reg, v)      do { (reg) = ((reg) & ~(0x3f << 12)) | ((v & 0x3f) << 12); } while (0)
-#define SET_FP_ENABLE(reg, v)     do { (reg) = ((reg) & ~(0x1f <<  7)) | ((v & 0x1f) << 7); } while (0)
-#define SET_FP_FLAGS(reg, v)      do { (reg) = ((reg) & ~(0x1f <<  2)) | ((v & 0x1f) << 2); } while (0)
+#define SET_FP_CAUSE(reg, v)      do { (reg) = ((reg) & ~(0x3f << 12)) | \
+                                               ((v & 0x3f) << 12); \
+                                     } while (0)
+#define SET_FP_ENABLE(reg, v)     do { (reg) = ((reg) & ~(0x1f <<  7)) |\
+                                               ((v & 0x1f) << 7);\
+                                     } while (0)
+#define SET_FP_FLAGS(reg, v)      do { (reg) = ((reg) & ~(0x1f <<  2)) |\
+                                               ((v & 0x1f) << 2);\
+                                     } while (0)
 #define UPDATE_FP_FLAGS(reg, v)   do { (reg) |= ((v & 0x1f) << 2); } while (0)
 #define FP_INEXACT        1
 #define FP_UNDERFLOW      2
-- 
2.20.1


