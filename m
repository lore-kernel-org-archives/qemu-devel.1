Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701DC2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyAjKhtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701DC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9ZK-0003CB-Go
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9VL-00040G-G5
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:23:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9VK-0006VE-F5
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591352593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c55q0J7grSSjYGaEHTw0pM5dKeE6x+GNtQxLVwkoJJw=;
 b=UyAjKhtcJh+W9Dvmsjd0nSIOe/xHWBFrsabukkeYhQgZoTfToY3FMZZD3X7mwQjUHgbC3i
 VlXgJEzaK558jMPOUoPwZ5epYpiKAgUMXE4bBJPqiKzhXNLVFeF77rcZ2YTFxqKgCmCtFW
 jGfZxLogtCXCXo/6baMI3J/7sIyGHSE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-buBY_I74OVuixVgsvDJs0w-1; Fri, 05 Jun 2020 06:23:12 -0400
X-MC-Unique: buBY_I74OVuixVgsvDJs0w-1
Received: by mail-wm1-f69.google.com with SMTP id h25so3689783wmb.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c55q0J7grSSjYGaEHTw0pM5dKeE6x+GNtQxLVwkoJJw=;
 b=ASWB+sS+rnNi5ImT8wavz597x/gY0ux7dkA2ceZxlQ9x7LpUeFUOFyI5s45D+tvRUF
 EEFFz6ajoyy3c50aN3XJxO7gTgk8qCNnYqwmo8luW9Zuec7B66SXaKrfdrg4KS9fHa5H
 f9CZNpWF5em31n4FRNbe7lq6Bf0za2A1kuaQnGga1qD/OcS5daU7iPlgLlxQoBXKbcmF
 TpcEYUHNjCO4cdIkWzvowcosTUsGn91PJPaWh2DauZaE0YoaZdIjHEVmGzSPN3BRnQBj
 E4lZLRRVS4qkQTi+7CVA2uAvqw7zG50+cUyBseXHPl9IFANQZ27MkOrxaRjyH2yTAUgd
 sLfg==
X-Gm-Message-State: AOAM532D17eIWEXFQioKXsLYVzd3S2O+jyF8r2xIVui+8c0Yt6QbQOrh
 xPnjBJv4egE/KZ0eFhLjNnpttxsubSoLqgjVEsxdMZ4SuUeqx+8UmkTKtxzGObVrrGAgPw6IKuB
 me+Wiw0WLKzwh3Xs=
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr8668453wrt.159.1591352590899; 
 Fri, 05 Jun 2020 03:23:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwh0sdz05XiyWXEeqfM/DhSPFCg7uEnMuDCDKKe3XoASfRX39gCw+7Ne3Mm5rX7jWKGaijSjw==
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr8668434wrt.159.1591352590693; 
 Fri, 05 Jun 2020 03:23:10 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id e10sm11529733wrn.11.2020.06.05.03.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:23:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/11] hw/sd/sdcard: Make iolen unsigned
Date: Fri,  5 Jun 2020 12:22:27 +0200
Message-Id: <20200605102230.21493-9-philmd@redhat.com>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I/O request length can not be negative.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/sd/sd.c         | 2 +-
 hw/sd/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9d51138b11..952be36399 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1950,7 +1950,7 @@ uint8_t sd_read_data(SDState *sd)
 {
     /* TODO: Append CRCs */
     uint8_t ret;
-    int io_len;
+    size_t io_len;
 
     if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
         return 0x00;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 5f09d32eb2..f892c05867 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -52,7 +52,7 @@ sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
-sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, int length) "%s %20s/ CMD%02d len %d"
+sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, size_t length) "%s %20s/ CMD%02d len %zu"
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 
 # milkymist-memcard.c
-- 
2.21.3


