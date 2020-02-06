Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDFFC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 713E620659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQT2Bzz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713E620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlAC-0006cZ-Jp
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izl07-0006on-7k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izl05-0006oH-AT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:35044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izl03-0006Yw-Cp
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:35 -0500
Received: by mail-wm1-x32c.google.com with SMTP id b17so1013331wmb.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m1bLOghX51x85KpGQ8LubXbMWazawtflU6lC5+ETOt0=;
 b=wQT2Bzz9jNy8iLOdroBgTf7SntlkB0ipMeBC6LwtXQO+3zjL7QRL971LsiynI8r6/l
 SBgcAXuTGmeCFDEXufv6A3rO/eIQ4Lj/eFrts8IVCYa6qiEwj1rP2H4uha8Dk16nx9x+
 uMJk1xaOpd0D5JcHLorTYHtPRE5q+OZ6OSvyKGYrPXngpbEipNk97ZvMZKwfb3iW7ybQ
 dAEIUpr9/Yt9PaJwnWjLrVAcSCIsmdnr/QOmDoOAB9YSXS2+JTAZ7m8SxnsrvTxM00EQ
 AVtUK35x83yjxfmx9c6oo5nVnJ+YOShXsSc4uRR4mu+6bhpWO6lgKexV0YK358f/Vr9E
 pzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m1bLOghX51x85KpGQ8LubXbMWazawtflU6lC5+ETOt0=;
 b=SKzXFsawdu1SzVvTZ4t69ySxiPvUE/eJCvxGH9f3pc8iCGpCqDtndphu0VRe+mbsek
 2M2Q66dTQXFMl682/ZGndcI11QrMkOcYiPQPn8yLn/J1GMgc8Is516v7KndnvYorJCWU
 TPQx+kw9HnHXIsCPQ1HPbv3bnnzqajnvzKAH46UOn7R0vTnu3S9WGqha222y6b5F99Iy
 o/pgbGfZjex/LT0UWeTQ6yn999YJD3J/9zE4wE0O/AGPvwC02aCxb4lV3r+jb3CRvIgd
 b+vnl6jkFTH3TybIl1OtzxwKr7+7Im1FsUfkOHWexEbquYz45kzTQh8KlIDtgrjdqqul
 hs9w==
X-Gm-Message-State: APjAAAWK4lRgJCqCSBER4KK/uA+A+swLIiNUmay1W709SkHE/KyeqLIg
 6J2T/f1sB3nRF/LTjgOlM1KwzN1kM3E=
X-Google-Smtp-Source: APXvYqxbPYqAkExvaGSYMeSzXxhZIVtHvHwyhXGY4sxGd/4VGQ5IyK0qpxMAs+HgDf+sGeJFo9xZkg==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr5576802wmk.131.1581010291851; 
 Thu, 06 Feb 2020 09:31:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/29] scripts/qapi: Move doc-comment whitespace stripping to
 doc.py
Date: Thu,  6 Feb 2020 17:30:32 +0000
Message-Id: <20200206173040.17337-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/qapi/doc.py    |  1 +
 scripts/qapi/parser.py | 12 ++++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 6f1c17f71f7..96346c9b14f 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -80,6 +80,7 @@ def texi_format(doc):
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
-- 
2.20.1


