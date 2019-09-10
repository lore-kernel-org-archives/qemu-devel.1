Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92288C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5BE2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/wMD5+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5BE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cL8-0005D1-SO
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0Y-0004YV-41
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7c0W-0004nQ-QJ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:18 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7c0W-0004mn-Jf
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:00:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id y19so18484841wrd.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PsQJeErI9+aTg6zkfqahDzJy6pOKWXrb4kmWb+mMXOE=;
 b=O/wMD5+1WTXokZBdczfjwraApWBaEa0Fpf3LQbjqGZ9FozH7/pq6fVFC21vqcLJTgB
 2pYfBmXFw3mrF5g085POAP5PfhQnqc4rsFsN5ogpF07wqPWR+BbIAYIMnKXSlcrWwtkx
 puUp3vpMZeZg8RZv20ZK8Oni0aX5PTU3Nd1TUCJJcrjL+5cv2F+lv7MO4j5VmSGI7Ott
 yX0k3Psw7zaCjfSrUyhYI4GikO6JuKMeBLVvDzrvPXHIPrEO2whwjL3v3yhd0tNmEfiN
 dPBQzmbZHrmAz85HZCOrtqFskRXbDfRmWI+At6CzlkE3F5Voui6jfiVc9bRM9YvHkyuL
 XMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PsQJeErI9+aTg6zkfqahDzJy6pOKWXrb4kmWb+mMXOE=;
 b=oeO6gOuE/ZVbgZHgnZUWLpgfc25Xab9jgmNYt3AX44Fu3q/VbSjinN5I/6hr9Fs2cG
 4f2KACKd7a2F+OS097XkPhKymVe6p4uur+6FTrHzywrVW4psJRwY8W1NFfHzyzr2NLGu
 ZqrYUBP6qB8RgK0v8vXDSWfqhD7RX/QgTT1bhDdXO8UoueGZqD9Kj7ElP+1NcFMBtPZA
 fIh7ckxjQy+5hP847mAz/v0DBKsOB832bRpAUQMvh3z6/cU21IzwPRNBiMr8ldKCFmKC
 DBg7mIx7Ft6zX8NLN1kAE9Xdr3Rx3q759fnfHgAZl1wm9s0qHGdjF8iaD3GIn0+KIFkU
 xF3Q==
X-Gm-Message-State: APjAAAV7kFIi7cOuZxEoRqKpzOtSBMIadbt0N2Dw5B7SXa00Lk7mwB1J
 rxtyHOZJzgfkFFCD0eNN/WfmMQ==
X-Google-Smtp-Source: APXvYqzVQ4a2PcfE8kEpEJYL06Tf0lqsYz4ErbL7eMbhe0BYYTxzOloQGfqCTmi6fQVmfFTS37GQxw==
X-Received: by 2002:adf:dbc6:: with SMTP id e6mr8557882wrj.149.1568106015296; 
 Tue, 10 Sep 2019 02:00:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b16sm25660254wrh.5.2019.09.10.02.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:00:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E0CA61FFAE;
 Tue, 10 Sep 2019 09:43:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:29 +0100
Message-Id: <20190910084349.28817-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 25/45] tests/docker: pin powerpc-user-cross to a
 snapshot
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now Jessie has entered LTS the powerpc architecture has been dropped
so we can no longer build the image from scratch. However we can use
the snapshot archive to build the last working version.

This now only lives on an example of setting up a user-cross image as
at least on x86-64 we can use the Buster packaged cross compiler for
building test images.

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index b6c04059502..b06716ff71c 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -71,7 +71,8 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 	$(if $(wildcard $(EXECUTABLE)),						\
 		$(call quiet-command,						\
 			DEB_ARCH=$(DEB_ARCH)					\
-			DEB_TYPE=$(DEB_TYPE)					\
+			DEB_TYPE=$(DEB_TYPE) 					\
+			$(if $(DEB_URL),DEB_URL=$(DEB_URL),)			\
 			$(DOCKER_SCRIPT) build qemu:debian-$* $< 		\
 			$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) 		\
 			$(if $(NOUSER),,--add-current-user) 			\
@@ -130,6 +131,7 @@ DOCKER_PARTIAL_IMAGES += fedora-cris-cross
 # broken so we need a qemu-linux-user for this target
 docker-binfmt-image-debian-powerpc-user: DEB_ARCH = powerpc
 docker-binfmt-image-debian-powerpc-user: DEB_TYPE = jessie
+docker-binfmt-image-debian-powerpc-user: DEB_URL = http://snapshot.debian.org/archive/debian/20180615T211437Z
 docker-binfmt-image-debian-powerpc-user: EXECUTABLE = ${BUILD_DIR}/ppc-linux-user/qemu-ppc
 docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
 DOCKER_USER_IMAGES += debian-powerpc-user
diff --git a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
index 6938a845ee2..83749b0abb8 100644
--- a/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
+++ b/tests/docker/dockerfiles/debian-powerpc-user-cross.docker
@@ -8,8 +8,14 @@
 # debootstrapped qemu:debian-powerpc-user but doesn't need any extra
 # magic once it is setup.
 #
+# It can be used to build old versions of QEMU, current versions need
+# newer dependencies than Jessie provides.
+#
 FROM qemu:debian-powerpc-user
 
 RUN echo man-db man-db/auto-update boolean false | debconf-set-selections
 RUN apt-get update && \
-    DEBIAN_FRONTEND=noninteractive apt-get build-dep -yy qemu
+        DEBIAN_FRONTEND=noninteractive apt-get build-dep -yy qemu
+
+ENV QEMU_CONFIGURE_OPTS --disable-werror
+ENV DEF_TARGET_LIST powerpc-softmmu,arm-linux-user,aarch64-linux-user
-- 
2.20.1


