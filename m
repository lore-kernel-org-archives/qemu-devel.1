Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E42C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC5B2469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 15:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S22lS01G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC5B2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7hqW-0002P7-DS
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 10:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhE-0001F7-6Y
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7hhD-00053D-2t
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:37:00 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7hhC-00052e-T7
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 10:36:59 -0500
Received: by mail-wr1-x42e.google.com with SMTP id j7so3361528wrp.13
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 07:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZbldaYpK0nbyI3uQIGQose1aCPrQO+Btz1X+MDN68xw=;
 b=S22lS01G4S/NFZpbMM96ucXvU4Zu5kSz1eoVdSXrbQVAFBgwLmAyTPd5nFEgZqiPLU
 Ta1zPqrLKFk9eBiSAR2Kn80ptyc2+zBeQlVwYr83oK6iNK0ONrhxNM0NDoR6enAg3GQE
 UVnRerfCLjZjJdsyohjRnxkvWDTOdbopvlLtJjNVXj7xXOKQoj1i893f7j+xGUXre+h2
 YdV/eVgz3Ly+xActLYf2LazKUAk32Jr84ZXPoxZB89XNGxS9Tj4FKK32VI/aAMKRoQzK
 n7p8fqbXsqQmjSMjcePKf/nBq2ktlCIVKmBAsK+XW3x8GTrOJksezukuG1GjzgxivgDJ
 8cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZbldaYpK0nbyI3uQIGQose1aCPrQO+Btz1X+MDN68xw=;
 b=Zlm5dd8IVtIs1dpj1Ugz37+nCUs78TzKA2Y9hYne/WwPPMuX2I3qaOypwsZYYULqzU
 qWYFhp8SodCwexjn7GWgeziA3Pn40FQq+LI+PGzKdMTxOGC6i0qMMcG+QXu3k41hlt98
 PWe2zf3rHGi4UrQ/uuDspb7+3ctYOps4G8bLHNsEdDvHoNcb23NwEdRM0CgGUz+DB2Qt
 veJi+OUTgiYnKc8ZT6BPo/BIyT8leOGe/cGJvaSPNhNIs05bqvmhkwo4fUsPFqHVIA/o
 UY2nLgmvw4OpbXY6LNioFa8WbtMGDEcAE/5UYHNtwYPedQ4iMfGO9S6jRq/+g/R4WzU/
 sRzg==
X-Gm-Message-State: APjAAAXAoVzB6aY/4QhGbRoZa9E5X6Y/BwtE+j11XF0AFjpbpMYrn8fn
 dvYk/Zwh4/sQQrEYGgLQVnAMRjDG9vupKQ==
X-Google-Smtp-Source: APXvYqzMe/Mcp6ssAswWi2n4OuvyY4WvKCpP8nO87YnZRFyiv8eNjQnX7JSExl4GUclr7ZL77BEPJQ==
X-Received: by 2002:a5d:4491:: with SMTP id j17mr285100wrq.152.1582904217638; 
 Fri, 28 Feb 2020 07:36:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u23sm2659452wmu.14.2020.02.28.07.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:36:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 22/33] doc/scripts/hxtool.py: Strip trailing ':' from
 DEFHEADING/ARCHHEADING
Date: Fri, 28 Feb 2020 15:36:08 +0000
Message-Id: <20200228153619.9906-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228153619.9906-1-peter.maydell@linaro.org>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In hxtool files, section headings defined with the DEFHEADING
and ARCHHEADING macros have a trailing ':'
  DEFHEADING(Standard options:)

This is for the benefit of the --help output. For consistency
with the rest of the rST documentation, strip any trailing ':'
when we construct headings with the Sphinx hxtool extension.
This makes the table of contents look neater.

This only affects generation of documentation from qemu-options.hx,
which we will start doing in a later commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/sphinx/hxtool.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/docs/sphinx/hxtool.py b/docs/sphinx/hxtool.py
index 5d6736f3002..7dd223fe362 100644
--- a/docs/sphinx/hxtool.py
+++ b/docs/sphinx/hxtool.py
@@ -60,8 +60,9 @@ def parse_defheading(file, lnum, line):
     # empty we ignore the directive -- these are used only to add
     # blank lines in the plain-text content of the --help output.
     #
-    # Return the heading text
-    match = re.match(r'DEFHEADING\((.*)\)', line)
+    # Return the heading text. We strip out any trailing ':' for
+    # consistency with other headings in the rST documentation.
+    match = re.match(r'DEFHEADING\((.*?):?\)', line)
     if match is None:
         serror(file, lnum, "Invalid DEFHEADING line")
     return match.group(1)
@@ -72,8 +73,9 @@ def parse_archheading(file, lnum, line):
     # though note that the 'some string' could be the empty string.
     # As with DEFHEADING, empty string ARCHHEADINGs will be ignored.
     #
-    # Return the heading text
-    match = re.match(r'ARCHHEADING\((.*),.*\)', line)
+    # Return the heading text. We strip out any trailing ':' for
+    # consistency with other headings in the rST documentation.
+    match = re.match(r'ARCHHEADING\((.*?):?,.*\)', line)
     if match is None:
         serror(file, lnum, "Invalid ARCHHEADING line")
     return match.group(1)
-- 
2.20.1


