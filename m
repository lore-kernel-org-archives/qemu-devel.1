Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6EFC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A61208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG7l2uI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A61208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hho84-0001vK-Rw
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2q-0004ux-Is
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2p-0004Vj-Hr
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:00 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:33905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho2p-0004VK-DL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:35:59 -0400
Received: by mail-yw1-xc44.google.com with SMTP id q128so7864085ywc.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SnQQzNhJLrrfWw0C3HJW3B+34wMj7FR5p3UF4GU8CRc=;
 b=OG7l2uI5tV0jycxFPW3T+hDN/t4dbi9LGGGIVGJeHadv+j92gzgI86+zvoy7kafzUu
 X+p64FJXxficOwi6qid2UgSwApvLHjf9f1KUSvqSeOq+D65CLxz2i+nr8Bv1rxdozuP7
 azXCGGyd45D5ct7299GBDk9R1c5Ax602qnxdbErulZlW5N2hgIFoIGi/YeE23+lej+1n
 nYLKc58LN8foXTCrqckAdYfkjwuB3N8X6Dt98Mz11E+m4zMmWLOyq+9Fz5Kjsy1xbGS8
 S6P9hk0bqEb/V0ALGFUDqGjkqiFVqnLa3FAndK4OHZkQ23Ixqu6NO5zUH7MTxks/7wid
 DbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SnQQzNhJLrrfWw0C3HJW3B+34wMj7FR5p3UF4GU8CRc=;
 b=Y5jCxYrHGIOb4K1+Hm7iIZlKmbgSqoStY3oOVEm1qETZ617DbUsRJo/5KDl4ENs+k+
 BiqsDw5Yj8UGjzKVTLSR70MAxyyvQjzXVAkRx4a/YL4kEE/+Oh70/JnH9ktGpwqwOK5o
 YIkSDav2C7cCqTHyOw/fzZOiybUMgO4o2y4YCi7LmHqYWc2+BdZQti0G8Xr5HrCaTUdI
 eJ6/xQSNZ9M/UpazJ9j5kmYvsefKrJ/B9839tCOii0hLZcHC99uedElp97ObKJobNvsG
 v2cgQcpB0CDUVpaI9SNf110sxeothyJdJe3//MjAoeG+IgiUpuJNc075fLZ611YUpNQw
 LHeA==
X-Gm-Message-State: APjAAAVN8IPIKH647v5fxQlPqr+jUlgDYw1oJRJOpQwrhCY/vSrYL9Xg
 hrwrQPpSnw0EK/sQStuaO6e4Og8D
X-Google-Smtp-Source: APXvYqwuuZ08cCNKof2jGwORq/O/HanGhvNjeh6sOn5hHGIp8EApH1Tp0O/Jd8n7e5WffFpGMgRE+Q==
X-Received: by 2002:a0d:d603:: with SMTP id y3mr9446505ywd.1.1561955758807;
 Sun, 30 Jun 2019 21:35:58 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.35.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:35:58 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:27 -0400
Message-Id: <20190701043536.26019-6-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701043536.26019-1-jan.bobek@gmail.com>
References: <20190701043536.26019-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RISU RFC PATCH v2 05/14] risugen: allow all
 byte-aligned instructions
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Accept all instructions whose bit length is divisible by 8. Note that
the maximum instruction length (as specified in the config file) is 32
bits, hence this change permits instructions which are 8 bits or 24
bits long (16-bit instructions have already been considered valid).

Note that while valid x86 instructions may be up to 15 bytes long, the
length constraint described above only applies to the main opcode
field, which is usually only 1 or 2 bytes long. Therefore, the primary
purpose of this change is to allow 1-byte x86 opcodes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/risugen b/risugen
index 09a702a..17bf98f 100755
--- a/risugen
+++ b/risugen
@@ -229,12 +229,11 @@ sub parse_config_file($)
                 push @fields, [ $var, $bitpos, $bitmask ];
             }
         }
-        if ($bitpos == 16) {
-            # assume this is a half-width thumb instruction
+        if ($bitpos % 8 == 0) {
             # Note that we don't fiddle with the bitmasks or positions,
             # which means the generated insn will be in the high halfword!
-            $insnwidth = 16;
-        } elsif ($bitpos != 0) {
+            $insnwidth -= $bitpos;
+        } else {
             print STDERR "$file:$.: ($insn $enc) not enough bits specified\n";
             exit(1);
         }
-- 
2.20.1


