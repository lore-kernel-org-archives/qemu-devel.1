Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5EBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE4420872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBji0cc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE4420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cK6-0003JP-1Y
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqz-0000sJ-Ef
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqy-0000fO-5d
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqx-0000f4-Vm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id d17so5663032wrq.13
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w3KXGO2QeFTAyb9q+f2s5ge/6Z1X5aYnAHJ4MqwDXEo=;
 b=rBji0cc3Cj4PdcMNYzXOjIyBxlezkbnW5VU5rLC0i4PfUk1kWGC1j3AZwEmYIk7+oU
 e9OqDM5QK080m2oqv2thBlCW6kJrGnPa3bFbCsjDKJs7gvlYWcnd52jgcyO7nAeW/PUg
 6HUM85QSBpkBVarMCGldl+P/QBAM/i2l30HVSzxnKOU5hFEi/ZifeBygM+BHMkxTO7YA
 BQCX4oBfPgoZdfY3sCHTC2dC94p5fVOLhA6usKsJCnjVBkdxw82jnHHkYSAXRCxZHoI3
 FHLGYyaHMVGwgKyt69T/Ih9J+m0BEjKe0avNSdeddhQXValpkUdw4TSxiLSy7W1getIY
 lidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w3KXGO2QeFTAyb9q+f2s5ge/6Z1X5aYnAHJ4MqwDXEo=;
 b=cvJILtDQQ7wgb3YQMhgqT+QvWYnzs2NmJw/kzXpQwbB5RRF/moxk1vTaIgu4tzxwHb
 iOVhgCbJJJ49CZthzppfTS7KoGrlxtf3OPofd/J/eZR2+AnVm3h7Xt3X3AVh90233F6M
 SQBAQFaa6tNDLNiTmohMXnFLzXhJqN4wl3IENVldzafIhco5JAhCQ1wFUsaZyrS8BWfN
 /4g64QKzTIaC6WKXj2YIidh6YW8lohcD9J8H00MWqTbOaG/jpIOSDubKSyWbJqHgqvQl
 47GMXk5zTguMahpVK7mBN8H2FO06j71Fbsav+ai0AxMj9vjLTAeaWQ/N+rt75leyUxFw
 Q4lQ==
X-Gm-Message-State: APjAAAWG3IBFioJUmftmEiR8EWSQb1tgpSRinMZIMxePnmQBpuu5Y1X/
 S5Va9q5EEpoNAfLQ92Z2ME43W2kTqPo=
X-Google-Smtp-Source: APXvYqx2FhPyynwyaZ/sPUBaDPMPUJdNpZThMB56lB3sMhv+FL6OI9fDVRvVLM7YWwIo9XW9znCJcw==
X-Received: by 2002:a5d:6604:: with SMTP id n4mr24447999wru.267.1568105422932; 
 Tue, 10 Sep 2019 01:50:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n12sm1819993wmk.41.2019.09.10.01.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:19 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B31671FFAB;
 Tue, 10 Sep 2019 09:43:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:27 +0100
Message-Id: <20190910084349.28817-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 23/45] tests/docker: move our ppc64 cross
 compile to Buster
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now Buster is released we can stop relying on the movable feast that
is Sid for our cross-compiler for building tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 93190b1e2a2..b6c04059502 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -104,11 +104,11 @@ docker-image-debian-hppa-cross: docker-image-debian10
 docker-image-debian-m68k-cross: docker-image-debian10
 docker-image-debian-mips64-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
+docker-image-debian-ppc64-cross: docker-image-debian10
 docker-image-debian-riscv64-cross: docker-image-debian10
 docker-image-debian-sh4-cross: docker-image-debian10
 docker-image-debian-sparc64-cross: docker-image-debian10
 
-docker-image-debian-ppc64-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
@@ -117,7 +117,7 @@ docker-image-tricore-cross: docker-image-debian9
 # These images may be good enough for building tests but not for test builds
 DOCKER_PARTIAL_IMAGES += debian-alpha-cross debian-hppa-cross debian-m68k-cross debian-sh4-cross
 DOCKER_PARTIAL_IMAGES += debian-sparc64-cross debian-mips64-cross debian-riscv64-cross
-DOCKER_PARTIAL_IMAGES += debian-tricore-cross debian-powerpc-cross fedora-i386-cross
+DOCKER_PARTIAL_IMAGES += debian-tricore-cross debian-powerpc-cross debian-ppc64-cross fedora-i386-cross
 DOCKER_PARTIAL_IMAGES += fedora-cris-cross
 
 # Rules for building linux-user powered images
diff --git a/tests/docker/dockerfiles/debian-ppc64-cross.docker b/tests/docker/dockerfiles/debian-ppc64-cross.docker
index e5757fe46ee..4bf88ab02dd 100644
--- a/tests/docker/dockerfiles/debian-ppc64-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64-cross.docker
@@ -1,12 +1,11 @@
 #
 # Docker ppc64 cross-compiler target
 #
-# This docker target builds on the debian sid base image which
-# contains cross compilers for Debian "ports" targets.
-FROM qemu:debian-sid
+# This docker target builds on the debian Buster base image.
+FROM qemu:debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
        gcc-powerpc64-linux-gnu \
-       libc6-dev-ppc64-cross || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
+       libc6-dev-ppc64-cross
-- 
2.20.1


