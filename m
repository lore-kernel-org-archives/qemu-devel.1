Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF30C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8046A222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gN1LN8vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8046A222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtgn-0001Df-CB
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWg-0003u5-HM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWf-0001G8-9F
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:26 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtWf-0001A5-08
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:25 -0500
Received: by mail-wm1-x32d.google.com with SMTP id m24so4960932wmc.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uLKaiiVcWx70eG0qkNbXF+zMJscr1d+jtw4eifA48Xc=;
 b=gN1LN8vooBN7X/EDhpq1QpMUPDE6G8qMh6rpyNzcJSlQ480NdO4ap8W615ibJn6ekE
 +XFcQiCMxDIeOXdVmVEmktX2Q+bt1E7bRpRpxAWNKfLEKvX05j+fWCGSxZNOMP3geCEo
 fJkQDVB0ViPpz4u9Y2irlLaGt2UbQM9sDeaCk1yMvDgHzV4BgmGVVfr5C8ZHE7ujdntW
 JvmWN1w0ZGcd7giCvE6xAUEw0H43r2WaO5odMmb+eRhhn3zdYBZIfZhyxVc4KzCUDY5R
 W6zJlFXiWHSbVAWt523ebGjrGHqWbxGr5vLFXaEiy/lKlDx6AeeM6orKN9gbHXK428b/
 /2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uLKaiiVcWx70eG0qkNbXF+zMJscr1d+jtw4eifA48Xc=;
 b=EycCdFD++7h97fyQFYr4QeQfR/x9FSy27eka7NHHEEIh8Cuxt8LyZ6vclXMWcZ6l49
 kQfZzdML01qb+XB98kXY1pun7maqaCK2b89SgtKDdeica8Fz/vDpcSeZ7CYC9pHLxQ0p
 BwMvpB62YJBlsHoENT5EWOO12RJoCNVI4bMX65EgebCuVzQUoU+yF9G49eSGhqcLgVLv
 RaQGLT2I6SLmKZBiq+StArIXfIGtygopq/GL2ePJfIRsnmrOBgExhF3K+QbD+bcgu6Xr
 PVjJFyr/GGyowbvBv50ESVYlmd/dG7VkOV/AAOkFip1X4g3LO1L58dI8KxEc5wcbDljK
 oPsg==
X-Gm-Message-State: APjAAAV29IFKjo+tU2D0eYEUc6frEa8f0b5U5qW8RrP+IhVd4E1DNLFt
 v/AC43Y9Rq0NpGro2tPjAtVBzA==
X-Google-Smtp-Source: APXvYqwnaE5sMeLuoo/v5TTY3yD+2d2J1CbG209PjiTK+beCUxeE0Swy6AeYffsmCIp30AmnfrpNag==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr9067854wma.106.1576753163816; 
 Thu, 19 Dec 2019 02:59:23 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y20sm5545442wmi.25.2019.12.19.02.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:59:19 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BB09B1FFAF;
 Thu, 19 Dec 2019 10:49:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 24/25] trace: replace hand-crafted pattern_glob with
 g_pattern_match_simple
Date: Thu, 19 Dec 2019 10:49:33 +0000
Message-Id: <20191219104934.866-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already use g_pattern_match elsewhere so remove the duplication.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20191205122518.10010-7-alex.bennee@linaro.org>

diff --git a/trace/control.c b/trace/control.c
index d9cafc161bb..0fb81241607 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -98,38 +98,6 @@ TraceEvent *trace_event_name(const char *name)
     return NULL;
 }
 
-static bool pattern_glob(const char *pat, const char *ev)
-{
-    while (*pat != '\0' && *ev != '\0') {
-        if (*pat == *ev) {
-            pat++;
-            ev++;
-        }
-        else if (*pat == '*') {
-            if (pattern_glob(pat, ev+1)) {
-                return true;
-            } else if (pattern_glob(pat+1, ev)) {
-                return true;
-            } else {
-                return false;
-            }
-        } else {
-            return false;
-        }
-    }
-
-    while (*pat == '*') {
-        pat++;
-    }
-
-    if (*pat == '\0' && *ev == '\0') {
-        return true;
-    } else {
-        return false;
-    }
-}
-
-
 void trace_event_iter_init(TraceEventIter *iter, const char *pattern)
 {
     iter->event = 0;
@@ -148,8 +116,7 @@ TraceEvent *trace_event_iter_next(TraceEventIter *iter)
             iter->group++;
         }
         if (!iter->pattern ||
-            pattern_glob(iter->pattern,
-                         trace_event_get_name(ev))) {
+            g_pattern_match_simple(iter->pattern, trace_event_get_name(ev))) {
             return ev;
         }
     }
-- 
2.20.1


