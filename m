Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBFCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CB1207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNbsIj9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CB1207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jairF-0006I7-Qj
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaip3-000212-CR
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:41:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:34692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaip2-0005pw-GJ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:41:01 -0400
Received: by mail-pl1-x62b.google.com with SMTP id g11so4453983plp.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mRcK8czV/oom/pkIx79cPTpR+Nhj4Hg+rOsk6vM94j4=;
 b=cNbsIj9eglGL5hwv9PKqKn/U1sEOD3nRLjBRyV0j8hserxzrN3sLVX3BM3R+jJRLX3
 eVCpcWHep/pXovhC84H+1dLpsjkChFKlXNUuBLpqMzidhMXrXC24XX65QDSQqQkx4yE7
 VJdPUkUjFR1AMzYVd1DJCBCU3+hhH1heQTZ443oFqQVNuZ57aHon2+nTIL3VVuYL+kI1
 ETVQpuV/EgNFIbDzwM1V/30RV/53hlAQ1xH4Cl9csYFt/b+/K2jDXP1WRNmOLImkYur/
 OT9oKQ3fiolNVgQ7iSB4+ODMBi2UVOYX5esqWjZmkgxEIBLAJld9QUqE5xCK+Zi3o8kn
 u2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mRcK8czV/oom/pkIx79cPTpR+Nhj4Hg+rOsk6vM94j4=;
 b=rpRpBqtv5Y6JWPF6pvMeDfKz7VpHOhQ3FdKVcYFFQJtDnyJ9DMNd7r+vO1jd1hX/fx
 92XRpEp07+083JpawjgkesFqrN1ahcBKe+DmFzfJgCvAxyHkKIvSI1GAOhAyDJ0purIY
 6DmLB5Vkv9x1FKAcd7FCNsDbsXL5XXMNN6h5kbQeElgtPxrn4pNwrQNw1xSMPOJe1OTo
 6yU/Zj31STWKW0Cj4HD+xSZHLPfSc7PBOZzLwZ1Ovh4s/PBu4eGJsaU1ZTYLVtd0/c8f
 ijxFMnjhR4dYhtziyihD6foWyiaQ0d3ueIi2VXABj1hQ+Y6pBqGKnMDsQaIHFBW4qu87
 gQFw==
X-Gm-Message-State: AOAM5319HVo2tIFgAb8sUsNSsv2P0ozTZZjc5R0WJ9p5+VxukyFjYWOG
 HeyZyvfHhMVnK/faCQG5MIQZOYx/c+c=
X-Google-Smtp-Source: ABdhPJyPHWxMOxYfyRF+BHa8WEmZOSrv9LDtSAXdNWqV971szryGbNrxyNZDGHeO8a0SM7liM+4AzQ==
X-Received: by 2002:a17:90a:a402:: with SMTP id y2mr291192pjp.24.1589820058605; 
 Mon, 18 May 2020 09:40:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x132sm5790610pfd.214.2020.05.18.09.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 09:40:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] decodetree: Rename MultiPattern to IncMultiPattern
Date: Mon, 18 May 2020 09:40:47 -0700
Message-Id: <20200518164052.18689-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518164052.18689-1-richard.henderson@linaro.org>
References: <20200518164052.18689-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Name the current node for "inclusive" multi-pattern, in
preparation for adding a node for "exclusive" multi-pattern.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index b559db3086..7af6b3056d 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -371,7 +371,7 @@ class Pattern(General):
 # end Pattern
 
 
-class MultiPattern(General):
+class IncMultiPattern(General):
     """Class representing an overlapping set of instruction patterns"""
 
     def __init__(self, lineno, pats, fixb, fixm, udfm, w):
@@ -410,7 +410,7 @@ class MultiPattern(General):
                 output(ind, '}\n')
             else:
                 p.output_code(i, extracted, p.fixedbits, p.fixedmask)
-#end MultiPattern
+#end IncMultiPattern
 
 
 def parse_field(lineno, name, toks):
@@ -751,8 +751,8 @@ def parse_generic(lineno, is_format, name, toks):
                           .format(allbits ^ insnmask))
 # end parse_general
 
-def build_multi_pattern(lineno, pats):
-    """Validate the Patterns going into a MultiPattern."""
+def build_incmulti_pattern(lineno, pats):
+    """Validate the Patterns going into a IncMultiPattern."""
     global patterns
     global insnmask
 
@@ -792,9 +792,9 @@ def build_multi_pattern(lineno, pats):
         else:
             repeat = False
 
-    mp = MultiPattern(lineno, pats, fixedbits, fixedmask, undefmask, width)
+    mp = IncMultiPattern(lineno, pats, fixedbits, fixedmask, undefmask, width)
     patterns.append(mp)
-# end build_multi_pattern
+# end build_incmulti_pattern
 
 def parse_file(f):
     """Parse all of the patterns within a file"""
@@ -860,7 +860,7 @@ def parse_file(f):
                 error(start_lineno, 'indentation ', indent, ' != ', nesting)
             pats = patterns
             patterns = saved_pats.pop()
-            build_multi_pattern(lineno, pats)
+            build_incmulti_pattern(lineno, pats)
             toks = []
             continue
 
-- 
2.20.1


