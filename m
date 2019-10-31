Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E80CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7AF2086D
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y7fk49Ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7AF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ7RA-0005BK-60
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 06:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ7I1-0002IO-FU
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ7Hw-0008R7-CX
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:02:49 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iQ7Hu-00089S-7B
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:02:44 -0400
Received: by mail-wr1-x42d.google.com with SMTP id i22so319869wrb.11
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gyEdBi21Z9gFQff72+o08golqnSn3favPI+vd9Jc3RE=;
 b=y7fk49IxPgHNjw1E1bojcT1GwiK/MPCpPulKC/h7PjKSIVjsprdlZ+TsRTE4ZuwGtT
 cva95SzcA2inGowXMbueJ+h5UNqwRTyR09Q36PmjQemIUl0MTCVdqC5C8iTYrhzy7lvP
 pUOo3BSjciyFE11U4s5/OXzClzeF8ml4us+BEyIIZJyrvmeL2Diu/MQ95Yq9OgspoL79
 TXV2YJEk1hHAY4cEHhhrizGU8Eu3HlQTzvV4cKL7HmFeWiDcs8HX8jKbnhnHxyEsuuR0
 Hm8MTYZcrImbdMdv6LjVjTed69UiOoTc42pgjrmDSkw73CDEOUipHcmcIXtF7bxRZfy8
 13WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gyEdBi21Z9gFQff72+o08golqnSn3favPI+vd9Jc3RE=;
 b=TCSSRqNE+0OiSxN7+ebc3XXRzr+IPjIrOAWu3YqZbPfHxTRYMIcAaHQDljVOnOXAmA
 RveNNs+jsUa9WenjS8h+8GBFg/2jdXZhkIe8ZxIsd21me+MMVxAcL2dhqJKWxswuw2NU
 NTXAvWNr62C4EB47NzxFyaLyn/YjrDwxNYIEHfU3VOep52zhiK72D92hZMFjX+8/kq7m
 1a+a9IGI5RWFhUIduK78kHOcivx1IaTZK8kyIY0o+94OLV0cJbHpoEh9jGidomhfjk42
 tEciIUg57mLRUtL1q8FAxz++Fxp5d4os5BuHTIJdfZrOkg1mu2lAUnHZrJYXRswqq+4g
 L7mQ==
X-Gm-Message-State: APjAAAWzO0jPkar4RJyP0sL1sdWqkceSE73+zCiUU72oWwDxKFQC15lU
 2UoSY/hJ+8KnqO49YEL5JD+5KQ==
X-Google-Smtp-Source: APXvYqyqEtNWX0ziThAEX45rjavfL5kX0nHqAbtefavzAnjPzpqpeXMPgioLR66JD3PrhKm2EIqacQ==
X-Received: by 2002:a5d:55c7:: with SMTP id i7mr4824245wrw.371.1572516157198; 
 Thu, 31 Oct 2019 03:02:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b186sm3015971wmb.21.2019.10.31.03.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2019 03:02:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 203A21FF90;
 Thu, 31 Oct 2019 10:02:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 3/3] Acceptance test: update kernel for m68k/q800 test
Date: Thu, 31 Oct 2019 10:02:32 +0000
Message-Id: <20191031100232.21992-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031100232.21992-1-alex.bennee@linaro.org>
References: <20191031100232.21992-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

There's an updated version of the Debian package containing the m68k
Kernel.

Now, if the package gets updated again, the test won't fail, but will
be canceled.  A more permanent solution is certainly needed.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191029232320.12419-3-crosa@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 880a4b31ee1..7e41cebd47d 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -480,14 +480,14 @@ class BootLinuxConsole(Test):
         :avocado: tags=machine:q800
         """
         deb_url = ('http://ftp.ports.debian.org/debian-ports/pool-m68k/main'
-                   '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68k.udeb')
-        deb_hash = '0797e05129595f22f3c0142db5e199769a723bf9'
+                   '/l/linux/kernel-image-5.3.0-1-m68k-di_5.3.7-1_m68k.udeb')
+        deb_hash = '044954bb9be4160a3ce81f8bc1b5e856b75cccd1'
         try:
             deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         except OSError as exp:
             self.cancel(exp)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinux-5.2.0-2-m68k')
+                                            '/boot/vmlinux-5.3.0-1-m68k')
 
         self.vm.set_machine('q800')
         self.vm.set_console()
-- 
2.20.1


