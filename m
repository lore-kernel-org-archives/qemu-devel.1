Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA20C41514
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 15:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A451020651
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 15:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YabwG0qD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A451020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzjSF-0004By-I9
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 11:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzjPy-0002Uw-4F
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzjPw-0002Wl-Pm
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:17:58 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:37084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzjPw-0002Qi-FP
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:17:56 -0400
Received: by mail-pf1-x431.google.com with SMTP id 129so1347046pfa.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aAsgcvP1KNeiO2DyuHvEBM+1rf528V/HzEzeINYjmQQ=;
 b=YabwG0qDHJQ3zR8wemiC7oSISh8CtnYF2SufRC1eX5C2WRTHZXnzd9i9BpHaVhS1i2
 iMpwDXxZyGK0mj7EFqUf4gTB5rBTvRs7Gms8/fdIafSscK8JrEB3fZ/hcAH1d3hCmgmI
 VIjqJ2I0cTnhmh93LAaTEqQQCJYxPtOq79Ur7XKtgZ0OUAUpbKS789Hv3uIW+l83H+Hi
 JQ/OCi6ydmFemLzC99zLwQf2UEktbvSWQk6afWkEBDKiJdn0NfgfKLNv7cAH0dvAbrIL
 K3DA+5FAOHfFf4cFUqqcL+91XRSSLWV+unSq+e3tJxzTpY0BZcfvDsKl0Gx54J33hdB8
 HALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aAsgcvP1KNeiO2DyuHvEBM+1rf528V/HzEzeINYjmQQ=;
 b=mJvN5E+d+t4rFVcgcY251/fo2MzdbjMcfWphC3FLGhNzcnoEVkbxpWAol36xnFJBs5
 jtvIKtJX4pCkkRRzwxewGDT1gWbGxYBlKx2Isg+R0pD4GPaJZJFL+icRtRRaUIoruhxU
 UUhm39zTCC7qb4lwDv3VjQGPd0pWSlYKNbDWQV3KHyVfAPzwwSOsdH7qr8pJfA/jpcHu
 uc7VYXfbw7Gthi7sA3crfeECSlenMwBtZJJMDng3VD9g4XqGR/CeowaIDyNRDCQgAQSz
 Nl3++CcvFHXduiiQ3hrIcXmaG2rMWC7aD8Qz369n1w8nOVI4gwYrww8Wh1AizprQxd6N
 lpRA==
X-Gm-Message-State: APjAAAUVK4TANPsx4VbWysRVz4U6gDQ+hxCbOkjuLL1K1GcBxejSQiB8
 q2PGaacfZrmr1keAc9zjCpZ2XX5Q8ck=
X-Google-Smtp-Source: APXvYqzOb3flQFpF/coP68QsC0S0Rp+nwTy6EsLIlNSvOA5qc00fB/LgSUjQkCy+4DF+sB+Ie8k9XQ==
X-Received: by 2002:a65:690f:: with SMTP id s15mr19835734pgq.432.1566227866271; 
 Mon, 19 Aug 2019 08:17:46 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r27sm21020406pgn.25.2019.08.19.08.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 08:17:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 08:17:41 -0700
Message-Id: <20190819151743.17267-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819151743.17267-1-richard.henderson@linaro.org>
References: <20190819151743.17267-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::431
Subject: [Qemu-devel] [PULL 1/3] decodetree: Allow !function with no input
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Call this form a "parameter", returning a value extracted
from the DisasContext.

Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/decodetree.rst         |  8 ++++-
 scripts/decodetree.py             | 49 ++++++++++++++++++++++++-------
 tests/decode/err_field6.decode    |  5 ++++
 tests/decode/succ_function.decode |  6 ++++
 4 files changed, 56 insertions(+), 12 deletions(-)
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
index d7a59d63ac..f6f7368774 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -245,7 +245,7 @@ class ConstField:
 
 
 class FunctionField:
-    """Class representing a field passed through an expander"""
+    """Class representing a field passed through a function"""
     def __init__(self, func, base):
         self.mask = base.mask
         self.sign = base.sign
@@ -266,6 +266,27 @@ class FunctionField:
 # end FunctionField
 
 
+class ParameterField:
+    """Class representing a pseudo-field read from a function"""
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
+# end ParameterField
+
+
 class Arguments:
     """Class representing the extracted fields of a format"""
     def __init__(self, nm, flds, extern):
@@ -433,17 +454,23 @@ def parse_field(lineno, name, toks):
 
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


