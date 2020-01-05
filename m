Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826F5C00523
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 07:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473D321582
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 07:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="AKMtDSLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473D321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io0N3-0001HB-Bl
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 02:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cota@braap.org>) id 1io0M4-0000h2-Lz
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 02:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cota@braap.org>) id 1io0M3-0004oc-Hw
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 02:29:44 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:36490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cota@braap.org>) id 1io0M3-0004mX-8Y
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 02:29:43 -0500
Received: by mail-qk1-x741.google.com with SMTP id a203so37482747qkc.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2020 23:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YHvSUxZTFvIHi/qksCje8+8TNPG6ulJOjYAYTSQ/DDk=;
 b=AKMtDSLW4QJTUGtmGdQiJN3bVn/HRbagRMGbTMJdUYIOJB/kSOzf8FKJ9/jenPMs4P
 /pRd6eqv/EOj4mZeU0GmhhgsKHcimgovo7bl4du08jxQjfYNbzS+9jHo7qIVx14s5kZM
 tRUVMgZsS+ITu+SqGHMtwBIBDaHcEVzeSsaeHVBEju8ArNZbB8a3xIcCkmbBx5d19RIl
 apLWG6eFYmkJ6LBlOWv6TRkOBcePQtVOKoLEf+gk+rMoqFEseIgcK28Ow34V/vNHLBn6
 xBuCRkLmegWB00fagvxkf76udc5xqU0wliWWUq3i3a5INLV4zH40gy3Vj/JYk8hDFTXi
 sqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YHvSUxZTFvIHi/qksCje8+8TNPG6ulJOjYAYTSQ/DDk=;
 b=JqoxIGdQVMFiu0xTeIrPGBpvfwpPvpYmXJKGW6KUWQ09Y1Zd0oumwdrx1rEp/UgWvR
 wVmPhOhNlcsVLOlUa84PKnJ8XHz4IfaN87ttms2dkvh4Wb1WY3IPRPAkzaAbF9bkkjoR
 WYnkF5LfVkXUDDSI0Msi3x7LDPDIUN9yOBt6t7OOa+kb+Q/3eCySGjtKlzkhU1siIRd/
 T5W4NfrnRpuBKxAUsjPoL3okgyGJBEOtnjlZgUYYT/b/Pv67/KiF4oMwCucjsonW+Rnu
 Ibw6/RpJ8+jrHpbwsIF3jFeWr2x8aJbGhhFbMECC4+AvOkzKl3zJy8HmNVevWZwoTqRD
 r/5Q==
X-Gm-Message-State: APjAAAUW65WhUY/kkCH90LJPKaCtOVcMZLfwDaSrJmvLPy0XuIJxyfU7
 KQo98aW33UxFk9t1xZzpr7lC8CxhvUVygw==
X-Google-Smtp-Source: APXvYqwrtau0P3un8Kapn5r3yKB0yYkuDU6a6dEdelXD8LKtQvnIDszFiPSi/cVofr2ikwijhs69dg==
X-Received: by 2002:a37:9f41:: with SMTP id i62mr75960063qke.272.1578209381816; 
 Sat, 04 Jan 2020 23:29:41 -0800 (PST)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id t23sm21245544qto.88.2020.01.04.23.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jan 2020 23:29:41 -0800 (PST)
From: "Emilio G. Cota" <cota@braap.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] plugins/core: add missing break in cb_to_tcg_flags
Date: Sun,  5 Jan 2020 02:29:40 -0500
Message-Id: <20200105072940.32204-1-cota@braap.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robert Henry <robhenry@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: Robert Henry <robhenry@microsoft.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 plugins/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/core.c b/plugins/core.c
index 9e1b9e7a91..ed863011ba 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -286,6 +286,7 @@ static inline uint32_t cb_to_tcg_flags(enum qemu_plugin_cb_flags flags)
     switch (flags) {
     case QEMU_PLUGIN_CB_RW_REGS:
         ret = 0;
+        break;
     case QEMU_PLUGIN_CB_R_REGS:
         ret = TCG_CALL_NO_WG;
         break;
-- 
2.20.1


