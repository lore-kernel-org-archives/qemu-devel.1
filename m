Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D882C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0871420656
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQNeop+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0871420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGwA-0002qR-8W
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbs-0000dK-FF
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbr-00089S-Ct
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:18:04 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAGbo-00082U-Mu
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:18:01 -0500
Received: by mail-wm1-x343.google.com with SMTP id e26so3165473wme.5
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0hkWJtDoUx3C/GFYCxG8kr97qdyRwJLP+Zk6m43M10Q=;
 b=FQNeop+gutXwrkXwNaeeEIFKZfRktfHITDE722SnPM2UnbNYrWE4QFPnzidTUeb868
 GhRWrCLE7I9DadAdBMBYW30FCyr8cAMm9fJ9+btZC+6y+qrF3S+tUbq88XBhiCqUuYvg
 hEU/SD4BYIF70nEpfBetYr0b6LK2kN4Xt5eEyA92mBLbQBku89FUOc/yJrRp4rAF1EKu
 qyZYuzrpL0IHGX5T8dA3vlcJWWdKokP9uTwUAW+HrJMfVoBUmXiDB3rLcCN0Vram3yar
 z9GC+A+PfdypCcnrde3Ly0hD+qA0u/+22Fyddm6oJsn7ojLTG2QKpG5ZT+s+1WGckjuc
 vtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0hkWJtDoUx3C/GFYCxG8kr97qdyRwJLP+Zk6m43M10Q=;
 b=pFaiWhzwhLzZMW2MGo7MAxWhnhqdz741h4F79W2xDLiAT0vr3Nya7auBMaJVIgw6gK
 B+CzLo1BUgwgzllPLWGWcoagsJIMCPMCKxfChGxMN+mxEnsjxj2lkzEAMUVfaKBkcxeo
 yy4Nn98R6CeGBoKpHOzRZ948id6tMsUhNqrkeZTTDAugRMGQXU2BMh6fkYtAKJ//fOql
 hKF4iRAY8mxg9aRBUxl9b8zz/Myv/VvSZ+PAFjtA51cOKQvrjOpVQZkRlS0+YiklvehQ
 2A0qeMhdCuCqWs2bwoSB4E0B/bI6yJLiGRBw6SwbFh7IdOa3Gj73LtwfZAKB+Bno66w3
 GpSQ==
X-Gm-Message-State: ANhLgQ2PiKxTsf+GqZLQcHlDgrbqciojCJdFhyF26YQsntLejL0mYGs8
 5nxThV2IT6KI4USMmiv/3pWZuIUlVqW3Kg==
X-Google-Smtp-Source: ADFU+vuRRnzQdvldYqq739sJxgwTrad6DlY//5pcCz3b78WSH9EAH3jlediFkIXaNK12mGQgQ4tbVw==
X-Received: by 2002:a05:600c:d8:: with SMTP id
 u24mr5136148wmm.165.1583515077913; 
 Fri, 06 Mar 2020 09:17:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f8sm6948346wmf.20.2020.03.06.09.17.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 09:17:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] docs/index.rst, docs/index.html.in: Reorder manuals
Date: Fri,  6 Mar 2020 17:17:48 +0000
Message-Id: <20200306171749.10756-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306171749.10756-1-peter.maydell@linaro.org>
References: <20200306171749.10756-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that qemu-doc.html is no longer present, the ordering of manuals
within the top-level index page looks a bit odd. Reshuffle so that
the manuals the user is most likely to be interested in are at the
top of the list, and the reference material is at the bottom.

Similarly, we reorder the index.rst file used as the base of
the "all manuals in one" documentation for readthedocs.

The new order is:
 * system
 * user
 * tools
 * interop
 * specs
 * QMP reference (if present)
 * Guest agent protocol reference (if present)
 * devel (if present)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/index.html.in | 10 +++++-----
 docs/index.rst     |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/docs/index.html.in b/docs/index.html.in
index cc19aad2ec5..e9a160384cf 100644
--- a/docs/index.html.in
+++ b/docs/index.html.in
@@ -7,13 +7,13 @@
     <body>
         <h1>QEMU @@VERSION@@ Documentation</h1>
         <ul>
-            <li><a href="qemu-qmp-ref.html">QMP Reference Manual</a></li>
-            <li><a href="qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
+            <li><a href="system/index.html">System Emulation User's Guide</a></li>
+            <li><a href="user/index.html">User Mode Emulation User's Guide</a></li>
+            <li><a href="tools/index.html">Tools Guide</a></li>
             <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
             <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
-            <li><a href="system/index.html">System Emulation User's Guide</a></li>
-            <li><a href="tools/index.html">Tools Guide</a></li>
-            <li><a href="user/index.html">User Mode Emulation User's Guide</a></li>
+            <li><a href="qemu-qmp-ref.html">QMP Reference Manual</a></li>
+            <li><a href="qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
         </ul>
     </body>
 </html>
diff --git a/docs/index.rst b/docs/index.rst
index 376dab28850..763e3d0426e 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -10,9 +10,9 @@ Welcome to QEMU's documentation!
    :maxdepth: 2
    :caption: Contents:
 
-   interop/index
-   devel/index
-   specs/index
    system/index
-   tools/index
    user/index
+   tools/index
+   interop/index
+   specs/index
+   devel/index
-- 
2.20.1


