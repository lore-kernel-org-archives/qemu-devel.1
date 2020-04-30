Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12D4C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68BE20787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68BE20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU578-0004pj-T8
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jU55x-0003Rj-HG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jU55r-0001ie-NB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:03:00 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45820)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jU55r-0001gh-4s
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:02:55 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id D630BCD465;
 Thu, 30 Apr 2020 12:02:51 +0300 (MSK)
Subject: [PATCH v2] icount: make dma reads deterministic
From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 30 Apr 2020 12:02:51 +0300
Message-ID: <158823737122.27545.13132967751052120169.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: softfail client-ip=83.149.199.45;
 envelope-from=Pavel.Dovgaluk@gmail.com; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 05:02:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
 dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>

Windows guest sometimes makes DMA requests with overlapping
target addresses. This leads to the following structure of iov for
the block driver:

addr size1
addr size2
addr size3

It means that three adjacent disk blocks should be read into the same
memory buffer. Windows does not expects anything from these bytes
(should it be data from the first block, or the last one, or some mix),
but uses them somehow. It leads to non-determinism of the guest execution,
because block driver does not preserve any order of reading.

This situation was discusses in the mailing list at least twice:
https://lists.gnu.org/archive/html/qemu-devel/2010-09/msg01996.html
https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05185.html

This patch makes such disk reads deterministic in icount mode.
It splits the whole request into several parts. Parts may overlap,
but SGs inside one part do not overlap.
Parts that are processed later overwrite the prior ones in case
of overlapping.

Examples for different SG part sequences:

1)
A1 1000
A2 1000
A1 1000
A3 1000
->
One request is split into two.
A1 1000
A2 1000
--
A1 1000
A3 1000

2)
A1 800
A2 1000
A1 1000
->
A1 800
A2 1000
--
A1 1000

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

--

v2:
 - Rewritten the loop to split the request instead of skipping the parts
   (suggested by Kevin Wolf)
---
 dma-helpers.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/dma-helpers.c b/dma-helpers.c
index e8a26e81e1..a49f9a0e34 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -13,6 +13,8 @@
 #include "trace-root.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
+#include "qemu/range.h"
 
 /* #define DEBUG_IOMMU */
 
@@ -142,6 +144,24 @@ static void dma_blk_cb(void *opaque, int ret)
         cur_addr = dbs->sg->sg[dbs->sg_cur_index].base + dbs->sg_cur_byte;
         cur_len = dbs->sg->sg[dbs->sg_cur_index].len - dbs->sg_cur_byte;
         mem = dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs->dir);
+        /*
+         * Make reads deterministic in icount mode. Windows sometimes issues
+         * disk read requests with overlapping SGs. It leads
+         * to non-determinism, because resulting buffer contents may be mixed
+         * from several sectors. This code splits all SGs into several
+         * groups. SGs in every group do not overlap.
+         */
+        if (use_icount && dbs->dir == DMA_DIRECTION_FROM_DEVICE) {
+            int i;
+            for (i = 0 ; i < dbs->iov.niov ; ++i) {
+                if (ranges_overlap((intptr_t)dbs->iov.iov[i].iov_base,
+                                   dbs->iov.iov[i].iov_len, (intptr_t)mem,
+                                   cur_len)) {
+                    mem = NULL;
+                    break;
+                }
+            }
+        }
         if (!mem)
             break;
         qemu_iovec_add(&dbs->iov, mem, cur_len);


