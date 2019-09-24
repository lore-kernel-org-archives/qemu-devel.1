Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EF6C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED89F2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxM6ebf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED89F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtTM-0004UT-Ub
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs5B-0003M3-1C
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs50-0007Yk-UG
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:48 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:37123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCs50-0007YF-M1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:38 -0400
Received: by mail-wr1-x435.google.com with SMTP id i1so3660626wro.4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hyz9bk4RuUadsEQ7ebSCzQj2HLMqLMmwaGBTYzwPdF0=;
 b=YxM6ebf1DdR7DJ3pffm0GCCUuKVqC0zRX7hyMuAnzsycODo/dkQGOIit0WTQGVdAVQ
 E8El4M0iXrqfoHxS4q+eNOQ6ql6zgKLb49GgTg9I6GjdKrh9G2KcLGX9pQ/fozQZWS1g
 fOcjDV7oMgO+KVAPjVkuQ9GlI9BjIWWKi9wjY/yWoRWQYvJUlt6eEWsWeWlUAY901Wrz
 3teAf5UhIeshNf/0PP2AO8837/aYOB5smDMcFMxfC5Q/abghNwkxLq136jjwDGBxQoqH
 E8O0dr4Jp89P7HidCz3dHb9Wh7cHT+bh7ivi112nA7doEwWz9pzq4/JqarOilUU+DitH
 TEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hyz9bk4RuUadsEQ7ebSCzQj2HLMqLMmwaGBTYzwPdF0=;
 b=l04m28fwXrVV9RvNJXJ2n/13xU5DxCOfldzywAhMTpRq+HCGPHxI3daIexhqY8lXOh
 7PvQR2nsn9Rx9nPYW331q4vRBp+cdawzIkWkLq7J8NgmygQ/xtBavwle1bNTCNnSCDwI
 rG0GzW5IlavwJaskSr6EkUi5u3KOmZejxyqdapmvGGsLkP/Q/9s+klhY9uexG3tNXQFy
 k/k0OSlig9OCVd8j/4oPXnikBIZXHpsSvZ6QB2GHmKTSfPXiwT2ALrgBDPZYUVxngt39
 WPKPiMhVhkHywF5fSQB1Me6HlaaerRqchgPGSSjTzayTRSSRih7qVgbY+pE8yXnlSbTB
 UB5w==
X-Gm-Message-State: APjAAAW4pjoXSlFpIPTxMI9zKENYj+WAZWrMKA+ZdqKVx5ojQsIOrcf7
 vi+6BIcncvUE9uX1PYV8D/ZSlGXjouo7nA==
X-Google-Smtp-Source: APXvYqy0kGxDnweU3UbC5QC9Sbk29LCedUOcwQv0ZQKaOvjLayz8LWeIV4x2R5ktwaYseh/PR0efNQ==
X-Received: by 2002:adf:e390:: with SMTP id e16mr4647234wrm.29.1569359437553; 
 Tue, 24 Sep 2019 14:10:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a10sm3731588wrm.52.2019.09.24.14.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:10:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1536E1FF9E;
 Tue, 24 Sep 2019 22:01:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 14/33] tests/docker: remove python2.7 from debian9-mxe
Date: Tue, 24 Sep 2019 22:00:47 +0100
Message-Id: <20190924210106.27117-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

When it was based on debian8 which uses python-minimal, it needed this.
It no longer does.

Goodbye, python2.7.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190918222546.11696-1-jsnow@redhat.com>
[AJB: fixed up commit message]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian9-mxe.docker | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian9-mxe.docker b/tests/docker/dockerfiles/debian9-mxe.docker
index 7431168dad9..62ff1cecf2d 100644
--- a/tests/docker/dockerfiles/debian9-mxe.docker
+++ b/tests/docker/dockerfiles/debian9-mxe.docker
@@ -16,7 +16,6 @@ RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C6BF758A33A3A276 &&
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-        libpython2.7-stdlib \
         $(apt-get -s install -y --no-install-recommends gw32.shared-mingw-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  -f2)
 
-ENV PATH $PATH:/usr/lib/mxe/usr/bin/ 
+ENV PATH $PATH:/usr/lib/mxe/usr/bin/
-- 
2.20.1


