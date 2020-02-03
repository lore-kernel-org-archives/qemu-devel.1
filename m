Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C99AC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8B22070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MwSofj/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8B22070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXqX-0001ej-SX
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjt-00072h-4m
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjs-0001FK-1V
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:53 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjr-0001El-Ro
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:51 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so15978635wmf.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2Ucn3/AM0D3+nUeurTNibmdkWf/khIKHvnRzsWso6SI=;
 b=MwSofj/NWTgnl2G7GnohKZgt4n27UfO6ovBcR4leZlYdJjp3DYxhNqnpIkZ3M3iwni
 BzGv0AgXrcH1oTru9VfTH0nRMp+ajYQLzeYWMDz/WjxbQXQeuKK3zkuQ7rFdK+XexPWu
 BRsKw99gPcK/5tSweMFJc69QQ5byqtK1SN7EzkraFY2ohEWf8+DDSCpJG4PPFATw0vR4
 XY3RZGJ6rvoYwjno0yXrcNAaIgDycgNJtMpA3gBYmhBsW77GtJNueSQN1zN0NiSuzrsM
 FAgSpFcK+ewC2e4sJkwQAmMs/dvqW5ANam0fdLIxOo4dZlhKqfQqn9NVLeMSQIj4G4PC
 DGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2Ucn3/AM0D3+nUeurTNibmdkWf/khIKHvnRzsWso6SI=;
 b=Yf7ye7xEcJk3n160dF6dvSCOXnS4R8dQQG7yUjSuUy3zim1OToBQC74XqLGgxfDDKv
 qGvqUei0TVzNtbFmFFeTHYF65GgKohM+NXnUGM0W+sLzAp1k3QC4IFzLIniCLbEF3wFG
 MIZYT435t/IUACYHWOQeTBHQbaPj50MvbPIQzF6mDgDhg9KSpwt29F0IERh7WF/NPdrP
 KHBQzUarxOcCU2RzUHpr1GgDoRndN51z3ZEKHnhB/NBhHVNklXwOF9Tm2wVk5pZv9lHl
 o9ni/VhNa6/E1uLR+ZDjGaqYJIF1iRvoHAmY319Gh9IdEthLyITNwdsKio948kkozSxM
 pzwg==
X-Gm-Message-State: APjAAAVzaxUJbPJPSkrMYWCd2NPIEMytHJKYyIrAybsJzOCbUwJ3k4Gp
 HOXxmB5A644PpRaNQR/Mj3BVWQ==
X-Google-Smtp-Source: APXvYqwds1zh/1VzMXz7j7wEa1rs1L9T7+uRDwjsh1apUXIEUQaMnEmCYz0vz8fD2SzXzIwaJuKa+w==
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr28645536wme.21.1580720990848; 
 Mon, 03 Feb 2020 01:09:50 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t9sm14278506wrv.63.2020.02.03.01.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:42 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 658A11FF9C;
 Mon,  3 Feb 2020 09:09:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/17] tests/tcg: add a configure compiler check for
 ARMv8.1 and SVE
Date: Mon,  3 Feb 2020 09:09:27 +0000
Message-Id: <20200203090932.19147-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will need this for some tests later. The docker images already
support it by default.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/configure.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 210e68396f2..e0d1fbb182f 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -216,6 +216,20 @@ for target in $target_list; do
       echo "CROSS_CC_GUEST_STATIC=y" >> $config_target_mak
     fi
     echo "CROSS_CC_GUEST=$target_compiler" >> $config_target_mak
+
+    # Test for compiler features for optional tests. We only do this
+    # for cross compilers because ensuring the docker containers based
+    # compilers is a requirememt for adding a new test that needs a
+    # compiler feature.
+    case $target in
+        aarch64-*)
+            if do_compiler "$target_compiler" $target_compiler_cflags \
+               -march=armv8.1-a+sve -o $TMPE $TMPC; then
+                echo "CROSS_CC_HAS_SVE=y" >> $config_target_mak
+            fi
+        ;;
+    esac
+
     enabled_cross_compilers="$enabled_cross_compilers $target_compiler"
     got_cross_cc=yes
     break
-- 
2.20.1


