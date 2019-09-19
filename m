Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F46C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6730D217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l9IaJXbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6730D217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0AI-0002vn-TA
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB06n-0008Kv-Qm
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iB05o-0000QA-Nf
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:19:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iB05o-0000PY-Fw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:19:44 -0400
Received: by mail-wm1-x344.google.com with SMTP id 3so4883673wmi.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/SabVeqMLjGlYBjbqwgWwIsgPvMvXk0prLQNMqx1ZLQ=;
 b=l9IaJXbHzaDjv78RIwWaOcwMt7q+aF9wRZFg39Qqxc20uro1e7b9AcojUQNciBAAUC
 2+3bmB5l70LPmbiKuId6ZAp/YoYgE+qZxtMGRQhe9eAk9kmSKB+Z8XD2STa1HhHga7aj
 vWKNGPBisKtpCtJZFeCMw/WtROEeYYKqe3IDvseq07wHK4V/0skgDfS+hIbbqBHQ8c2p
 Mx7I+4GUyOe1/zB4UuYMPqULuMIwo+57z3/fKRUF+PdHfbjKs7xqS+qPAZ2IBZNZwhqU
 3M9hGBJSHI/vvg5Glr01qsBsPN3FG7hyRCCjCk1hnu4cn7IPewRcFxL4QWpw5VBW6SU6
 zbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/SabVeqMLjGlYBjbqwgWwIsgPvMvXk0prLQNMqx1ZLQ=;
 b=DRADp6c06HZBvvtWy2I7pH4NsRneF1zWD5Ab1bxBqNkZoMFvCbjBKIstCkLETPVUDU
 Wn9OsGFJufy0ZKvI/pz8LOvTAjAo30VosH0R2G9OTxNLC6ra+g3eLhOX79ASVo2MUIjN
 RyexlzfQOiVUAUVnz2yw+t++eFJr01EE7+MS0J1V9HOnb05Yznqx54HhaCjElcItO8Oq
 cmDxVZYJIHIj8rCCtpINK5FLqqrIS3kNgyHq41c02i44sh65QoT7WSlgtcSjZw/nF6/S
 ZmUmnpJK94wkMi72DRtEdGMp9cKUQb7IDgEM8cJ15H2iX2eVRO/e2/ztXUiwLlNqclFr
 52Cw==
X-Gm-Message-State: APjAAAUG5yuh3yFMJf3iX1bf20TMHqf5N3LRym6icgkIIYdOfQu34Mk2
 wrC8l/BNaYJHiV7JBRZ4E7PPPQ==
X-Google-Smtp-Source: APXvYqx3Nk+j0sqeD0lEUHPT+wNLc3/P+ehPJ1Kf7h9SSGv1yUv7ecijwyS6cjV33qU4csSjPVea8Q==
X-Received: by 2002:a05:600c:28d:: with SMTP id
 13mr3884920wmk.84.1568913583400; 
 Thu, 19 Sep 2019 10:19:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z142sm12389182wmc.24.2019.09.19.10.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:19:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 292F31FF8C;
 Thu, 19 Sep 2019 18:10:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 15/16] docs/devel: add "check-tcg" to testing.rst
Date: Thu, 19 Sep 2019 18:10:14 +0100
Message-Id: <20190919171015.12681-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It was pointed out we haven't documented the check-tcg part of the
build system. Attempt to rectify that now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing.rst | 62 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bf75675fb04..1feee3ad101 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -266,6 +266,8 @@ another application on the host may have locked the file, possibly leading to a
 test failure.  If using such devices are explicitly desired, consider adding
 ``locking=off`` option to disable image locking.
 
+.. _docker-ref:
+
 Docker based tests
 ==================
 
@@ -799,3 +801,63 @@ And remove any package you want with::
 
 If you've used ``make check-acceptance``, the Python virtual environment where
 Avocado is installed will be cleaned up as part of ``make check-clean``.
+
+Testing with "make check-tcg"
+=============================
+
+The check-tcg tests are intended for simple smoke tests of both
+linux-user and softmmu TCG functionality. However to build test
+programs for guest targets you need to have cross compilers available.
+If your distribution supports cross compilers you can do something as
+simple as::
+
+  apt install gcc-aarch64-linux-gnu
+
+The configure script will automatically pick up their presence.
+Sometimes compilers have slightly odd names so the availability of
+them can be prompted by passing in the appropriate configure option
+for the architecture in question, for example::
+
+  $(configure) --cross-cc-aarch64=aarch64-cc
+
+There is also a ``--cross-cc-flags-ARCH`` flag in case additional
+compiler flags are needed to build for a given target.
+
+If you have the ability to run containers as the user you can also
+take advantage of the build systems "Docker" support. It will then use
+containers to build any test case for an enabled guest where there is
+no system compiler available. See :ref: `_docker-ref` for details.
+
+TCG test dependencies
+---------------------
+
+The TCG tests are deliberately very light on dependencies and are
+either totally bare with minimal gcc lib support (for softmmu tests)
+or just glibc (for linux-user tests). This is because getting a cross
+compiler to work with additional libraries can be challenging.
+
+Other TCG Tests
+---------------
+
+There are a number of out-of-tree test suites that are used for more
+extensive testing of processor features.
+
+KVM Unit Tests
+~~~~~~~~~~~~~~
+
+The KVM unit tests are designed to run as a Guest OS under KVM but
+there is no reason why they can't exercise the TCG as well. It
+provides a minimal OS kernel with hooks for enabling the MMU as well
+as reporting test results via a special device::
+
+  https://git.kernel.org/pub/scm/virt/kvm/kvm-unit-tests.git
+
+Linux Test Project
+~~~~~~~~~~~~~~~~~~
+
+The LTP is focused on exercising the syscall interface of a Linux
+kernel. It checks that syscalls behave as documented and strives to
+exercise as many corner cases as possible. It is a useful test suite
+to run to exercise QEMU's linux-user code::
+
+  https://linux-test-project.github.io/
-- 
2.20.1


