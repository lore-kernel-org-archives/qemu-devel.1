Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269EEC742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 07:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F313220645
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 07:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F313220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysgo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlqNU-00064v-E2
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 03:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43837)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.engraf@sysgo.com>) id 1hlqNL-0005b8-A7
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.engraf@sysgo.com>) id 1hlqNK-0000Wf-Di
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:53:51 -0400
Received: from mail.sysgo.com ([176.9.12.79]:46240)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <david.engraf@sysgo.com>)
 id 1hlqNI-0000Rv-GS; Fri, 12 Jul 2019 03:53:48 -0400
From: David Engraf <david.engraf@sysgo.com>
To: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Date: Fri, 12 Jul 2019 09:50:02 +0200
Message-Id: <20190712075002.14326-1-david.engraf@sysgo.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 176.9.12.79
Subject: [Qemu-devel] [PATCH] hw/arm/virt: Fix non-secure flash mode
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
Cc: qemu-devel@nongnu.org, David Engraf <david.engraf@sysgo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using the whole 128 MiB flash in non-secure mode is not working because
virt_flash_fdt() expects the same address for secure_sysmem and sysmem.
This is not correctly handled by caller because it forwards NULL for
secure_sysmem in non-secure flash mode.

Fixed by using sysmem when secure_sysmem is NULL.

Signed-off-by: David Engraf <david.engraf@sysgo.com>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b5138cb22..d9496c9363 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1674,7 +1674,7 @@ static void machvirt_init(MachineState *machine)
                                     &machine->device_memory->mr);
     }
 
-    virt_flash_fdt(vms, sysmem, secure_sysmem);
+    virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
 
     create_gic(vms, pic);
 
-- 
2.17.1


