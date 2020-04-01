Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44B9C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DE320714
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+ektMcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DE320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJjDS-0002R8-LB
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 15:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJjCd-000206-33
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJjCb-0003n2-J3
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:39:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJjCb-0003mc-Ck
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:39:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id 65so1538259wrl.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0YO5167kwLYfgxVVGMiRXb/uPs/vYWM9kuVl5147QMg=;
 b=w+ektMcgGFH4dlpBkdhXHVrGpabgez6kZGXxk6KhB60zhuXBGTqhJnMsXxrS6gHsz6
 j4noEkZyHBnWpUrybZn2WR5E1UM7wMPjRggHYgGkmHBiDwQBiydTVUkkUaHtczgWMBkx
 pWopLooFT+PG3di+tykwdSvelj8sllLhZS4xpSIisLtQY1U9SRfHygttGvd9dIQRfEZB
 4Lp/qFopdAfrS7nHaoBHas+WsInNOnLQpxmoM+vy0y2yjiBQQYt8vAmt3Bt4RKlqWK+L
 gdv+Ottk1UZzNuCAJe4th71jZDngdL9yraFwvwk/z+nYg6yaqHz49PEKVd3f4xQ3daXx
 77Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0YO5167kwLYfgxVVGMiRXb/uPs/vYWM9kuVl5147QMg=;
 b=TIuYVCpjrshhCUOzlW4lbpg/yWj4UjntTQ/Uh/1rvCnY8tIMwDD09zWIHjDUzWPyRW
 dbQgsvMpgNq34cBxPQw+RtXEhjpb62+fFYkUaIu4IdZfxVIs1PXkK7/JCam8BDQUOo42
 O/+5hvGBCpkxfPgQHM64j7vv8RG4YGe/DoYiJ2ieBGp5XKYAbWGWnz5YxPPCO8kTO/GQ
 oW9/zcyAaYna6gYsmGtgTjs15yG5cZvnvJACkgushqW1PECjx3EYUQU21PTLG2hFevqf
 NV4NMLdudz3FD88+L0dtx03ZWyKnURY/BUej5SHDSRCqAyn24vnEfoWDyYToOSTNAk6i
 gvLQ==
X-Gm-Message-State: ANhLgQ0Wx4Cdc1yYVzPz0GIfxrn68MQx6sl3GREz9CphDzkJCAOuTat6
 eDjw3LIpAcpHnCIOqkV2NZPC/A==
X-Google-Smtp-Source: ADFU+vs3IP014yK7G94QGFA+yzA9JS7nrSBXCxPkRZ7TpucsVarNnNGni4MR0OQYdSzUm9NKuQztyA==
X-Received: by 2002:a5d:4648:: with SMTP id j8mr27622996wrs.202.1585769944079; 
 Wed, 01 Apr 2020 12:39:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v26sm4293502wra.7.2020.04.01.12.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 12:39:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E94851FF7E;
 Wed,  1 Apr 2020 20:39:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/core: properly terminate loading .hex on EOF record
Date: Wed,  1 Apr 2020 20:38:49 +0100
Message-Id: <20200401193849.14017-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, joel@jms.id.au,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The https://makecode.microbit.org/#editor generates slightly weird
.hex files which work fine on a real microbit but causes QEMU to
choke. The reason is extraneous data after the EOF record which causes
the loader to attempt to write a bigger file than it should to the
"rom". According to the HEX file spec an EOF really should be the last
thing we process so lets do that.

Reported-by: Ursula Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/core/loader.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index eeef6da9a1b..8bbb1797a4c 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1447,6 +1447,7 @@ typedef struct {
     uint32_t current_rom_index;
     uint32_t rom_start_address;
     AddressSpace *as;
+    bool complete;
 } HexParser;
 
 /* return size or -1 if error */
@@ -1484,6 +1485,7 @@ static int handle_record_type(HexParser *parser)
                                   parser->current_rom_index,
                                   parser->rom_start_address, parser->as);
         }
+        parser->complete = true;
         return parser->total_size;
     case EXT_SEG_ADDR_RECORD:
     case EXT_LINEAR_ADDR_RECORD:
@@ -1548,11 +1550,12 @@ static int parse_hex_blob(const char *filename, hwaddr *addr, uint8_t *hex_blob,
         .bin_buf = g_malloc(hex_blob_size),
         .start_addr = addr,
         .as = as,
+        .complete = false
     };
 
     rom_transaction_begin();
 
-    for (; hex_blob < end; ++hex_blob) {
+    for (; hex_blob < end && !parser.complete; ++hex_blob) {
         switch (*hex_blob) {
         case '\r':
         case '\n':
-- 
2.20.1


