Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89CDC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF0E20857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3iTwHzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF0E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXDH-0005uv-Hl
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUX7N-0004s2-6m
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUX6P-0007sc-Dv
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:58:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUX6P-0007rq-1C
 for qemu-devel@nongnu.org; Fri, 01 May 2020 10:57:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id x25so6196790wmc.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YNX+/fnT88Z/wFzIjWWLDF8jEJXh9RNje7+wEwFPi9I=;
 b=Q3iTwHzAY60My2NsA7gGW+zj0hgk2I9AFDcg02zXyCWclGkvZ0/5P4uqtJb23g2NNs
 wWd2sfB3C2K6ccvAkc6WhsrJhgoHdTozpmjrwN0/i5oO6gswCpAdoptaX+xga8Hw3xy7
 lJ2t2RJNGr4vTsRxyisRkaQcREPdHGaP4UNKhzAgjoWvQzIljC2g1goJM7b9tOZrtMQ1
 +jB+u0qVzI5RHLWBAnnZXgLXMBqQ+btiEsepTEucnH802klgEmuk2tfI9uz7osr4LUev
 Qbo38bW60zh2uIjDhKP0YAX3jgfaeADNcWgGcEGow5Vkm4eYl7p0zRqXpjqX8mby6S/F
 EVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YNX+/fnT88Z/wFzIjWWLDF8jEJXh9RNje7+wEwFPi9I=;
 b=gq3xzDE3l034DrXp8J5tC9p/6BdlomhAPsyiVjvksQisU4YoqvWABLKqzXMVLWza8n
 mbOgBq+jwHnxVQHwm6nsNBKXgVLDnLSDfiP/iwRUUWaRzynCGk7mneL8JqrCVu3mq9eF
 6pyYun73cE5efN0AVo4VbU6fiqzswpNEgZyv4Z8lVG7tl5To8q+vjCoAPLQQAnBGYa+t
 uPJ1ioNqSgUGmZWB/CUrMrFGagjGGAWYLpJ2jRDiz8kxG4lHxKWcu9YcTNumIF3xDX69
 gzhgdYbOJ59p22utgnDkrXbIohwsD8iOKGLBKilHu2/GLozS1i6SQx42xo4Q/Qnk89TP
 BncQ==
X-Gm-Message-State: AGi0Pua4OsdAVa6MGqI3zpenb49o/AK2nDS2qGuLRO5Mm60j5F+r85gW
 ZKeT0udTDCl52E7fxLOh589uvM+bOyY=
X-Google-Smtp-Source: APiQypK426Gb29HWddBA1GkB7fDbydTvEX/jkzHGGih6hNZdyDZotRlEsEwMXFY4Ur2bDpYDXXrdzA==
X-Received: by 2002:a1c:80c3:: with SMTP id b186mr4731563wmd.117.1588345039647; 
 Fri, 01 May 2020 07:57:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z16sm5103214wrl.0.2020.05.01.07.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 07:57:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6DCF61FF90;
 Fri,  1 May 2020 15:57:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 4/7] accel/tcg: don't disable exec_tb trace events
Date: Fri,  1 May 2020 15:57:09 +0100
Message-Id: <20200501145713.19822-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200501145713.19822-1-alex.bennee@linaro.org>
References: <20200501145713.19822-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I doubt the well predicted trace event check is particularly special in
the grand context of TCG code execution.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/trace-events | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/trace-events b/accel/tcg/trace-events
index 01852217a6..385b9f749b 100644
--- a/accel/tcg/trace-events
+++ b/accel/tcg/trace-events
@@ -1,10 +1,10 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
-# TCG related tracing (mostly disabled by default)
+# TCG related tracing
 # cpu-exec.c
-disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
-disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
+exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
+exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
+exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=0x%x"
 
 # translate-all.c
 translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
-- 
2.20.1


