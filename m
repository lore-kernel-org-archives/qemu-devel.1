Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A6FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B313C214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 23:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf8dZ9WC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B313C214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifXor-000600-SU
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 18:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ifXo0-00058N-4y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1ifXny-000771-QZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:23:36 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ifXnx-00073g-Ag
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 18:23:34 -0500
Received: by mail-lf1-x143.google.com with SMTP id n12so562019lfe.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 15:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DhoqWiMGoVdw47Q4e9bSpG5qhQNpHYEmY/z121gdltk=;
 b=jf8dZ9WC0cpSPH9XGhiV7M0c/xv/E8n+Kc2PN30pyqnucVWwR4WRoPRwOTURZ1lP6u
 3HopGJUJIRRYSL5u/7c+LriYfftBFBDbsBGL8U5GBNFfqUL5++ceZSPg1t/+171O2dzJ
 ksqZ5ywKiuJRvND5CGR7ixi+cPhke4uW9pbqpc9qypmQNRSrOO2qX6CAxMAHc7AenZyT
 op6+sabwhXQ1j+oulMJddRqJZ3pOLdWdFMARBh1mJ7TLjkejo7uea9uAuaiG6o0B34fl
 6Cwh4IO21l6kJ+SBerQOI66XYhjqUZurTygcBNskq5dBZePb2mjH8UnQJH9TlQJF7BlT
 CkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DhoqWiMGoVdw47Q4e9bSpG5qhQNpHYEmY/z121gdltk=;
 b=K0ouhs+CTHjs2nMcfiwjKXdoPWkszPE5Vs4KsEbDtUaCxhBP2PDvi8AGzkemx+hQ6u
 MAbSob3fILVLc8XwMZMo/Qfw/Q6Rq7ViXQrxbwQcR2O99Cng97c+Q03FwS+XQ81xjsDb
 dhjV7mnPPLRpwLeG1oQs315rhcSZwRlh8cDn+agupHChZ84cx8Z3coYjsUazlwcKv05O
 6+G0AThfrJnIzCNsk5lSAnhcYWYsZ9HkZrnvgtwuwz85oUhSZSfjGGhGHz0IKpB7tyRK
 h/Z6bg5/A10i+XfveA2aUqkJjGyDGgt462jCN9uMaLwwAZx0CiQlMG/bWmxzAUMEwE1A
 tZ/A==
X-Gm-Message-State: APjAAAWjYwYqLmRCy/qk3oYMJVMRg9sEtIU1eYjWO5s6MhvrfO2bm4YT
 5h4BjQTySLpO2fL9/l781IJg3ewtKIQ=
X-Google-Smtp-Source: APXvYqyYBGParWPO9JBxwXP8qxqs2v3lNLGPTMKVESfeZJ2QSBS6m9uRRptVN+gTtWAQXWiP23pGpg==
X-Received: by 2002:a19:760c:: with SMTP id c12mr7543088lff.60.1576193011719; 
 Thu, 12 Dec 2019 15:23:31 -0800 (PST)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id j19sm4107859lfb.90.2019.12.12.15.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 15:23:31 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/xtensa: import xtensa/config/core-isa.h
Date: Thu, 12 Dec 2019 15:23:17 -0800
Message-Id: <20191212232318.2840-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212232318.2840-1-jcmvbkbc@gmail.com>
References: <20191212232318.2840-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Import core-isa.h from its canonical place in the configuration overlay.
Drop --xform option from the tar command line.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/import_core.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/import_core.sh b/target/xtensa/import_core.sh
index e4a2e39f6353..97c3219debf0 100755
--- a/target/xtensa/import_core.sh
+++ b/target/xtensa/import_core.sh
@@ -19,8 +19,8 @@ exit
 
 [ $# -ge 3 ] && FREQ="$3"
 mkdir -p "$TARGET"
-tar -xf "$OVERLAY" -C "$TARGET" --strip-components=1 \
-    --xform='s/core/core-isa/' config/core.h
+tar -xf "$OVERLAY" -C "$TARGET" --strip-components=2 \
+    xtensa/config/core-isa.h
 tar -xf "$OVERLAY" -O gdb/xtensa-config.c | \
     sed -n '1,/*\//p;/XTREG/,/XTREG_END/p' > "$TARGET"/gdb-config.inc.c
 #
-- 
2.20.1


