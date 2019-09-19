Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08F1C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977372053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 16:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="do31j4xL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977372053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAz7i-0008Fw-3h
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 12:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iAz4e-00066q-E9
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iAyqg-0000Gd-DE
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:00:03 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iAyqg-0000FZ-4f
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 12:00:02 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 7so5242839wme.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mxbpLFgbvXahsfaVwZ9WqZ1fAPev+aEfkTXQWBTT2B0=;
 b=do31j4xLBXcXlW/y83xkvfwl6HVbamfqvv4inkU34bFFphJSIBzFAO9gdNYxUWg1vx
 Sa9dfCdnNiTVOcLz1v6/tbhBy2fZUb9ABI7nIA30gu0DW7IBtAbVcci7IB/54IbXuJRO
 MYOstFPlnCgzqujG3mZ6EqOmXMPGuIMIp0njWD4ASzS9yD4/WQtq4Ps3t0r+IyBJdPT9
 pjfcRZI1Sh38cJZXiJBv2UzuL9M153XcmWAOB3kcUsg45fkp24Z0CLwh2yC80qRkUVE+
 kng8308mnHSP/2wgLP5k608e39XLT4vyraQihXmPvBEIz7tSGB8Ax5Ejl0Y95EdtcsjP
 EYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mxbpLFgbvXahsfaVwZ9WqZ1fAPev+aEfkTXQWBTT2B0=;
 b=qDm2bmymwvhMWl8RavYDS04o4Jka2f/3IA0irhRhCg6oeICyQXo84kPktvAJJ8BdaM
 GI3Gvm8CVbRwOzIbj1n/MkiyKJDNW9Ck50r6Y8VQnADVGu9ExATxbyPanaCWuda839rt
 RvCGslAWa0osOPym8xJOlA8t4DeoHJoJlP39hQeXqd/VIfdP8RZHgo9/BpD6yT/tKE6a
 Qsy09vewhRE4JDBkblR1T9xwyaAOkpPKAb3AL3wBqNB9B1yC3ZzyR7eNobOlvyytVd4g
 kbq/nuZUE4oMPJWtWPYO7O/SC45QGK0FCVl7gP1Wx0zEdbdMIz+++wE9sCSqbNIkcDIh
 26Og==
X-Gm-Message-State: APjAAAWwDRp5nefY6RfsmWGKkyzyFFNftF5qCRPCdz3WU/x3KZgRGCh8
 uGwhJ4Z3GHiwFU8KzBY/zQsgrsRY3oo3Ag==
X-Google-Smtp-Source: APXvYqyl4YiPZ93ASMweC9DA/+C0QorDddtMAujRVexaKvcrXwrDEkeY+2YJHqleW6PsgYUuQYVBVQ==
X-Received: by 2002:a1c:9615:: with SMTP id y21mr3494503wmd.5.1568908800022;
 Thu, 19 Sep 2019 09:00:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r6sm6131493wmh.38.2019.09.19.08.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 08:59:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] Makefile: Fix in-tree builds when Sphinx is available
Date: Thu, 19 Sep 2019 16:59:57 +0100
Message-Id: <20190919155957.12618-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

In commit 27a296fce9821e we switched the qemu-ga manpage over to
being built from Sphinx.  The makefile rules for this were correct
for an out-of-tree build, but break for in-tree builds if Sphinx is
present and we're trying to build the documentation.

Specifically, because Sphinx refuses to build output files into
the same directory as its sources, for an in-tree build we tell
it to build into a subdirectory docs/built, and set up a makefile
variable MANUAL_BUILDDIR indicating where the docs are going.
The makefile rule telling Make how to build qemu-ga.8 correctly
used this variable, but the lines adding qemu-ga.8 to the list
of DOCS to be built and the 'make install' rune did not. The
effect was that for an in-tree build we told Make to build
'docs/interop/qemu-ga.8' but did not provide a specific rule for
doing so, which caused Make to fall back to the old rules.make
rule for building any "%.8" file. Make tried to invoke texi2pod
with a bogus command line, resulting in the error:

  GEN     docs/interop/qemu-ga.8
No filename or title
make: *** [rules.mak:394: docs/interop/qemu-ga.8]

Fix this by using $(MANUAL_BUILDDIR) when constructing the
list of DOCS files we want to build and also in the source
file name we install for 'make install'.

(Among other things, this broke the Shippable CI builds.)

Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 111082ce545..a0c1430b407 100644
--- a/Makefile
+++ b/Makefile
@@ -324,8 +324,19 @@ endif
 endif
 endif
 
+# Sphinx does not allow building manuals into the same directory as
+# the source files, so if we're doing an in-tree QEMU build we must
+# build the manuals into a subdirectory (and then install them from
+# there for 'make install'). For an out-of-tree build we can just
+# use the docs/ subdirectory in the build tree as normal.
+ifeq ($(realpath $(SRC_PATH)),$(realpath .))
+MANUAL_BUILDDIR := docs/built
+else
+MANUAL_BUILDDIR := docs
+endif
+
 ifdef BUILD_DOCS
-DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 docs/interop/qemu-ga.8
+DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 $(MANUAL_BUILDDIR)/interop/qemu-ga.8
 DOCS+=docs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/interop/qemu-qmp-ref.7
 DOCS+=docs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/interop/qemu-ga-ref.7
 DOCS+=docs/qemu-block-drivers.7
@@ -699,17 +710,6 @@ dist: qemu-$(VERSION).tar.bz2
 qemu-%.tar.bz2:
 	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
 
-# Sphinx does not allow building manuals into the same directory as
-# the source files, so if we're doing an in-tree QEMU build we must
-# build the manuals into a subdirectory (and then install them from
-# there for 'make install'). For an out-of-tree build we can just
-# use the docs/ subdirectory in the build tree as normal.
-ifeq ($(realpath $(SRC_PATH)),$(realpath .))
-MANUAL_BUILDDIR := docs/built
-else
-MANUAL_BUILDDIR := docs
-endif
-
 define clean-manual =
 rm -rf $(MANUAL_BUILDDIR)/$1/_static
 rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.js $(MANUAL_BUILDDIR)/$1/*.html
@@ -819,7 +819,7 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) scripts/qemu-trace-stap.1 "$(DESTDIR)$(mandir)/man1"
 endif
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
-	$(INSTALL_DATA) docs/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
+	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
 	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
-- 
2.20.1


