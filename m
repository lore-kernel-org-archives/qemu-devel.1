Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEE0C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E2D20714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0DjZkk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E2D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnUM-0008GG-Ly
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGnTg-0007qE-D1
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGnTf-0005ni-1j
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:36:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGnTe-0005na-RD
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:36:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id a25so22625924wrd.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yiqNo48ag7gzDCzI0XyjUFiLj55QYsYhRpvFKm1CEWI=;
 b=o0DjZkk+hhuxUjCN5yOV2VvmcxJFxwxbgGf9+I18llUP4ooOHqXF7TlBwNrg8+jeul
 OXvOjBfaTX+aXVthTCf3+Tqwyq6/qR+6jRTRtSIo/Z2wJuF7NVg6oTWFgvo7sYtjJT7K
 9CdNomLIeXTdJGbnJeEJpnOIAfJrk493cjCc6XHvUx2DfUl5rtvJv5sOyA//MkFycFAx
 4d+toq95EwzjOngTbzQGh+pyP0ioKJu+3I8EGZdTMlZaEiDO51btzUl2/vVu09DM3bjy
 wPSPrMfHWGIKNPd9GeZR822AFRbkicQ6niFySjokQ2He0GKJVaue7ACO8vqCsr11t//1
 oUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yiqNo48ag7gzDCzI0XyjUFiLj55QYsYhRpvFKm1CEWI=;
 b=CStZgKES4cJXa2VCZDPJEccNVtGipBTzsyngyPXLKasGTqE4RUEmt72/A5pkXtYtny
 kWLNk2LBAhFBOMJNs1SIN/TS2UpDomgdkCktfVnTIs3afahUDEclMr74UCKTYJzqE9DR
 N+pY5Tv7XxLrcBw/St1016wfosJkwibc/2w+krgIVGOUfVBe91Hs3gn2nXYbzllu1x/x
 WbJ21LpuwfeTbi8KgEOXn/1dbYk3Pz/qsEFBH/Iw+7Pvlkvp17sFi4AKVKQOioAUAFgz
 8EdB+wT5o6mK6wxbIk9AMVnK0LfpOXko3JUaFFytylpzqKLr5izLq99QkGZP7mycLqkG
 w0Ng==
X-Gm-Message-State: ANhLgQ0yUk2vJbO2MlBaA/v8mFAYU3jY0V8WXZ98pcWemYsEEnQgFZox
 SUZT6fYm3Bevhw7Leg3u72xBs4Zy45iANw==
X-Google-Smtp-Source: ADFU+vsnen3VePkGEMtI9wONTAb9l4lyYVTFRMuAcpuHauIckFrhaVz0aJTSTSaSurfWz28YYjILHg==
X-Received: by 2002:a5d:5286:: with SMTP id c6mr37564240wrv.418.1585071393075; 
 Tue, 24 Mar 2020 10:36:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g14sm5468763wme.32.2020.03.24.10.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 10:36:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] dump: Fix writing of ELF section
Date: Tue, 24 Mar 2020 17:36:30 +0000
Message-Id: <20200324173630.12221-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I have not tested this because I can't reproduce the conditions
under which we try to actually use write_elf_section() (they
must be rare, because currently we produce a bogus ELF file
for this code path). In dump_init() s->list.num must be
at least UINT16_MAX-1, which I think means it has to be a
paging-enabled dump and the guest's page table must be
extremely fragmented ?
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


