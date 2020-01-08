Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80417C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477D42077B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/7YZrxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477D42077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2OW-0004LC-Si
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Hr-0002zQ-Fd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Hq-0002UM-Dt
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:39 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40634)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Hq-0002TJ-7U
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:38 -0500
Received: by mail-pf1-x441.google.com with SMTP id q8so900877pfh.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QJWdcTP2J+BE/WP+ZDabDTmYnHjvwI2urBEoPPtrZzo=;
 b=g/7YZrxJkrHkiWUpkg8YHuE1aykrrgOSsshh19A3rjwSISm/1IBbYTbHJcDFqti8uq
 PCd+SYG3BUCrla4Ktlqam6+xjDxrSkpDiwh6Td3X1cuemPNF6OzgnXr3fjxMfVciJCgK
 8KFwPmmwPixV8htEQpGtFM4II/A1wM6vdCMh1YrG7wZ3kyIUmEX7MvX5K9H4Td3nq7QA
 BJBH9gTFdNx/7clm2YMuY4HgwHbFWM2NaPsggJnSZvj9tjaQ/XNM43ZRZUfOQCEn3lTE
 RMvmNSHs0FCycYJ1sw9mh/7VxjRadkK8QmPCOYKmXNIPILB9SXyeSu458paFFROHY2T7
 MB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QJWdcTP2J+BE/WP+ZDabDTmYnHjvwI2urBEoPPtrZzo=;
 b=VB8crur3SlVPIiFFxezLJIEv/xHeIne2KwPypkOVVNmHKwv3wFNAB4md9gMW2iJJQO
 s0FAslKvUtrlbrIhbGfvRGFBC+JaPiVD69aRW9yWjCGc6VaFou91aPPJDS0jMyzuwrHl
 TbXyCoLVDAzfLKnTjvfO3EXL7+qpBNERJa2RDiUteVRvgMxmfuQADg8nH49Rkt5ekh1s
 6OS+lvMQrIh3zvRdJLTbZkAhnhQ3rs3BNPETwdlCRhfk9wO+movegRqMz42aPGug3ZUO
 y1DuPCkxGqsW7/Lg0FyRn9Y5sDGRazuimkieQTVWV7Vbm1aD45UCc9h3PbHWlgpNEe6Z
 ejAQ==
X-Gm-Message-State: APjAAAX7OnWQwPNnPtApSRar2oF3hoJ+XNSU4SZ9ZtqGdG9gHkKTGbyM
 3rKg61wFWiaLT6P293xkr3+hOywtAqcDug==
X-Google-Smtp-Source: APXvYqx3bD6Ls/pE4e3QilqpCy+T4Yw3VjhEKOMAyokJ+Bfex2icTvBKeBY3Du1PMQDIhrYIA+lWeg==
X-Received: by 2002:a63:9d07:: with SMTP id i7mr3260006pgd.344.1578455136873; 
 Tue, 07 Jan 2020 19:45:36 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:45:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/41] configure: Do not force pie=no for non-x86
Date: Wed,  8 Jan 2020 14:44:45 +1100
Message-Id: <20200108034523.17349-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PIE is supported on many other hosts besides x86.

The default for non-x86 is now the same as x86: pie is used
if supported, and may be forced via --enable/--disable-pie.

The original commit (40d6444e91c) said:

  "Non-x86 are not changed, as they require TCG changes"

but I think that's wrong -- there's nothing about PIE that
affects TCG one way or another.

Tested on aarch64 (bionic) and ppc64le (centos 7) hosts.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/configure b/configure
index 0f365bfdf1..351e39795b 100755
--- a/configure
+++ b/configure
@@ -2019,16 +2019,6 @@ if ! compile_prog "-Werror" "" ; then
 	"Thread-Local Storage (TLS). Please upgrade to a version that does."
 fi
 
-if test "$pie" = ""; then
-  case "$cpu-$targetos" in
-    i386-Linux|x86_64-Linux|x32-Linux|i386-OpenBSD|x86_64-OpenBSD)
-      ;;
-    *)
-      pie="no"
-      ;;
-  esac
-fi
-
 if test "$pie" != "no" ; then
   cat > $TMPC << EOF
 
-- 
2.20.1


