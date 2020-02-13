Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FC3C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6769D206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UirwSC0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6769D206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2J3i-0002jV-Gd
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijr-0000mL-HN
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijp-00035l-T4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:23 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ijp-00033Q-Km
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:21 -0500
Received: by mail-wr1-x42d.google.com with SMTP id u6so7849583wrt.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wpXd5QxscHZ5Ze+pVlbaJlNdMe0Q3RlgSzZJLeNwcSk=;
 b=UirwSC0WPnPtZx8dyMewg+fuLEeN+VYHty+qCll09IjdIfyajD7PMeU1cJRH77Lu+h
 UchqNPNSDpKlaYqzlTt/gQwtrO11jv5SQW6/irbQpeaIhD3uEhXIMl4/Wp41zt8TiRt/
 fhKcLPLu7unjaYUWm5g8/AByhV6CALsNBGzkhVc/SeIDYYc2UDUVRF4XMhMZV9NKMgrr
 HB1ocjka/MNnMy2eYI23wYgOqe7SDZydT1tu43J1mLEqYlR5fjGjDSEaRENeCafxYiF3
 1whPVv/izr0zoTE7KsN2MCSJJ0Ma4CfjcU2dhJxINJfjgAC0iOSxZ6s7EZlJ2oH4cpmV
 An5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wpXd5QxscHZ5Ze+pVlbaJlNdMe0Q3RlgSzZJLeNwcSk=;
 b=ACe/qlWSFAbWxzlDYlDw107rnVHl5ADLxJxclXVeaj5V9ete89A1K+brj1VC+qSDqF
 tVIzgFdvp7pq4/vSBMypHsj8PiO3nXV+JbvUbGPRkVCRwaEh/w2f1RrZKQ0HM/D6/nGn
 O7Ep+MBvOgVGXx5Re6GW7Vl9KswjwFNgorv4k+cSiMAOrBd8uyGOXGoC9wpsvZhF7VkH
 63lGDvgVmB3qq5cB9wVZb5LLcfHuVHB1lh44LrVdRWU/Ip1bdNVbZW9tiFRn7UjJSMIp
 eBeirOPuGhbH/4QhhjXW+mAo9fwzpvWoGveP7TGec9V7BXB8v/phmdZN3Lg+NgsHWeJe
 fzhg==
X-Gm-Message-State: APjAAAUfdaGCjAa2+PCKEFmHCjXtN6LuKcWbvbXpe9tGxgAxCzAd2BCE
 DolXdXvtdZus/+YcfbOuFVR1QNuHCu4=
X-Google-Smtp-Source: APXvYqw0JLqOxAetbv1MciWoFRa+PvDZjQkct/q4n3ImEAQpbOreWsBOz88X+WgD6L6euW/zLWvlsQ==
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr23553063wrs.92.1581616640457; 
 Thu, 13 Feb 2020 09:57:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 22/30] scripts/qapi: Move doc-comment whitespace stripping
 to doc.py
Date: Thu, 13 Feb 2020 17:56:39 +0000
Message-Id: <20200213175647.17628-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

As we accumulate lines from doc comments when parsing the JSON, the
QAPIDoc class generally strips leading and trailing whitespace using
line.strip() when it calls _append_freeform().  This is fine for
texinfo, but for rST leading whitespace is significant.  We'd like to
move to having the text in doc comments be rST format rather than a
custom syntax, so move the removal of leading whitespace from the
QAPIDoc class to the texinfo-specific processing code in
texi_format() in qapi/doc.py.

(Trailing whitespace will always be stripped by the rstrip() in
Section::append regardless.)

In a followup commit we will make the whitespace in the lines of doc
comment sections more consistently follow the input source.

There is no change to the generated .texi files before and after this
commit.

Because the qapi-schema test checks the exact values of the
documentation comments against a reference, we need to update that
reference to match the new whitespace.  In the first four places this
is now correctly checking that we did put in the amount of whitespace
to pass a rST-formatted list to the backend; in the last two places
the extra whitespace is 'wrong' and will go away again in the
following commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
New in v2: update doc-good.out as noted in final para of commit msg
---
 scripts/qapi/doc.py            |  1 +
 scripts/qapi/parser.py         | 12 ++++--------
 tests/qapi-schema/doc-good.out | 12 ++++++------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 1787a53d91a..26cd1a1751e 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -79,6 +79,7 @@ def texi_format(doc):
     inlist = ''
     lastempty = False
     for line in doc.split('\n'):
+        line = line.strip()
         empty = line == ''
 
         # FIXME: Doing this in a single if / elif chain is
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 342792e4103..2196ec5de1e 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -422,10 +422,10 @@ class QAPIDoc(object):
                 self._append_line = self._append_various_line
                 self._append_various_line(line)
             else:
-                self._append_freeform(line.strip())
+                self._append_freeform(line)
         else:
             # This is a free-form documentation block
-            self._append_freeform(line.strip())
+            self._append_freeform(line)
 
     def _append_args_line(self, line):
         """
@@ -458,7 +458,7 @@ class QAPIDoc(object):
                 self._append_various_line(line)
             return
 
-        self._append_freeform(line.strip())
+        self._append_freeform(line)
 
     def _append_features_line(self, line):
         name = line.split(' ', 1)[0]
@@ -477,7 +477,7 @@ class QAPIDoc(object):
             self._append_various_line(line)
             return
 
-        self._append_freeform(line.strip())
+        self._append_freeform(line)
 
     def _append_various_line(self, line):
         """
@@ -500,10 +500,6 @@ class QAPIDoc(object):
             line = line[len(name)+1:]
             self._start_section(name[:-1])
 
-        if (not self._section.name or
-                not self._section.name.startswith('Example')):
-            line = line.strip()
-
         self._append_freeform(line)
 
     def _start_symbol_section(self, symbols_dict, name):
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 9503a3a3178..a65bce639ff 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -71,20 +71,20 @@ doc freeform
 
 * List item one
 * Two, multiple
-lines
+  lines
 
 * Three
-Still in list
+  Still in list
 
 Not in list
 
 - Second list
-Note: still in list
+  Note: still in list
 
 Note: not in list
 
 1. Third list
-is numbered
+   is numbered
 
 2. another item
 
@@ -144,7 +144,7 @@ doc symbol=Alternate
 
     arg=i
 an integer
-@b is undocumented
+    @b is undocumented
     arg=b
 
 doc freeform
@@ -157,7 +157,7 @@ doc symbol=cmd
 the first argument
     arg=arg2
 the second
-argument
+       argument
     arg=arg3
 
     feature=cmd-feat1
-- 
2.20.1


