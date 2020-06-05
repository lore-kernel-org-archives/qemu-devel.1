Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E33C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213CC207D0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWaTlEx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213CC207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9b5-0006eM-DD
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9VG-0003oE-Uo
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:23:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9VG-0006R3-2D
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591352589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lSSjLejiscLCvJVDaLCtQGkkV0h02Ah/YQj2aVjpKQ=;
 b=SWaTlEx7Pf1VQs+2iQSAsQENxhMTV8g4zla8yJmhkP8wHXRpTJ80kcDIpDVxxuSMhuwXs1
 AlB280qoZIdwhDWROi5iSnLC14W6ZTMf/0XX7ZtCJG4C0eu4DIAW1JbTpyiAdXXM1/9fue
 HhngMtcy37faIaLkh0xEU1YwLabvoT8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-v8jD5gH4N42edEMQUh-FsA-1; Fri, 05 Jun 2020 06:23:07 -0400
X-MC-Unique: v8jD5gH4N42edEMQUh-FsA-1
Received: by mail-wm1-f72.google.com with SMTP id u11so2843268wmc.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6lSSjLejiscLCvJVDaLCtQGkkV0h02Ah/YQj2aVjpKQ=;
 b=KjFMWTq/U+FTZfWQx5xwrbXNBCF+bLWF8CEfXc6mgPR2llkXOJSnjjcEdCUL2EhOst
 lAKd10IFgAIT3rCc1NMIFu71Chl14QShAYIdJ/dqDaSJWDyLuMwNAvwr3nTcXsx89Vsh
 z2BwQGj+fTXufh00G4JGaAJaFTG/k38ZYgn9WwR0GQy9PoNLIh2JrmGrjIMLPsYOc1ni
 5gM7dp4YLgUf6NkfyYITnnQ1rDvr5SWq7Fxuhf1ow+T1auZfPCYJ06SdBaRR/kkjkhao
 wvwx9PudUvRNIfnbCPP9kNAr0ZgEEBhNC1J3+GuzIdRnzinTdC4ymP2epHFKbHXge++f
 Dg1g==
X-Gm-Message-State: AOAM531TM5WhzIcroJehXLXcPnjoCmWWex2xDDw4quxykKZGAqxFHyJZ
 cCa106fKEyR4QVjmmg5QLS3LzjMnybV8fC64aSp3FN1W8AeIhswaPJxNMzuNWfazpghtln1LMvn
 stQ6CKRDbv2fu6x0=
X-Received: by 2002:adf:ed4f:: with SMTP id u15mr8655713wro.126.1591352586305; 
 Fri, 05 Jun 2020 03:23:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1/gm5RqSpGyRv3/h4o+yYzMBujqn1ZUWppyGY4JpNXUGRCiqMhWW2IMqzpAfhq0ntaLOWAA==
X-Received: by 2002:adf:ed4f:: with SMTP id u15mr8655698wro.126.1591352586101; 
 Fri, 05 Jun 2020 03:23:06 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a3sm11303685wrp.91.2020.06.05.03.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:23:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/11] hw/sd/sdcard: Constify sd_crc*()'s message argument
Date: Fri,  5 Jun 2020 12:22:26 +0200
Message-Id: <20200605102230.21493-8-philmd@redhat.com>
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

CRC functions don't modify the buffer argument,
make it const.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7799a3c621..9d51138b11 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -242,11 +242,11 @@ static const int sd_cmd_class[SDMMC_CMD_MAX] = {
     7,  7, 10,  7,  9,  9,  9,  8,  8, 10,  8,  8,  8,  8,  8,  8,
 };
 
-static uint8_t sd_crc7(void *message, size_t width)
+static uint8_t sd_crc7(const void *message, size_t width)
 {
     int i, bit;
     uint8_t shift_reg = 0x00;
-    uint8_t *msg = (uint8_t *) message;
+    const uint8_t *msg = (const uint8_t *)message;
 
     for (i = 0; i < width; i ++, msg ++)
         for (bit = 7; bit >= 0; bit --) {
@@ -258,11 +258,11 @@ static uint8_t sd_crc7(void *message, size_t width)
     return shift_reg;
 }
 
-static uint16_t sd_crc16(void *message, size_t width)
+static uint16_t sd_crc16(const void *message, size_t width)
 {
     int i, bit;
     uint16_t shift_reg = 0x0000;
-    uint16_t *msg = (uint16_t *) message;
+    const uint16_t *msg = (const uint16_t *)message;
     width <<= 1;
 
     for (i = 0; i < width; i ++, msg ++)
-- 
2.21.3


