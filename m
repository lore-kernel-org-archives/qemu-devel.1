Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8704AC3F68F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A7C2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1UFcYo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A7C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybl1-00082f-Hg
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iybjR-0006ob-13
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iybjP-0000Ii-IM
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:25:40 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iybjP-0000Hc-Az
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:25:39 -0500
Received: by mail-wr1-x436.google.com with SMTP id z7so18035202wrl.13
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 05:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7ivHz9ai/wGMbGbVP0jqruym1wedxhoZvCA2AOYPZAM=;
 b=b1UFcYo0ZZT6KDdEEnOniRVdilYsX9Zgmxnr2sGOUtELU8ueplUnBvL8fvh6ecBFf9
 ttKaV0fCUvtAdkq0cptb/4l9qvAdjBTrQRpYiei/2TdjPM8kLVk8eyufkif8eBTRtar2
 ABfp12GvWkCm8EXlCR6GYWPh8wGI9WeicayTXvWVLVLQO024x2PJBaOQSXowhCgaVjvD
 2cv78EH2wJoWSbtCMA0HRGe9SlBrBx7Iu2SjH88jQWiQ2Exj4HjekY1PaiLDaM7rT6bE
 KAR3U9BSObCs1x7EbSvsXoMPNxtshdm8GWqy1bHQBA+c90Uo6xtoGsMP9/0TyNg9wXyC
 WR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7ivHz9ai/wGMbGbVP0jqruym1wedxhoZvCA2AOYPZAM=;
 b=QyRKiQbkTrgM+o8XQELgCh5ljLaEEiGTJgB0OievGPy/OC3uafMl5WeWCjXw0HRO0L
 aCdkQVIQlW5ln5xLGox5ccBPLGEvrKoAH59khMUnhNh881bS1efqH6gjsOQS3Z/AOJMp
 YkZb7ngjrpjmutFSshYKh4rIoZr6fN0VWn2y7b+xC8XkXBm8uhTUadVXQcvTRlmn7gjV
 qTlwp1d8wH58NQEjso7UHWZxJ8lN6qKiQy4s4lkFmuPJGG70Z1ZlpRum0Hit1RTlMdl3
 fO3kH/cCHSjTQcaf0tGel8XoNPM78TrNnli6wBDb0BccvZif/TL49wKjCZsjuIX8pyy3
 TK+Q==
X-Gm-Message-State: APjAAAXiADhvp+w2TgHsahCdG0JDi2bARFfHSQq30efqIlo/TfT+tbC5
 b0rAcSBXI78f5BeMgR4dEx3THfrWbPNknw==
X-Google-Smtp-Source: APXvYqylCSaCMX/FnpmgWGpjSWSrfcm38QeXDYssCv+LYsAMKiAkHPisLAF/FUOHs+t6WamC41YDkA==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr16759296wrs.213.1580736337865; 
 Mon, 03 Feb 2020 05:25:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s16sm26100534wrn.78.2020.02.03.05.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 05:25:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] configure: Allow user to specify sphinx-build binary
Date: Mon,  3 Feb 2020 13:25:32 +0000
Message-Id: <20200203132533.21850-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203132533.21850-1-peter.maydell@linaro.org>
References: <20200203132533.21850-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently we insist on using 'sphinx-build' from the $PATH;
allow the user to specify the binary to use. This will be
more useful as we become pickier about the capabilities
we require (eg needing a Python 3 sphinx-build).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I went with the most common convention for specifying "here's
an executable", like --make=, --install=, --python=....

The only odd one out for our current configure options seems to be
that we want --with-git=GIT, not --git=GIT. You could argue that
that's a better convention, but it makes more sense to me to
stick with the convention we currently mostly have. (Perhaps
we should even change --with-git= to --git= ?)

 configure | 10 +++++++++-
 Makefile  |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 5095f017283..830f325822a 100755
--- a/configure
+++ b/configure
@@ -584,6 +584,7 @@ query_pkg_config() {
 }
 pkg_config=query_pkg_config
 sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
+sphinx_build=sphinx-build
 
 # If the user hasn't specified ARFLAGS, default to 'rv', just as make does.
 ARFLAGS="${ARFLAGS-rv}"
@@ -975,6 +976,8 @@ for opt do
   ;;
   --python=*) python="$optarg"
   ;;
+  --sphinx-build=*) sphinx_build="$optarg"
+  ;;
   --gcov=*) gcov_tool="$optarg"
   ;;
   --smbd=*) smbd="$optarg"
@@ -1677,6 +1680,7 @@ Advanced options (experts only):
   --make=MAKE              use specified make [$make]
   --install=INSTALL        use specified install [$install]
   --python=PYTHON          use specified python [$python]
+  --sphinx-build=SPHINX    use specified sphinx-build [$sphinx_build]
   --smbd=SMBD              use specified smbd [$smbd]
   --with-git=GIT           use specified git [$git]
   --static                 enable static build [$static]
@@ -4799,7 +4803,7 @@ has_sphinx_build() {
     # sphinx-build doesn't exist at all or if it is too old.
     mkdir -p "$TMPDIR1/sphinx"
     touch "$TMPDIR1/sphinx/index.rst"
-    sphinx-build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
+    $sphinx_build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
 }
 
 # Check if tools are available to build documentation.
@@ -6474,6 +6478,9 @@ echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
 echo "make              $make"
 echo "install           $install"
 echo "python            $python ($python_version)"
+if test "$docs" != "no"; then
+    echo "sphinx-build      $sphinx_build"
+fi
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" != "no" ; then
     echo "smbd              $smbd"
@@ -7503,6 +7510,7 @@ echo "INSTALL_DATA=$install -c -m 0644" >> $config_host_mak
 echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
+echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=$iasl" >> $config_host_mak
diff --git a/Makefile b/Makefile
index a6f5d440828..1f37523b528 100644
--- a/Makefile
+++ b/Makefile
@@ -1024,7 +1024,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
 # Note the use of different doctree for each (manual, builder) tuple;
 # this works around Sphinx not handling parallel invocation on
 # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
-build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
+build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
               $(wildcard $(SRC_PATH)/docs/$1/*.rst.inc) \
-- 
2.20.1


