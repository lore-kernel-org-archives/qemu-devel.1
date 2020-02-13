Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB0DC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEB4217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQZYCKT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEB4217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ikr-00021F-Ix
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 12:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjQ-00005h-B0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjP-0002Kg-6C
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:56:56 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2IjO-0002It-Ud
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:56:55 -0500
Received: by mail-wr1-x431.google.com with SMTP id t3so7806529wru.7
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wr8RlgOBQK+lZKQOUvmEh0ytBymCGpyT+5O+C4ZgoYs=;
 b=NQZYCKT3Eqi6lJKeBeuJcFRFHqY5CnDIdqrRPVocEsoDPkQ7K52VmMTNw56WUBs4o5
 8Pj+r5ErzQ4fSZrk5VRSa7+SFhMMAFXNOcAb6oeZp7Wb9aLUMwY/h8lIUhqAeud99MIo
 dYo8EllPWHSs2mKum9lxODQsAx+MKZg5NyK3MOSMhx4ccEYmvigLgIrzQuRPnx8GVkO/
 2ps4TwjI9NzSplvi7mJ9vkvA/AAxbQb2eofxMnItGgmSuJx7mssPzwW1MasnAvQW2ago
 IMzDD0Z8ZCjpzCB5tcjMaGKjIp+EiQ3gcz3l98Sg5rt3s3EAmvgaR1GlabJdUTQCTDVV
 Ke1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wr8RlgOBQK+lZKQOUvmEh0ytBymCGpyT+5O+C4ZgoYs=;
 b=P1BL6grw5Z2tcbYqvMXMzNlGaD4GnnkjaIgtoJD0ZW0tHTWR6xSAEcFSSGPY0lzUGa
 nGlwVBY8kBcu9B1qPT1+bayRowHxAdTi+F71Mez2nwg9dJPZ3Af86yM9y0P2MHxvHKTu
 1k1qKBEFKHyLq/dMUwZ7g2aoefop5PmvK2MofKYhZXSV5dNL8dTpuM+lO4gtwPQjqgUw
 8hYLRUTGhoKSd+6Ys8iPaWmMtYE1hcxIYCUjXoJbUsvHMF2mCnib04SidhsAmTZo4lYs
 7BZSl1m+0PpnFoFysmeRfAPZouELo4Kud0KRH8ZDjZTju4e4Ch8N5V9tniuzTrumjblE
 scAw==
X-Gm-Message-State: APjAAAU1iG8CxBeRC38LBtPLeSv+ud2T4MwPTthA2ix4KY8Hcw4jd8Gt
 MlLbY+oVcWPmPQ3hxyWUAdGMqFEjw58=
X-Google-Smtp-Source: APXvYqxQwyRGLtKqOvFOZApwoHcgpkKOlejk7mN1XbrBaxNUgGz94oH+I9fjNBRN8fbn8LlmtQVaBw==
X-Received: by 2002:adf:e610:: with SMTP id p16mr24460075wrm.81.1581616613657; 
 Thu, 13 Feb 2020 09:56:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:56:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/30] configure: Check that sphinx-build is using Python 3
Date: Thu, 13 Feb 2020 17:56:19 +0000
Message-Id: <20200213175647.17628-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
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


