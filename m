Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862BCC48BE7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 07:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D6D20844
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 07:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D6D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkOKd-00027Y-Mg
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 03:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48790)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <root@shaju-abraham.dev.nutanix.com>)
 id 1hkJuf-0003Ic-5j
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 23:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <root@shaju-abraham.dev.nutanix.com>)
 id 1hkJuX-00009c-WE
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 23:01:54 -0400
Received: from [192.146.154.1] (port=22458 helo=shaju-abraham.dev.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <root@shaju-abraham.dev.nutanix.com>)
 id 1hkJuC-0008IT-00; Sun, 07 Jul 2019 23:01:29 -0400
Received: by shaju-abraham.dev.nutanix.com (Postfix, from userid 0)
 id 70BBE40628; Sun,  7 Jul 2019 19:55:12 -0700 (PDT)
From: shaju.abraham@nutanix.com
To: qemu-devel@nongnu.org
Date: Sun,  7 Jul 2019 19:55:03 -0700
Message-Id: <1562554503-177179-1-git-send-email-shaju.abraham@nutanix.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 192.146.154.1
X-Mailman-Approved-At: Mon, 08 Jul 2019 03:42:45 -0400
Subject: [Qemu-devel] [PATCH] Fix Guest VM crash due to iSCSI Sense Key error
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
Cc: Shaju Abraham <shaju.abraham@nutanix.com>, jsnow@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shaju Abraham <shaju.abraham@nutanix.com>

During the  IDE DMA transfer for a ISCSI target,when libiscsi encounters
a SENSE KEY error, it sets the task->sense to  the value "COMMAND ABORTED".
The function iscsi_translate_sense() later translaters this error to -ECANCELED
and this value is passed to the callback function. In the case of  IDE DMA read
or write, the callback function returns immediately if the value of the ret
argument is -ECANCELED.
Later when ide_cancel_dma_sync() function is invoked  the assertion
"s->bus->dma->aiocb == ((void *)0)" fails and the qemu process gets terminated.
Fix the issue by making the value of s->bus->dma->aiocb = NULL when
-ECANCELED is passed to the callback.

Signed-off-by: Shaju Abraham <shaju.abraham@nutanix.com>
---
 hw/ide/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 6afadf8..78ea357 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -841,6 +841,7 @@ static void ide_dma_cb(void *opaque, int ret)
     bool stay_active = false;
 
     if (ret == -ECANCELED) {
+        s->bus->dma->aiocb = NULL;
         return;
     }
 
-- 
1.9.4


