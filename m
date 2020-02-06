Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF933C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDE321775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AG4Qohl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDE321775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl42-0004GI-Qv
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzM-00065H-GX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzL-0003xh-BL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:52 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:44167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzK-0003pP-59
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:51 -0500
Received: by mail-wr1-x431.google.com with SMTP id m16so8168129wrx.11
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wr8RlgOBQK+lZKQOUvmEh0ytBymCGpyT+5O+C4ZgoYs=;
 b=AG4Qohl8KXnqXx7w1lxhvhIjoRFVP/mtyDy7TzyzuWUDFyG2HCwN6JaSrmqnz+Hg9s
 RJMYJAVXA6gsl09QeiusAZg61TmewYZch16aHJ5d+OeiAG4/RN2YWYP2c0FGHr0IwKGL
 olObe3TeoBPytc53Phc7RcuVY6XpFDguTNHPdYQYg+pFimpLvKsbQfZVfQbYybbZRqaL
 ADpXQmy+AITpQz4sir9M5oI6iiAdABTl6g7qZWxmCVidBeNjc5KOeD80Iw7lnAQOo85k
 +6b+S0qjcQCGtEVsb4sZmwzOmvh6twdwcaU5k8Df2pHPqGo06nnKJhoBfZwk8kLOIDaa
 Hyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wr8RlgOBQK+lZKQOUvmEh0ytBymCGpyT+5O+C4ZgoYs=;
 b=UHk2/hMKmlwkiYRaZ5xgXuU3BdXhQTouU1qx6HIyDB4abEbCoHGu5987ovGlLnvOsA
 a6AWfFubN23Io9XON+R3jTIcJfOLnfI6Ttf0tfR3kprvQRaywLabWE6EapzxmuqdvpN+
 +RcLKbGkzEhjAqGIvI9dawVphMFm99A/N4Hk/G/EqWwqA1Gw8FPalXuegi2UHW35VUHD
 XsbfUUcWP51TohGkAtT7h7cWUQzGGaPUoELdbP2u4R1YAXJHS3VVIaiFEAzAuOD2Wh8M
 9q7FXcLpygFgEosWjOrXhWASSOcEp8O8fFmESF0E7ZtzT4Pr3/3QVVEsnPsT1zt4cnAK
 Uuiw==
X-Gm-Message-State: APjAAAXyidt/UGY9p6OpqgZ25/Yi6qjbNfBZ0U8CnodhNotwSM7HVa8O
 nABaxA95Jesj6cKgqgwKVtckueiISao=
X-Google-Smtp-Source: APXvYqz8r4VUhsw1YcxX7c2AdM3TgYbYLVhPDJkYfnAav7IIjvDqSsU4y96BZ9S5K0VHfR4oehUGig==
X-Received: by 2002:a05:6000:1201:: with SMTP id
 e1mr4969750wrx.386.1581010248573; 
 Thu, 06 Feb 2020 09:30:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:30:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/29] configure: Check that sphinx-build is using Python 3
Date: Thu,  6 Feb 2020 17:30:13 +0000
Message-Id: <20200206173040.17337-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently configure's has_sphinx_build() check simply runs a dummy
sphinx-build and either passes or fails.  This means that "no
sphinx-build at all" and "sphinx-build exists but is too old" are
both reported the same way.

Further, we want to assume that all the Python we write is running
with at least Python 3.5; configure checks that for our scripts, but
Sphinx extensions run with whatever Python version sphinx-build
itself is using.

Add a check to our conf.py which makes sphinx-build fail if it would
be running our extensions with an old Python, and handle this
in configure so we can report failure helpfully to the user.
This will mean that configure --enable-docs will fail like this
if the sphinx-build provided is not suitable:

Warning: sphinx-build exists but it is either too old or uses too old a Python version

ERROR: User requested feature docs
       configure was not able to find it.
       Install texinfo, Perl/perl-podlators and a Python 3 version of python-sphinx

(As usual, the default is to simply not build the docs, as we would
if sphinx-build wasn't present at all.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 configure    | 12 ++++++++++--
 docs/conf.py | 10 ++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 0aceb8e50db..2c5cad13edd 100755
--- a/configure
+++ b/configure
@@ -4808,11 +4808,19 @@ has_sphinx_build() {
 
 # Check if tools are available to build documentation.
 if test "$docs" != "no" ; then
-  if has makeinfo && has pod2man && has_sphinx_build; then
+  if has_sphinx_build; then
+    sphinx_ok=yes
+  else
+    sphinx_ok=no
+  fi
+  if has makeinfo && has pod2man && test "$sphinx_ok" = "yes"; then
     docs=yes
   else
     if test "$docs" = "yes" ; then
-      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and python-sphinx"
+      if has $sphinx_build && test "$sphinx_ok" != "yes"; then
+        echo "Warning: $sphinx_build exists but it is either too old or uses too old a Python version" >&2
+      fi
+      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and a Python 3 version of python-sphinx"
     fi
     docs=no
   fi
diff --git a/docs/conf.py b/docs/conf.py
index ee7faa6b4e7..7588bf192ee 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -28,6 +28,16 @@
 
 import os
 import sys
+import sphinx
+from sphinx.errors import VersionRequirementError
+
+# Make Sphinx fail cleanly if using an old Python, rather than obscurely
+# failing because some code in one of our extensions doesn't work there.
+# Unfortunately this doesn't display very neatly (there's an unavoidable
+# Python backtrace) but at least the information gets printed...
+if sys.version_info < (3,5):
+    raise VersionRequirementError(
+        "QEMU requires a Sphinx that uses Python 3.5 or better\n")
 
 # The per-manual conf.py will set qemu_docdir for a single-manual build;
 # otherwise set it here if this is an entire-manual-set build.
-- 
2.20.1


