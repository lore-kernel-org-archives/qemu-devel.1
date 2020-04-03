Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E34C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFD720737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mnN0kuMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFD720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRqz-0005Bz-TZ
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRja-0003Sj-8N
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjZ-0002QU-8s
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:06 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRjZ-0002Pa-1g
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:05 -0400
Received: by mail-wm1-x341.google.com with SMTP id t128so8281811wma.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BnraU9e2QlfXAnwDnsquPq2nPEANf8Vm3M5lpPbQw3c=;
 b=mnN0kuMJWeH2jNmYRvBwWcMWl9zT59HHmZ0M9fZBR3G4+3+vM5nUyBpmtYrbb2oxLd
 HsRLIU+P0k5W7bH3PX9QwtBqo6PQHjBQKm9imnkIlVI/fDvi/5VyDJ8UahZOVxSUj81I
 ZEapBaVrfvVZSwTjRCq+8AWAer+VHULRUjdPpO2FwPzbR2OCg4hViVK6z+BPCS68kHiY
 IIDSKzkx3qXTsLRm7GL3TUzpC6ZlXp+Qie23Y+XCX8q1UuXMsYwjW5M7KinrHmf1vVRe
 DcOe7BKOUmVrTyC9lQWEr0fntyeSSq5kSb7rclEDoP4dSW/NJuhMueod7ger7YvjGrkQ
 zJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BnraU9e2QlfXAnwDnsquPq2nPEANf8Vm3M5lpPbQw3c=;
 b=Y30hlB5cS2s5TeEQSYVVboN22S8f98DAJZsH9KDqyu5ikhDGUsDIjz5KM1W8JvEu9v
 caqKTaJZi4ZmLQ/hlsCiHLpRBekK4s4ySSjzxp6rT93T8TFeWy+x2IQNTO1FERhPmEa7
 pRz6OcqA99hoaEciqddWBsA9Lr9V8RXuwWCoOOlxproml9id8Uutw9l9pFVptSJ8DU5a
 KlS2uQseWIHB0/6Z0tmod+4/wTeJwQZlHBAtnuZIngE+UMVbTmeVhr2lvOf5krwZefSx
 etT3HD4TZnhsi2alkjNBVYR7Pd+V2xHWNZp9Wtm5gCd11sIYQQrnTPutN5v/yQuBliXY
 jIyg==
X-Gm-Message-State: AGi0PuaQm1/B4uIfiq7GUsVqbDQGE7/zdn7oV6SLMklBKnT7GMXUeVwW
 LCUkp5zuFcSRscebDCH53529LA==
X-Google-Smtp-Source: APiQypL1H+tX9Q6efzFWQ5HFlYboOz2mWWgstd2kz6XQyRYFVpI6PdoSDDLq3bkGHzQhg15js3iBUw==
X-Received: by 2002:a1c:e055:: with SMTP id x82mr9953081wmg.20.1585941124055; 
 Fri, 03 Apr 2020 12:12:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b187sm13626896wmc.14.2020.04.03.12.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 94EF91FF99;
 Fri,  3 Apr 2020 20:11:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 10/12] target/arm: don't expose "ieee_half" via gdbstub
Date: Fri,  3 Apr 2020 20:11:48 +0100
Message-Id: <20200403191150.863-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403191150.863-1-alex.bennee@linaro.org>
References: <20200403191150.863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While support for parsing ieee_half in the XML description was added
to gdb in 2019 (a6d0f249) there is no easy way for the gdbstub to know
if the gdb end will understand it. Disable it for now and allow older
gdbs to successfully connect to the default -cpu max SVE enabled
QEMUs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/gdbstub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index d9ef7d2187c..8efc535f2a0 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -192,7 +192,12 @@ static const struct TypeSize vec_lanes[] = {
     /* 16 bit */
     { "uint16", 16, 'h', 'u' },
     { "int16", 16, 'h', 's' },
-    { "ieee_half", 16, 'h', 'f' },
+    /*
+     * TODO: currently there is no reliable way of telling
+     * if the remote gdb actually understands ieee_half so
+     * we don't expose it in the target description for now.
+     * { "ieee_half", 16, 'h', 'f' },
+     */
     /* bytes */
     { "uint8", 8, 'b', 'u' },
     { "int8", 8, 'b', 's' },
-- 
2.20.1


