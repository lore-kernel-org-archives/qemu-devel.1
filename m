Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F8C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEE520663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDaX+DG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEE520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO63G-0005cy-2g
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 16:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO62g-0005Dt-QF
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO62f-0007QS-L0
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:50:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:36322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO62f-0007QI-FP
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:50:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id u13so11218329wrp.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 13:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AYMAqmFGrqu8cY7KLFJtaKcRzl2CAk958x2nV2IeMnc=;
 b=SDaX+DG69w9fYNwhavk7u5aGy/srvj+4JSyMk9/HKwhP43qMy+YTzAmpFlKD0Kf8WQ
 R4csbfi7Ju/oBBNEqVYb/tbj1oLAGmJe3NFqcIFPoXM3MnDGsbCFUNzT5hIkM9Ely3XV
 CqQXf6md1DuKoL7F4pJRe07F3SWcOnfYlaYiRyZjOrK1s88UF5NDc4A74rH3AiHDE9du
 sOzFgwxSfl2dMeiRQZO0gk8mp2URLpbXMEVvSrceX9HgJsNlQwVIVQELB2TY2n1+VhlW
 I9Fz0XyrTtu7pnmLys4p2pN92cCBQM7fdeHLbx2+/6B3PVsKlB1R6a0XgBKxf1UrYaez
 XPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AYMAqmFGrqu8cY7KLFJtaKcRzl2CAk958x2nV2IeMnc=;
 b=R7c6JzHb3ZD179s7JKUENz4tRsP2lupya0hPkAoGRzhu0fvhzP6ADhkOZX4Rpk4WOk
 vGwFXruCwu7hY/SQV7pZ+9mP4DsLlIO0TFo931zPCuhw6WbulkHXccsI/D7AkjvEIKZV
 xZgqErHP1NoNokwDY5hAW30lGWaBwkKEmIj7XUW9qQU/s4VD4NO62ZgeFi8ZOs+SNGQ9
 Zdmwo7zW7fFtpotf5OifISewMNfPPn4vRCeJjPU1RJVFC8YYQ05LI6XWh43dsJn0W7Y4
 dJKNSczU1hRymbA3YwNKIAThlhXX/Zrp5ja96jo4Nbz+F1wT9CgJICZH2sjGsZUIKAYL
 c1fw==
X-Gm-Message-State: AGi0PubtOZR9n+Xpa37S1VG05r2hxbYJ0S6b6X+IhDG8tpmicUuYSoWZ
 ioAnXLa+dY7hwczh/LRC3DABKxXE0u0=
X-Google-Smtp-Source: APiQypLAOatj+YxxI2Pu8F/0jUoCxkcEAiKV55+AH5dVJSIqFSFrnhuTLcDnM+ps6+RKwYRag4IDvg==
X-Received: by 2002:a5d:4248:: with SMTP id s8mr19950773wrr.216.1586811051860; 
 Mon, 13 Apr 2020 13:50:51 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j13sm16991001wro.51.2020.04.13.13.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 13:50:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 3/7] scripts/coccinelle: Find eventually missing
 error_propagate() calls
Date: Mon, 13 Apr 2020 22:50:40 +0200
Message-Id: <20200413205040.518-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: 20200412224517.12869-1-f4bug@amsat.org
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In some places in we put an error into a local Error*, but
forget to use it. Add a Coccinelle patch to find such cases
and report them.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .../find-missing-error_propagate.cocci        | 53 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 scripts/coccinelle/find-missing-error_propagate.cocci

diff --git a/scripts/coccinelle/find-missing-error_propagate.cocci b/scripts/coccinelle/find-missing-error_propagate.cocci
new file mode 100644
index 0000000000..8b75b37b64
--- /dev/null
+++ b/scripts/coccinelle/find-missing-error_propagate.cocci
@@ -0,0 +1,53 @@
+// Find places likely missing error-propagation code, but code is too
+// complex for automatic transformation, so manual analysis is required.
+//
+// Copyright: (C) 2020 Philippe Mathieu-Daudé
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch \
+//  --macro-file scripts/cocci-macro-file.h --include-headers \
+//  --sp-file scripts/coccinelle/find-missing-error_propagate.cocci
+//
+// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg691638.html
+
+
+// First match two subsequent calls using local Error*
+// in function provided a Error** argument
+//
+@discard_func_with_errp_argument@
+typedef Error;
+Error *local_err;
+identifier func, errp, errfunc1, errfunc2;
+@@
+void func(..., Error **errp)
+{
+ <+...
+ errfunc1(..., &local_err);
+ ... when != local_err          // local_err is not used between the calls
+ errfunc2(..., &local_err);
+ ...+>
+}
+
+
+// Again, match two subsequent calls using local Error*
+// but ignoring within functions provided a Error** argument
+//
+@manual depends on never discard_func_with_errp_argument@
+Error *local_err;
+identifier errfunc1, errfunc2;
+position p;
+@@
+ errfunc1@p(..., &local_err);
+ ... when != local_err
+ errfunc2(..., &local_err);
+
+
+// As it is likely too complex to transform, report the hit
+//
+@script:python@
+f << manual.errfunc1;
+p << manual.p;
+@@
+print("[[manual check required: "
+      "error_propagate() might be missing in {}() {}:{}:{}]]".format(
+            f, p[0].file, p[0].line, p[0].column))
diff --git a/MAINTAINERS b/MAINTAINERS
index 77b93612bc..1150ec95a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2058,6 +2058,7 @@ F: scripts/coccinelle/add-missing-error_propagate.cocci
 F: scripts/coccinelle/err-bad-newline.cocci
 F: scripts/coccinelle/error-use-after-free.cocci
 F: scripts/coccinelle/error_propagate_null.cocci
+F: scripts/coccinelle/find-missing-error_propagate.cocci
 F: scripts/coccinelle/remove_local_err.cocci
 F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
 F: scripts/coccinelle/use-error_abort-in-instance_init.cocci
-- 
2.21.1


