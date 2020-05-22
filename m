Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD57BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6752072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnNVy4m0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6752072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBlX-0001G0-EY
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBjt-0007VW-JQ
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:45:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42014
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBjs-0006HM-FG
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590169543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9opZe6voHNiZF2I8d27OC0NCQS7HY6LsO5ZpOjdW7vY=;
 b=AnNVy4m0xBDYI2bYJIsZmWtZaSSUZnIBg0S5iepPc6KPw7IHnZ9s+ul7v/rSW6yVG5cpnN
 Un3FgCRdUgdUz1dMD7cYiabnf9nEut2YuBR+UlS8yyhC//CZvyu8agsTxNCVNuhUdiJfmA
 LgDJp1EcyDvucudOJYTVdh85o3+cdHk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-ooJHew8YNa6OJheTQPeCCQ-1; Fri, 22 May 2020 13:45:41 -0400
X-MC-Unique: ooJHew8YNa6OJheTQPeCCQ-1
Received: by mail-wr1-f69.google.com with SMTP id c14so3513977wrm.15
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9opZe6voHNiZF2I8d27OC0NCQS7HY6LsO5ZpOjdW7vY=;
 b=ewPJf1qokZ9MOb7CW4ZzjFqdydpyraSRNBrZQ72xwBC/R6GtQtUO1Cpo9lQhjIY8Aa
 8DXgfzPc2qbydeEQx9V6AX3go9hp4FB4VGs3e9WdHVhHmRkMkmpHqDe2b88fhH76a7Ss
 XFfTNc1NFX+7QiXOFAHMA6xsZ1Bn4sJRJa0Jsi+bLVDF+MzUQEChvPUEyUC8IzHxXdtA
 Qgav79SLi343oXe44pVdbZPkxhzZhhyzBx3heWQrkwtJA0mrtzYyPjlrQlowsySppjk/
 1Mag0vh6jV8CcbWU3bZOenJAkdiFF21EWVc651ZNwKhI4lu7UMJrDjjYbwKzPELS+NuX
 hIRA==
X-Gm-Message-State: AOAM531+3Y2ywzBQcjDIb8TXb7Cd5wTEHrfcfQ47riP6J7XlBMKOG2rc
 ShIaQ+v3I8z/zWvo+880+6WoMeS1VkcL6D9NHhpesNh9C+TJprxvIo+tKPTxC2HW6sdbJOrqeN6
 gt8scLGBbnbN0fZ4=
X-Received: by 2002:a1c:66d6:: with SMTP id
 a205mr15142861wmc.163.1590169539963; 
 Fri, 22 May 2020 10:45:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNzIjvevKGKpccIR4WKM+keCZWuLDXzUXtOv4tnp4kCYxUV6JNXAPbL3Ci7J9jeunL4WoQHA==
X-Received: by 2002:a1c:66d6:: with SMTP id
 a205mr15142845wmc.163.1590169539796; 
 Fri, 22 May 2020 10:45:39 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 88sm7549072wre.45.2020.05.22.10.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:45:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] hw/block/pflash_cfi01: Rename 'reset_flash' label as
 'mode_read_array'
Date: Fri, 22 May 2020 19:45:23 +0200
Message-Id: <20200522174524.29152-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522174524.29152-1-philmd@redhat.com>
References: <20200522174524.29152-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 08:01:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the 'reset_flash' as 'mode_read_array' to make explicit we
do not reset the device, we simply set its internal state machine
in the READ_ARRAY mode. We do not reset the status register error
bits, as a device reset would do.

Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20190716221555.11145-5-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 3cd483d26a..2ca173aa46 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -454,7 +454,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
         /* read mode */
         switch (cmd) {
         case 0x00: /* This model reset value for READ_ARRAY (not CFI) */
-            goto reset_flash;
+            goto mode_read_array;
         case 0x10: /* Single Byte Program */
         case 0x40: /* Single Byte Program */
             DPRINTF("%s: Single Byte Program\n", __func__);
@@ -477,7 +477,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
         case 0x50: /* Clear status bits */
             DPRINTF("%s: Clear status bits\n", __func__);
             pfl->status = 0x0;
-            goto reset_flash;
+            goto mode_read_array;
         case 0x60: /* Block (un)lock */
             DPRINTF("%s: Block unlock\n", __func__);
             break;
@@ -502,10 +502,10 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             break;
         case 0xf0: /* Probe for AMD flash */
             DPRINTF("%s: Probe for AMD flash\n", __func__);
-            goto reset_flash;
-        case 0xff: /* Read array mode */
+            goto mode_read_array;
+        case 0xff: /* Read Array */
             DPRINTF("%s: Read array mode\n", __func__);
-            goto reset_flash;
+            goto mode_read_array;
         default:
             goto error_flash;
         }
@@ -531,8 +531,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             if (cmd == 0xd0) { /* confirm */
                 pfl->wcycle = 0;
                 pfl->status |= 0x80;
-            } else if (cmd == 0xff) { /* read array mode */
-                goto reset_flash;
+            } else if (cmd == 0xff) { /* Read Array */
+                goto mode_read_array;
             } else
                 goto error_flash;
 
@@ -558,16 +558,16 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             } else if (cmd == 0x01) {
                 pfl->wcycle = 0;
                 pfl->status |= 0x80;
-            } else if (cmd == 0xff) {
-                goto reset_flash;
+            } else if (cmd == 0xff) { /* Read Array */
+                goto mode_read_array;
             } else {
                 DPRINTF("%s: Unknown (un)locking command\n", __func__);
-                goto reset_flash;
+                goto mode_read_array;
             }
             break;
         case 0x98:
-            if (cmd == 0xff) {
-                goto reset_flash;
+            if (cmd == 0xff) { /* Read Array */
+                goto mode_read_array;
             } else {
                 DPRINTF("%s: leaving query mode\n", __func__);
             }
@@ -627,7 +627,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
                     " the data is already written to storage!\n"
                     "Flash device reset into READ mode.\n",
                     __func__);
-                goto reset_flash;
+                goto mode_read_array;
             }
             break;
         default:
@@ -637,7 +637,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
     default:
         /* Should never happen */
         DPRINTF("%s: invalid write state\n",  __func__);
-        goto reset_flash;
+        goto mode_read_array;
     }
     return;
 
@@ -646,7 +646,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
                   "(offset " TARGET_FMT_plx ", wcycle 0x%x cmd 0x%x value 0x%x)"
                   "\n", __func__, offset, pfl->wcycle, pfl->cmd, value);
 
- reset_flash:
+ mode_read_array:
     trace_pflash_reset();
     memory_region_rom_device_set_romd(&pfl->mem, true);
     pfl->wcycle = 0;
-- 
2.21.3


