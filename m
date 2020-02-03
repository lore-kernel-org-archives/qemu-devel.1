Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1DFC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B7920721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOSerxc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B7920721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXr7-0002mg-98
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjw-0007Cv-Gf
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjv-0001Jx-9Q
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:56 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:39756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjv-0001JI-2u
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:55 -0500
Received: by mail-wm1-x32b.google.com with SMTP id c84so15953879wme.4
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VwZpL5U6qDCdNJrjf9NYp5QpUgNZfUar63YIMPVfZmY=;
 b=AOSerxc0RZJ0xynPKOlfM2ydpEidGiJHGqai4hBdEZLp+3FklJ3SVPJUN3tQX57Jw5
 Ph7Lb/2vN4AblWgnlFOX/2D8EjRlDnQG6Gbw7Fjv74ihP3iWcESAo17zx7cPO/s+qwmx
 XMGkPf96W1y16M8mX37VZt11tJ+nqS2i/tj1+DMHIDcenngEZ509ZiBM3hBz0GPx6Zyn
 JDb9eEtQ7pfRDmA9xRD6aG4GRrRM3ko3mSoFrnhYrzdh689O9oYSpqj2FUgnDfRqKqZ5
 0AuP+k/S7+Y609SGhEy5a80iATsFsUUAD8Hvf/8RXfPh6qh/2pWeWDEl2qbwUpB5J9Vr
 96Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VwZpL5U6qDCdNJrjf9NYp5QpUgNZfUar63YIMPVfZmY=;
 b=JFHLF9imOXnJ+ocTQndk1N73pOdLx5GnKeb1Dhuqm+oREAwbnLiIo/guO4QAcMCOcP
 x01fQnbtp2i9I1dn8dA3B8LYQ2gWZTun/O0YTAOjPxls1seLUFy5X5NCsBx62qtopOVQ
 uJrPykSqOueJuUvNUQw2SWyvJHmQooeBO9rfIaOXfN7siLNWp18GYJoi+tQGGatR4EiP
 ivBQiPM/yPqs/se9c5ehzEoVVBW2Xc1tAaUbcFhngwNYYnJlgvzrgVMb7OcGto25T+9H
 okVcCMF9X78IgLwjt9FU5pV1OSUqe4w00iSCDsLYiV+Rc299Vp0NL50NM86zfpS85wyO
 PsJA==
X-Gm-Message-State: APjAAAUsMoV2dvry/D62z/HsWFB+VdERtuk+NhXM9/HV5EJDh37fg9Yn
 DWEzOb7MWD4dYfvvtQgly4NO0w==
X-Google-Smtp-Source: APXvYqy07o2tKQPgVOHm03n1fw9egosT0kFzPVaTnlI/AYDDtMI8zrntt33xB2RVwsgUin9MVRL/eg==
X-Received: by 2002:a05:600c:118a:: with SMTP id
 i10mr28477908wmf.142.1580720994073; 
 Mon, 03 Feb 2020 01:09:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b13sm10107786wrq.48.2020.02.03.01.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:48 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7EB001FF9D;
 Mon,  3 Feb 2020 09:09:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/17] tests/tcg: gate pauth-% tests on having compiler
 support
Date: Mon,  3 Feb 2020 09:09:28 +0000
Message-Id: <20200203090932.19147-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise we end up failing to build our tests on CI which may have
older compilers that the user expects. We can get rid of this once we
can fallback to multiarch containers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 12 +++++++++---
 tests/tcg/aarch64/Makefile.target         |  2 ++
 tests/tcg/configure.sh                    |  4 ++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index f6b5121f5ce..d2299b98b76 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -61,7 +61,13 @@ run-memory-replay: memory-replay run-memory-record
 	   	  $(QEMU_OPTS) memory, \
 	  "$< on $(TARGET_NAME)")
 
-run-pauth-3: pauth-3
-pauth-3: CFLAGS += -march=armv8.3-a
+EXTRA_TESTS+=memory-record memory-replay
 
-EXTRA_TESTS+=memory-record memory-replay pauth-3
+ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_3),)
+pauth-3: CFLAGS += -march=armv8.3-a
+else
+pauth-3:
+	$(call skip-test, "BUILD of $@", "missing compiler support")
+run-pauth-3:
+	$(call skip-test, "RUN of pauth-3", "not built")
+endif
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index efa67cf1e9e..8ed477d0d51 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -18,9 +18,11 @@ run-fcvt: fcvt
 	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
 
 # Pauth Tests
+ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_3),)
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4
 run-pauth-%: QEMU_OPTS += -cpu max
 pauth-%: CFLAGS += -march=armv8.3-a
+endif
 
 # Semihosting smoke test for linux-user
 AARCH64_TESTS += semihosting
diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index e0d1fbb182f..9eb6ba3b7ea 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -227,6 +227,10 @@ for target in $target_list; do
                -march=armv8.1-a+sve -o $TMPE $TMPC; then
                 echo "CROSS_CC_HAS_SVE=y" >> $config_target_mak
             fi
+            if do_compiler "$target_compiler" $target_compiler_cflags \
+               -march=-march=armv8.3-a -o $TMPE $TMPC; then
+                echo "CROSS_CC_HAS_ARMV8_3=y" >> $config_target_mak
+            fi
         ;;
     esac
 
-- 
2.20.1


