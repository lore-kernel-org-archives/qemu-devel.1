Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEE1C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3877C206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vacjemKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3877C206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoID-0002DE-Sb
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoE0-0005Au-Up
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoDz-0003XI-Rc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:40 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoDz-0003Vt-LZ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:39 -0500
Received: by mail-wr1-x42e.google.com with SMTP id g17so6730842wro.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Sfa3q62bPJXCnWShG4VYkUrdYTp0bRsHxJH6tzFRdu8=;
 b=vacjemKAijkhe1FEiUZmMM1C7dRnkCTkUkszFc97crJlgOGHRi2oqxEsmeRgqDW7od
 Mequ7su8F9yFj6WtVBx1fqb4baLD0JtTvbKuxVYgrqnrwQFzlHQObzJECxVHldQZmjhW
 jsT+aminWW/jKysuQPP1m0a5D9hXvo5ak6iHiuYenMKQIPV7NEqh8NpFL8GeWIOhGSzO
 4W/YBLjFFEs/k8xKwxAI4cnSyQPoIuekwT6cB/AfJKBBREqvnZM8HOoVkQLJOdzXkYGv
 BGLHwHvwsRPboAwFM2fplOETpGZxpqoO06yjeNFDYS1tJFtgzrE4xXHYIbhfrQ+hlXwI
 XL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Sfa3q62bPJXCnWShG4VYkUrdYTp0bRsHxJH6tzFRdu8=;
 b=Zy3KaDfX1RGqJfwSxjsHcsJR5GSJjweBZ+OA0hxyRY2iWSzE/Z53IY/pA3LtAtU3O8
 mhuFl3mPFdzVY5Z+i0cb5fVG/6Up7E3cdYyhf5piNDjXZTeKXs06AZhKUl9LrhOcomD4
 pUblMsqAm+l8dCIh2y2cHwAdkS5CskGxgT/GYs6h+f96w5ZsPXd2pC6eKDQlwVrvInsf
 iGx3+Isg8xbWmvPyBJ2czEf8tgQjf7+jucIMyUK2hflhJgW3fqi1pUmag4yJwiquBb8m
 suSVpgFF4uTYr3mMS1qH2fmGIGFBrsyF/cjFMc3ofFXe2pG4MeXwt5+NMJA9hzDDbY6p
 JKsw==
X-Gm-Message-State: APjAAAUUNUGD6bUOLIA7fXlTnIKnmNgjWMP98FR298ze7Bs2JsnFa/oE
 Hb2qH5d0mJk+IdCv+wWYu2Ysew==
X-Google-Smtp-Source: APXvYqwzKTrcmKU/FNftR1jnN9cOdCM1nqfh7UgF1ULqSupjs9r/B+GfLf1IDOg8huOfZMaYbGZFeA==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr30751646wrp.171.1576494458552; 
 Mon, 16 Dec 2019 03:07:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 16sm20422018wmi.0.2019.12.16.03.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:07:35 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 687BF1FF90;
 Mon, 16 Dec 2019 11:07:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/16] travis.yml: Run tcg tests with tci
Date: Mon, 16 Dec 2019 11:07:19 +0000
Message-Id: <20191216110732.24027-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110732.24027-1-alex.bennee@linaro.org>
References: <20191216110732.24027-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com, Stefan Weil <sw@weilnetz.de>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

So far we only have compile coverage for tci. But since commit
2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
for INDEX_op_ld16u_i64") has been included now, we can also run the
"tcg" and "qtest" tests with tci, so let's enable them in Travis now.
Since we don't gain much additional test coverage by compiling all
targets, and TCI is broken e.g. with the Sparc targets, we also limit
the target list to a reasonable subset now (which should still get us
test coverage by tests/boot-serial-test for example).

Tested-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191204083133.6198-1-thuth@redhat.com>
[AJB: just --enable-debug-tcg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 6cb8af6fa59..15946293ff3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -214,10 +214,11 @@ matrix:
         - TEST_CMD=""
 
 
-    # We manually include builds which we disable "make check" for
+    # Check the TCG interpreter (TCI)
     - env:
-        - CONFIG="--enable-debug --enable-tcg-interpreter"
-        - TEST_CMD=""
+        - CONFIG="--enable-debug-tcg --enable-tcg-interpreter --disable-kvm --disable-containers
+            --target-list=alpha-softmmu,arm-softmmu,hppa-softmmu,m68k-softmmu,microblaze-softmmu,moxie-softmmu,ppc-softmmu,s390x-softmmu,x86_64-softmmu"
+        - TEST_CMD="make check-qtest check-tcg V=1"
 
 
     # We don't need to exercise every backend with every front-end
-- 
2.20.1


