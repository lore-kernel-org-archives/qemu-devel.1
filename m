Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB869C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9690920678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kbkZnarK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9690920678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOTC-0006Zb-NL
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOON-0005Dy-Ra
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOI-0007Cc-0R
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:40622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOOOH-0007CE-QB
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:25 -0400
Received: by mail-wr1-x435.google.com with SMTP id h26so3664328wrb.7
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3GfCTfNzdj9dy1pa2ZHw7P0hlDvMSW+Y7bEI+7tRgbU=;
 b=kbkZnarKZKoMu8TADfKifLPL6IFzKUW2Vod37uexqnAMlU8ITuuq8FiES+0YqvTT3N
 YNSfVeqKbMZxvbRzjqVK4X155boV+bUY9bkMDG6cOdabxwcfQkYyNhZAVhPF6YgjBJ1K
 1XhTVN9kKmmdMvHppYAQKxI+FJHPAQ41grycF7k5s/heYIUlnrOEYtr2U/ADwKji0XRJ
 EmCqg3Bc8DA8flkqSsP6ZHfmAxtNrQM2EwQ2P+i/hhlrbImEP9qmXK1gfOhPXIZbqdZQ
 0usYMWxaO9baTIhpEk9ym8bNWuw5q18TMRcnV/D7XrC4iz+XkSi9DgvY0l4kwofF5iSs
 i2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3GfCTfNzdj9dy1pa2ZHw7P0hlDvMSW+Y7bEI+7tRgbU=;
 b=cMhEaPuFNPTWmGbKb6C166APe3GD93AEeQ0GzfSFVf7U7mqRbd2sW7TYuDWz76o7Od
 lRSlwUt8Jk41afLDkdfQieneR6+1yzDdhe4J+nlLB+8EfR+AuUCpDR9mlCl7vpcz5W69
 dXOuJHnVXzfZM5x3RZMebPXBwcpQCDXzHZwCrEu5qg4L1nh9RuJ2o2lLcZbFchHqL8dY
 aUq78jt0cyfZI2Af2EtM7uqJ5SfgtqoQzNSXIZk8nEwW6usrULyd4JXzVEVm9yOsgYSq
 pPeNDiqa9t9dQltQ4jFlMLGrOFVqsWXo5ATm3kkwaOsS2fWGpGupmKvfVvcp2oh32vhz
 Xqog==
X-Gm-Message-State: AGi0PuZRQ883XaUc7Eoc1ZEXhaKY1+KnepdoVQ/XYQHlyPAZdXtx5iIW
 7lJ5jis7MS7eMP386kFMj55B+dHZwlUCYw==
X-Google-Smtp-Source: APiQypLPPzSwAOrb271XFSh72LaJ+Ur0jJK6t0vtw7ZAC0Y5G4yCVP1Slh9upK9XoKmhkcu48uKUaA==
X-Received: by 2002:a5d:5085:: with SMTP id a5mr4866957wrt.394.1586881584533; 
 Tue, 14 Apr 2020 09:26:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i129sm20003802wmi.20.2020.04.14.09.26.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:26:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] configure: Honour --disable-werror for Sphinx
Date: Tue, 14 Apr 2020 17:26:09 +0100
Message-Id: <20200414162613.4479-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414162613.4479-1-peter.maydell@linaro.org>
References: <20200414162613.4479-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

If we are not making warnings fatal for compilation, make them
non-fatal when building the Sphinx documentation also.  (For instance
Sphinx 3.0 warns about some constructs that older versions were happy
with, which is a build failure if we use the warnings-as-errors
flag.)

This provides a workaround at least for LP:1872113.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200411182934.28678-2-peter.maydell@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 9 ++++++++-
 Makefile  | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 233c671aaa9..9b1f5b33e45 100755
--- a/configure
+++ b/configure
@@ -4928,6 +4928,12 @@ if check_include sys/kcov.h ; then
     kcov=yes
 fi
 
+# If we're making warnings fatal, apply this to Sphinx runs as well
+sphinx_werror=""
+if test "$werror" = "yes"; then
+    sphinx_werror="-W"
+fi
+
 # Check we have a new enough version of sphinx-build
 has_sphinx_build() {
     # This is a bit awkward but works: create a trivial document and
@@ -4936,7 +4942,7 @@ has_sphinx_build() {
     # sphinx-build doesn't exist at all or if it is too old.
     mkdir -p "$TMPDIR1/sphinx"
     touch "$TMPDIR1/sphinx/index.rst"
-    "$sphinx_build" -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
+    "$sphinx_build" $sphinx_werror -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1
 }
 
 # Check if tools are available to build documentation.
@@ -7631,6 +7637,7 @@ echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
+echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
diff --git a/Makefile b/Makefile
index 84ef8816000..8a9113e6663 100644
--- a/Makefile
+++ b/Makefile
@@ -1076,7 +1076,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
 # Note the use of different doctree for each (manual, builder) tuple;
 # this works around Sphinx not handling parallel invocation on
 # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
-build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
+build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(if $(V),,-q) $(SPHINX_WERROR) -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst $(SRC_PATH)/docs/$1/*/*.rst) \
               $(SRC_PATH)/docs/defs.rst.inc \
-- 
2.20.1


