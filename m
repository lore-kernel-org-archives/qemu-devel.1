Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D71C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:04:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4363A22459
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCNQqF9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4363A22459
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUrOA-0000we-EU
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 07:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrJY-00050U-9c
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrJX-0004E6-6b
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:00:00 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUrJX-0004De-0p
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:59:59 -0500
Received: by mail-wr1-x444.google.com with SMTP id s5so2061926wrw.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 03:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LLUdVSuPei6RAwTaPKVy6/3rq24iATJe7bkWNsh6uTU=;
 b=pCNQqF9/m0xFj0siyxMAgjxY47lz1d85wHe2FmDsJVgAWI6UEEaXZNn3dO6xloLRCA
 kEa8kLgYK0IepcSqjDfAK7XJ/4LQE74Yu4ro53r5zN5snIscTk8D4U0QFuRw+B2iQee/
 MYM9A2vq295bQCvo+Cn5drsOYw9cLdCKvui9tlws63DKkyphv7drWEkifzMjvVQUXsEM
 Y+vKIWjBNQIDGxl5VDRgiivsgfpLjaLG3rFkcW/CWJg/c613PZqcu34KgUEApYuRnbaD
 v0tj8+MNK4UpWfdbf1lAZlnnqMc9ticIKHUwmCNIVTqK2zd6+BrH7600TVoediHOHWUv
 qEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LLUdVSuPei6RAwTaPKVy6/3rq24iATJe7bkWNsh6uTU=;
 b=bZkQAiIpJQGxAIKYgA45trqfR/cWtu4M29daNplitkr9+0gMYdIoBKkrqqDzfkXvUf
 j+6WbgVS6U4ZxufTR+O+7BBG0KlRlvEvP23Dp2fVuiR6Pe6QGJgtsvgtUgiF6ojjrhjn
 dvW8pun8wZzTiRQeJ8TBxVV+etj5Qkjlmn3v0CX3LqFj/Nq9sI1mzOHyUWLYSjme1KwI
 +AJY5KnOLCpnP2W7AB250U2erkoE7HsNrCR6MijP2CzkFAVn4c7eJWi76BkRXbnAQUpp
 oJ0YRadzX+PuKturYn/x2i+N9VuGY3VLfJn7EKfGIa9dFGHqfAKyMuW5V+BqeSNYjEiN
 qvnA==
X-Gm-Message-State: APjAAAUIgfSkf6fnj8OTCRtVhZUFWefy1SxGjB916Qxju2RjbKjmV0eU
 bXiJhJ2KpieqklthOvcZhQdsNw==
X-Google-Smtp-Source: APXvYqy8fRBi/cqGcYgUKAmKaoTPeCDEPtLiFYN/CVJLjShe+/Yw7d/ENFCxKzSLESwWpiUxa9HzAw==
X-Received: by 2002:a5d:48c8:: with SMTP id p8mr2617842wrs.318.1573646397870; 
 Wed, 13 Nov 2019 03:59:57 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 200sm2432008wme.32.2019.11.13.03.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 03:59:56 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6D0EB1FF90;
 Wed, 13 Nov 2019 11:59:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/5] docs/devel: update tcg-plugins.rst with API versioning
 details
Date: Wed, 13 Nov 2019 11:59:50 +0000
Message-Id: <20191113115952.775-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113115952.775-1-alex.bennee@linaro.org>
References: <20191113115952.775-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we are at it fix up the quoted code sections with the inline ::
approach.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix grammar
  - mention we also will fail to load outside the range
  - clean-up code sections
---
 docs/devel/tcg-plugins.rst | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index b18fb6729e3..718eef00f22 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -25,6 +25,23 @@ process. However the project reserves the right to change or break the
 API should it need to do so. The best way to avoid this is to submit
 your plugin upstream so they can be updated if/when the API changes.
 
+API versioning
+--------------
+
+All plugins need to declare a symbol which exports the plugin API
+version they were built against. This can be done simply by::
+
+  QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+The core code will refuse to load a plugin that doesn't export a
+`qemu_plugin_version` symbol or if plugin version is outside of QEMU's
+supported range of API versions.
+
+Additionally the `qemu_info_t` structure which is passed to the
+`qemu_plugin_install` method of a plugin will detail the minimum and
+current API versions supported by QEMU. The API version will be
+incremented if new APIs are added. The minimum API version will be
+incremented if existing APIs are changed or removed.
 
 Exposure of QEMU internals
 --------------------------
@@ -40,16 +57,14 @@ instructions and events are opaque to the plugins themselves.
 Usage
 =====
 
-The QEMU binary needs to be compiled for plugin support:
+The QEMU binary needs to be compiled for plugin support::
 
-::
-    configure --enable-plugins
+  configure --enable-plugins
 
 Once built a program can be run with multiple plugins loaded each with
-their own arguments:
+their own arguments::
 
-::
-    $QEMU $OTHER_QEMU_ARGS \
+  $QEMU $OTHER_QEMU_ARGS \
       -plugin tests/plugin/libhowvec.so,arg=inline,arg=hint \
       -plugin tests/plugin/libhotblocks.so
 
-- 
2.20.1


