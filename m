Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A1DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095272070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095272070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blade-group.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRlU-00062s-4d
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=lhc+=a4=lse.epita.fr=xdbob@cri.epita.fr>)
 id 1jwQrk-0007ba-Fe; Fri, 17 Jul 2020 09:57:32 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:33922
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=lhc+=a4=lse.epita.fr=xdbob@cri.epita.fr>)
 id 1jwQri-0003TD-F2; Fri, 17 Jul 2020 09:57:32 -0400
Received: from localhost (unknown [78.193.104.169])
 (Authenticated sender: damhet_a)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 1E8453FB70;
 Fri, 17 Jul 2020 15:57:25 +0200 (CEST)
From: antoine.damhet@blade-group.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND] file-posix: Handle `EINVAL` fallocate return value
Date: Fri, 17 Jul 2020 15:56:04 +0200
Message-Id: <20200717135603.51180-1-antoine.damhet@blade-group.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=lhc+=a4=lse.epita.fr=xdbob@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 09:34:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 17 Jul 2020 10:54:07 -0400
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
Cc: antoine.damhet@blade-group.com, Kevin Wolf <kwolf@redhat.com>,
 "open list:raw" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Antoine Damhet <antoine.damhet@blade-group.com>

The `detect-zeroes=unmap` option may issue unaligned
`FALLOC_FL_PUNCH_HOLE` requests, raw block devices can (and will) return
`EINVAL`, qemu should then write the zeroes to the blockdev instead of
issuing an `IO_ERROR`.

Signed-off-by: Antoine Damhet <antoine.damhet@blade-group.com>
---

I am resending this patch because:
1. I sent the first version from the wrong email address
2. I forgot to send it to the devel mailing list

Please forgive me for the inconvenience.

 block/file-posix.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 8067e238cb..b2fabcc1b8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1620,7 +1620,11 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     int ret = do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                            aiocb->aio_offset, aiocb->aio_nbytes);
-    if (ret != -ENOTSUP) {
+    switch (ret) {
+    case -ENOTSUP:
+    case -EINVAL:
+        break;
+    default:
         return ret;
     }
 #endif
-- 
2.27.0


