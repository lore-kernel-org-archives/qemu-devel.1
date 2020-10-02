Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D83FC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33CD5206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwdvro64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CD5206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJYe-0002TR-Az
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJNI-0006v9-4x
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:20 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJND-0007d3-A6
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:19 -0400
Received: by mail-wr1-x435.google.com with SMTP id w5so1436983wrp.8
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q56uJlplEOGZNO4NGXUUldxlm0BXcxTkBDeUS1B3sak=;
 b=gwdvro64OZ2zEEnvwHmjv0VBLNJDp8RSKnK7OX6S9G1+XS+8crYQdNgMgHMXVF6BXh
 ZSai+R0C06JzYoISoYDjqmFi9TydPicUSES6xGqXevypGDRug5aIFkHNEe1ad2SLVg/+
 cjc1MYbNmMa3SRTNRK13lj8D7WdxNH0a5RyqKSRJEKdGVjEDOPH3lsfbIm+C8kWGYLh0
 VVIzgum7WROCofzGapvEXbXxLNLZzW6NUqFZ6fNB4a4A23lj13sGBlelCeWbWnnV1Fj9
 XpzZ8pFaf90oWWPfgf+lvFLcpVFoOCUdAfxZehqi+b597TUAVX0zfBDm/cqapithqd2J
 64pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q56uJlplEOGZNO4NGXUUldxlm0BXcxTkBDeUS1B3sak=;
 b=Ej1TPc4zmuvuAnQaoIwQAxNQ5wTrE51EWIG7yyROaXc0zAPegpAsCcQhoMVftn0ix5
 j3dEtIFg2JQm3wWkRd8feKP/77Bgkmt+mHlwML8BNGVZImw9pG46gyeN+3sdxT4VbXUa
 ITOzSsIwJkDSsCcffDfQAGWrHekty/BLGCeujg62MI0oeZZmtJv5OgR/FSbbnO+Gaq4g
 9S5Nw933ItZNTgenXtN1NlnJpOIptGixYPKDpnXs9CbOKlfUJGIobyqw+88VMQdxGEm1
 qXQXVRD4r+bm1JCSHoCGh0MClJTJnsbXyiKgP8cYWbUrt+ZuOsF/OEzwAuqoyvtvuiE6
 +9Kg==
X-Gm-Message-State: AOAM532EsvP1fe1z+w8C456EyeouOWZAEBEiCrJXosJVGjmV9sH3wHM8
 /21kG0bB4W3UapR3sx9qcuUVBg==
X-Google-Smtp-Source: ABdhPJxKtenxYzUTj8MtH31IyBu2m1Agitl2H9jeT7cEm9XzkpJSEcgBo0vmEPDKySNimHwvTbbMQQ==
X-Received: by 2002:a5d:6404:: with SMTP id z4mr2644099wru.423.1601638624398; 
 Fri, 02 Oct 2020 04:37:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f63sm184597wme.38.2020.10.02.04.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:37:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 131C11FF9B;
 Fri,  2 Oct 2020 12:36:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 12/14] configure: Bump the minimum required Python version to
 3.6
Date: Fri,  2 Oct 2020 12:36:43 +0100
Message-Id: <20201002113645.17693-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

All our supported build platforms have Python 3.6 or newer nowadays, and
there are some useful features in Python 3.6 which are not available in
3.5 yet (e.g. the type hint annotations which will allow us to statically
type the QAPI parser), so let's bump the minimum Python version to 3.6 now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200923162908.95372-1-thuth@redhat.com>
Message-Id: <20200925154027.12672-16-alex.bennee@linaro.org>

diff --git a/docs/conf.py b/docs/conf.py
index 606f623211..00e1b750e2 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -36,9 +36,9 @@ from sphinx.errors import ConfigError
 # In newer versions of Sphinx this will display nicely; in older versions
 # Sphinx will also produce a Python backtrace but at least the information
 # gets printed...
-if sys.version_info < (3,5):
+if sys.version_info < (3,6):
     raise ConfigError(
-        "QEMU requires a Sphinx that uses Python 3.5 or better\n")
+        "QEMU requires a Sphinx that uses Python 3.6 or better\n")
 
 # The per-manual conf.py will set qemu_docdir for a single-manual build;
 # otherwise set it here if this is an entire-manual-set build.
diff --git a/configure b/configure
index ca9b458ea0..a5841241be 100755
--- a/configure
+++ b/configure
@@ -1964,8 +1964,8 @@ fi
 
 # Note that if the Python conditional here evaluates True we will exit
 # with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (3,5))'; then
-  error_exit "Cannot use '$python', Python >= 3.5 is required." \
+if ! $python -c 'import sys; sys.exit(sys.version_info < (3,6))'; then
+  error_exit "Cannot use '$python', Python >= 3.6 is required." \
       "Use --python=/path/to/python to specify a supported Python."
 fi
 
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 91e4a57126..f48460480a 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -40,8 +40,6 @@ sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 from qemu import qtest
 from qemu.qmp import QMPMessage
 
-assert sys.version_info >= (3, 6)
-
 # Use this logger for logging messages directly from the iotests module
 logger = logging.getLogger('qemu.iotests')
 logger.addHandler(logging.NullHandler())
-- 
2.20.1


