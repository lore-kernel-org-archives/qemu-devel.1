Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD91C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013A720578
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYGd84j9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013A720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aqM-0007zt-51
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apP-0006f5-Iv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apL-0005HT-ON
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:51 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6apL-0005HE-I7
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:47 -0500
Received: by mail-wr1-x42e.google.com with SMTP id y17so6065577wrn.6
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nWSMAlzi0oMRfWAEf8TA2pk4lWoUJVNUT6Q1IhJAJTw=;
 b=DYGd84j9TBG5oKX7JWteQ/J52Juw6m8eKvyHB0IIj/AkOWjqaBLRTtjzi1YjrfG+pG
 /U6+JltS6Ra4W/qtwqeOnVQ8zIKvFjrInjzwjdiD5jBsdTuQ5SbmqE+N5eyiH6VY3Lfg
 2fEq7///r3Zc3w0uvHb+NTfl+C31VbmhK+bdXdwkNoiLunBlXbJZISQb+Gh/J7/iiVOx
 X+E8jonWpyI48BACpLYbYT/HThtJu2lrTCVRHTSo/XtO9jJ8r7B39y1rZgnELB1AjtDL
 M8HoTaIdSNWjct7Yy1xO/UjMI6pdkrWf02trbiQ5TrzM1wJuddvxHXkjtMfxbf0j1Zh0
 sAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nWSMAlzi0oMRfWAEf8TA2pk4lWoUJVNUT6Q1IhJAJTw=;
 b=F1ywz1KBYVMyGW9z4OYefNxkSbIrXOjWaxEExUZvAH367wUL1hpSnwuvc8Q1jYQI6H
 0EbtaLYRRMcrY4AO5yPTkTRsnXB6GbE1FPrEu/3wiqyYBU+PEAzbibiji5rzv1uJk1h6
 3fudnvCdaSjlCW/OW3nFZ6nU3jQYJnFtPP2MLIxD3+ejMbZTtnx3BYWALd1cgtR/nKqQ
 hjIG/4XKmCiL3ES/rVNKNX8YnXCDIT67b/rELRW4O5k4H0WEpLZQz4XlIQwLU4vifvWP
 zjS+4bsW/MWxtdfErKleU+gQgYb3O5DxvD72ssI3UQp/KWDyLzSier4nJ7vQwlaIW45a
 MRBg==
X-Gm-Message-State: APjAAAUiwmThIMglLpuct4mnudhaacTTOUWbyh79pBkUxkFe0RjIGsyB
 nQ2oYe/mOpWQ0cqA4gGtMuV8eShQamF1fA==
X-Google-Smtp-Source: APXvYqx8zlC45YD0O5JzwN0FOrY/TA0+n2C+HeIozGSQzHYHLrLSGOvpsi7usMOiXpOzhDOTQKztVw==
X-Received: by 2002:a5d:488c:: with SMTP id g12mr70004481wrq.67.1582639486142; 
 Tue, 25 Feb 2020 06:04:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f127sm4322136wma.4.2020.02.25.06.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 06:04:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/12] tests/qapi/doc-good.json: Clean up markup
Date: Tue, 25 Feb 2020 14:04:28 +0000
Message-Id: <20200225140437.20609-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225140437.20609-1-peter.maydell@linaro.org>
References: <20200225140437.20609-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

doc-good.json tests some oddities of markup that we don't want to
accept.  Make them match the more restrictive rST syntax:

 * in a single list the bullet types must all match
 * lists must have leading and following blank lines
 * indentation is important
 * the '|' example syntax is going to go away entirely, so stop
   testing it

This will avoid the tests spuriously breaking when we tighten up the
parser code in the following commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
New patch in v2
---
 tests/qapi-schema/doc-good.json | 25 +++++++++++++------------
 tests/qapi-schema/doc-good.out  | 12 ++++++------
 tests/qapi-schema/doc-good.texi | 12 +++---------
 3 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index d992e713d97..a45dc22848c 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -10,25 +10,25 @@
 #
 # *strong* _with emphasis_
 # @var {in braces}
+#
 # * List item one
-# - Two, multiple
+# * Two, multiple
 #   lines
 #
-# 3. Three
-# Still in list
+# * Three
+#   Still in list
+#
+# Not in list
 #
-#   Not in list
 # - Second list
-# Note: still in list
+#   Note: still in list
 #
 # Note: not in list
+#
 # 1. Third list
 #    is numbered
 #
-# - another item
-#
-# | example
-# | multiple lines
+# 2. another item
 #
 # Returns: the King
 # Since: the first age
@@ -62,7 +62,7 @@
 ##
 # @Base:
 # @base1:
-#   the first member
+# the first member
 ##
 { 'struct': 'Base', 'data': { 'base1': 'Enum' } }
 
@@ -101,7 +101,7 @@
 ##
 # @Alternate:
 # @i: an integer
-# @b is undocumented
+#     @b is undocumented
 ##
 { 'alternate': 'Alternate',
   'data': { 'i': 'int', 'b': 'bool' } }
@@ -115,7 +115,7 @@
 # @arg1: the first argument
 #
 # @arg2: the second
-# argument
+#        argument
 #
 # Features:
 # @cmd-feat1: a feature
@@ -124,6 +124,7 @@
 # Returns: @Object
 # TODO: frobnicate
 # Notes:
+#
 # - Lorem ipsum dolor sit amet
 # - Ut enim ad minim veniam
 #
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 4c9406a464d..9503a3a3178 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -68,25 +68,25 @@ doc freeform
 
 *strong* _with emphasis_
 @var {in braces}
+
 * List item one
-- Two, multiple
+* Two, multiple
 lines
 
-3. Three
+* Three
 Still in list
 
 Not in list
+
 - Second list
 Note: still in list
 
 Note: not in list
+
 1. Third list
 is numbered
 
-- another item
-
-| example
-| multiple lines
+2. another item
 
 Returns: the King
 Since: the first age
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index d4b15dabf03..1e8063c8579 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -6,6 +6,7 @@
 
 @strong{strong} @emph{with emphasis}
 @code{var} @{in braces@}
+
 @itemize @bullet
 @item
 List item one
@@ -20,6 +21,7 @@ Still in list
 @end itemize
 
 Not in list
+
 @itemize @minus
 @item
 Second list
@@ -28,6 +30,7 @@ Note: still in list
 @end itemize
 
 Note: not in list
+
 @enumerate
 @item
 Third list
@@ -36,15 +39,6 @@ is numbered
 @item
 another item
 
-@example
-example
-@end example
-
-@example
-multiple lines
-@end example
-
-
 @end enumerate
 
 Returns: the King
-- 
2.20.1


