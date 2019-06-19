Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95190C31E5E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67398208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCx5cGsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67398208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSr5-0000e0-ED
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 01:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34448)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmV-0003vc-EL
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmT-0001g8-KA
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:11 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:45563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hdSmT-0001ec-6o
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:09 -0400
Received: by mail-yb1-xb41.google.com with SMTP id v104so7061871ybi.12
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 22:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gemq4FQpBDazHnNNQMVsZrUQhBxsgJYn42ZIvzcwvYo=;
 b=bCx5cGscHJ/NJVBK6K17fEQcOA36yWW+bwRtJTW/fNCKAo16OEJgAJ2LPdW/rqD0cP
 74N+tt/MMyh75MXibMrvu+Gh/AxBpqZqK03hgPWPzatPJQEZurDx2zNnsuVEmaS7JUJL
 PBkGTXRfq+OiilXkzFJu/uk4jlTXuUlwWs8okYO+G+iu9jfOerYCPkpq8VncprSqMAWs
 5Rj4Ie89jbpErSDC0tvEs4wJ4VRPpYEBlnbAFxeKyZBnQAlTJJU6Su7fzELryxzZ1LUu
 KvvNYwztN1UZrDkjUn4iVD2epP1ltnVhMKQzgHjqYQZS06iW7K96OY4Zrmm6PzV0nqds
 S8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gemq4FQpBDazHnNNQMVsZrUQhBxsgJYn42ZIvzcwvYo=;
 b=Ipeon3tH6Hih6Z0hCjviE6oST7Pr72uR3yCcBQerUnrHSAR8K3F2012FkthZsN3ypc
 KOjZXfzs02rldfwRgFvsGRIxFUVtu1Vb2x/+ZLZmdQG5uGNmYRhik84unrdRBPrw1ibd
 IjiqogsSnszJacAeZxttOzu2qHeL8yl2l2COJfCFW17wgZ1gpgBH13dq79GdA10DepAu
 NWsM8MvbUWGuiJTgB3VNfFWtNBzBHoiYlWo6HULe/FTBKDJG/PUxro6Hz6j05utbsxIh
 UIbsKOBymLviBc4z6HTFGHLQ72YKGFClBLllRNePwtuPBophst8S1vXIKViK15r1f0rl
 PMhA==
X-Gm-Message-State: APjAAAV8S8afV5XgOMUxiXss/bM+yOp2SYxgq4O+VBaGYrITGCVUgfbU
 FdQLdLsX/aH/JC8P5CbCPbwSeZmY
X-Google-Smtp-Source: APXvYqwMYcgh/AXWierOd6UCwIjrXcsT6U5PPIOk2M1SRnSfKVyGgbmA8QEHE/Q+0anjyboIv1aSvQ==
X-Received: by 2002:a25:20c6:: with SMTP id
 g189mr20010311ybg.401.1560920706938; 
 Tue, 18 Jun 2019 22:05:06 -0700 (PDT)
Received: from localhost.localdomain (67-9-99-67.biz.bhn.net. [67.9.99.67])
 by smtp.gmail.com with ESMTPSA id e12sm1714426ywe.85.2019.06.18.22.05.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 18 Jun 2019 22:05:06 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 01:04:45 -0400
Message-Id: <20190619050447.22201-6-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619050447.22201-1-jan.bobek@gmail.com>
References: <20190619050447.22201-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RISU RFC PATCH v1 5/7] risugen: allow all
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


