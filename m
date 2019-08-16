Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0CEC3A59F
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 01:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2C52077C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 01:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GrFzEz1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2C52077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyn9m-00050T-9D
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 21:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50844)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3lD1XXQMKCl0EFUBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--jkz.bounces.google.com>)
 id 1hylk7-0000gB-JM
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3lD1XXQMKCl0EFUBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--jkz.bounces.google.com>)
 id 1hylk6-0007lV-Be
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:34:47 -0400
Received: from mail-qk1-x74a.google.com ([2607:f8b0:4864:20::74a]:43845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3lD1XXQMKCl0EFUBJJBG9.7JHL9HP-89Q9GIJIBIP.JMB@flex--jkz.bounces.google.com>)
 id 1hylk6-0007lD-64
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:34:46 -0400
Received: by mail-qk1-x74a.google.com with SMTP id m2so6893932qkk.10
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 16:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=uTlU7369N/T6XdZ9PunrkOBg1mbDdKBzc3XGRYISXOg=;
 b=GrFzEz1ENgRQDcegoCd7tCR5LLqQss2QHmRY9OzKraWUDo8hq+xl5VcrL0nqtnwgEV
 qmB39THVr6D2spFKdWio+9BICPS9En8U3xoSpS88wLhyf1ixBJc2Y5dY17EGZMdFq68q
 UqmZjFL9KTiqXNzSZhY+AaRZ4VV5GZqlBlQQFByaWmroh0+/elxuPCGRSKANucBJtxtv
 Lf76XslOxfmeM9EoPLQBHQFgORhcFwCh61W4sZqmSDbQId/A7NJhroHHU+HwJpa2q3kE
 FHXWZTKMwWCV1NT/TY4iiieRjG7pwGVhUjIditPMTOJcQFva7/JR52YYmz4MAibf0f7P
 KZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=uTlU7369N/T6XdZ9PunrkOBg1mbDdKBzc3XGRYISXOg=;
 b=LTRdcMwadMfV7qsjy8HyCWvLyj34mE8zgxC12pFxDUpwA2E7Umh1exVOaNVDMl9axB
 PGu0xDX9IPQCQOSYiFbZA6vbPjRfyVIUPYw4PsDAKIPk98wi5UCOiYh2g6waZkRcU8J2
 LPPnFy09PKZ6TaGNQI01+MxTeHlKRMe71c4YrJugqMa6qCS1/0D4Fnc6MUmBBcdKHo+u
 wcydZMpiMsIIPjmE/C75ZEZuDbpTzq8GXEh8QUxm4eqo4GDKhg8tbPJxUl35bL2GKoUp
 TdlwbJknfEv+Xex4bNxM9zwYlx9Tyw3k/RmifyOUIWJUvcpT+2lMZ/oVXO5uDjzcajeF
 RQnw==
X-Gm-Message-State: APjAAAWCpKe4r4+Q1z573xXpvRbka1bNTF4r0QlDu1/s4Nd06bYemXeZ
 /AFN6+Kc9UpcIdKoReV2iEk9A/MwJqtKQz65R7/l74FGdynEb2YTmm9f+een0gb928d3VpUNoJ7
 Dp8HBWI5vsklkGf0ACxnEYZ1ji34LOIkv9IR9974Y++KuHtKMbu6w
X-Google-Smtp-Source: APXvYqzZ6dD3kv2dbCqUy+9iMJ84DBwcBv3SHW7vOHvkemwRNK35EXGoUaTV3V3GbGy7KgK/AQLSom0=
X-Received: by 2002:a37:a744:: with SMTP id q65mr4062074qke.151.1565998484831; 
 Fri, 16 Aug 2019 16:34:44 -0700 (PDT)
Date: Fri, 16 Aug 2019 16:34:22 -0700
Message-Id: <20190816233422.16715-1-jkz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::74a
X-Mailman-Approved-At: Fri, 16 Aug 2019 21:04:12 -0400
Subject: [Qemu-devel] [PATCH] linux-user: Support gdb 'qOffsets' query for
 ELF
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
From: Josh Kunz via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Josh Kunz <jkz@google.com>
Cc: qemu-trivial@nongnu.org, riku.voipio@iki.f, laurent@vivier.eu,
 Josh Kunz <jkz@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is needed to support debugging PIE ELF binaries running under QEMU
user mode. Currently, `code_offset` and `data_offset` remain unset for
all ELF binaries, so GDB is unable to correctly locate the position of
the binary's text and data.

The fields `code_offset`, and `data_offset` were originally added way
back in 2006 to support debugging of bFMT executables (978efd6aac6),
and support was just never added for ELF. Since non-PIE binaries are
loaded at exactly the address specified in the binary, GDB does not need
to relocate any symbols, so the buggy behavior is not normally observed.

Buglink: https://bugs.launchpad.net/qemu/+bug/1528239
Signed-off-by: Josh Kunz <jkz@google.com>
---
 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3365e192eb..ceac035208 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2380,6 +2380,8 @@ static void load_elf_image(const char *image_name, int image_fd,
     }
 
     info->load_bias = load_bias;
+    info->code_offset = load_bias;
+    info->data_offset = load_bias;
     info->load_addr = load_addr;
     info->entry = ehdr->e_entry + load_bias;
     info->start_code = -1;
-- 
2.23.0.rc1.153.gdeed80330f-goog


