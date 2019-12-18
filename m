Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D87C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5B6206EE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSDo/qpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5B6206EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihPw3-0000VD-Un
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPs6-00049R-SO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPs4-0002kL-Oz
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:34 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihPs4-0002jj-JW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:32 -0500
Received: by mail-pf1-x441.google.com with SMTP id 4so385241pfz.9
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 19:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IVABMN0hJYlQXO1glbSSBN/F4pdMjp3DIhyEvyino7c=;
 b=SSDo/qpYhLTxx5ztb+3nRQGRrHrPeNn6y4BeS90fRI+xFdHV3IXpC8lVNzQ095sSwE
 0R82gSpua4KmLmJN1WnTc8PYHeRlLHnv7fT/1GB/R4XqMre5+FhUE/qAjHAMqe83TOin
 VXWkPEb3X5MZdVg3tfrBL/G7JH4QGDdEgXBc8t1SYWPRhej5bXSaAxfIYB+MP/J0BAVr
 kC3J/oJwtw+uF9VbKdGZeHMOU4fOfYtMLZOp/czIcl1HxugSBJVnXox/Fl6+85ozjopm
 Huo/504ckZIvREvtng90CwtPJ4uhbwOfszfudb6EwXs7rxMEKXTPuHL8QJ967OdbNuJ9
 ph8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IVABMN0hJYlQXO1glbSSBN/F4pdMjp3DIhyEvyino7c=;
 b=DMC1uDRgxHdyIG/rCRdPNko8dpt4KblRlqdCYUCkJsB7CLsmFtf9g5bbcM4xyoEDZw
 Nws93BUnzUv//+3qpngNXberPOouX4epVZrS6pPjtuEIdXWo6QwSpM5cMKHsVfWoLEfA
 2TMPMLVKRj/aoauITNNcq2O0dwaRtF4qXgm7VPQaCRCNVeKh8usvAmqxgfKp4oLAp8cd
 4Kr1/97Q+7xHPYqoM6p+/4O9+PWxkrNzlmlLIBbybMsLIEvMyGwnqF59YHQs6jhGN0lK
 Gh15jgIEEuRHh+EGxfKGVz4YG3E9GtTzzaGiqRNsIkQ85rnLNDnkaK1pFNSt+nDssrmd
 TH3g==
X-Gm-Message-State: APjAAAUXnnJ0BOPlaZTjvhEKTN/ukrfTQ51g4eb0rzWqYQTsThEQUCf6
 Bl7zzxOPA/+TnI+DETD68/kTCIOztHw=
X-Google-Smtp-Source: APXvYqw9lrS94GUPXHsMFF5nhNCcSXjGjJ2r6QqfUTbHKsk0WYkWLYHBMlP3/esnNBQB/dPv1PJGSA==
X-Received: by 2002:a63:4b48:: with SMTP id k8mr326832pgl.362.1576639171240;
 Tue, 17 Dec 2019 19:19:31 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id k27sm404870pfp.66.2019.12.17.19.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 19:19:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] configure: Unnest detection of -z,relro and -z,now
Date: Tue, 17 Dec 2019 17:19:18 -1000
Message-Id: <20191218031920.6414-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218031920.6414-1-richard.henderson@linaro.org>
References: <20191218031920.6414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: philmd@redhat.com, i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is nothing about these options that is related to PIE.
Nor is there anything that specifically ties them to each other.
Use them unconditionally.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 972ce7396f..f8981eec15 100755
--- a/configure
+++ b/configure
@@ -2034,9 +2034,6 @@ if test "$pie" != "no" ; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
     LDFLAGS="-pie $LDFLAGS"
     pie="yes"
-    if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
-      LDFLAGS="-Wl,-z,relro -Wl,-z,now $LDFLAGS"
-    fi
   else
     if test "$pie" = "yes"; then
       error_exit "PIE not available due to missing toolchain support"
@@ -2047,6 +2044,16 @@ if test "$pie" != "no" ; then
   fi
 fi
 
+# Detect support for DT_BIND_NOW.
+if compile_prog "" "-Wl,-z,now" ; then
+  LDFLAGS="-Wl,-z,now $LDFLAGS"
+fi
+
+# Detect support for PT_GNU_RELRO.
+if compile_prog "" "-Wl,-z,relro" ; then
+  LDFLAGS="-Wl,-z,relro $LDFLAGS"
+fi
+
 ##########################################
 # __sync_fetch_and_and requires at least -march=i486. Many toolchains
 # use i686 as default anyway, but for those that don't, an explicit
-- 
2.20.1


