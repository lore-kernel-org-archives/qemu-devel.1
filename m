Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0997FC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 06:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13AA2184E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 06:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13AA2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvcOD-0001hZ-3K
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 02:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50919)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hvcNp-0001Ho-Jt
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 02:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hvcNo-0001pZ-IQ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 02:58:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hvcNo-0001nS-Cw
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 02:58:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 83915C049E10;
 Thu,  8 Aug 2019 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.65.150.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C6D75D9DC;
 Thu,  8 Aug 2019 06:58:38 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Thu,  8 Aug 2019 12:26:36 +0530
Message-Id: <20190808065636.28787-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 08 Aug 2019 06:58:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] ide: ahci: add check to avoid null dereference
 (CVE-2019-12067)
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
Cc: Bugs SysSec <bugs-syssec@rub.de>, John Snow <jsnow@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

AHCI emulator while committing DMA buffer in ahci_commit_buf()
may do a NULL dereference if the command header 'ad->cur_cmd'
is null. Add check to avoid it.

Reported-by: Bugs SysSec <bugs-syssec@rub.de>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/ide/ahci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 00ba422a48..9fff94075b 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1458,8 +1458,10 @@ static void ahci_commit_buf(IDEDMA *dma, uint32_t =
tx_bytes)
 {
     AHCIDevice *ad =3D DO_UPCAST(AHCIDevice, dma, dma);
=20
-    tx_bytes +=3D le32_to_cpu(ad->cur_cmd->status);
-    ad->cur_cmd->status =3D cpu_to_le32(tx_bytes);
+    if (ad->cur_cmd) {
+        tx_bytes +=3D le32_to_cpu(ad->cur_cmd->status);
+        ad->cur_cmd->status =3D cpu_to_le32(tx_bytes);
+    }
 }
=20
 static int ahci_dma_rw_buf(IDEDMA *dma, int is_write)
--=20
2.21.0


