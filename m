Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7E4C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8799D206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zM+xSxNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8799D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOwu-0002iM-OP
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjo-0006jC-Ef
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjn-0002ok-DN
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:16 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOjn-0002mA-7M
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:15 -0400
Received: by mail-wr1-x42e.google.com with SMTP id c15so801031wro.11
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sVStBWBB/nYKZSZLm9qzTwRd2BAPghRDv9sMPC8uICQ=;
 b=zM+xSxNeCpi6cl/P7qydRzmwD2hcWmp//lyl2LYNTfcwsp9wjtLXgqnOSNNvLjy7Rp
 HiK7Gj4Ye1pVS3VZycGGWcbxUDZYealw2QgecFUTt81WE+jZyCGJTK4Th9UdhRzIMfm8
 nY79NhT8kgXaSJ2hFvl8C2xpCEql3ar4S17wMZsMDwaHlsOvBVIWyhk5kXe4OX4Yk480
 IHEUjcyqnZ1ySg/w9yZDmtIalEMQz6R+oVbMKQ6KqQU9Zcr6tREozKm+KRbKVv9OBgrj
 8H84yWoHaLpYheWziEvyCxLTR8yLxjwzDgpa4tCksNkJKB/kNjnZMn1xfrI5Kdmu/3HC
 DCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sVStBWBB/nYKZSZLm9qzTwRd2BAPghRDv9sMPC8uICQ=;
 b=GU43TvJJkb7M0qcZOYUshOlQ1k5o/uvWrmDHUdddu1TRfDTjs/zNgyU5i/7CFB0lv7
 TSEw7A1F5UtZERRFpA07Si0cKi8opEfpyqtc6vBEih37oLMwPB+S7/90/37llbY5liSc
 YBNnGzYesMFymfJXI0IDu9+olVD87LqUsVc2S6YqW2oe+bY8jWGrJlfZ/sZvSxaLL8dF
 chcgtIbzRYWbwtreq5qAPYk/OriQsMC1riafV9HOhF0pFMQzaCajqVFFfHWMGUs/jXnm
 4V64u19xMFKou1A9nac7R56E3DOAvXS9hg1V7Smemw0wD7oLACDhfJ9R3xib+YiaYA5c
 oEkw==
X-Gm-Message-State: AGi0PuZxtZUx447bHVbAOtxjCkZhUpr6ckZxLMQxyDOQ4RiZ6r78YwAk
 PHJqSoIxHdhJjNywBiig2Am2226YJDIB4A==
X-Google-Smtp-Source: APiQypJcI51Rn3etkNJA9kqHzC8gv7FknwDUG3UaeEiCpb65fgXCdCIIkOXl0pbq9LRRXv9ehlp7iA==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr5634343wrm.45.1586167933729; 
 Mon, 06 Apr 2020 03:12:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f187sm25163765wme.9.2020.04.06.03.12.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 03:12:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] dump: Fix writing of ELF section
Date: Mon,  6 Apr 2020 11:12:00 +0100
Message-Id: <20200406101205.23027-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406101205.23027-1-peter.maydell@linaro.org>
References: <20200406101205.23027-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In write_elf_section() we set the 'shdr' pointer to point to local
structures shdr32 or shdr64, which we fill in to be written out to
the ELF dump.  Unfortunately the address we pass to fd_write_vmcore()
has a spurious '&' operator, so instead of writing out the section
header we write out the literal pointer value followed by whatever is
on the stack after the 'shdr' local variable.

Pass the correct address into fd_write_vmcore().

Spotted by Coverity: CID 1421970.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200324173630.12221-1-peter.maydell@linaro.org
---
 dump/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dump/dump.c b/dump/dump.c
index 6fb6e1245ad..22ed1d3b0d4 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -364,7 +364,7 @@ static void write_elf_section(DumpState *s, int type, Error **errp)
         shdr = &shdr64;
     }
 
-    ret = fd_write_vmcore(&shdr, shdr_size, s);
+    ret = fd_write_vmcore(shdr, shdr_size, s);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
                          "dump: failed to write section header table");
-- 
2.20.1


