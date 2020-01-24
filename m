Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2023C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F46F20704
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KaD7ITNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F46F20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv1oK-0005U6-Iq
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1mh-0002S3-8e
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iv1mg-0002oT-20
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:15 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:36971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iv1mf-0002my-Sh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:26:14 -0500
Received: by mail-wr1-x42d.google.com with SMTP id w15so2707856wru.4
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cxdjd0+/T8oWcuIOqxYHGy696lLjTHLlcETHinq7j3Y=;
 b=KaD7ITNJAWl9Ml02sjRO2XNqtomycY2eTMOaFAdCO3X9W72h/eNn/oUFpU8nWlJYW2
 TrkhqZjeAgt4EwGKfQGvA3V2842Enrpeo0LVOftTfHibsxxr/cPVUTzta3Q2EQl33W3g
 HJSYhDOXFiGDSq7aLdkggqTYW1di7QpE+161KPWT8E1/Hb45QODXsgr7xROakudy/QvF
 vfgJmWhxk1BNGo2IkY5lOViWsOgO3Or1NU/+iszNwZ6AG4w82MLNKUPq7ozrNXE1x+Yl
 +moiS3SR1OCLLfoJbQYAA6XRxSO/9BkQKAmBWkXSqFfqmt8/AyeyiAovZax748ZKp1qJ
 0qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cxdjd0+/T8oWcuIOqxYHGy696lLjTHLlcETHinq7j3Y=;
 b=sX/qtiVTNnRfJdQ6+twVr8mFIY33O8tgxN1EEJITMED+a/toFR+pBGXIIztCagZ7fH
 gEwhayfaNzwJ+9j4iKt3RavPcc6zZdlymo2ydqD9tyDyD/Yvjg0omBh5ZoM+24sYDelR
 J/hPSdZfzVfGU15BHb7VY25HODLIlzWeDxzX3gvpcgbxowSdF8DkM9Ph01Bseqgk6qOp
 ZlejfsdYnEiQzASIyOOdfh7yzvHVIGWM7aprTbBsNXPwCqjuhaj1iJGJ6PTSw0bBwper
 QhM9NKqINK7EpuhwlO0V0OSRGzEL0hHnpzB+nP96sP0Q57I2ABB2vJoFfZbXUXwtK4sH
 AZ5A==
X-Gm-Message-State: APjAAAVGKk00cpiikKpUNj+7MutcsGrwphSgvn1mOUGzJ/grJaAWnQmB
 eflPAfk3+yw+Tl7HEEWzQYeZJWCQunqrow==
X-Google-Smtp-Source: APXvYqxKeY55agqWYrXeQtnbvp+s+MzPouCj7YH1zkzND+iuYmS8zjgxLyeRaGxDm751BAK8OgnlBw==
X-Received: by 2002:adf:f288:: with SMTP id k8mr5496791wro.301.1579883172529; 
 Fri, 24 Jan 2020 08:26:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q3sm7054998wmj.38.2020.01.24.08.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:26:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/8] hxtool: Support SRST/ERST directives
Date: Fri, 24 Jan 2020 16:26:00 +0000
Message-Id: <20200124162606.8787-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124162606.8787-1-peter.maydell@linaro.org>
References: <20200124162606.8787-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to add support for including rST document fragments
in our .hx files, in the same way we currently have texinfo
fragments. These will be delimited by SRST and ERST directives,
in the same way the texinfo is delimited by STEXI/ETEXI.
The rST fragments will not be extracted by the hxtool
script, but by a different mechanism, so all we need to
do in hxtool is have it ignore all the text inside a
SRST/ERST section, with suitable error-checking for
mismatched rST-vs-texi fragment delimiters.

The resulting effective state machine has only three states:
 * flag = 0, rstflag = 0 : reading section for C output
 * flag = 1, rstflag = 0 : reading texi fragment
 * flag = 0, rstflag = 1 : reading rST fragment
and flag = 1, rstflag = 1 is not possible. Using two
variables makes the parallel between the rST handling and
the texi handling clearer; in any case all this code will
be deleted once we've converted entirely to rST.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/hxtool | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/scripts/hxtool b/scripts/hxtool
index 7d7c4289e32..0003e7b673d 100644
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -7,7 +7,7 @@ hxtoh()
         case $str in
             HXCOMM*)
             ;;
-            STEXI*|ETEXI*) flag=$(($flag^1))
+            STEXI*|ETEXI*|SRST*|ERST*) flag=$(($flag^1))
             ;;
             *)
             test $flag -eq 1 && printf "%s\n" "$str"
@@ -27,12 +27,17 @@ print_texi_heading()
 hxtotexi()
 {
     flag=0
+    rstflag=0
     line=1
     while read -r str; do
         case "$str" in
             HXCOMM*)
             ;;
             STEXI*)
+            if test $rstflag -eq 1 ; then
+                printf "line %d: syntax error: expected ERST, found '%s'\n" "$line" "$str" >&2
+                exit 1
+            fi
             if test $flag -eq 1 ; then
                 printf "line %d: syntax error: expected ETEXI, found '%s'\n" "$line" "$str" >&2
                 exit 1
@@ -40,12 +45,38 @@ hxtotexi()
             flag=1
             ;;
             ETEXI*)
+            if test $rstflag -eq 1 ; then
+                printf "line %d: syntax error: expected ERST, found '%s'\n" "$line" "$str" >&2
+                exit 1
+            fi
             if test $flag -ne 1 ; then
                 printf "line %d: syntax error: expected STEXI, found '%s'\n" "$line" "$str" >&2
                 exit 1
             fi
             flag=0
             ;;
+            SRST*)
+            if test $rstflag -eq 1 ; then
+                printf "line %d: syntax error: expected ERST, found '%s'\n" "$line" "$str" >&2
+                exit 1
+            fi
+            if test $flag -eq 1 ; then
+                printf "line %d: syntax error: expected ETEXI, found '%s'\n" "$line" "$str" >&2
+                exit 1
+            fi
+            rstflag=1
+            ;;
+            ERST*)
+            if test $flag -eq 1 ; then
+                printf "line %d: syntax error: expected ETEXI, found '%s'\n" "$line" "$str" >&2
+                exit 1
+            fi
+            if test $rstflag -ne 1 ; then
+                printf "line %d: syntax error: expected SRST, found '%s'\n" "$line" "$str" >&2
+                exit 1
+            fi
+            rstflag=0
+            ;;
             DEFHEADING*)
             print_texi_heading "$(expr "$str" : "DEFHEADING(\(.*\))")"
             ;;
-- 
2.20.1


