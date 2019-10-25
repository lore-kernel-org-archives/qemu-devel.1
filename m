Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0608ECA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831BE21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+vrO2MI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831BE21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNthf-0003OM-UP
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWW-0003EK-HU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtWV-0007bX-Aj
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtWV-0007Z1-35
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:56:35 -0400
Received: by mail-wm1-x32b.google.com with SMTP id p21so809691wmg.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ARdcrEhdcWtFfl52Az/c8K3t0fy2I7ICblv42Psekak=;
 b=e+vrO2MIyhFMxPEB1Oau06arYJkfr516sbLEQhJS/M7YK6z1PspKhe4VuSzgjcdERd
 /ub0RUvlAV9S+7ThGXabpaxGHqgXCEO1owMugwt+jGaziRXyDZxnW/jA6z85SHCWjorG
 KeMrHWSLdDU0qF0izLYu4DhRnSOy6E+SwdFAUbUY3NOILIsuZW3xITkaNQgb9ogHmaSc
 5bIUCXYIW0zrPLJh7nVXQ24JS/AXqYaQQ1PoZwfrilz0hlnRyPq1hI11Jw9F+NBmMGEd
 OHI1iNvNCZMaDidi3e6i4r3OCYRoSCMlun/b4472oP3bcjRIViWCn2w9wpD58Li3uBaO
 /GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ARdcrEhdcWtFfl52Az/c8K3t0fy2I7ICblv42Psekak=;
 b=U7a57fBKbfQ5xoh0C2EPKZ77/Trnt44JH75dNqsKRIYRGZu8pWpmHwLn6zwXqx3AnD
 LctjGLLmdAhP2S9wR+Dkmlo/qtSNccmiRd3W/FDyNyFt1IUbDlQ2AvfB/eNnKODS7i30
 Oq4wOyIY64MpssClP83Dy2KRD6Ue0f2OysxKNSc4l2gXYzMYKQP33rvMJ5m0k/08ubmJ
 C4Ht5WBnww0mou0oYStRY5V0RniRSvix0UqWT0h2w/svyu97O3hkkHb5UewPZnaTuGQT
 jkaRgHGlsedmwOmXZek+f4TOZbLiuaVPj6/s+AxWC9Pq5pKEoaUjSMSJM8Pv7W5G63ja
 g1bQ==
X-Gm-Message-State: APjAAAWPTjxZnIySyNAgZPmrdZqi3f3JTyqYgZjkVSE8YKJJZGbZgYog
 iH3DMv0YHuMLaXZncUvPfDFl2A==
X-Google-Smtp-Source: APXvYqxn3FDn46qYAvySqWZoc1uchPcyVESW79MOz9kF2xtfIlNrJ+SF2hZ54PlaJYSi8xaKVP9COQ==
X-Received: by 2002:a1c:5641:: with SMTP id k62mr1916872wmb.97.1571986593641; 
 Thu, 24 Oct 2019 23:56:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a71sm1205364wme.11.2019.10.24.23.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:56:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A89C1FF8C;
 Fri, 25 Oct 2019 07:37:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 25/73] queue: add QTAILQ_REMOVE_SEVERAL
Date: Fri, 25 Oct 2019 07:36:25 +0100
Message-Id: <20191025063713.23374-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This is faster than removing elements one by one.

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 73bf4a984d8..4764d93ea3f 100644
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


