Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FADC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5AE20838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5AE20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vkT-0002LQ-Gx
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <boyarsh@altlinux.org>) id 1j6vgT-0002RD-4i
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <boyarsh@altlinux.org>) id 1j6vgP-0007qo-El
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:21:00 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:36960)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <boyarsh@altlinux.org>) id 1j6vgP-0007no-6S
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:20:57 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 498C772CCEF;
 Wed, 26 Feb 2020 15:20:55 +0300 (MSK)
Received: from table.localdomain (109-252-52-89.nat.spd-mgts.ru
 [109.252.52.89])
 by imap.altlinux.org (Postfix) with ESMTPSA id 2EE5C4A4A16;
 Wed, 26 Feb 2020 15:20:55 +0300 (MSK)
Date: Wed, 26 Feb 2020 15:20:54 +0300
From: "Anton V. Boyarshinov" <boyarsh@altlinux.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] Arithmetic error in EDID generation fixed
Message-ID: <20200226122054.366b9cda@table.localdomain>
Organization: ALT Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-alt-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 194.107.17.57
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
Cc: shaba@altlinux.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To calculate screen size in centimeters we should calculate:
pixels/dpi*2.54
but not
pixels*dpi/2540

Using wrong formula we actually get 65 DPI and very small fonts.

Signed-off-by: Anton V. Boyarshinov <boyarsh@altlinux.org>
---
Changes from v1: get rid of casts

 hw/display/edid-generate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
index 75c945a948..e58472fde5 100644
--- a/hw/display/edid-generate.c
+++ b/hw/display/edid-generate.c
@@ -360,8 +360,8 @@ void qemu_edid_generate(uint8_t *edid, size_t size,
     edid[20] = 0xa5;
 
     /* screen size: undefined */
-    edid[21] = info->prefx * info->dpi / 2540;
-    edid[22] = info->prefy * info->dpi / 2540;
+    edid[21] = info->prefx * 254 / 100 / info->dpi;
+    edid[22] = info->prefy * 254 / 100 / info->dpi;
 
     /* display gamma: 2.2 */
     edid[23] = 220 - 100;
-- 
2.21.0



