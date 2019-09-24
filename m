Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905ADC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5240620872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDWTNlon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5240620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCs2q-0000OD-Vy
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw3-0002Zz-Ll
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw1-0004Vk-7J
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:23 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrw0-0004TH-Ti
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:21 -0400
Received: by mail-wm1-x331.google.com with SMTP id i16so1872688wmd.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UOwxHWCw5vo47KIS9zU1ApIX4RnyzrGBUBwelWBJL7Y=;
 b=zDWTNlonuqvkhNbI3OKbzXrhnXFxcA6zSCURe7uzssKINJuDB0BMJHT0032fNTEJ7o
 qqPKj3OgSLw/yZW792hJAGI0NKCUCFJk3/hSArUXZzGBhb4kMvPu1O4P5lLEVCwTmnin
 fjV3Kyi4t1NKQgAIY9xCBAZeqIeeTuDbbFa57ZWzFm7soDo+1pvkuHvgbab0oNIZPEds
 ncNCVIOMycTNJfVRgbRWd4BYrBpEDJvlVUGe75YdWRPhzvpilmT5/iQKmnSLRR46w+r6
 bxFSLYTC+6TbtWIbuFU4m+6qWezoJ8q2oXwDuprEElQcQ/ZG5YxlqScVHbVflvrdrrIP
 fKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UOwxHWCw5vo47KIS9zU1ApIX4RnyzrGBUBwelWBJL7Y=;
 b=pJPw5AHse3/1yqsqqCkf/Q545H0qYtv73h6lrJNHppOklXA2XupAYi2S+o/3zJKcJF
 OX4yU0fiIrmSXabApNNVElHnaDgMj+4kmy8wn1+2iWWYne+ZecAGKqssPumWo6sJ27w+
 ui1zpon0AeQnfjSAfOlTq4cgYduOtEg4wyDvYGVx3KwEhiDbh8qeoR7VjeYGoC+Qq27I
 AiverWCnZx0tf0qDuOlGn7BPvexlISLJwuLlVCH41E+/J4w1mWDY5TnyAxbxfXlVUQL+
 GaKuRlXP3ln4g/CA72wJVK26mDxqRWPRlIAKyyTy+I5WZZ9oLDwJsx3uyHtLDd3lY50w
 D36w==
X-Gm-Message-State: APjAAAUArC0qhijC5ANYFr/93Daf5ZSOH2zm6W15Gim7+r6LM7GsH+tY
 0/JBCKcAPHz3fdqNc7pqq4vCHLrwHiv/FA==
X-Google-Smtp-Source: APXvYqwVWfArU3z1pOcax7CaxlkjAFQR5GhnJobr4l1ZhPfW5POBj9DmipakbK1aO1gmW548Tn9DNA==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr2428049wme.35.1569358875847; 
 Tue, 24 Sep 2019 14:01:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b16sm4859565wrh.5.2019.09.24.14.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F78D1FF99;
 Tue, 24 Sep 2019 22:01:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 09/33] tests/migration/postcopy: trim migration bandwidth
Date: Tue, 24 Sep 2019 22:00:42 +0100
Message-Id: <20190924210106.27117-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, jsnow@redhat.com, f4bug@amsat.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On slow hosts with tcg we were sometimes finding that the migration
would complete during precopy and never get into the postcopy test.
Trim back the bandwidth a bit to make that much less likely.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190923131022.15498-3-dgilbert@redhat.com>
---
 tests/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 9c62ee5331b..221a33d0834 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -753,7 +753,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
      * quickly, but that it doesn't complete precopy even on a slow
      * machine, so also set the downtime.
      */
-    migrate_set_parameter_int(from, "max-bandwidth", 100000000);
+    migrate_set_parameter_int(from, "max-bandwidth", 30000000);
     migrate_set_parameter_int(from, "downtime-limit", 1);
 
     /* Wait for the first serial output from the source */
-- 
2.20.1


