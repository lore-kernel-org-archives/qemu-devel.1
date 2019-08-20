Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8332C3A59E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A89206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A89206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i064f-0004Uu-PY
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0632-0002dU-3S
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0630-0007jr-SX
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0630-0007j9-Nl
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:27:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 161933018FC6;
 Tue, 20 Aug 2019 15:27:46 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1330A10013A1;
 Tue, 20 Aug 2019 15:27:44 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 17:27:41 +0200
Message-Id: <1566314861-32709-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566314861-32709-1-git-send-email-pbonzini@redhat.com>
References: <1566314861-32709-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 20 Aug 2019 15:27:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 31/34] migration: do not rom_reset() during
 incoming migration
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
Cc: Catherine Ho <catherine.hecx@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Catherine Ho <catherine.hecx@gmail.com>

Commit 18269069c310 ("migration: Introduce ignore-shared capability")
addes ignore-shared capability to bypass the shared ramblock (e,g,
membackend + numa node). It does good to live migration.

As told by Yury,this commit expectes that QEMU doesn't write to guest RAM
until VM starts, but it does on aarch64 qemu:
Backtrace:
1  0x000055f4a296dd84 in address_space_write_rom_internal () at
exec.c:3458
2  0x000055f4a296de3a in address_space_write_rom () at exec.c:3479
3  0x000055f4a2d519ff in rom_reset () at hw/core/loader.c:1101
4  0x000055f4a2d475ec in qemu_devices_reset () at hw/core/reset.c:69
5  0x000055f4a2c90a28 in qemu_system_reset () at vl.c:1675
6  0x000055f4a2c9851d in main () at vl.c:4552

Actually, on arm64 virt marchine, ramblock "dtb" will be filled into ram
druing rom_reset. In ignore-shared incoming case, this rom filling
is not required since all the data has been stored in memory backend
file.

Further more, as suggested by Peter Xu, if we do rom_reset() now with
these ROMs then the RAM data should be re-filled again too with the
migration stream coming in.

Fixes: commit 18269069c310 ("migration: Introduce ignore-shared
capability")
Suggested-by: Yury Kotov <yury-kotov@yandex-team.ru>
Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/loader.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index de00f56..32f7cc7 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -58,6 +58,7 @@
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "qemu/cutils.h"
+#include "sysemu/runstate.h"
 
 #include <zlib.h>
 
@@ -1114,6 +1115,15 @@ static void rom_reset(void *unused)
 {
     Rom *rom;
 
+    /*
+     * We don't need to fill in the RAM with ROM data because we'll fill
+     * the data in during the next incoming migration in all cases.  Note
+     * that some of those RAMs can actually be modified by the guest on ARM
+     * so this is probably the only right thing to do here.
+     */
+    if (runstate_check(RUN_STATE_INMIGRATE))
+        return;
+
     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
             continue;
-- 
1.8.3.1

