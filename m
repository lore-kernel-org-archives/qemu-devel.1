Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9863C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0DD208C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxEZ9enm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0DD208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw737-0002Gu-PP
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50762)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hw71n-0000aV-Kg
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hw71l-0008Si-Mq
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:42:03 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:38482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hw71j-0008QR-QW
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:42:00 -0400
Received: by mail-pl1-x634.google.com with SMTP id m12so6500788plt.5
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UcR6femN4PMRW3W5bwCjDWWwUNOlmVUXp07Zv3cBZyQ=;
 b=uxEZ9enmcTxPqmNgKJswZzmoH9lBzoCHXrZjIOPyzmeT30scIFiZNvQH13MytafGZf
 aXODqG3aPGdhY1jrtriJ3SsaXitIxVVSgV0xf+sdb/0v6wg1Fh835sjOjJ1CQWQUhfZ+
 tcsmX/l353DyrFySOJjSC8SBANxDdSxilHEEvi8TZnkjcBJifpCGB4ulNDs0pVD+nPjK
 TqfFhaKpdkWKsLo5xirMRuUIQL/9oW3yYcwPzoKWymYJ1PejVG0zvI+g7xr9FL7EgqZ5
 Qh4ZhZnazPf2VlMZzznCnHD5GL23pkvbjSm98lNYSWmrwqcSYep6h3qEEci+LCECNrpk
 YlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UcR6femN4PMRW3W5bwCjDWWwUNOlmVUXp07Zv3cBZyQ=;
 b=JHtY6C6Pz8jN2N+cLV0LgPi2Y6uZV8SMTm8tfyroYp7EEFcKCAQ4fV72rSVedqKdzc
 aaMvqeio33Sz5woK1hKrn3X3GSOu2C/uQJkRdey1Jf+NSmROxoODze17jarEay1I3MUb
 16nbZfcKtULytWjj07P4Kpo5s/Paa29uBnOGLVqxhCyq3TCO4g03lrwHzYHHZaD2zPH6
 DWcwfqSakme2cX4eQwSWE9EhYR75wdIHLCTES6CCCV2SDEQQpLIi8P9zRRaLbSnbVAmU
 4Dv5+FNlAxO4/DH4V9CAitqEvB+J3CZOB4cBHynoDT3Qq/w204imw1/WIDRGbamM5Gj1
 XE1w==
X-Gm-Message-State: APjAAAWZeLLP4k7p2YSSaCxiacjLtRqDQsl8ApAECxUP550eslYiWqj1
 omMY1j1LHCbEgbYlcQEIBAX9jVU+JuI=
X-Google-Smtp-Source: APXvYqwwREgGIpusrFEZs1pgJix6v55EN21JddT3zPGUA8OuT4jt8L1ZRDoDXxuCP8vpFzn6YJ6jeA==
X-Received: by 2002:a17:902:8bc1:: with SMTP id
 r1mr19714697plo.42.1565365317334; 
 Fri, 09 Aug 2019 08:41:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 67sm80452179pfd.177.2019.08.09.08.41.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 08:41:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:41:51 -0700
Message-Id: <20190809154153.31763-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190809154153.31763-1-richard.henderson@linaro.org>
References: <20190809154153.31763-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::634
Subject: [Qemu-devel] [PATCH 1/3] decodetree: Allow !function with no input
 bits
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

Call this form a "parameter", returning a value extracted
from the DisasContext.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/decodetree.rst         |  8 ++++-
 scripts/decodetree.py             | 54 ++++++++++++++++++++++++-------
 tests/decode/err_field6.decode    |  5 +++
 tests/decode/succ_function.decode |  6 ++++
 4 files changed, 60 insertions(+), 13 deletions(-)
 create mode 100644 tests/decode/err_field6.decode
 create mode 100644 tests/decode/succ_function.decode

diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
index 44ac621ea8..ce7f52308f 100644
--- a/docs/devel/decodetree.rst
+++ b/docs/devel/decodetree.rst
@@ -23,7 +23,7 @@ Fields
 
 Syntax::
 
-  field_def     := '%' identifier ( unnamed_field )+ ( !function=identifier )?
+  field_def     := '%' identifier ( unnamed_field )* ( !function=identifier )?
   unnamed_field := number ':' ( 's' ) number
 
 For *unnamed_field*, the first number is the least-significant bit position
@@ -34,6 +34,12 @@ present, they are concatenated.  In this way one can define disjoint fields.
 If ``!function`` is specified, the concatenated result is passed through the
 named function, taking and returning an integral value.
 
+One may use ``!function`` with zero ``unnamed_fields``.  This case is called
+a *parameter*, and the named function is only passed the ``DisasContext``
+and returns an integral value extracted from there.
+
+A field with no ``unnamed_fields`` and no ``!function`` is in error.
+
 FIXME: the fields of the structure into which this result will be stored
 is restricted to ``int``.  Which means that we cannot expand 64-bit items.
 
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index d7a59d63ac..a2490aeb74 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -195,7 +195,10 @@ class MultiField:
     """Class representing a compound instruction field"""
     def __init__(self, subs, mask):
         self.subs = subs
-        self.sign = subs[0].sign
+        if len(subs):
+            self.sign = subs[0].sign
+        else:
+            self.sign = 0
         self.mask = mask
 
     def __str__(self):
@@ -245,7 +248,7 @@ class ConstField:
 
 
 class FunctionField:
-    """Class representing a field passed through an expander"""
+    """Class representing a field passed through a function"""
     def __init__(self, func, base):
         self.mask = base.mask
         self.sign = base.sign
@@ -266,6 +269,27 @@ class FunctionField:
 # end FunctionField
 
 
+class ParameterField:
+    """Class representing a psuedo-field read from a function"""
+    def __init__(self, func):
+        self.mask = 0
+        self.sign = 0
+        self.func = func
+
+    def __str__(self):
+        return self.func
+
+    def str_extract(self):
+        return self.func + '(ctx)'
+
+    def __eq__(self, other):
+        return self.func == other.func
+
+    def __ne__(self, other):
+        return not self.__eq__(other)
+# end FunctionField
+
+
 class Arguments:
     """Class representing the extracted fields of a format"""
     def __init__(self, nm, flds, extern):
@@ -433,17 +457,23 @@ def parse_field(lineno, name, toks):
 
     if width > insnwidth:
         error(lineno, 'field too large')
-    if len(subs) == 1:
-        f = subs[0]
+    if len(subs) == 0:
+        if func:
+            f = ParameterField(func)
+        else:
+            error(lineno, 'field with no value')
     else:
-        mask = 0
-        for s in subs:
-            if mask & s.mask:
-                error(lineno, 'field components overlap')
-            mask |= s.mask
-        f = MultiField(subs, mask)
-    if func:
-        f = FunctionField(func, f)
+        if len(subs) == 1:
+            f = subs[0]
+        else:
+            mask = 0
+            for s in subs:
+                if mask & s.mask:
+                    error(lineno, 'field components overlap')
+                mask |= s.mask
+            f = MultiField(subs, mask)
+        if func:
+            f = FunctionField(func, f)
 
     if name in fields:
         error(lineno, 'duplicate field', name)
diff --git a/tests/decode/err_field6.decode b/tests/decode/err_field6.decode
new file mode 100644
index 0000000000..a719884572
--- /dev/null
+++ b/tests/decode/err_field6.decode
@@ -0,0 +1,5 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# Diagnose no bits in field
+%field
diff --git a/tests/decode/succ_function.decode b/tests/decode/succ_function.decode
new file mode 100644
index 0000000000..7751b1784e
--- /dev/null
+++ b/tests/decode/succ_function.decode
@@ -0,0 +1,6 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# "Field" as parameter pulled from DisasContext.
+%foo  !function=foo
+foo   00000000000000000000000000000000 %foo
-- 
2.17.1


