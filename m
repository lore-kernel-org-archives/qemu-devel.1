Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14386C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D897020828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBl0CxhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D897020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOy6-0006B7-1s
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBOvt-0001rW-Qf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBOvr-00059i-PZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:25 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBOvr-00059M-Jh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id l18so2820647wru.11
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZZCLDV01NVJMn0TsI5hdBQQvWUb6UiKnEo9bNWpw6gs=;
 b=tBl0CxhEddlGiVwNHE56dFZ7jFvrV/PKy9CUR5+xDbsa3TyHVlJ3HH/ywnC8rYbWdv
 JxwgZVd48rPZKWkxGRT0aMqXcIEwrJR9yasXb0XgwC0Cle6v5oEn8BAY+PDN6kx5X7xZ
 hfIy4JMckZk5zqRvmBZdyxDgYjDUSGRSklN+JvmIk3RtQ8VvUvEFjbB8un1XeZyJIXlx
 b7oeZQl2Y7VB6gt0E2aBJ1cU2+VJqSifP2yq1iH6JdNgfW2zTXq01PzFLsMFgrcgJfkA
 /180eUFDprD/iTjuS69FN0fEO5DVwBXVzWQFgzuyFeh7KYEzfwpa0YYDcQZKQsY/T3DO
 TmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZZCLDV01NVJMn0TsI5hdBQQvWUb6UiKnEo9bNWpw6gs=;
 b=ozvv4gf3wyQzpQHvW9EvQt58qMagktCy7cFSpCokBYD7ZlTDsLbbt7Vf1sQ2iVbImd
 m3whBF6r7R6gccAkOoCH07OUZtiLRh7zE3PezOhFIIQhs8QxJV7aT5cPpL/1pHZ/iGs8
 pYeP6V0AcAWsbX2eOUErgiSqetbTRuLPqtstCTaXSsFU8YWLlalGeRY/MGOWp/oRi3zX
 gbV4i4iZ53k+r7hYValrV9Aol3qQxSxRWWSiCk2uFjHipbRp9JjdHWUF5cSGTNvZJ/j1
 nS5TfRgA+L22LuFTEOdH0uIx0SEKcQ8pdq5YFvSVfai2VpHOYh9q86Uynr8wY/w+S6oV
 S6Cw==
X-Gm-Message-State: ANhLgQ0jRfJvTg24ipdimzcBSCV8SqTu5yrQEFn6TnScvk0wOiK9F8v8
 72q54dQrVhwYrKs7OA2YHjbXiw==
X-Google-Smtp-Source: ADFU+vtsQnyxHlmpEoUP5d4tRTGPNNW8JZXLL7OPg+vCcRJCnNBW5fePu0sIXm/i1nICIVihuY6TNA==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr21550944wrl.320.1583785402609; 
 Mon, 09 Mar 2020 13:23:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z135sm868506wmc.20.2020.03.09.13.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 13:23:19 -0700 (PDT)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD33B1FF8C;
 Mon,  9 Mar 2020 20:23:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/5] tests/docker: Update VirGL git repository URL
Date: Mon,  9 Mar 2020 20:23:15 +0000
Message-Id: <20200309202318.3481-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309202318.3481-1-alex.bennee@linaro.org>
References: <20200309202318.3481-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

freedesktop.org is moving to a GitLab instance,
use the new url.

- https://www.fooishbar.org/blog/gitlab-fdo-introduction/
- https://gitlab.freedesktop.org/freedesktop/freedesktop/-/wikis/home

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200212202709.12665-2-philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 3b860af1068..b67fad54cb7 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -27,7 +27,7 @@ RUN apt update && \
         libegl1-mesa-dev \
         libepoxy-dev \
         libgbm-dev
-RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr/src/virglrenderer && \
+RUN git clone https://gitlab.freedesktop.org/virgl/virglrenderer.git /usr/src/virglrenderer && \
     cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
 RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
 
-- 
2.20.1


