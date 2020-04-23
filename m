Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA340C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE5D20724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZxCVaVAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE5D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRiM6-0004PY-Fn
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 16:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRiKg-0002bs-JH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRiKW-0001ZU-IA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:20:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jRiKV-0001V7-WE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 16:20:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id j2so8173297wrs.9
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 13:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uzNcoSaHAxnC2uxrv5wEs3MnYadshJL173MPoerjSJs=;
 b=ZxCVaVATqzDtxHkVpAKLax76QNbBsWfQpnKnJWtP+DLiZEBDJ7CgaLxI/kgGWewESr
 LJQjrBkLRqiYQkWkf+4Jc5IBiM8mMJuaNUZJXJlyZUDacgULXT83Jnkrl2Nzq/NhvjWR
 i3A648MXV2kO4aT6YxcwNGKQFi2Ouv86uOaPKO6losOWBiGK+x3s0pIlgIQldUM3GL+h
 iZDIYlynL7Yx0BYItyJW8Y0/nVXO0pkw8U7fCX0vdqL59lx2sQbm3q/UuzyoU7mPyWUX
 RC1kwZmhqLXo43zLfQwUb0xBkYkNXzcWzUsdkMEeXA2YBlWN35hllZvP4AgtwTOgYmRa
 CmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uzNcoSaHAxnC2uxrv5wEs3MnYadshJL173MPoerjSJs=;
 b=eBsj8ANdf7YtdPLE9VdmbUcln9CV6Z+Z5xDY+C4xi3hQ0NCnaYTnCqLrLhdJ3puRr1
 BMPbkIulrbgepFxjFlJ3p4OtVwuvoUi0MWrYTIPGObOUId1eHLim0e5MrmnyaoZav3Qq
 99tkO/hpgcurZ/ViZYsUB+vIXqUViElB99eGOEF41meD5vsZQ+A+tR+onOYYOiVxh0kx
 e4o2eZiz3IEIEkt2oXSjLTaGJ4jPZpwjlzB4Ufi4M/fBwdKazSubMGDnFc+1+fvamhF5
 NO/mno5vgdD6PEMr9LnH3hbEE6bU9RWY1vpvMofX1oBE5+EPueZlRXcMsktBSHQsNi7f
 GTiw==
X-Gm-Message-State: AGi0Pubf7iXshLDoDBEdMbQBzZjTGmTBMFfmj28iNRGoaMTcA6RxwAZI
 ume42hAwSzBZTVNwa3N9Kjq6bbdW8bS1hw==
X-Google-Smtp-Source: APiQypKZMh/f0iwH4Fxvz1muefMi8nuA1G6xiow7VLVE5+E9mVK8rDQfWDzAWUPK1yy1KWUhowNVMg==
X-Received: by 2002:a5d:6b86:: with SMTP id n6mr6697619wrx.113.1587673213824; 
 Thu, 23 Apr 2020 13:20:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u127sm5149308wme.8.2020.04.23.13.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 13:20:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Subject: [PATCH] elf_ops: Don't try to g_mapped_file_unref(NULL)
Date: Thu, 23 Apr 2020 21:20:11 +0100
Message-Id: <20200423202011.32686-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Randy Yates <yates@ieee.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Calling g_mapped_file_unref() on a NULL pointer is not valid, and
glib will assert if you try it.

$ qemu-system-arm -M virt -display none -device loader,file=/tmp/bad.elf
qemu-system-arm: -device loader,file=/tmp/bad.elf: GLib: g_mapped_file_unref: assertion 'file != NULL' failed

(One way to produce an ELF file that fails like this is to copy just
the first 16 bytes of a valid ELF file; this is sufficient to fool
the code in load_elf_ram_sym() into thinking it's an ELF file and
calling load_elf32() or load_elf64().)

The failure-exit path in load_elf can be reached from various points
in execution, and for some of those we haven't yet called
g_mapped_file_new_from_fd().  Add a condition to the unref call so we
only call it if we successfully created the GMappedFile to start with.

This will fix the assertion; for the specific case of the generic
loader it will then fall back from "guess this is an ELF file" to
"maybe it's a uImage or a hex file" and eventually to "just load as
a raw data file".

Reported-by: Randy Yates <yates@ieee.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/elf_ops.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index e0bb47bb678..398a4a2c85b 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -606,7 +606,9 @@ static int glue(load_elf, SZ)(const char *name, int fd,
         *highaddr = (uint64_t)(elf_sword)high;
     ret = total_size;
  fail:
-    g_mapped_file_unref(mapped_file);
+    if (mapped_file) {
+        g_mapped_file_unref(mapped_file);
+    }
     g_free(phdr);
     return ret;
 }
-- 
2.20.1


