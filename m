Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0E7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B327520776
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAMlAEPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B327520776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBnt-0004Y8-OY
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBjw-0007fh-Uy
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:45:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26235
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBjv-0006I6-Uj
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590169547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZDKCWTN0BUU3keGoiOAEHskel55kf5sdpYAUP1vRz1g=;
 b=ZAMlAEPJ8SSLANT99opdA2t5bPhmyhrJ/m1t7Y7PRjvWGbSUkBPCsNDX6ja5Ni3I/xN03x
 DRjOzTzYbIpSErj2qlr+kfVxTJ+bR4ftITN1qDpKorffs5LlT3kps2Oh6QrOAhvRzVKxwL
 KB6bEEbMj6Uz8y8HREgJ58skfJqu9h0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-UzQuEz6ENgalx2cC5dsREQ-1; Fri, 22 May 2020 13:45:45 -0400
X-MC-Unique: UzQuEz6ENgalx2cC5dsREQ-1
Received: by mail-wm1-f71.google.com with SMTP id l2so4435073wmi.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZDKCWTN0BUU3keGoiOAEHskel55kf5sdpYAUP1vRz1g=;
 b=rMnDOHI31lMiQivsBOfD+JoXIyTyoMZ98mI79EYIuftJF7hOhm8RCjswXnGvkmwuQs
 KjPvS3ZSp4JnObHxxBsKl1x8Zc5n6bmS65O9ooedeG4M3Cd2wIW+sUDmLsgsxb6paSwY
 a0hnJ3qqDxHC7Nza1zjAQ0qxBfBczpiogyYwfdgMsH5f5RU9lPUB3XkJ+IuHrcG/l0Ew
 NERVtz/lYfEE46YSkJWJ5kZdpTSWvYNJqM+qUekyNq5WKVtUnnlDXbAbawRlPVAd7wil
 pBcB4DCeYN4CBED7SqlMTuaNZU17nSirHQ2kjQb6PdDAp1JuGfnfrbCI5AbzUSuYb6/D
 yY1w==
X-Gm-Message-State: AOAM531RBi6PZPdC0k+l544tj27o76u15HuSMQVAzBL2Ux4z+o45MAAQ
 EXcXUhRSEyTZrPfdD9p2d5c050X+3h2eo6YdYlgv8IpIRBmEICdv6/ZSKra/yOILWZ98+Ns4+Lo
 BIsQcO1tSRIQZB+M=
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr13910653wmc.10.1590169544369; 
 Fri, 22 May 2020 10:45:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDCEEyReoRGKrZz+Zpl9TngdOt730rvbP7Vh1S10CiWTf8tV8KAsF3/kbQhqb+tSuLH9QH5w==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr13910640wmc.10.1590169544190; 
 Fri, 22 May 2020 10:45:44 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id p23sm10058484wma.17.2020.05.22.10.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:45:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] hw/block/pflash: Check return value of blk_pwrite()
Date: Fri, 22 May 2020 19:45:24 +0200
Message-Id: <20200522174524.29152-5-philmd@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Mansour Ahmadi <mansourweb@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mansour Ahmadi <mansourweb@gmail.com>

When updating the PFLASH file contents, we should check for a
possible failure of blk_pwrite(). Similar to commit 3a688294e.

Reported-by: Coverity (CID 1357678 CHECKED_RETURN)
Signed-off-by: Mansour Ahmadi <mansourweb@gmail.com>
Message-Id: <20200408003552.58095-1-mansourweb@gmail.com>
[PMD: Add missing "qemu/error-report.h" include and TODO comment]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 8 +++++++-
 hw/block/pflash_cfi02.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 2ca173aa46..11922c0f96 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -42,6 +42,7 @@
 #include "hw/qdev-properties.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "qemu/host-utils.h"
@@ -389,13 +390,18 @@ static void pflash_update(PFlashCFI01 *pfl, int offset,
                           int size)
 {
     int offset_end;
+    int ret;
     if (pfl->blk) {
         offset_end = offset + size;
         /* widen to sector boundaries */
         offset = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
         offset_end = QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
-        blk_pwrite(pfl->blk, offset, pfl->storage + offset,
+        ret = blk_pwrite(pfl->blk, offset, pfl->storage + offset,
                    offset_end - offset, 0);
+        if (ret < 0) {
+            /* TODO set error bit in status */
+            error_report("Could not update PFLASH: %s", strerror(-ret));
+        }
     }
 }
 
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index c277b0309d..ac7e34ecbf 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -37,6 +37,7 @@
 #include "hw/block/flash.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/bitmap.h"
 #include "qemu/timer.h"
 #include "sysemu/block-backend.h"
@@ -393,13 +394,18 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
 static void pflash_update(PFlashCFI02 *pfl, int offset, int size)
 {
     int offset_end;
+    int ret;
     if (pfl->blk) {
         offset_end = offset + size;
         /* widen to sector boundaries */
         offset = QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
         offset_end = QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
-        blk_pwrite(pfl->blk, offset, pfl->storage + offset,
+        ret = blk_pwrite(pfl->blk, offset, pfl->storage + offset,
                    offset_end - offset, 0);
+        if (ret < 0) {
+            /* TODO set error bit in status */
+            error_report("Could not update PFLASH: %s", strerror(-ret));
+        }
     }
 }
 
-- 
2.21.3


