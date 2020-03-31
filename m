Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD2AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2F42072D
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 03:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="APe97RPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2F42072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ82J-0001h9-01
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 23:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zZ-0004gM-3h
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJ7zX-0008FR-W5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:09 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJ7zX-0008F4-Qj
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 23:55:07 -0400
Received: by mail-pl1-x641.google.com with SMTP id a23so7621386plm.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 20:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4fxKsy6khBcHTq1p6rkwxiGqHx6M8cWBd65wf3ZxqfQ=;
 b=APe97RPRwahsiYzPaIZvKEg7kxEcZ9VN2zoNFNCG+NumkrpRkPHTiU3fbYUfHVdT2z
 FxeamWMB04LyyqhreI//MuW3TP8oMp1uZGkDZ9/Z6wdDjlqAohr9aa0QSuRDvgwz33Hk
 FQsrmw2OfiaQ7NLS31HZrtKs5a52JPU/vxpeiO9icIzzMvGDe60rWiqp9wPJEFnNu8mN
 AIejH6ua01VEtw0+Gb0uNnKRyGCBkngv9McmrpjuuA/6ZDlwPmDbMaZjNitKMols0TeB
 RuSYD/sVlBdmBLUQSMO0JVX7jWE+NPcVkHFLmRAMHoEeUrzf5PXmGBqHJqXQuKtYvm7q
 LS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4fxKsy6khBcHTq1p6rkwxiGqHx6M8cWBd65wf3ZxqfQ=;
 b=RNkYqje+T12bGh9sXJ8PFtfFzr/O9bHNwB1mTe6C0APQQcOsiUlFjNPoimnQLTwKoB
 AnpDgbhdaT4gFXoE7S/ehkTZrTg6DM/im/WBOA95Kuyrd8BBuO2prRiYCTJoYZbFubXe
 QHS0S7SSCGDRhIpAJc25SK8Zwrd119JFYOddNGCJTnNxrzE2wPrwXcz+qzWSbT9HTO0W
 GGzHTZffGvge6MH4XuZG4HkVn4+Jumm5nIieW5iD7uYRAcxkq6N08TbdsAipYeV4WiJ9
 J6XUXRtvRY4F227AoUVtZw7jV8L8EtSdc1MgrshkPfz8Iouy4EEu1NpPapYtivG7GuSx
 hQKg==
X-Gm-Message-State: AGi0PuaURZXd0WrfW0JzzFJ/BlTIbgzewVk8/mcLOE1s2c0xgM4xTqaV
 708hdombqcLnOouskkCl6c3zHpM5H5g=
X-Google-Smtp-Source: APiQypIsCNzFcNxYuHM+X6X4kfJwOhYVwQIJ1hSJ4lLateIHFArx1KGJmlGrTea4qaq6I8slt+gOrQ==
X-Received: by 2002:a17:90a:2103:: with SMTP id
 a3mr1527798pje.181.1585626906522; 
 Mon, 30 Mar 2020 20:55:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h11sm11386174pfq.56.2020.03.30.20.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 20:55:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 05/10] configure: Unnest detection of -z, relro and -z,
 now
Date: Mon, 30 Mar 2020 20:54:51 -0700
Message-Id: <20200331035456.6494-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331035456.6494-1-richard.henderson@linaro.org>
References: <20200331035456.6494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, Fangrui Song <i@maskray.me>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
index 1cdc439a57..1e622f5acb 100755
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


