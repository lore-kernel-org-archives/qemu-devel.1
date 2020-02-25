Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F626C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166592176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOUy6dlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166592176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZAY-0005UW-2p
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlB-0001Wh-0i
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl7-0000WT-1A
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:20 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:42506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yl5-0000Nf-Pm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:16 -0500
Received: by mail-wr1-x429.google.com with SMTP id p18so10723241wre.9
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ck5X4vl1RGKGfpbpG5MISitEJJgkamTLoZojb/ILQQc=;
 b=WOUy6dlc89fPR79czCKS4c0SNuzvd/UJVnIVeXs4o6Ofng1vyQPTROqTnuv0czFSfp
 02T4LTaUMcMvNqBN0USWe5EBisNzRejjb/MM4srcGVI0aUmF+NnldkeAUtOYpq7FL52/
 UPJzQXUgTqc+iAh6jeuyzBREpyOR83w+ktDQz2u+lIroODhCwKBzSBiaw1KYWNTEFxVl
 bmEOyi46iMTC2xGGrZm0iN2JU8Fmo6n+jVsVaEfkiItNFJ+JA8Q4dzzilUkNgPMaPDBL
 pbymPFg3Tf7O6Hnvu4/uDIDES8LV7jzKCFqfU4mCxRcBqXuJEy+3rKm8cH/d5MbDxYE7
 JyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ck5X4vl1RGKGfpbpG5MISitEJJgkamTLoZojb/ILQQc=;
 b=a3IOHFXuJO+qiUw4uedvRRIx8/GWtCbtkydFHnJkpfvkd+ef2FTU/JUa7ayFX+4+9H
 9cK6kujEGmM7UXXVut+ktxxr35uQsGHcThBEHFVMBOnYwV3lmt1Eq478AOYTS7jdZ81B
 k0GDaTUnzrFU9feMWAmJGTFb0J93cZ2lUo/HdF5fKwrfuLwXXVkrrmLYL/3i2lRwE32M
 PaqrTfzIMrftUXuCxvAHh1jUp06aLr64VTNOzXSYMfaEWYsmXx7sznBZKiGxsdHA8GEm
 px3RYuvQcmjCTHe66UcjfI6a3GgpMp5hZRZaQqgyga+4UnoFYzYcYtRZzgTY8tb0Khj2
 mk3g==
X-Gm-Message-State: APjAAAVC4c58U0n1IKnOEj7i28IdU2nbHgT3Ad4Fz4dBoQlZXlN2iI7S
 mXPfUglUMDpmgmYLGStYFHX0mW/Z
X-Google-Smtp-Source: APXvYqyRhIgoiWskYVIm5EjBcuvPIFBCB/ZX1GlrLav8F2Fj2EtBb2DSsR9I3892uPiA8LjFTQYUAQ==
X-Received: by 2002:adf:de0b:: with SMTP id b11mr70961422wrm.89.1582631534457; 
 Tue, 25 Feb 2020 03:52:14 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 074/136] exec: drop bogus mem_path from qemu_ram_alloc_from_fd()
Date: Tue, 25 Feb 2020 12:50:04 +0100
Message-Id: <1582631466-13880-74-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Function will report error that will mention global mem_path,
which was valid the only if legacy -mem-path was used and
only in case of main RAM.

However it doesn't work with hostmem backends
(for example:
"
  qemu: -object memory-backend-file,id=ram0,size=128M,mem-path=foo:
    backing store (null) size 0x200000 does not match 'size' option 0x8000000
")
and couldn't possibly work in general FD case the function
is supposed to handle.

Taking in account that main RAM was converted into
memory-backend-foo object, there is no point in printing
file name (from inappropriate place) as failing path is
a part of backend's error message.

Hence drop bogus mem_path usage from qemu_ram_alloc_from_fd(),
it's a job of its user to add file name to error message if applicable.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-75-imammedo@redhat.com>
---
 exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index d85a868..6ebff8b 100644
--- a/exec.c
+++ b/exec.c
@@ -2307,9 +2307,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     size = HOST_PAGE_ALIGN(size);
     file_size = get_file_size(fd);
     if (file_size > 0 && file_size < size) {
-        error_setg(errp, "backing store %s size 0x%" PRIx64
+        error_setg(errp, "backing store size 0x%" PRIx64
                    " does not match 'size' option 0x" RAM_ADDR_FMT,
-                   mem_path, file_size, size);
+                   file_size, size);
         return NULL;
     }
 
-- 
1.8.3.1



