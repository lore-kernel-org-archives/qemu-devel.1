Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B50CCA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 13:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B5B205C9
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 13:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kambanaria-org.20150623.gappssmtp.com header.i=@kambanaria-org.20150623.gappssmtp.com header.b="QcKSWnA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B5B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLpAK-0004Y3-KP
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 09:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ash@kambanaria.org>) id 1iLnUV-0006Vv-RB
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 08:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ash@kambanaria.org>) id 1iLnUU-0002td-5u
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 08:05:51 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:34769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ash@kambanaria.org>) id 1iLnUU-0002sm-0j
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 08:05:50 -0400
Received: by mail-wr1-x433.google.com with SMTP id t16so3753927wrr.1
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 05:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MrtvVJmSyqwqULqVndoYPRFrL2xWqsVES8uYOf+Y1Ys=;
 b=QcKSWnA8NKSaZdj2WYcoN5iFbSXIcqaOzJ5ZK/JB8K0NhZvjpDR6z5wZdwIG/2WKoF
 gRW4KSaDTZdyEixJddWih3uJ8pgbui3CI9HZjZTonm7m1fkCZ4r0xSgHFagY79OeoO3u
 z7L9IVIledlqI/lZ0Y0m9/zHSiBsv/nA5uTPkvBbKvyvW0+NQ5EN9VPUX6wmWFl2IsHZ
 qn+Dg8IGPGLJm56OSrRn9JvrOUsPPRc2jbNpkZco7rWtm6sYaynueJxr/sB4nUKWu8Xb
 +y9z2rSDJJo2gnSxTYmeRGs6IIXHGS7/8FqkFldnS+VxtLPUdI6yUxRjnE9AgjKn42Au
 JGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MrtvVJmSyqwqULqVndoYPRFrL2xWqsVES8uYOf+Y1Ys=;
 b=bTNBAZ+XlRn+Zj3DkFr0S9c1OkqtxVF/3ts93rGLgXUTLlSA619WN/FPdIUy2PrDLL
 VWMcxJOMpMzXh80GYkm9aIw8g8MOkZFAGUgNhVAPnLFTM8ou597Ilia4TPiZcxlxTO/u
 2+g9U3Iog8gzKw86+OGIMmGHm3vWMHLotgszfmvMlVz79894658DoHqZBpQv4+uDikrG
 vNDWw7B+HMHRM5WCQA2d8QVjE3EWw2VHimintGLC6HzWofkKjRvCIsyeTF1y7r7505Y/
 9gQgUhtbkpocinLjeHIjBNdIs+R6ZrbWiF46z7RpCQ2jD+duS2dfxSAXX12novp2uJSw
 ZMww==
X-Gm-Message-State: APjAAAVtVWO70iM1Eb6p0Oe84gcTc4vSjkXl6/yoqCWCb15EJcz1AuHc
 1aaUW1Y8vEbXnImuSGldmsSxcIlZirzIQA==
X-Google-Smtp-Source: APXvYqz5/3KoMSNtMZjU1gAhnIQ5nVaCZBmd6J5l2JIRmaoOe0RS+NN5QktEJazcNMeGvWjrwgCTcQ==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr12458849wrq.385.1571486748481; 
 Sat, 19 Oct 2019 05:05:48 -0700 (PDT)
Received: from ashopov-C02X544YJHD3.home (ip4da0f75a.direct-adsl.nl.
 [77.160.247.90])
 by smtp.gmail.com with ESMTPSA id z22sm9249550wmf.2.2019.10.19.05.05.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Oct 2019 05:05:47 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] Updated Bulgarian translation (19) - 4.1.0
Date: Sat, 19 Oct 2019 14:05:34 +0200
Message-Id: <20191019120534.27479-2-ash@kambanaria.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019120534.27479-1-ash@kambanaria.org>
References: <20191019120534.27479-1-ash@kambanaria.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
X-Mailman-Approved-At: Sat, 19 Oct 2019 09:51:04 -0400
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>,
 Fam Zheng <famz@redhat.com>, Wei Huang <wehuang@redhat.com>,
 Pino Toscano <ptoscano@redhat.com>, qemu-trivial@nongnu.org,
 Laszlo Ersek <lersek@redhat.com>, Alexander Shopov <ash@kambanaria.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amos Kong <akong@redhat.com>, Dongsheng Song <songdongsheng@live.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 po/bg.po | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/po/bg.po b/po/bg.po
index 3d8c353372..98c57e5b22 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -1,14 +1,14 @@
 # Bulgarian translation of qemu po-file.
-# Copyright (C) 2016 Alexander Shopov <ash@kambanaria.org>
+# Copyright (C) 2016, 2019 Alexander Shopov <ash@kambanaria.org>
 # This file is distributed under the same license as the qemu package.
-# Alexander Shopov <ash@kambanaria.org>, 2016.
+# Alexander Shopov <ash@kambanaria.org>, 2016, 2019.
 #
 msgid ""
 msgstr ""
-"Project-Id-Version: QEMU 2.6.50\n"
+"Project-Id-Version: QEMU 4.1.0\n"
 "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
 "POT-Creation-Date: 2018-07-18 07:56+0200\n"
-"PO-Revision-Date: 2016-06-09 15:54+0300\n"
+"PO-Revision-Date: 2019-10-19 13:14+0200\n"
 "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
 "Language-Team: Bulgarian <dict@ludost.net>\n"
 "Language: bg\n"
@@ -66,7 +66,7 @@ msgid "Detach Tab"
 msgstr "Към самостоятелен подпрозорец"
 
 msgid "Show Menubar"
-msgstr ""
+msgstr "Лента за менюто"
 
 msgid "_Machine"
 msgstr "_Машина"
-- 
2.23.0


