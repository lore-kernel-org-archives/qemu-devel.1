Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CFFC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D68206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mNgcXFBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D68206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2IzF-0006Kq-Ts
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijn-0000ev-ND
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Iji-0002sf-O0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:19 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:39696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Iji-0002qj-Ge
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:14 -0500
Received: by mail-wm1-x333.google.com with SMTP id c84so7796254wme.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zJjv+z0Lmna1TM2chaAJ29LZREt9wVMVE2+U6A2tRX4=;
 b=mNgcXFBjVHrzN754CquH3cR1TQbRWe5YNnCJNEdnj5u5NVfGuqOrvJFsv/YY1gxKDt
 hPFThYyRSfDbhT0ZqOVyOyaillb5aL5EiY4qdCX+72PYDc/C6wHCY5L8mBdcOreANawL
 3pz4CCXair7oRKsOHFGWBCVavwGv5jQRpS5vNKeFT2kUMaShUZQnfMKxgF1atP25ZhUE
 SKqRe4SiP6s0016M3/B4voNrfGhN9hRV41ZO2FaruAvIdcFfuzcZrKW4aQmzfYAumSxa
 amGsFAY03Q+yipNT4YOx1dbMUS6FEop50gnOyirkth4ECgtpftUreIotQBk9FTXVM9fo
 rgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zJjv+z0Lmna1TM2chaAJ29LZREt9wVMVE2+U6A2tRX4=;
 b=kxgQibbGHYNj0JPhZML94rZEdiUND8GO+K8injs2ZjLd1yGhegHG8d7DCVf1XUTRYq
 OEvOKjR/Hz6EbeBqlLQsiRXhdCSRjBHGspmp8MDItmbst3PO0WjCV69xem1zMyIrEvgh
 wIYp2MgQv9frTkQvvUjwok1HiWmYnHvvkTiUWGtpjjW/jk4sJ5yCmalkGEwGHOwe/Yfc
 eaL/xJhI4X0Ph/VGQlWGr8uun8v76zZzxPF8UKrCwQwQGTrEt0ylsezNbC+rjm5CkuPT
 sxY3whYSMJNa4WZaMvMxeiWZAlqv88i/GvdZ5FDYtaKRgKbq7eqh9Uz0i2wdc2z8pxSb
 Q5ug==
X-Gm-Message-State: APjAAAWwDqEQiNBkLbzgizBYm2SFabG1dhJtBt2yAvF5cCk4WN9ZzpNJ
 121pypOoysHAzq9vffvLGr2yJ16+2cU=
X-Google-Smtp-Source: APXvYqzHScbfKs79eVEBPx3SZyyr4pP+V4lacOdWPIVGeBC5sish0ZG7L1O1uyVmnPE0Ek7doG2xDw==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr6818432wml.173.1581616633159; 
 Thu, 13 Feb 2020 09:57:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/30] qapi: Add blank lines before bulleted lists
Date: Thu, 13 Feb 2020 17:56:33 +0000
Message-Id: <20200213175647.17628-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

rST insists on a blank line before and after a bulleted list,
but our texinfo doc generator did not. Add some extra blank
lines in the doc comments so they're acceptable rST input.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/block-core.json | 1 +
 qapi/char.json       | 2 ++
 qapi/trace.json      | 1 +
 qapi/ui.json         | 1 +
 4 files changed, 5 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 082aca3f699..13dad62f441 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4757,6 +4757,7 @@
 #
 # Once the tray opens, a DEVICE_TRAY_MOVED event is emitted. There are cases in
 # which no such event will be generated, these include:
+#
 # - if the guest has locked the tray, @force is false and the guest does not
 #   respond to the eject request
 # - if the BlockBackend denoted by @device does not have a guest device attached
diff --git a/qapi/char.json b/qapi/char.json
index 8a9f1e75097..6907b2bfdba 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -133,6 +133,7 @@
 # @data: data to write
 #
 # @format: data encoding (default 'utf8').
+#
 #          - base64: data must be base64 encoded text.  Its binary
 #            decoding gets written.
 #          - utf8: data's UTF-8 encoding is written
@@ -167,6 +168,7 @@
 # @size: how many bytes to read at most
 #
 # @format: data encoding (default 'utf8').
+#
 #          - base64: the data read is returned in base64 encoding.
 #          - utf8: the data read is interpreted as UTF-8.
 #            Bug: can screw up when the buffer contains invalid UTF-8
diff --git a/qapi/trace.json b/qapi/trace.json
index 4955e5a7503..47c68f04da7 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -53,6 +53,7 @@
 # Returns: a list of @TraceEventInfo for the matching events
 #
 #          An event is returned if:
+#
 #          - its name matches the @name pattern, and
 #          - if @vcpu is given, the event has the "vcpu" property.
 #
diff --git a/qapi/ui.json b/qapi/ui.json
index e4bd3d8ea76..89126da395b 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -934,6 +934,7 @@
 # Input event union.
 #
 # @type: the input type, one of:
+#
 #        - 'key': Input event of Keyboard
 #        - 'btn': Input event of pointer buttons
 #        - 'rel': Input event of relative pointer motion
-- 
2.20.1


