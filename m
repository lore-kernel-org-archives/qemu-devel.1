Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37DAC3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 06:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B556C2173B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 06:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrWWzm8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B556C2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzEta-0008HE-QX
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 02:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzErG-00056P-K3
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 02:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzErF-0000kZ-EB
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 02:40:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzErF-0000kC-8K
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 02:40:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id p17so5409153wrf.11
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tKxbBo5PP5QzWeZGavSTCFjk6sHISgddhsvvpM6xVYM=;
 b=QrWWzm8EiDh7WQPpLMtGfaJRXKnuIwFPVtvShtsqBBwHC/LXMWst5dTO5QoQMxIBMo
 rBG/GwsyU6BdjbVRZbphzqiU/N556v97REuB7Vms8OxweRc6DQO9R0Pwwm617wHM+Jd2
 lPFNSAMmJHGcXDxx1eI5ONHTPmuwmdvASQOd41oedznlBgtMtLvFPLk9CbfjIU2uU0GY
 o6+EUuzMMEPPIeKm2UqOPUeB5SyBp6I3Kvmim73WljLny4YbM3iJuztqICrz6nVJJR9g
 OudK3nUmfhxHR++7NEFUwPeZUBVHG5/simi/kAE1lCnFUdha0KtEXEvVubyJQR+AY8tx
 xpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tKxbBo5PP5QzWeZGavSTCFjk6sHISgddhsvvpM6xVYM=;
 b=HKoNQVd37wb8uJBLmkMpo21biaH8yVJBeFJ/6VKGy/BQdY+CrrK++T3k51Lwn2Ttgs
 liCqosHPLr4RQVouon3oElv0Ukr1WF+1P7Fglzd5bjQCG0iRpcAPFygkN4lHoU2fUiu0
 /EjlArgYXn3Krz04lUoCzoixvmyGXDh6Yt+DJ6m+m8TvOzAA0y7g+Fg7Amx9XcTdQX3Q
 5tNR5QK9YcI2iiaUUFAEX5yfeApimGXwpM1/GD4Wj181jor4SaV7UuTfclwH47Jq4c5S
 VBn2L/4dRsXq6rxvwPyvBC4mjLTBNUpq5dZ7U6pLuPz6WXqQFtBYgEndwDIZpFEh54u2
 8dLw==
X-Gm-Message-State: APjAAAXdbeZ50F0uYTxlB71vUz5t+Nx80+s+3IPuKKZYuOEnGoaHw3wn
 Ymtn+iGfd/EXyvx5svvjTkFdxVDgc+U=
X-Google-Smtp-Source: APXvYqwlnW5SbHvBJqzGlM7UvEMDw0ERmMLcm6sEC/ZUjipCz0jmkM1lTZNqtGvCwsO36saAc1buoQ==
X-Received: by 2002:adf:8bd8:: with SMTP id w24mr19589296wra.273.1566110404020; 
 Sat, 17 Aug 2019 23:40:04 -0700 (PDT)
Received: from cloudburst.Home ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id r5sm9015435wmh.35.2019.08.17.23.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Aug 2019 23:40:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 18 Aug 2019 07:39:58 +0100
Message-Id: <20190818063959.14533-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818063959.14533-1-richard.henderson@linaro.org>
References: <20190818063959.14533-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PATCH v2 2/3] decodetree: Suppress redundant
 declaration warnings
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can tell that a decodetree input file is "secondary" when it
uses an argument set marked "!extern".  This indicates that at
least one of the insn translation functions will have already
been declared by the "primary" input file, but given only the
secondary we cannot tell which.

Avoid redundant declaration warnings by suppressing them with pragmas.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 31e2f04ecb..12c1cd0ddb 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -33,6 +33,7 @@ arguments = {}
 formats = {}
 patterns = []
 allpatterns = []
+anyextern = False
 
 translate_prefix = 'trans'
 translate_scope = 'static '
@@ -482,12 +483,14 @@ def parse_arguments(lineno, name, toks):
     """Parse one argument set from TOKS at LINENO"""
     global arguments
     global re_ident
+    global anyextern
 
     flds = []
     extern = False
     for t in toks:
         if re_fullmatch('!extern', t):
             extern = True
+            anyextern = True
             continue
         if not re_fullmatch(re_ident, t):
             error(lineno, 'invalid argument set token "{0}"'.format(t))
@@ -1188,6 +1191,7 @@ def main():
     global insnmask
     global decode_function
     global variablewidth
+    global anyextern
 
     decode_scope = 'static '
 
@@ -1248,6 +1252,19 @@ def main():
     # A single translate function can be invoked for different patterns.
     # Make sure that the argument sets are the same, and declare the
     # function only once.
+    #
+    # If we're sharing formats, we're likely also sharing trans_* functions,
+    # but we can't tell which ones.  Prevent issues from the compiler by
+    # suppressing redundant declaration warnings.
+    if anyextern:
+        output("#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE\n",
+               "# pragma GCC diagnostic push\n",
+               "# pragma GCC diagnostic ignored \"-Wredundant-decls\"\n",
+               "# ifdef __clang__\n"
+               "#  pragma GCC diagnostic ignored \"-Wtypedef-redefinition\"\n",
+               "# endif\n",
+               "#endif\n\n")
+
     out_pats = {}
     for i in allpatterns:
         if i.name in out_pats:
@@ -1259,6 +1276,11 @@ def main():
             out_pats[i.name] = i
     output('\n')
 
+    if anyextern:
+        output("#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE\n",
+               "# pragma GCC diagnostic pop\n",
+               "#endif\n\n")
+
     for n in sorted(formats.keys()):
         f = formats[n]
         f.output_extract()
-- 
2.17.1


