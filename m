Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A697C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B672071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGIZODHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B672071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHx6F-0004RS-Sl
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 18:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx5B-0003Gs-O7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHx5A-0000iM-N5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:05 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHx5A-0000fH-Ha
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:04:04 -0400
Received: by mail-pf1-x442.google.com with SMTP id c21so4494892pfo.5
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 15:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MJ7nDsplw+ocPp9vnnkEeeJdkP45dluwjo/j6FpQjog=;
 b=SGIZODHWqW/hjwO6DzDa1UhrIRnAj63GCiwop5oSfaPElIjnh+CUqjWHEpaXCoGiQa
 ZhGVRc/hhtLRVNRwMVttfLhDy7Mza4n9caXl3X/qBapIx4VghmIiiR8bPGbFNr+jeq2H
 9NQxdo3z9v2DqCgT7Z+zjBmty7p8tc5PozFesPiA7CaVxWziiO24IrkusBqyqRy5+RJk
 HFLLzggNeg33XRVml6B+mL3arE6i3Tte0XHHGY+TxY0A/huu7EF5gNzf7+Ugjk2yTnuh
 kl/ffaNCDw2WL+9Ptcz9cOjv9tjAiZCrySPlGOWp8676r6gNd8V+VR8YUkZlOLnsVX/2
 +Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MJ7nDsplw+ocPp9vnnkEeeJdkP45dluwjo/j6FpQjog=;
 b=KWRwFBJfvAqCDrnKqTox5WCnt03XJI58ggXxjIBqf1r89juTf3jcMy9G3PxcxTDqNI
 GY8GwyEQdA83MMTBwLJjTPa6pn+xNLWFxIiBhuuqj93IKDdzsY2JmItD8qAgZH/QvSbz
 Qqy1J6apn3AzeuFiwrsmkhKmvIPpwv2R/Rxexpwq/pB5KqESK0hM7waK2QXJ86uoVKyJ
 yq9WU8WWtVw2cVuv9ACsdSgnpZ+tHdpXfhvzruL1mRCyCXWn60DPG6U1Vg+W+gPhLSS1
 Oqnfnwehos3O9i/oLuezsUrk01jmWOPuJHI8dOpfL7C9mayo8j+kiT3Olej5yj7EkPVs
 LcdA==
X-Gm-Message-State: ANhLgQ1gc3zRLiy+c3GZciupxuodet8dTiOqzlMPX9yXO3tyGmdSihqs
 MTvKGc5svu3tiY4bArMXz0bog4Koo10=
X-Google-Smtp-Source: ADFU+vviO2tLdpvUxMHpTYrsfu9O5Btp0841gan6FWzX7aYZhZWtLf9ryzOAUP5ksHKvwJ0PiGOo7w==
X-Received: by 2002:a63:a1e:: with SMTP id 30mr1455858pgk.146.1585346642695;
 Fri, 27 Mar 2020 15:04:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id y29sm4516929pge.22.2020.03.27.15.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 15:04:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 v3 5/7] configure: Unnest detection of -z, relro and -z,
 now
Date: Fri, 27 Mar 2020 15:03:51 -0700
Message-Id: <20200327220353.27233-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200327220353.27233-1-richard.henderson@linaro.org>
References: <20200327220353.27233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: dim@FreeBSD.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fangrui Song <i@maskray.me>, alex.bennee@linaro.org, roger.pau@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is nothing about these options that is related to PIE.
Use them unconditionally.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Fangrui Song <i@maskray.me>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Do not split into two tests.
v3: Update to QEMU_LDFLAGS.
---
 configure | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 7ba18783cb..4dead416ae 100755
--- a/configure
+++ b/configure
@@ -2129,9 +2129,6 @@ if test "$pie" != "no" ; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
     QEMU_LDFLAGS="-pie $QEMU_LDFLAGS"
     pie="yes"
-    if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
-      QEMU_LDFLAGS="-Wl,-z,relro -Wl,-z,now $QEMU_LDFLAGS"
-    fi
   else
     if test "$pie" = "yes"; then
       error_exit "PIE not available due to missing toolchain support"
@@ -2142,6 +2139,12 @@ if test "$pie" != "no" ; then
   fi
 fi
 
+# Detect support for PT_GNU_RELRO + DT_BIND_NOW.
+# The combination is known as "full relro", because .got.plt is read-only too.
+if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
+  QEMU_LDFLAGS="-Wl,-z,relro -Wl,-z,now $QEMU_LDFLAGS"
+fi
+
 ##########################################
 # __sync_fetch_and_and requires at least -march=i486. Many toolchains
 # use i686 as default anyway, but for those that don't, an explicit
-- 
2.20.1


