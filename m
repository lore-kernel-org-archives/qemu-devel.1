Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1C2C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51BE920C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+x9JWNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BE920C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw738-0002Hj-Gk
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50813)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hw71p-0000eR-5y
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hw71n-0008Ur-Lj
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:42:05 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hw71l-0008RA-LP
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:42:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id ay6so45162176plb.9
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=leHpSxHzVUfQCq35SXdIhrfSJv5bGUxlfMEN59fKGs8=;
 b=R+x9JWNGRCUyPT9qY3gVRkx/94Jp2YtcuNACFzBuhhxhqF95so80+Jb8LzC7mqvsLE
 PC1JIijvAdAWGOxKse6YwXT0dF8oVgKkcY4NyvZYiY9uV7qkFrkRJh6qZcs7DHqC/Hrw
 DZohBIcvGacA/E0rBf7QTEmwaq9UQlQEF7IYM/eUVmlgtqPtgnV2gPIu+UZsGPtIQ3HT
 +iZ27v7taX0V46y2bXnJWuseXxxFPGoozjGC3faiJmbLMWbH9eGtJ6tMM1X2qCp2ii7x
 +AWyzWzDTHpxRPIEDUXvlKn5rPoOeMXZeDR332BiSIOBsgiC2Y4k3d862xbmCtgufaJk
 clnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=leHpSxHzVUfQCq35SXdIhrfSJv5bGUxlfMEN59fKGs8=;
 b=XACmY2iLAFVN/3uIEf8A7vIXA4zTlWCtRy3BP/e8mBWf7AtV2vPM9+7UUF8wAwsJ1l
 ULOE5n5KZooI4mll3UW+Tcb8EQ5fgApV2E5K23edVbVQv+/Dc/jYprJ2qiyboMAslb63
 4tfJ0uEjnyCR6naaY6CNXqtCnFWPTnzxYDHjt+prUSjtwIbn9sJ+9Ph1+k3cfvOXHa4n
 B38AEkfRdlP0/TJ8w6XrypVKUOTGHm7GOXga+dOkifUd2umm1SzmYeR3epHCjn/9pkf3
 6xv/zZPwCF2FaX7Fj9yT6FGsd5LWUzxN3aSGKgsxy1XjHWcG070bJZxpl1qGUpPjRZcw
 2PqQ==
X-Gm-Message-State: APjAAAWp9oP7yaL16o5vrlTWsd26P8ULuwLNKHkV1UgJgHNsoS1uhcRM
 Q6jxaAfZaM3fgDFZGW79qVYl0OW0bgI=
X-Google-Smtp-Source: APXvYqz1hWfeknIiwUhlO6H8PJ7tvLD522TuqQjZPZ6xJ7ttkaVOB/zgqj9VJzjJKHTm+8JMBJDKxA==
X-Received: by 2002:a17:902:7d86:: with SMTP id
 a6mr19609862plm.199.1565365318747; 
 Fri, 09 Aug 2019 08:41:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 67sm80452179pfd.177.2019.08.09.08.41.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 08:41:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:41:52 -0700
Message-Id: <20190809154153.31763-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190809154153.31763-1-richard.henderson@linaro.org>
References: <20190809154153.31763-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 2/3] decodetree: Suppress redundant declaration
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
Cc: peter.maydell@linaro.org, Alistair.Francis@wdc.com, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can tell that a decodetree input file is "secondary" when it
uses an argument set marked "!extern".  This indicates that at
least one of the insn translation functions will have already
been declared by the "primary" input file, but given only the
secondary we cannot tell which.

Avoid redundant declaration warnings by suppressing them with pragmas.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index a2490aeb74..f02c8acca1 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -33,6 +33,7 @@ arguments = {}
 formats = {}
 patterns = []
 allpatterns = []
+anyextern = False
 
 translate_prefix = 'trans'
 translate_scope = 'static '
@@ -485,12 +486,14 @@ def parse_arguments(lineno, name, toks):
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
@@ -1191,6 +1194,7 @@ def main():
     global insnmask
     global decode_function
     global variablewidth
+    global anyextern
 
     decode_scope = 'static '
 
@@ -1251,6 +1255,19 @@ def main():
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
@@ -1262,6 +1279,11 @@ def main():
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


