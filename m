Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA91C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B231A20665
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXH3NpW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B231A20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33233 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTl6A-0006tR-1u
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:37:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvK-0005uf-0s
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkvA-0001KG-PP
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:26:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkv6-00010L-5N
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:58 -0400
Received: by mail-wr1-x444.google.com with SMTP id s17so5671413wru.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ItvJrxkkJAYsPd3+i9yl+Ujb7HJI7J9UVBJligOhXtM=;
	b=aXH3NpW0wGCXuRLYjqaPr1YaSXUAaupjWTZWtBXYo02w0AKWJ3futE7RtVQeQttt4I
	1xbBNCLSGYiqd/k6JwIiy8Fr9Ye7LJtAEy0JQIYnrOQXg0h9jRBZNSj2DsUwwcNXsy4D
	53W7yLuz6mjtQsTDnQowlQ9LPXhge867AcXAEAsRc5k5kG0objC8wP0CzACqNgJDD40Q
	xNbcF0imnE/rPYctzociqlwcO8XyL93+1ODOsM6SNCA0ptcYKhaLWnYlas31YfZAfpbW
	fmtfdjRSOyKc3fzrCLIRIFJE9L725Hcg1emHi0xxM7MjhrBBparqM4/Hi7bJ53BDQ8jJ
	H1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ItvJrxkkJAYsPd3+i9yl+Ujb7HJI7J9UVBJligOhXtM=;
	b=XV1YsoI7GH0bs3dRRgh1THNDwVDKp+s08OIsy8jOzDh2wLgBx14yPq8TPIDVGPbB3V
	23anupBlR1ch4dxNmRGeeM+rTXzIXtFi2m012iMk8lP/I3vrX2bzmXW90tekA/De7tGM
	LE/zuSAQhBpbxjrBdgZLsDmcJl3NZ7HgkXNmpDofRRw/5FuT47JatvkXOUQwGJcgUeuS
	AU4qOYTDr0tS3MLI9MfaPFWt0T+0mA77AjAQCVrtIA5LGBdFHWVjO5srzfOuNAZzcz2d
	U1m/uJA71/xd4+e7sfbBD7ll4MpmysBsnhZJzZABKDLaH5rAZ4+xxQgcCJgs0WPyEjgt
	Wf5g==
X-Gm-Message-State: APjAAAWqGcqgTkobbdNDlhgMdWpiOhpIzIJfp+VlpqfhJVIYAfGo6+dZ
	Sd2AT9+is7qbDsZlW2XE1DUjZA==
X-Google-Smtp-Source: APXvYqyUpMJvhWzq4E7aij4cVes71HPjQhPNn9LbK/bYRzB7rbH0nohPCM9RMTLwZXftF3ffqFj4jA==
X-Received: by 2002:a05:6000:10c4:: with SMTP id
	b4mr33632260wrx.145.1558607144297; 
	Thu, 23 May 2019 03:25:44 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id p8sm21177850wro.0.2019.05.23.03.25.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:40 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 9C08C1FF9C;
	Thu, 23 May 2019 11:25:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:17 +0100
Message-Id: <20190523102532.10486-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2 13/28] tests/docker: Test more components on
 the Fedora default image
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Install optional dependencies of QEMU to get better coverage.

The following components are now enabled:

  $ ./configure
  ...
  Multipath support yes
  VNC SASL support  yes
  RDMA support      yes
  PVRDMA support    yes
  libiscsi support  yes
  seccomp support   yes
  libpmem support   yes
  libudev           yes

Note: The udev-devel package is provided by systemd-devel.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190504055440.20406-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
---
 tests/docker/dockerfiles/fedora.docker | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 69d4a7f5d75..afbba29adaa 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -8,6 +8,7 @@ ENV PACKAGES \
     bzip2-devel \
     ccache \
     clang \
+    cyrus-sasl-devel \
     device-mapper-multipath-devel \
     findutils \
     flex \
@@ -23,13 +24,17 @@ ENV PACKAGES \
     libaio-devel \
     libasan \
     libattr-devel \
+    libblockdev-mpath-devel \
     libcap-devel \
     libcap-ng-devel \
     libcurl-devel \
     libfdt-devel \
+    libiscsi-devel \
     libjpeg-devel \
+    libpmem-devel \
     libpng-devel \
     librbd-devel \
+    libseccomp-devel \
     libssh2-devel \
     libubsan \
     libusbx-devel \
@@ -74,10 +79,12 @@ ENV PACKAGES \
     pixman-devel \
     python3 \
     PyYAML \
+    rdma-core-devel \
     SDL2-devel \
     snappy-devel \
     sparse \
     spice-server-devel \
+    systemd-devel \
     systemtap-sdt-devel \
     tar \
     usbredir-devel \
-- 
2.20.1


