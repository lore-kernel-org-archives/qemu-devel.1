Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9716C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C95208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpcDjBsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C95208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkLk-0000Q4-8k
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKo-00055b-2u
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKk-0001AO-9K
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:51:05 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34364)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkKj-00017Y-P0
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:51:01 -0400
Received: by mail-wm1-x341.google.com with SMTP id w9so19231456wmd.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FueVvrQyl+4oa+yjvU/y1NHtb38qdErvOQQrhe5Tnk0=;
 b=VpcDjBsOqJYKhdBQLS0DZMi1MYane0Nl3uIxl/o/JZn4y1P7SkMx6ectxStRknUxgo
 J7kpeAgqeGL+LOuXiPK3X3Thm6qFymgOzeEJoau10yjia7Ss0enaT64jQwnDEtbA//Ak
 jFl/e2O+l9f024HdjrJBEq36YFZ2Sw43LYWiRA2p+180Maq1a1h9Axwri5365VUSUdLg
 yoTQ0fNqG3GFg5DaX69TceTjaQciOclP7b38D9VtThYFslmaGxK+H577kRog7xKek0kA
 ZRyM9bKfdLkk4I0WQoceU7uSx6vW5M+ToGaaN00iMyISJU8udDcwEbfzZNen7TgfOtmi
 /ZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FueVvrQyl+4oa+yjvU/y1NHtb38qdErvOQQrhe5Tnk0=;
 b=CIbnuKmqNO7H2nVImiC9Eg30qRTdTaWduLHoxGZCgg1wNEqPiDWohT06SZrGp2lkqB
 xoRwIMqGeJWDJj4Ka1VLjh8w7ksUUoWeh+CYJ5JdxFdL6RTi2ks8vpueo+Q6G3rwBoG5
 hiFE/O2ycQX9epvOqDZiyPdq/zQOTvm2xXrDVxIn0MsjCJURlOWA28HnZWmN6l6v6t9O
 06q1kuq0C4JRWc2zdicoyuE8xSYYvUC7ct7UWkbU2N5IMxKtB7/77ItsPZ2DW1BstTk5
 6vevOMKU7wp5ZXjRQz4sier7FiVlHneLRU+WFz2sXSLOKuwbmSfHI5za9nV1oP4YgQT3
 ozwA==
X-Gm-Message-State: APjAAAUomd5ihVaXTfGVUyq1uRDOYGYx/7Zj08sD5rFFM/Lq1P+S372J
 pYmnZMdB4Xvh22oh3t9ZKWee2A==
X-Google-Smtp-Source: APXvYqxAuNpQRMgB6s6CcB7GC473zDzcnW/Wtodghlc3/oQxIMRVGQu7jNf6/FB13HRigtp9Z75b8A==
X-Received: by 2002:a05:600c:c6:: with SMTP id
 u6mr37937523wmm.153.1563371460558; 
 Wed, 17 Jul 2019 06:51:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y12sm2959416wru.30.2019.07.17.06.50.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:50:56 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 807561FFA5;
 Wed, 17 Jul 2019 14:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:31 +0100
Message-Id: <20190717134335.15351-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v2 19/23] tests/docker: invoke the DEBUG shell
 with --noprofile/--norc
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's very confusing when things work in the debug shell because the
environment is different from what the test is running. Fix this by
ensuring we only have the inherited environment from the run shell.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/run | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/run b/tests/docker/run
index 7aebf4b5698..1014871fec0 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -62,7 +62,7 @@ echo "* Prepared to run command:"
 echo "  $CMD"
 echo "* Hit Ctrl-D to continue, or type 'exit 1' to abort"
 echo
-$SHELL
+$SHELL --noprofile --norc
 
 if "$CMD"; then
     exit 0
@@ -72,7 +72,7 @@ elif test -n "$DEBUG"; then
     echo "* Hit Ctrl-D to exit"
     echo
     # Force error after shell exits
-    $SHELL && exit 1
+    $SHELL --noprofile --norc && exit 1
 else
     exit 1
 fi
-- 
2.20.1


