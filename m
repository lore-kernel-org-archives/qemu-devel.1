Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF8EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1798D2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frcI9FZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1798D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9dt-0000eF-Ck
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9VW-0004Tf-0g
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:23:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44248
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9VT-0006ZZ-Th
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591352603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gw1xw+LMpEmzRwp28aIuZw9IW5+ls2uZgRvm0cZFybM=;
 b=frcI9FZwI+VQieHx7pWpMN+K9IrE3s9rTCHVTnXwNHtw5bw2Y9iSAWnc5DfCJvu8bULvme
 7+03SpK3IxQ4EABzJ8MdUEsNXY6r0ORPzVTdDCyYTRfQujeoqEepAbZAT35IX05hTz1/XP
 oVx3WUp1hrXXy0dJf70JWNu1e07wkzw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-xe56vpd0ONW8d0jHvz_18w-1; Fri, 05 Jun 2020 06:23:21 -0400
X-MC-Unique: xe56vpd0ONW8d0jHvz_18w-1
Received: by mail-wr1-f70.google.com with SMTP id j16so3564878wre.22
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gw1xw+LMpEmzRwp28aIuZw9IW5+ls2uZgRvm0cZFybM=;
 b=Gk9PTY+UR+y+fzGznDUfQenHVdlteOnUHwXaKhAZN3j214Rn6B7qEbjyemidoz5ktE
 Rh99EoKkk7J7FoGc3uMXyDWywXKtLAj73kSRYNNN0tMTdn64SCTilZr9StrZ9hanrSWY
 +2nGsz+/wbjXNow75WeMWd5YnlwOWaiCxq4AyEAnKeAgvni3k2GRJ62iWovkWL9Y2mo1
 xvkmGNY5bn+jjU3pZVoqQk/npXD09Vxy+aFR5ntDrq3gye3+dMVtv/heot/KSSYmjD9z
 zvAcQZ0wJUkphDMNfHGf8zsUDqs0jDp/fCMSn3kpn06fGqZk4J5k1eSky0/Trfyd8N+C
 t6iQ==
X-Gm-Message-State: AOAM532fivpTjwy5zzUVDV47UiRzTXkTnbmySZADKQm8g78RrdB6brSd
 VLgNMrsJLt+ffCND14uQ/a1ItbQXc9LltgziYM4bEJZ5GFcX1X7c5GPhBBjsfvgPw8mVNgaxkql
 Pa2gyS7tQECyfj9Y=
X-Received: by 2002:a5d:4245:: with SMTP id s5mr8916871wrr.6.1591352600292;
 Fri, 05 Jun 2020 03:23:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHl4l4ZA1cP1cNZ19vVlA/aHSUlfwTwzKv0NYQRaZ9rTd/r32G0Q6YN8HBj8LQEbgJuaMZ5g==
X-Received: by 2002:a5d:4245:: with SMTP id s5mr8916856wrr.6.1591352600113;
 Fri, 05 Jun 2020 03:23:20 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 138sm11300924wma.23.2020.06.05.03.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:23:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/11] hw/sd/sdcard: Display offset in read/write_data()
 trace events
Date: Fri,  5 Jun 2020 12:22:29 +0200
Message-Id: <20200605102230.21493-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605102230.21493-1-philmd@redhat.com>
References: <20200605102230.21493-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Having 'base address' and 'relative offset' displayed
separately is more helpful than the absolute address.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 8 ++++----
 hw/sd/trace-events | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index fad34ab184..a1b25ed36f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1824,8 +1824,8 @@ void sd_write_data(SDState *sd, uint8_t value)
         return;
 
     trace_sdcard_write_data(sd->proto_name,
-                            sd_current_cmd_name(sd),
-                            sd->current_cmd, value);
+                            sd_current_cmd_name(sd), sd->current_cmd,
+                            sd->data_start, sd->data_offset, value);
     switch (sd->current_cmd) {
     case 24:	/* CMD24:  WRITE_SINGLE_BLOCK */
         sd->data[sd->data_offset ++] = value;
@@ -1978,8 +1978,8 @@ uint8_t sd_read_data(SDState *sd)
     io_len = (sd->ocr & (1 << 30)) ? 512 : sd->blk_len;
 
     trace_sdcard_read_data(sd->proto_name,
-                           sd_current_cmd_name(sd),
-                           sd->current_cmd, io_len);
+                           sd_current_cmd_name(sd), sd->current_cmd,
+                           sd->data_start, sd->data_offset, io_len);
     switch (sd->current_cmd) {
     case 6:	/* CMD6:   SWITCH_FUNCTION */
         ret = sd->data[sd->data_offset ++];
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index f892c05867..1529ad4c6d 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -51,8 +51,8 @@ sdcard_lock(void) ""
 sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
-sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
-sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, size_t length) "%s %20s/ CMD%02d len %zu"
+sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint64_t address, uint32_t offset, uint8_t value) "%s %20s/ CMD%02d addr 0x%" PRIx64 " ofs 0x%" PRIx32 " val 0x%02x"
+sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint64_t address, uint32_t offset, size_t length) "%s %20s/ CMD%02d addr 0x%" PRIx64 " ofs 0x%" PRIx32 " len %zu"
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 
 # milkymist-memcard.c
-- 
2.21.3


