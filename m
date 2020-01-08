Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1187FC33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3422087F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMmRWWlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3422087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2j3-0001IV-Oy
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Jn-0005pm-H9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Jl-0004VK-GP
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:39 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:33382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Jl-0004UL-8D
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:37 -0500
Received: by mail-pg1-x535.google.com with SMTP id 6so886823pgk.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QkZbjvbQ7GHATNZxrRi8m/ZcWvz3612eqG76lAaVpag=;
 b=uMmRWWlS8ZYozLcGMBRq9ker+HNKWyIZN7SKeDh0mwZsHbKn4DXN0MwjU4yxXGgJQ9
 u515BVzjk9lhGnfrwtBATZTTlmysqV8mcv6fksMQXudS0ONYjXfTv88B4Mkcvj3bO+iR
 ioOySVND+gdZTgvEV6l2oLKCmFv+jir0Cv7i237nF2MBjA1ejkLEu3emT5ZQGnhYGhw8
 qBPGJF3JxTehh6rfsIAdaigwPYjuwdhosf2laCNxseeFYDQa24zLqouQaMsovqA6zaQi
 JyTzWIx9gcha8dfCJAcGv12b5m+9HjMapLACJBUQOT4P0qgMGhM5G5sq+BXQH0IU0NLT
 bgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QkZbjvbQ7GHATNZxrRi8m/ZcWvz3612eqG76lAaVpag=;
 b=JsYnmsO08ghsQMRL9p/FYYEASgI5AAuYkEkFaLsf6+o4D64RRYBz6anvR9I2kiw3kC
 Zrj8gWt9/4DBjQ6CIlpIpk6FQi2SDWUXdENteyEwjBR6t+cLZBCxxIrJ1PILXw0g0dgv
 RkWo+7Z5keP7YALuR9+JMLx3Cei/0BEkGfajQxsj8ovSG4rRLdpLhEXnNzgi+EFUCzMs
 9PqSiOpqLWOLQTqkGFIE5XfDRQpWntgd9K5Lk6rYh6mdinMl+l+Y9GGEBaHz4FiFqEsO
 6HfMSp+JDoXj3S1C3ZwGxOxqn7ES2FCt8Gte59rAVFy0PqwogPSMqqpmw1usFxX5QCMN
 ukmg==
X-Gm-Message-State: APjAAAU3beA9OVpBaz9UoBNpYuq8EFRyaBHVCEJdEjAVDiNNsxWVU29r
 kb+qiZOAkYRAlVqnG3LXc90qGyadpFIO0w==
X-Google-Smtp-Source: APXvYqxcxP5PJcVSpfLC6zWqo9sj7tpROMMxeczPpwRmPT1hIWikS7LPxm1nRcO3pQItrl2I5MoQZg==
X-Received: by 2002:a62:7a43:: with SMTP id v64mr2737150pfc.243.1578455256065; 
 Tue, 07 Jan 2020 19:47:36 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:47:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/41] configure: Remove tcg/ from the preprocessor include
 search list
Date: Wed,  8 Jan 2020 14:45:22 +1100
Message-Id: <20200108034523.17349-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::535
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
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

All tcg includes are relative to the repository root directory,
we can safely remove the tcg/ directory from the include search
path list.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200101112303.20724-5-philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index 94a4b1c848..cac36a9e08 100755
--- a/configure
+++ b/configure
@@ -7386,7 +7386,6 @@ elif test "$ARCH" = "riscv32" || test "$ARCH" = "riscv64" ; then
 else
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/\$(ARCH) $QEMU_INCLUDES"
 fi
-QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg $QEMU_INCLUDES"
 
 echo "TOOLS=$tools" >> $config_host_mak
 echo "ROMS=$roms" >> $config_host_mak
-- 
2.20.1


