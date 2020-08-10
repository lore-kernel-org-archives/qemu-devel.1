Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD58C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CADC22BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUuPW5X9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CADC22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DwD-0008VK-IP
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dow-00018Y-RR
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dov-0004yC-5D
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id z18so9298060wrm.12
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OiS7jf9/E4jzfaL7m5CjkFMwe4+1gVTXRlsOG3FVJ2Q=;
 b=uUuPW5X9VJgTOhuyrS43fEgnW75PjzRUK/wBPtydElNt6/uNIMQ27wy6gHL/OqVHch
 PnAZtGJuJX/GcPF9lhiANfuV9FE2LhOWtbM7AxG2waCLQrV3PhGAefDnOjGvk0ENBsi6
 qA1dGxcaO6H6H09ht22hOxSFOKup5Rbb1YYkZGNUK+7V5LZ1hjzvPcvf56/BPYYjpWRD
 5N7YFh4Hklor3SY0I/E1Bv5o3SQoGylFtorienkn+rFdEGhQT3200ooNdeteQvRMKJYJ
 crUI8zvmwLpt2li8dVMSKZOY1IHTT2EhAnT9xT0hrLIwcocHXICIlMzlR0vE84kg5MzZ
 ztpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OiS7jf9/E4jzfaL7m5CjkFMwe4+1gVTXRlsOG3FVJ2Q=;
 b=SjKtp4tvy4lWJHWoktNQs3gpIdYAKWPSBiIxpVvG/M+vNkujz3SFrIrorQQMI2h1+m
 GHAt1/s0C1Nufqb5NjVGedeEVou3wT4UtBWz9a+ud4sPkenDelxt8FCKVOVMyNK5fz8Y
 t6U8UBsKvWGqx/9YUB9plpGlVr66fJWvjFCEGFJxDaqbZldIit2u9MI1i/xHdNEF6cIw
 CdLIED1yXB/R4p+8ZgQNBXlW4QYQsfRBV0zbEmd7FSCfpAlWitOVIRmeEZ2rMjIHcaXc
 UesrleyEAf8FnM/Oq0xnza6cr41kNxrVCh8R8YTUMbtJaPqADV0Vg2WQ3iDKgcE2XYTd
 NrRA==
X-Gm-Message-State: AOAM5311Z4h1bfXbdz1j71Ea75rYGqjMCsZi+ZBG3BbsVmzsLzjhlUqg
 SesiZzsL5zWH6sQUH/XibrBThSsH5hmuUg==
X-Google-Smtp-Source: ABdhPJxaiMlRkFmKhkDYwhrHDVAHRbKGlSWILzzOi1ulMIlNk7odXKK5djKsCmib5LOpVURdG02cpQ==
X-Received: by 2002:a5d:544f:: with SMTP id w15mr2897757wrv.208.1597089055109; 
 Mon, 10 Aug 2020 12:50:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 19/20] configure: Drop texinfo requirement
Date: Mon, 10 Aug 2020 20:50:18 +0100
Message-Id: <20200810195019.25427-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need the texinfo and pod2man programs to build our documentation
any more, so remove them from configure's tests.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 2acc4d1465f..ae66ceeeaae 100755
--- a/configure
+++ b/configure
@@ -5105,14 +5105,14 @@ if test "$docs" != "no" ; then
   else
     sphinx_ok=no
   fi
-  if has makeinfo && has pod2man && test "$sphinx_ok" = "yes"; then
+  if test "$sphinx_ok" = "yes"; then
     docs=yes
   else
     if test "$docs" = "yes" ; then
       if has $sphinx_build && test "$sphinx_ok" != "yes"; then
         echo "Warning: $sphinx_build exists but it is either too old or uses too old a Python version" >&2
       fi
-      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and a Python 3 version of python-sphinx"
+      feature_not_found "docs" "Install a Python 3 version of python-sphinx"
     fi
     docs=no
   fi
@@ -6593,13 +6593,6 @@ if test "$solaris" = "no" && test "$tsan" = "no"; then
     fi
 fi
 
-# test if pod2man has --utf8 option
-if pod2man --help | grep -q utf8; then
-    POD2MAN="pod2man --utf8"
-else
-    POD2MAN="pod2man"
-fi
-
 # Use ASLR, no-SEH and DEP if available
 if test "$mingw32" = "yes" ; then
     for flag in --dynamicbase --no-seh --nxcompat; do
@@ -8008,7 +8001,6 @@ echo "LDFLAGS_SHARED=$LDFLAGS_SHARED" >> $config_host_mak
 echo "LIBS_QGA+=$libs_qga" >> $config_host_mak
 echo "TASN1_LIBS=$tasn1_libs" >> $config_host_mak
 echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
-echo "POD2MAN=$POD2MAN" >> $config_host_mak
 if test "$gcov" = "yes" ; then
   echo "CONFIG_GCOV=y" >> $config_host_mak
   echo "GCOV=$gcov_tool" >> $config_host_mak
-- 
2.20.1


