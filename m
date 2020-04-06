Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BBEC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC71D206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqRw/cf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC71D206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWDi-00029Q-UV
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrT-0002ZL-Dk
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrS-0003OP-63
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:39 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:40893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrR-0003Nv-JQ
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:38 -0400
Received: by mail-wr1-x434.google.com with SMTP id s8so488282wrt.7
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rzpb0J1Cx8Gx3IGOeDn1CxWpgjTf5+0X2hS5j/0kwDI=;
 b=RqRw/cf3RxpKOHKcqc2z4XMDCFhaBg4tlvBUC2wpT6NM8BAeN0WzjKaT8yFOltPAH8
 0SrSkFgqyK9ZdtkVYLqZbA+MbnhVMT3biptCgQz07m6qHNRjF2cN+/f3GJ5j1alb4AWg
 4PU1ng7BEdV/drm5FEc10E58GcF/EB1w6WYSesuBhGCD63Lqi66iUBfVVSIF/TipYwLJ
 TTvQMK5SXgOw0wa/OR6PPrwbo/jNrQvaGlIf53OM2NfL3/78JMUn57XjOzlcDWbbmjPI
 aDFvw0bFov7o3tJyOtVwmCPR/xz6aJ4k6NG1KnjY0vgR+4peVed+xNWO1t3kxqQlN3zX
 XN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rzpb0J1Cx8Gx3IGOeDn1CxWpgjTf5+0X2hS5j/0kwDI=;
 b=CYzMZbGKVspJbksxqkAUq1OoVVDASbLIKQYOiA6Kadw/BvSaETYWpDosYPHaSVX0IF
 zqe3ifTviYJyWlQMug8bAVdGpAkDj8jBZ2aAXyYqq2JFfVmR8QDcd6N8T7qnzXxH0khe
 nc+POtp+kZCwa8ESHpxPks8uEoYJtlc+6ZtvMg/afb4kueZSfaFSpaGv/7s2DElqnvT4
 Hvpd4Xv0Ei/aFSb9Cncd0X4uyRhk8sB7jVg9YFu1BjFDKhFJ6P9mwwg3gqIy8DWuoygV
 Td52O5hLpe0aXWTLIxnOePGmaaKIcz6VKVNLHJMRZtPeMJPlEbZlejywRZ6Ii5wii6HM
 tP4Q==
X-Gm-Message-State: AGi0PuYEk+Jq7ciU0JVIhoUCVq4qZwrAQbZ2BqyNwuOdX0GU8KUjD72X
 g7wbGbEnhH/o8lbe0fLtvOupxIPr5fU=
X-Google-Smtp-Source: APiQypJ2XL45j+foSFdMhjkTxrNUv6FXWPeIf9ntLPvj5gIQB43pE53pY3VCMxl6klcSq2i+kpFtbg==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr334601wru.317.1586195316377; 
 Mon, 06 Apr 2020 10:48:36 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 37/54] scripts/coccinelle: Add script to catch
 missing error_propagate() calls
Date: Mon,  6 Apr 2020 19:47:26 +0200
Message-Id: <20200406174743.16956-38-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In some places in we put an error into a local Error*, but forget
to check for failure and pass it back to the caller.
Add a Coccinelle patch to catch automatically add the missing code.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .../add-missing-error_propagate.cocci         | 30 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 scripts/coccinelle/add-missing-error_propagate.cocci

diff --git a/scripts/coccinelle/add-missing-error_propagate.cocci b/scripts/coccinelle/add-missing-error_propagate.cocci
new file mode 100644
index 0000000000..7991c9e2c2
--- /dev/null
+++ b/scripts/coccinelle/add-missing-error_propagate.cocci
@@ -0,0 +1,30 @@
+// Add missing error-propagation code where caller provide a Error* argument
+//
+// Copyright: (C) 2020 Philippe Mathieu-Daudé
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch \
+//  --macro-file scripts/cocci-macro-file.h --include-headers \
+//  --sp-file scripts/coccinelle/add-missing-error_propagate.cocci \
+//  --keep-comments --in-place
+//
+// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg691638.html
+
+
+@ add_missing_error_propagate @
+typedef Error;
+Error *local_err;
+identifier func, errp, errfunc1, errfunc2;
+@@
+func(..., Error **errp)
+{
+    <...
+    errfunc1(..., &local_err);
++   if (local_err) {
++       error_propagate(errp, local_err);
++       return;
++   }
+    ... when != local_err
+    errfunc2(..., &local_err);
+    ...>
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b58f02efb..14de2a31dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2053,6 +2053,7 @@ F: include/qemu/error-report.h
 F: qapi/error.json
 F: util/error.c
 F: util/qemu-error.c
+F: scripts/coccinelle/add-missing-error_propagate.cocci
 F: scripts/coccinelle/err-bad-newline.cocci
 F: scripts/coccinelle/error-use-after-free.cocci
 F: scripts/coccinelle/error_propagate_null.cocci
-- 
2.21.1


