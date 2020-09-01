Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C41C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D52D206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D52D206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Ad-0004gi-5f
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zQ-0005hX-IS; Tue, 01 Sep 2020 10:10:24 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zN-0003uX-Un; Tue, 01 Sep 2020 10:10:24 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYvTs-1k8f0I2cWe-00UsG5; Tue, 01 Sep 2020 16:10:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 26/44] hw/ide/ahci: Replace magic '512' value by
 BDRV_SECTOR_SIZE
Date: Tue,  1 Sep 2020 16:09:36 +0200
Message-Id: <20200901140954.889743-27-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xxDhq+TV0IfhP9YC17vf1ffp70QmhzJ+LSLjKKD9ZRHGqPWKsWI
 dfMp6LQG9bu0HuMAOhgCjrfL4jmvrzdVCMHJCKzHMrTMO8pTnrj0JUXGDPhqy9RjENZYxDk
 ZeqE0vMA+F9m07Q7KsL1ucznABmEKRh3aBMiRuLFOzEjexUZQCJaH95fnYrNdju4X0N+bqu
 ml90btsCLsq6qiwbXix/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D8jVz6yqPOU=:xLlTOrRID3d6tMfvRLF1Mp
 M7hjRbUmlidApPd0IsDWxMTLXVM1V8yTNCkMIZh9mUa3yLQPpK7T8zbEoUWvGMJN5H8NO5XCN
 CInWGHTtdKkKGeV9dCT8grtgUPLntUJuPCttFshMnLjgPOH0UqL7UvTVXca9GWb4na2+s0ANl
 rH5PV23JuqZSkCIcxhcHR3CD42/GHyzUb+dKdMFVXkBIJWS6Y01OB+9n7MhpT0pmKc3ICetvn
 rSzQac05LCNWWxdawI0uJtQBeMjTVSmkM5sdaQi8Bo37OepCT2llLZVLqfr0wW6XUyE1sy+v/
 byj5SxvFZOYX9bPF3LhmfYWK9+VMv62e3MW0xfKToZMFRVgkbZ+aZl1i0sv2OSxejO51fcQjY
 FKddVNk1MLTNRz8Wh4cfXC0yTxExLqYSbG9t14XeoGnDfx53dc0Kph4m3Fl4BjB5N51A+zAw1
 1e983eLJBN2ORK4UQVMqKCwj4q/+XWwRrxZVdkp2iR/AdQ+b7hXeCY2ZC5iIBgIx6k+T/3zSu
 Fvrq/96h/cYNpzuiJV8N/8Ovdhdp4YYEZtDOIGGagXsQuMkOROIvdkl0mHlKwfF2mc8xijNRb
 BnKu7JiOE5OENTWSiNHHPAy7k7RNDLf4Aj9+PLdowls3PZMyeDckmBI2lg7ZbU0IMCsF+zkUu
 ssOaLBYXD2cnXa2LwS+xqQCk9QGsupLJEikydcjCufwJ0zkoGjhb5JOkKK4UzNbZobPQRt1ES
 5eLDYu21KGZMdqjcq3rzeZ5Us6QrHVbDgy0/s8qPQkClJqlEjGjniD4LD3Z/cVZzRCkcXee1m
 xgZeNSXjowMALY5VkOXiXqVMydB4KVX1ZAeZfCmN7oUThp/afhMt8VqLdiYN4q92jeYInAy
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Use self-explicit definitions instead of magic '512' value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200814082841.27000-5-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/ide/ahci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 009120f88b78..b696c6291a38 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1151,7 +1151,7 @@ static void process_ncq_command(AHCIState *s, int port, uint8_t *cmd_fis,
     if (!ncq_tfs->sector_count) {
         ncq_tfs->sector_count = 0x10000;
     }
-    size = ncq_tfs->sector_count * 512;
+    size = ncq_tfs->sector_count * BDRV_SECTOR_SIZE;
     ahci_populate_sglist(ad, &ncq_tfs->sglist, ncq_tfs->cmdh, size, 0);
 
     if (ncq_tfs->sglist.size < size) {
@@ -1703,7 +1703,8 @@ static int ahci_state_post_load(void *opaque, int version_id)
                 return -1;
             }
             ahci_populate_sglist(ncq_tfs->drive, &ncq_tfs->sglist,
-                                 ncq_tfs->cmdh, ncq_tfs->sector_count * 512,
+                                 ncq_tfs->cmdh,
+                                 ncq_tfs->sector_count * BDRV_SECTOR_SIZE,
                                  0);
             if (ncq_tfs->sector_count != ncq_tfs->sglist.size >> 9) {
                 return -1;
-- 
2.26.2


