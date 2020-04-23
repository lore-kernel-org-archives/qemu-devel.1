Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A1AC55191
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9047020781
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRmbP7K0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9047020781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfLS-000896-GD
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIc-0000wk-Ve
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIc-0005T3-5Y
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:06 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRfIb-0005SD-Oo
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:05 -0400
Received: by mail-wr1-x42e.google.com with SMTP id g13so7698957wrb.8
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UJa9O7SlcWT6UhRg1uaROqwj8sngC3TBRya5nKD48qg=;
 b=iRmbP7K02SURG8MePkSnYB1oj8pI0UdbEjwY4TrY+CIcCuADJkBUeSiZNiLyOY2taA
 xf96a0talmzrB8bDxXmEl0HgU0BO4qc8VAnS2MqrNxIgJwbdh0YKDCQvYCspGsUOCJPb
 yATT4x2az+V9V2XnEk3yULAFkMaM3rTdl/ZxBSZ32UlFMx7mEf1QcmAGk6kl9IO6PdSq
 wiYNLEQhD9VLdJi21WbpP1iILINQjGqFdWtbqAEXPfTVCOx1ir9dDxoOaUR0d6HTgO/n
 eBHYV6xAL18CCh3efHH4i8i9WXpaik8hbJxJejwrkvIY9zEt6dKz71iiuFlYB58sVvJp
 58og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UJa9O7SlcWT6UhRg1uaROqwj8sngC3TBRya5nKD48qg=;
 b=IiNlSnnpZDMosQgSsbHCYDvw8Hyymzatj4EVb+WO0qY2o+iJDPePeBMx8zy8zwisfG
 UBQjTbTyfauVG2Ksm8Kf/HXA/rhG7FBQXlSpSxAgtyOnUkNSixTfY8ueSPUXNuqDRiRT
 Fe5Hi1JGli/5AKzNCC60ytDP3BsrbxxsZVWPb9j00WFc1dKOB/sIs8+y6QrhI3eBehW3
 Ex/APcXXsOoTlTjQg03QHdhYalobgiEuO5hZOr1pswSxTcqSIspe2QcLtmhWDa4XVWbx
 Q5XkITuzMtb9arSO0CwNHPkbwimbJKLKYWcuPainPmktqLx/pwJcIYoYmPD/6ukjw91O
 IglA==
X-Gm-Message-State: AGi0PuaamixxA96NAuJD6j7dv4++ZqeNev0BMXqmHUlDwiC9zbevTRdR
 mP7gph5cXYhUN4o5y0yEVud8Fg==
X-Google-Smtp-Source: APiQypJM55Y1GDZGtjTTV6YRsqM9IAoYg3AmM3lwxmCGl2l05B1uYw3m1hCHe32nYEPoXd6RujpfHw==
X-Received: by 2002:a5d:4042:: with SMTP id w2mr5587250wrp.195.1587661564341; 
 Thu, 23 Apr 2020 10:06:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d5sm4702433wrp.44.2020.04.23.10.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 10:05:59 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9E4851FF90;
 Thu, 23 Apr 2020 18:05:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 04/14] .gitignore: include common build sub-directories
Date: Thu, 23 Apr 2020 18:05:47 +0100
Message-Id: <20200423170557.31106-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423170557.31106-1-alex.bennee@linaro.org>
References: <20200423170557.31106-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As out-of-tree builds become more common (or rather building in a
subdir) we can add a lot of load to "git ls-files" as it hunts down
sub-directories that are irrelevant to the source tree. This is
especially annoying if you have a prompt that attempts to summarise
the current git status on command completion.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---
v2
  - use build*/ to capture build and it's variants
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 0c5af83aa7..8dccb61a44 100644
--- a/.gitignore
+++ b/.gitignore
@@ -141,6 +141,7 @@ cscope.*
 tags
 TAGS
 docker-src.*
+build*/
 *~
 *.ast_raw
 *.depend_raw
-- 
2.20.1


