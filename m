Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529DEC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC83206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oem/5z2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC83206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqbX-0005cl-JG
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVR-0006hO-QI
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:50349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVQ-0006of-2M
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id e17so3637443wme.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6jDfZ800Wl3nx3KWVZmGyBEziqyPjN03/nUW4cQFzOE=;
 b=Oem/5z2SGcWKYvmOaHULvPMdjmAL+XrLoA+HQUw9GQVDzFrcLPxgi5FJrIDPFzUUCb
 OlpzxDqA3JEU+c9bhuxvTB/w3aEkpDLaRsqidW8TBjknKbHUY7Q9jb3udt2AmjhleTsm
 +nRzKo+bfLzB4j8Mv869/uKohgDx/ko4lPYC0jCNe/5Cwl0dMG7k+cfaAVJWyoubKZj3
 G0NcU/pd2/uFnGcadaXxHBLlNZGIlpyyGKvmAE/lNpsaPWtT4aXhv5fuY0Fo7LE263//
 6nzoJcSC1+iFePP28b5yAQW/90sLQsd7W2c/pQ6dJFXeQtRldoq5nPfKSx+qH1M0GE6Y
 ODgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6jDfZ800Wl3nx3KWVZmGyBEziqyPjN03/nUW4cQFzOE=;
 b=ql+g9PWzo3Q85axlv0zKQZMS0UrNeH/YLs0UrZ0Lt67jYWr9zFnGDBxhyfe4TPIgIF
 NrlAbwC9LxKaIo7Dqcgg7WNhRQIwadbd80ubNjbH0OTDqf/a0JxBy0UFMmawYN/AdI7G
 Nu4WFbb5InNPWdw/FkORZYBlrFLw8qM6EoXjsy0paheBhQp5VxDb2a65LRw5b+ueC9gW
 ZD5H+VhRNAwwdEynnWWZ2f4Uw4l3gd9YHDBOP/zN+/FbNu6M3JUXHcyV56cFiAK1cJLO
 5+TdU7ppocDpYgl9ipCGExNPqRAfrvU1GMntA8VA6mpA1bRlz3pT8fczXUC08JBIpvoP
 9WtQ==
X-Gm-Message-State: AOAM531xr5U7D7AjHsOXiJZM5FI846s9zZVc/Wpfs06mByUrphe+pisU
 xsQa/r+SxZMjGAduP0DQlqSpK/XFyp6GnYcU
X-Google-Smtp-Source: ABdhPJyU7qz9Cb4BVNMzPkQ50PH5uMTq6zv6xUzmiKgzda2qo5UxmiEInkwx20RM5ZcoXEIiBgrdtA==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr3721924wmc.143.1601051010442; 
 Fri, 25 Sep 2020 09:23:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 10/21] qapi: Use rST markup for literal blocks
Date: Fri, 25 Sep 2020 17:23:05 +0100
Message-Id: <20200925162316.21205-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are exactly two places in our json doc comments where we
use the markup accepted by the texi doc generator where a '|' in
the first line of a doc comment means the line should be emitted
as a literal block (fixed-width font, whitespace preserved).

Since we use this syntax so rarely, instead of making the rST
generator support it, instead just convert the two uses to
rST-format literal blocks, which are indented and introduced
with '::'.

(The rST generator doesn't complain about the old style syntax,
it just emits it with the '|' and with the whitespace not
preserved, which looks odd, but means we can safely leave this
change until after we've stopped generating texinfo.)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/block-core.json  | 16 +++++++++-------
 qapi/qapi-schema.json |  6 ++++--
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index dd77a91174c..86ed72ef9fa 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -570,13 +570,15 @@
 #        For the example above, @bins may be something like [3, 1, 5, 2],
 #        and corresponding histogram looks like:
 #
-# |      5|           *
-# |      4|           *
-# |      3| *         *
-# |      2| *         *    *
-# |      1| *    *    *    *
-# |       +------------------
-# |           10   50   100
+# ::
+#
+#        5|           *
+#        4|           *
+#        3| *         *
+#        2| *         *    *
+#        1| *    *    *    *
+#         +------------------
+#             10   50   100
 #
 # Since: 4.0
 ##
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index f03ff91ceb5..6bafa81b727 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -21,8 +21,10 @@
 #
 # Example:
 #
-# | -> data issued by the Client
-# | <- Server data response
+# ::
+#
+#   -> data issued by the Client
+#   <- Server data response
 #
 # Please, refer to the QMP specification (docs/interop/qmp-spec.txt) for
 # detailed information on the Server command and response formats.
-- 
2.20.1


