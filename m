Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2BAC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D4420838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6xUIs5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D4420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl6P-00082e-Cy
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzq-0006hH-Rz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzp-0005ug-KB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:22 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzp-0005mn-Cd
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:21 -0500
Received: by mail-wr1-x429.google.com with SMTP id w15so8200394wru.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ny3WK8pMdlgBlAoYUdqL7k5E1SZb/jHOFqlIQGucr5M=;
 b=Y6xUIs5hWVoM0LMDBumGmw7SFmqozh4Bbo6rVPQmqjYeJWOpG75nQww3he5bpG3yyn
 IDRsEz7dn6SVqidsaUU2x2yhlc3tleCepXRiGf4BpUp6/QJwTD5q/U3/4GTFWI4mv+N1
 x6a7Qe6//NcHM/r2CxO0xD8MfUuV4UOOUUjNWQVUHl49F3ilWjD6JdAtZkNbjT0L5fpL
 dfDUCgBcUFaAJZQdaMdPMd3ZMoGKMGuIFeUdG7ULHDtf1xCi4BB4jaQwLpdkQVU8Ocze
 iqxEDrVD97QNelejlK/WeBgFs8VLDIJeDfsrVwIxWp3PXOq1RcrVbXDWooMSsInXit8L
 77kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ny3WK8pMdlgBlAoYUdqL7k5E1SZb/jHOFqlIQGucr5M=;
 b=oU/mAFZCF77Od/kx5cObIrLQh1qfSoPBxSQsiEoXLZn5N2mqj9ih71liLK1MyrJvs/
 Ssnedngk8HdiuHNvhvsheyME/ocnlvySlTCGoqYTPgv4zgdDNoYrw1oOFvk8dj4mrK/z
 5wt3w7WmZBAO5bZKu41aS4hMVp7ZG/UYd7brSBoLaN2Nji9NDQVNnRkL0dPFSm7kWOAz
 Dd2XiPGkiUFwVpKJScHONtNSGowML0U5GmDrtlAAM6vbgQ5F6HJKtwJiWhlsYGxVEN+S
 9zghjO5fvQfZ4NIEXoTcyQ5BNpiHMBYPHa04+AMNzERzVQepKKRy7RMBQxM1pr/xS7h/
 W09w==
X-Gm-Message-State: APjAAAWegsZOH3uEu2+u4ibTxxGWbOpflhKLuRKp4+WZg18swPjUfWrF
 9/oumVa1u6Y2QZQOs+z6gaSeYpsApaM=
X-Google-Smtp-Source: APXvYqyWTvZ/C1bk3vc5Jaie/wSB0lyj1IgMSIJYJUo9RF1SD6KKWuQx2BzdVZehIZxWDqCbtRQ02Q==
X-Received: by 2002:adf:f0ca:: with SMTP id x10mr5036186wro.423.1581010277659; 
 Thu, 06 Feb 2020 09:31:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/29] qapi: Explicitly put "foo: dropped in n.n" notes into
 Notes section
Date: Thu,  6 Feb 2020 17:30:23 +0000
Message-Id: <20200206173040.17337-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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

A handful of QAPI doc comments include lines like
"ppcemb: dropped in 3.1". The doc comment parser will just
put these into whatever the preceding section was; sometimes
that's "Notes", and sometimes it's some random other section,
as with "NetClientDriver" where the "'dump': dropped in 2.12"
line ends up in the "Since:" section.

Put all of these explicitly into Notes: sections (either
preexisting or new), with the right indentation, and
standardising on quoting of the symbol with ''.

In the case of QKeyCode, the generated docs were actively
misformatted:
   ac_bookmarks
        since 2.10 altgr, altgr_r: dropped in 2.10

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/machine.json | 2 +-
 qapi/net.json     | 6 +++---
 qapi/ui.json      | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 704b2b0fe31..51ffa96be98 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -20,7 +20,7 @@
 #        prefix to produce the corresponding QEMU executable name. This
 #        is true even for "qemu-system-x86_64".
 #
-# ppcemb: dropped in 3.1
+#        'ppcemb': dropped in 3.1
 #
 # Since: 3.0
 ##
diff --git a/qapi/net.json b/qapi/net.json
index 109eff71cd4..8fbcbc611b9 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -447,7 +447,7 @@
 #
 # Since: 2.7
 #
-# 'dump': dropped in 2.12
+# Notes: 'dump': dropped in 2.12
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
@@ -464,7 +464,7 @@
 #
 # Since: 1.2
 #
-# 'l2tpv3' - since 2.1
+# Notes: 'l2tpv3' - since 2.1
 ##
 { 'union': 'Netdev',
   'base': { 'id': 'str', 'type': 'NetClientDriver' },
@@ -494,7 +494,7 @@
 #
 # Since: 1.2
 #
-# 'vlan': dropped in 3.0
+# Notes: 'vlan': dropped in 3.0
 ##
 { 'struct': 'NetLegacy',
   'data': {
diff --git a/qapi/ui.json b/qapi/ui.json
index 94a07318f55..6da52b81143 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -776,7 +776,6 @@
 # @ac_forward: since 2.10
 # @ac_refresh: since 2.10
 # @ac_bookmarks: since 2.10
-# altgr, altgr_r: dropped in 2.10
 #
 # @muhenkan: since 2.12
 # @katakanahiragana: since 2.12
@@ -790,6 +789,8 @@
 #
 # Since: 1.3.0
 #
+# Notes: - 'altgr': dropped in 2.10
+#        - 'altgr_r': dropped in 2.10
 ##
 { 'enum': 'QKeyCode',
   'data': [ 'unmapped',
-- 
2.20.1


