Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93D7ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824A92089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANtwZlKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824A92089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5vK-0004D1-W1
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dj-00084v-9v
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5di-0005TI-1M
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:26 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:44360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5dh-0005Sg-RS
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id z9so2295786wrl.11
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4u0DAyRPQyWfOOgltou2F/pxj6T1sopcMhD6CsKad8c=;
 b=ANtwZlKjptqrzZntw/imIkxEzMzWSUisY7EV1BEnF/0uwTl3dTLWAGKKv6osJnjR9p
 xqmMvanFuHpDEwIOatSLKhsrSljVKFvXy0a2g5SWOtLIvfTVUpwkQceNVcPnoMO5OE2t
 h6grn74EVcYUcMwwqWrKj7LtjMCrADy0huaTdlrcq2ycir9rL2r5fGyDgGqSVaKe5VsX
 YdQqwRQkOeocY/mngB6BcE7LhPCEzaExQm+OGJndQlj39VWLyxXpCsXjZXs5b2styBTn
 02/zEvKa7EWMTiRM+WjUnJ2X9QlS1IZG1HQX0ZVUlh9/I+WECQB8k62DZf3q9loCvfa2
 ZQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4u0DAyRPQyWfOOgltou2F/pxj6T1sopcMhD6CsKad8c=;
 b=srIFb4Nzck6x3RMMLO0jDUkiKt76a8Dc+2ZNhWq9XwnFU0U+gdJrbrruYV+ai6w+aO
 tueyoojdhNL2JyuSkarYV1J+4vdHvaxxIb1Jf2Ooz5aU1WgouDrhJhKo0kXnKduxHY2+
 00zFQv5m8iLbGAhQ1qTRdtUZfVvEEajoA4Txwoy6jNxy+V/tVlmTco0K2j2fsbhRkI7c
 sLKGlP4w+xml1H2q0FcFffhT8mVSAIT+xKO1doUtgDg2k26vqCyoq5THHe4zC61yI8Yp
 ErZX1P+JyElZxvinaLuwiCOT6fjXWQ9cL1+qkvHvT21MKFpzjq5vPJcRQ3fbqJ/BuYKD
 pXDg==
X-Gm-Message-State: APjAAAW99f/qTzuFDmpr85z8sClBBde385FkYVMfqfBew6pRMzSXwGO2
 YYB/Rg7pNqJvSyhzmDDxvSrWzA==
X-Google-Smtp-Source: APXvYqwaXW1we6RMVa24dBTBgzuUKnhgZTXc4u9seJQGGfI3/2QkcdN6CnLKrzGAgIyirCRcpagKIg==
X-Received: by 2002:adf:da4a:: with SMTP id r10mr3131057wrl.356.1571318184632; 
 Thu, 17 Oct 2019 06:16:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a13sm2245583wrf.73.2019.10.17.06.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD7061FF99;
 Thu, 17 Oct 2019 14:16:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 09/54] queue: add QTAILQ_REMOVE_SEVERAL
Date: Thu, 17 Oct 2019 14:15:30 +0100
Message-Id: <20191017131615.19660-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This is faster than removing elements one by one.

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/queue.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 73bf4a984d..4764d93ea3 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -420,6 +420,16 @@ union {                                                                 \
         (elm)->field.tqe_circ.tql_prev = NULL;                          \
 } while (/*CONSTCOND*/0)
 
+/* remove @left, @right and all elements in between from @head */
+#define QTAILQ_REMOVE_SEVERAL(head, left, right, field) do {            \
+        if (((right)->field.tqe_next) != NULL)                          \
+            (right)->field.tqe_next->field.tqe_circ.tql_prev =          \
+                (left)->field.tqe_circ.tql_prev;                        \
+        else                                                            \
+            (head)->tqh_circ.tql_prev = (left)->field.tqe_circ.tql_prev; \
+        (left)->field.tqe_circ.tql_prev->tql_next = (right)->field.tqe_next; \
+    } while (/*CONSTCOND*/0)
+
 #define QTAILQ_FOREACH(var, head, field)                                \
         for ((var) = ((head)->tqh_first);                               \
                 (var);                                                  \
-- 
2.20.1


