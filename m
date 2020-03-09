Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1B5C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4C320828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ae07XyQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4C320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOwt-0003hh-9s
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBOvu-0001sr-Rp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBOvs-0005AB-Sd
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:26 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBOvs-00059t-Mx
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:24 -0400
Received: by mail-wr1-x433.google.com with SMTP id v4so12903655wrs.8
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 13:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ckXsB/S4+Zc7QwguSZl38+7FV9JObasmn6KmK05PN2I=;
 b=ae07XyQ7YTpkNmm5OVgcqd9dHlShaHTxFZewe4e6y/bxGxE+YVTbllLBJxIaAmWt3b
 MrzpWuy/KdcE/F5lolaNYbiCXtC8DGUCyQGSydb3OyMvUn5AMGmGUctVu0tnYZpKlSyG
 q5lUYLnKuBarnNlVBgH4KpB6VZtHNc/vD5PHOfF6rrpOgTH8HTXoRLQlkEQ1QPaRqbkI
 ZW4XASQhMx9VHN1pg+XtqT3FCoNsU2HMGPhYPs4ogZDLXE7mGVMIO4EKf8UnBQ83uvy7
 3WiZUhGLaNfZOAgau7IcUuKuovczHRHX6yv+o9ObQAOeCUahM7b87bMawbzxWC6NMIkC
 5e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ckXsB/S4+Zc7QwguSZl38+7FV9JObasmn6KmK05PN2I=;
 b=L8pCDUWXiynX+5VKiJ6vs+g/r7w0V6v50J8E9MHIzU4lIYbz50SPkkGesE/549egVB
 HuyCdvZYxxCQtBQ3b7d5Boe3QYevq5w2vQ1ONYpxC5q+AZ9HBwtD80ey+DAECTZyZ2Ui
 U7Ctalohz8I6uc5sBlRQIL4aiUORKziQ8r8uBSIAIPjULua/3sg44c2fjOI9H38lwWXU
 DlWE0Lxk700mYWQ4qUywuBm19jJ/oiad6Csw7opExdxLWlVAd4kyB7SrWC7v5GjXOWnS
 LZukte330uFxGhWiqOQaHIOgRPN2tFeucJ+lkJQhxQ0vRHIxwxV1+BG5AKUh/YNVFqcK
 mq1g==
X-Gm-Message-State: ANhLgQ04PM8KLf3HMgWPbJQvbBvqHLkADc3qQvMnufyKB242ETV19gdG
 TV3kBNtahiRKMg9JftRtoAUpIQ==
X-Google-Smtp-Source: ADFU+vsMa20KzMi8G8F1Fqg5RnTC6jQ14vvy8H15VoHP35IS3KR/c7yr8CB95/UvKa8IO7p28yh9CQ==
X-Received: by 2002:adf:f0ca:: with SMTP id x10mr22981413wro.264.1583785403702; 
 Mon, 09 Mar 2020 13:23:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q7sm9143444wrd.54.2020.03.09.13.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 13:23:19 -0700 (PDT)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C183E1FF8F;
 Mon,  9 Mar 2020 20:23:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/5] tests/docker: Remove obsolete VirGL --with-glx
 configure option
Date: Mon,  9 Mar 2020 20:23:16 +0000
Message-Id: <20200309202318.3481-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309202318.3481-1-alex.bennee@linaro.org>
References: <20200309202318.3481-1-alex.bennee@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The GLX configure option has been removed in 71c75f201d [*].
We missed that when updating to v0.7.0 in commit fab3220f97.

This silents:

  configure: creating ./config.status
  config.status: creating virglrenderer.pc
  ...
  configure: WARNING: unrecognized options: --with-glx

[*] https://gitlab.freedesktop.org/virgl/virglrenderer/commit/71c75f201d

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200212202709.12665-3-philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index b67fad54cb7..a1d40a56fa1 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -29,7 +29,7 @@ RUN apt update && \
         libgbm-dev
 RUN git clone https://gitlab.freedesktop.org/virgl/virglrenderer.git /usr/src/virglrenderer && \
     cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
-RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
+RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --disable-tests && make install
 
 # netmap
 RUN apt update && \
-- 
2.20.1


