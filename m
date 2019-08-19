Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EF3C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 15:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899F920651
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 15:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOzgaKQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899F920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzjSJ-0004Jv-Cp
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 11:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzjPy-0002Uv-45
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzjPw-0002WZ-P6
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:17:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:33699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzjPw-0002RC-HE
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:17:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id go14so1115905plb.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kcQQwhe8tbvIkqlEv04wiqdNqDeAeBEJXEVRAMnwP74=;
 b=oOzgaKQvX9pX/pHo6fX2nRrnGGPWGfe1iUDvPjg+1Kl2hE2p834EWd1J4syElgmY3h
 qk7LBj12kFb9hxgtpBcwF9agEJ6jut9pECh4IjyKszOsLrpDSEZnmnz9krH0ngRrT85c
 dlgsyh5nxj44XprDhOUtGuMoByKVvVkM1P59b3SIuHQE0SgJNnusCC5MImBMOoc4Dnr9
 ihiYft2gltHWjaZJfarlh0WukArNCt9nBNbnP9iyuePd3G9wMMwZAULX/retuIhLyIBq
 caEna1GOpggAFfh5ker2q+7iA9imJY7XONJ8PXD/NDEkTdbVUufbkRSmUwJM1zmcHWm4
 lhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kcQQwhe8tbvIkqlEv04wiqdNqDeAeBEJXEVRAMnwP74=;
 b=iX8Ux+BoR8H0ZzQ+v0Xjwu3t3s70LsX1S1xCJK0fIStU8QHHVepLAtcAvpNrgW4GYa
 FBXCHX1RqRmunOwOUkXMebYXXFpYEJ42Q1Qet90MUdBcrO3Iths7+gYB9fwJ+hPG0K6D
 /eAzmDSGv+Jx58BahHh84fw/gnQhZf9naDJjvcQrxjp+v0IYJOLFOn8W+P0VUELSxDWL
 xyTqitOn7CbpBE0JLDV5SSX8BaZ4qYS8Piq1Idm9qqM3pxQMOwE23cg0DquOJxRU+yWb
 ePfm/npwvHtozWalqEwB8i799d1+LTyoaVPdPYzwIztjLtShqkGdMtA5mYVYYox8h/7N
 8XoA==
X-Gm-Message-State: APjAAAVFFwHK60xEeP72uCbmQZ80kfB4YyVbfXlUf7xdQya2wCU9wM7a
 9LUZeBXAeXV46E5wZBJTxiJhXBloFSc=
X-Google-Smtp-Source: APXvYqxE5d0ADpu/eSkXXYOzafnaMOkWbBBlmp+8buJkgUqAOUMRP++wc00Fa+V8H/Rct6mIuSicOg==
X-Received: by 2002:a17:902:834c:: with SMTP id
 z12mr9134007pln.8.1566227867525; 
 Mon, 19 Aug 2019 08:17:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r27sm21020406pgn.25.2019.08.19.08.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 08:17:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 08:17:42 -0700
Message-Id: <20190819151743.17267-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819151743.17267-1-richard.henderson@linaro.org>
References: <20190819151743.17267-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: [Qemu-devel] [PULL 2/3] decodetree: Suppress redundant declaration
 warnings
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
index f6f7368774..d8c59cab60 100755
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


