Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1CCC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC3720721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwVC0Frm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC3720721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZgH-0006jU-MI
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:14:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfS-00052f-Se
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZfR-0000d8-JH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:26 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyZfR-0000cV-D8
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:13:25 -0500
Received: by mail-wm1-x335.google.com with SMTP id a9so16447115wmj.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SMXWwK9C5fyLAmwrWfFqG+ePKSfUA5YuxleAhhfwIiE=;
 b=ZwVC0Frmh5sJkF2GYUdNpncFMDqe3+RcZz8ycM96Fp6ipYQFQs4PxroGcDY2bbef1W
 qzJoJNRyLa44pUA64gzWwxVRBKIGCAPFYlXzbmlmDBbykjeQuWrIYDdqDiAD+pDultwE
 Pl96FMt+KcwtD0lbTB1hm6Cib0oH3Lz3/h5e96mZK4bfySBkw0gDvGjO3iO58aOzGJk8
 vjmQN+6rsrKKGfE/gk5ir3gVHh3XywUyll0t55ZX8XgiFTpYdCkc8IIsgPxrUZsCl6/M
 o8pa2nvccjzpJ2ddiuV1a7aBxRHvIC0zbXeqlc6dsG1bZJx/AhIK3vmlpuROZl0cjXhp
 RlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SMXWwK9C5fyLAmwrWfFqG+ePKSfUA5YuxleAhhfwIiE=;
 b=AFCkx4fxhleuotbSlUP/uonF3vQgQ1XBT5rgzAUH7euXMcvJQj+UlqrRIZtm2FEBQ3
 MbfnJOqmryqmgzNjkxav1GWjPc/099Y98bMjSl+NGHeCl7u/qr3ga2hiZ7NHKbKKQ56+
 JgXy8g8IGz19ENLJjGC/ut9Psmi1s6B5HMOH9XflVtpwBa5eDvrgxPXJKmI+WaQqLfvg
 zFEER97v5uvzm5OJIgv9argN1vJ7A9/yXSRqp0CjbIYC3KcYy/+CLqvDuHaSBgsAOPY/
 XjMhSeguj+ybmIbsrGY7JiIHNJgZH0ISXnpoavaaAj6m/7feWBP6N7mQUMr5iGn4ITBr
 emOg==
X-Gm-Message-State: APjAAAWWzAF1SZvQ7Ddj4Penzy15S1OfFCTtq5TkBd0wlh1fjaTjbpF+
 f6Po2xNaHWJuFiDEtGo0729prbEyN9WTHA==
X-Google-Smtp-Source: APXvYqzBwqgCEoQdXPVIs6IY7VUMEpH5USVkNsuY6whKbo9ZvkV9CKmWPuccV7YP/dp5b4X/2F6Sxg==
X-Received: by 2002:a05:600c:22c8:: with SMTP id
 8mr28605147wmg.178.1580728403357; 
 Mon, 03 Feb 2020 03:13:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm24028917wme.35.2020.02.03.03.13.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 03:13:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] hxtool: Support SRST/ERST directives
Date: Mon,  3 Feb 2020 11:13:12 +0000
Message-Id: <20200203111318.23378-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203111318.23378-1-peter.maydell@linaro.org>
References: <20200203111318.23378-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200124162606.8787-3-peter.maydell@linaro.org
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


