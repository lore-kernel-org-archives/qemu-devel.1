Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF3FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA662072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+eH1pWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA662072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBmo-00032q-AQ
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBjo-0007Hy-Sm
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:45:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21013
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBjo-0006Fd-0X
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590169538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mGJcMQjK5aZXrUwTJnYJzoIr1ktljNKQXX01xjHQ4Jg=;
 b=T+eH1pWJw39HIvQe+IZKJxcZA/rknQsQJkPUmoIrRYB3rcRFga2C0rpGIS9EfCmDhxwGcW
 jiXdRbrscPsvVcLGIjA/78kTf736OMaL2O/6ngHVasqoYtWHZbL8YeHtrVLbeLomAynRti
 B2prFg6FAqrsX21XiNxr+YR0GVLbBX8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-A6a7LrhJNMGlPJ7sfQ6g4Q-1; Fri, 22 May 2020 13:45:37 -0400
X-MC-Unique: A6a7LrhJNMGlPJ7sfQ6g4Q-1
Received: by mail-wr1-f72.google.com with SMTP id l1so989326wrc.8
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mGJcMQjK5aZXrUwTJnYJzoIr1ktljNKQXX01xjHQ4Jg=;
 b=Pr7Qy2gG7Y9GqoxWsKr55XAMguRE/+ZLs7+blUMPuJ01gDj6PMNAseieEKHsstmjJY
 PAfVXCKXlK5zJta7xGIPbWe+VY6Y6H8//+MV23wgTFiAo53249yleqh1vIoOWNQmMb6A
 v22yQhO+6ped2InR5Mjpkgsijzru4RgSDwcAwfb0R61fqjGFAXK5nYBG1Dd8h+L/8kXi
 yMwY5LSDtPAqquk6laeASwQcvM/0TK4pxGOmkIqtX8ub1k3bi4stcqb4+NA85dbMoI0q
 T0eOZusxazxnYjVlXyv4UJYn2X6Lv1XZPIu7T2LU7CYa2tSNotDThgwJXRHiC2ZXe+tp
 obPg==
X-Gm-Message-State: AOAM533RI5nS5BVbas6dF3ti2wsO3jljVoy1Ed7nGsk86oWSJYRL/Wf9
 U62LrM5Z0MeyNSgZUZ//6lNbBabpnMeP81DLrW59dbP3Kb2pjZ+PRPfVO91LAqR1SHZZDxOMZXW
 u5dm3t3OEAlatbSI=
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr4626891wrp.81.1590169535540;
 Fri, 22 May 2020 10:45:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6BGywPYoOqVPY864Pzp2yne9Jhxx9xgvedyiPGFH1HwdZrMo9OHG9eTi66A06fhR6Uppolw==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr4626873wrp.81.1590169535277;
 Fri, 22 May 2020 10:45:35 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a184sm10220663wmh.24.2020.05.22.10.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:45:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] hw/block/pflash_cfi01: Document use of non-CFI compliant
 command '0x00'
Date: Fri, 22 May 2020 19:45:22 +0200
Message-Id: <20200522174524.29152-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522174524.29152-1-philmd@redhat.com>
References: <20200522174524.29152-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:12:54
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The command 0x00 is used by this model since its origin (commit
05ee37ebf630). In this commit the command is described with a
amusing '/* ??? */' comment, probably meaning 'FIXME'.

        switch (cmd) {
        case 0x00: /* ??? */
            ...

This comment survived 12 years because the 0x00 value is indeed
not specified by the CFI open standard (as of this commit).

The 'cmd' field is transfered during migration. To keep the
migration feature working with older QEMU version, we have to
take a lot of care with migrated field. We figured out it is
too late to remove a non-specified value from this model
(this would make migration review very complex). It is however
not too late to improve the documentation.

Add few comments to remember this is a special value related
to QEMU, and we won't find information about it on the CFI
spec.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20190716221555.11145-3-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index d67f84d655..3cd483d26a 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -278,9 +278,13 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr offset,
         /* This should never happen : reset state & treat it as a read */
         DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
         pfl->wcycle = 0;
-        pfl->cmd = 0;
+        /*
+         * The command 0x00 is not assigned by the CFI open standard,
+         * but QEMU historically uses it for the READ_ARRAY command (0xff).
+         */
+        pfl->cmd = 0x00;
         /* fall through to read code */
-    case 0x00:
+    case 0x00: /* This model reset value for READ_ARRAY (not CFI compliant) */
         /* Flash area read */
         ret = pflash_data_read(pfl, offset, width, be);
         break;
@@ -449,7 +453,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
     case 0:
         /* read mode */
         switch (cmd) {
-        case 0x00: /* ??? */
+        case 0x00: /* This model reset value for READ_ARRAY (not CFI) */
             goto reset_flash;
         case 0x10: /* Single Byte Program */
         case 0x40: /* Single Byte Program */
@@ -646,7 +650,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
     trace_pflash_reset();
     memory_region_rom_device_set_romd(&pfl->mem, true);
     pfl->wcycle = 0;
-    pfl->cmd = 0;
+    pfl->cmd = 0x00; /* This model reset value for READ_ARRAY (not CFI) */
 }
 
 
@@ -762,7 +766,11 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     }
 
     pfl->wcycle = 0;
-    pfl->cmd = 0;
+    /*
+     * The command 0x00 is not assigned by the CFI open standard,
+     * but QEMU historically uses it for the READ_ARRAY command (0xff).
+     */
+    pfl->cmd = 0x00;
     pfl->status = 0x80; /* WSM ready */
     /* Hardcoded CFI table */
     /* Standard "QRY" string */
-- 
2.21.3


