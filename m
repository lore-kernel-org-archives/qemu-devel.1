Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B2CC352BE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9236D20732
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p8FLOnJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9236D20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34041 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOORQ-0003DG-Nw
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOQ-0005KI-VA
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOL-0007Dg-48
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:34 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOOOK-0007DQ-Uk
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:29 -0400
Received: by mail-wr1-x42e.google.com with SMTP id x18so10783076wrq.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xzNWaaDL+DDil6WrxdOdqg0SzbyTOIFf6u4kxUXo+R8=;
 b=p8FLOnJQlBKKGlqEkJaSOwVwWqxkc9kWdvzGo+dkhTod7kSnLZIltUfT4Szs94LBvg
 cphYOF23UXMOlofy8WrFTUnIAB9K9nxL0sGy/Ob0dz9aqHjXe6X0bbQEJi1hnDzJ+72Y
 uKt3HibFPTNPY/9KjwubMGVST4S3jXvktleZeasLn1K2YKuFHT0EB24lyepi/0VM2bue
 qDSuKYqa8U1hUFgn1qQOeqdv5U1kB5XViReNZajSsBByWI8gCuFpdzqzNv4iGYGs9EPX
 JfcvdH2WDlQ28wWD15PFUUHOCeWbFUM03+CQPSJ4xfwE2OjI8vlhHzIRca09bLsHEIGB
 926A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xzNWaaDL+DDil6WrxdOdqg0SzbyTOIFf6u4kxUXo+R8=;
 b=sRNIL3nujIFqv1DG/lj2i1YjupQZMi89Cj3/y6ManVt773C9S+Gdj8Qj7BlMVC+4XS
 t6+sdJOxaHz+s/yMBmQ/3nxTb0NYHWeMdOLt6qT1Y1itmXkC6kTAYyl8V9HgApABqx7Q
 YVENXWc5cGISc/vBwxHlB/AQ61YyDJSozCfKasXifXVf/qcdqZvS9AGkb5VIXiS8We1Z
 hc2SjbDwPg6Uby44EIgxZoBenAYnqIuZdErdFyFLJG7w9HROFBdJEg+/kDhBOa7gSf1e
 y8f/hAz1rhLuqjJrADIivhXw4RC9Qjep9Vp1e21yHwUvIk17Jj5PhE5wkijt/qXmeqKy
 qXZg==
X-Gm-Message-State: AGi0PubEVOSNjfyvFWP3LKNtEi1iTxMeE3IjmdWg4XDc2Uc6CVmaFPzZ
 N/Lg0NV/F5vqj/mQc+LqnC+b+l/2mnczjA==
X-Google-Smtp-Source: APiQypJ52wI0Z300A8zM68XCMbf4CI/I7naew8qUYN0yqqGKRyqF6M9RLH1tuaycVhexz78julrF7w==
X-Received: by 2002:adf:e942:: with SMTP id m2mr24518353wrn.364.1586881587647; 
 Tue, 14 Apr 2020 09:26:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i129sm20003802wmi.20.2020.04.14.09.26.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:26:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] docs: Require Sphinx 1.6 or better
Date: Tue, 14 Apr 2020 17:26:12 +0100
Message-Id: <20200414162613.4479-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414162613.4479-1-peter.maydell@linaro.org>
References: <20200414162613.4479-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Versions of Sphinx older than 1.6 can't build all of our documentation,
because they are too picky about the syntax of the argument to the
option:: directive; see Sphinx bugs #646, #3366:

  https://github.com/sphinx-doc/sphinx/issues/646
  https://github.com/sphinx-doc/sphinx/issues/3366

Trying to build with a 1.4.x Sphinx fails with
 docs/system/images.rst:4: SEVERE: Duplicate ID: "cmdoption-qcow2-arg-encrypt"
and a 1.5.x Sphinx fails with
 docs/system/invocation.rst:544: WARNING: Malformed option description '[enable=]PATTERN', should look like "opt", "-opt
args", "--opt args", "/opt args" or "+opt args"

Update our needs_sphinx setting to indicate that we require at least
1.6.  This will allow configure to fall back to "don't build the
docs" rather than causing the build to fail entirely, which is
probably what most users building on a host old enough to have such
an old Sphinx would want; if they do want the docs then they'll have
a useful indication of what they need to do (upgrade Sphinx!) rather
than a confusing error message.

In theory our distro support policy would suggest that we should
support building on the Sphinx shipped in those distros, but:
 * EPEL7 has Sphinx 1.2.3 (which we've never supported!)
 * Debian Stretch has Sphinx 1.4.8

Trying to get our docs to work with Sphinx 1.4 is not tractable
for the 5.0 release and I'm not sure it's worthwhile effort anyway;
at least with this change the build as a whole now succeeds.

Thanks to John Snow for doing the investigation and testing to
confirm what Sphinx versions fail in what ways and what distros
shipped what.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/conf.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index 7768611e89c..d6e173ef77b 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -59,8 +59,10 @@ sys.path.insert(0, os.path.join(qemu_docdir, "sphinx"))
 
 # If your documentation needs a minimal Sphinx version, state it here.
 #
-# 1.3 is where the 'alabaster' theme was shipped with Sphinx.
-needs_sphinx = '1.3'
+# Sphinx 1.5 and earlier can't build our docs because they are too
+# picky about the syntax of the argument to the option:: directive
+# (see Sphinx bugs #646, #3366).
+needs_sphinx = '1.6'
 
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
-- 
2.20.1


