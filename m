Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E45DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176D02064A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4IWk+DZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176D02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORqe-0007do-9Z
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpR-0005wm-O1
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpQ-0005vD-Rh
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:55531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORpQ-0005uo-LI
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id e26so14519210wmk.5
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ptCwd/BWCtSQi+ZJyFjq9rFc58i3OUw5zJJkXD91Vg=;
 b=a4IWk+DZy2PglXYjno1snkpgc3RTKB4rcida2gYlPyIullfzGuxZgTgIv2yjAvnmpu
 gCea0wLVCVG2BXjPJ0asCN73JynyDO5Z25ZtA9egGHRkwD0x/Bw8fhKxJyoCuB3KfOO9
 CuFtIq/D9aClq//VrRHrP61k/JAA90LMzICpGBP697qfWPHVbZngxeS9o777bUVj0Rwx
 fGt/CrvfdWG2n2DRoJ445ZuEteXOAzcc7G1JJ6GiP7RjHBSxqTTtxn53xtdYDQ3jZv8d
 2VZuIH46vZ4Y2WgvMlTUS6ercjmXmtY9PTWA3EUG67Z+5n6I0zI0qTTby296cIL8jusf
 a6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ptCwd/BWCtSQi+ZJyFjq9rFc58i3OUw5zJJkXD91Vg=;
 b=f3SLgxBjGqidFv6vBaUNDsrICiHR5ooMyaoGBaA4vBDIoNzm7uXJY4dkDPPD+gUveL
 qUQ8wE0t22BlasVfp6vQPFa9DnjCQUzrOYj3m70+YY5OpAAqRusXyhVPcd62OpQzqCHG
 Ddi7aIt5Kbl0VziEhTaU+pDZaA42FhVIPxPnoRYKN9Y7o+B9bSk607gp+beA3q9dqEBh
 0uZWB4OEJ80VrkqpqFuhdxBox/BSMze6ttOCtKp22V24GDLlWR/rBZKZkGHR7tC/S/qu
 aP33THDtPPZeqxSHhySF3FSQyzihjMzqHiEeTrNz4puq7zV7ru2GyAhjxAD/ajAsYuHO
 7ZAg==
X-Gm-Message-State: AGi0PuZ6o9vhkoYgzgzZSUPnjfU7mDMLXovD6nlG3KMvvAi7tbennlkt
 P/df55MS6Ft2YFJlLeL2eAPaCHfTgdw=
X-Google-Smtp-Source: APiQypLh9kf2Hwe65mdupU0NiT9CVnW14hK8ToD5n/YAm1NJ1lD7glAU1ZqNJ0iePuENuxK38wxjaA==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr1627354wme.154.1586894799652; 
 Tue, 14 Apr 2020 13:06:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q4sm21416156wmj.1.2020.04.14.13.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:06:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 173811FF90;
 Tue, 14 Apr 2020 21:06:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 04/17] .gitignore: include common build sub-directories
Date: Tue, 14 Apr 2020 21:06:18 +0100
Message-Id: <20200414200631.12799-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
index 0c5af83aa74..8dccb61a44e 100644
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


