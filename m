Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F20C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7CC20748
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qxZpcVJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7CC20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ80T-0006Lx-VQ
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 23:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zW-0004af-9K
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zV-0008EA-AG
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:06 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJ7zV-0008Dr-4v
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:05 -0400
Received: by mail-pl1-x642.google.com with SMTP id x1so7614334plm.4
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 20:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cw+WZzzhEd4mjQWPUsr/UQXcmfdkOCsgB8L/Xuk7inw=;
 b=qxZpcVJaFb1jtv+OAw3oDhzmEtPCwR4/gKbgDx7xi1xRIeD6z9WjvPmUr6uXGzMYz9
 e+g2o0qFsV7PviiombDQ7ArypNeYJQMjnupFh9eGoK40O7NP0a6njiNFGbZTcyBlMYR3
 yocl2XrXtB6Fl52lAkAAg8/2OmM+KYSzmxjB4OSaMxB4risW2w7/894uapn62ISzyd81
 sFsS3cukM9GwQrpdd36Zin1r7R/TXqmPT+9chMdvY7dNy0N9HbN8DQo8x+/Re/Mc8Xe9
 GgOpxviQFQju7LRmkEboWoRK0zMhLMm7XlebJGPAU4YHVckiAfEhapa3DtTP91+pCQBY
 m84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cw+WZzzhEd4mjQWPUsr/UQXcmfdkOCsgB8L/Xuk7inw=;
 b=e+HJ2cuCMo7u2TRly2oqc2G6wKiJ/xAiLPlV2GltOsO8907TPvWF67Xxgf7ENsIIX+
 H9YXt9IOcd7hrdrD4L1HM/ZMuf2yTXdy1PZzxRlvaagGfQytLNIwfyMn6NPp+oSnzUUg
 F7iCLqsRDkfh+40+6fmKXwerZ4jjXcfsiwzshBiZX8+k88qxCDyWZfaHsvGP44mevXSM
 0hWvMYei9KzTFF1X0LjWBu7GYDbHSFJd3VNUsw2riUQI5ViUmGTQxBIjtpaX2k02yle2
 iZ5rUCXAxPycdpGq7OVgyVObyfsNC1mM37gWwAD5yhzGXaJ1QzJTqZD093KwJeLW3SbN
 l6ig==
X-Gm-Message-State: ANhLgQ2HkfRoUB5ViFef0K4l7kNewuvGXztgQ4t0bDZkMQAuZuWLfmqG
 /XkoDDVbyBB1nE9yNbj4GKAIb2nTfsA=
X-Google-Smtp-Source: ADFU+vsInyVfA4EpyfMh+1f8/1lVKHbYyC0qb0QHQb0ciDj6BCQhMWjV5ZETmtcHyi44z3GxOA8cmQ==
X-Received: by 2002:a17:902:a517:: with SMTP id
 s23mr16150017plq.125.1585626903844; 
 Mon, 30 Mar 2020 20:55:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h11sm11386174pfq.56.2020.03.30.20.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 20:55:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 03/10] configure: Do not force pie=no for non-x86
Date: Mon, 30 Mar 2020 20:54:49 -0700
Message-Id: <20200331035456.6494-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331035456.6494-1-richard.henderson@linaro.org>
References: <20200331035456.6494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PIE is supported on many other hosts besides x86.

The default for non-x86 is now the same as x86: pie is used
if supported, and may be forced via --enable/--disable-pie.

The original commit (40d6444e91c) said:

  "Non-x86 are not changed, as they require TCG changes"

but I think that's wrong -- there's nothing about PIE that
affects TCG one way or another.

Tested on aarch64 (bionic) and ppc64le (centos 7) hosts.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/configure b/configure
index e3ccb8daf0..d4c2c7a563 100755
--- a/configure
+++ b/configure
@@ -2107,16 +2107,6 @@ if ! compile_prog "-Werror" "" ; then
 	"Thread-Local Storage (TLS). Please upgrade to a version that does."
 fi
 
-if test "$pie" = ""; then
-  case "$cpu-$targetos" in
-    i386-Linux|x86_64-Linux|x32-Linux|i386-OpenBSD|x86_64-OpenBSD)
-      ;;
-    *)
-      pie="no"
-      ;;
-  esac
-fi
-
 if test "$pie" != "no" ; then
   cat > $TMPC << EOF
 
-- 
2.20.1


