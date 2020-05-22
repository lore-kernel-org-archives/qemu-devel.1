Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA65BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB0220756
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6g1BO8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB0220756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBl1-0000Vi-M0
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBjn-0007DT-Gv
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:45:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBjk-0006De-RG
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590169535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gFARda38uI5LKaq1O+Flf3O67TPescdkjgmAvm6EoVA=;
 b=C6g1BO8v36Gimo27HLZSrcMkrj3jbTmODSp6O88u4MM2rDut9M/UNPs8EzATzGSbj/Qb+d
 dQPwLGW3RfdePjgAm/clMmOZEENQ5GTuADhoaS9V8o5n/zoYZbUEVBdmXjXZWeUpPF8AtW
 mWIVMhfnH/hpww7210TlBb6gzRmx1u4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-D6NuH4naNd-C6uYxoIvo8w-1; Fri, 22 May 2020 13:45:32 -0400
X-MC-Unique: D6NuH4naNd-C6uYxoIvo8w-1
Received: by mail-wr1-f72.google.com with SMTP id x8so4672338wrl.16
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gFARda38uI5LKaq1O+Flf3O67TPescdkjgmAvm6EoVA=;
 b=FHrk9Wx0XupW0GEH8QZ6Jh/3osecdr+lydPCvJwdj1UoglQGbW03FZHjRQIZRlOXJ7
 OCo+EivgHEWj5zQVnbr7LxYWnQQDQHHTVD6vbbTVyTQDSmVbIqPgmTQPiTE2NPFbow+A
 KxnjviwirFz++8Psod/KA+QUfUshW+ewTIyvCPwQZK+nO7RHSTHfJgzJPMEp83V28enC
 ngYZrwh9hMWPWZfwBNNAIVATpTwZ6QGj5K+39oy41mMR9XcWFPr+CEfd4BpwHBr//E3A
 51X8DaeG78oImHk2u2cyiUtsCE27CWekcDp5wtNTpmloEhpqtyoZIzH+Jv2GjGSb66Hq
 vHsQ==
X-Gm-Message-State: AOAM532IKNsONE5SHofugyYeIgoPb5I6Dn6bTvH4AYNzmlqfh0/9nUZV
 CowqX8dBzaeQGnaFVkgZaVqyi9rVPUlKlurPp7295McsbSsPXkp6hWrbQDAeTPDDmAgoWamD9FJ
 9pcSpZ3XDf7RXCmU=
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr2325183wmg.70.1590169530877; 
 Fri, 22 May 2020 10:45:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlYUiP2QPSXxk1lO2RckYv3wfLRr8jMzClSL2DViVr9f1j1GbuSVBtsysTUajaV6qq/g4y1A==
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr2325168wmg.70.1590169530619; 
 Fri, 22 May 2020 10:45:30 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v11sm10344738wrv.53.2020.05.22.10.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:45:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] hw/block/pflash_cfi01: Removed an unused timer
Date: Fri, 22 May 2020 19:45:21 +0200
Message-Id: <20200522174524.29152-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522174524.29152-1-philmd@redhat.com>
References: <20200522174524.29152-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 10:36:44
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'CFI02' NOR flash was introduced in commit 29133e9a0fff, with
timing modelled. One year later, the CFI01 model was introduced
(commit 05ee37ebf630) based on the CFI02 model. As noted in the
header, "It does not support timings". 12 years later, we never
had to model the device timings. Time to remove the unused timer,
we can still add it back if required.

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
[Laszlo Ersek: Regression tested EDK2 OVMF IA32X64, ArmVirtQemu Aarch64
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04373.html]
Message-Id: <20190716221555.11145-2-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 8e8887253d..d67f84d655 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -42,7 +42,6 @@
 #include "hw/qdev-properties.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
-#include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "qemu/host-utils.h"
@@ -91,7 +90,6 @@ struct PFlashCFI01 {
     uint8_t cfi_table[0x52];
     uint64_t counter;
     unsigned int writeblock_size;
-    QEMUTimer *timer;
     MemoryRegion mem;
     char *name;
     void *storage;
@@ -115,18 +113,6 @@ static const VMStateDescription vmstate_pflash = {
     }
 };
 
-static void pflash_timer (void *opaque)
-{
-    PFlashCFI01 *pfl = opaque;
-
-    trace_pflash_timer_expired(pfl->cmd);
-    /* Reset flash */
-    pfl->status ^= 0x80;
-    memory_region_rom_device_set_romd(&pfl->mem, true);
-    pfl->wcycle = 0;
-    pfl->cmd = 0;
-}
-
 /* Perform a CFI query based on the bank width of the flash.
  * If this code is called we know we have a device_width set for
  * this flash.
@@ -775,7 +761,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
         pfl->max_device_width = pfl->device_width;
     }
 
-    pfl->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, pflash_timer, pfl);
     pfl->wcycle = 0;
     pfl->cmd = 0;
     pfl->status = 0x80; /* WSM ready */
-- 
2.21.3


