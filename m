Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC55C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD10214DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zn/dBj6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD10214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZQ4-000756-HT
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNd-0002rI-1p
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41894
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNW-0001eU-NN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FDtFgVXbdXkJ2To4Y8gFPq3/FazjDall/X6/Ks/zPA=;
 b=Zn/dBj6SHBqwyjuC1LRcbesUYl+eXi4NAdI8E6+vVNXy93Am6ZFyZlUwM5rhJWudexkJyC
 kUKQ0VPjZ+9WYkMIqDD0qYg9yXeFMWXDo84UrlUFjhVY9jIKTLbh6SGysONDDoHtNr5uP4
 3KgrcGlPxsdboRjLVXZNLsVrt4gfmDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-tmtw0q-OOBqPDJRXUBZV5w-1; Wed, 17 Jun 2020 10:49:17 -0400
X-MC-Unique: tmtw0q-OOBqPDJRXUBZV5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B409108BBE0;
 Wed, 17 Jun 2020 14:49:16 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33E547CAAA;
 Wed, 17 Jun 2020 14:49:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/43] icount: make dma reads deterministic
Date: Wed, 17 Jun 2020 16:48:28 +0200
Message-Id: <20200617144909.192176-3-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
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
Message-Id: <159117972206.12193.12939621311413561779.stgit@pasha-ThinkPad-X280>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 dma-helpers.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/dma-helpers.c b/dma-helpers.c
index e8a26e81e1..2a77b5a9cb 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -13,6 +13,8 @@
 #include "trace-root.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
+#include "qemu/range.h"
 
 /* #define DEBUG_IOMMU */
 
@@ -142,6 +144,26 @@ static void dma_blk_cb(void *opaque, int ret)
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
+        if (mem && use_icount && dbs->dir == DMA_DIRECTION_FROM_DEVICE) {
+            int i;
+            for (i = 0 ; i < dbs->iov.niov ; ++i) {
+                if (ranges_overlap((intptr_t)dbs->iov.iov[i].iov_base,
+                                   dbs->iov.iov[i].iov_len, (intptr_t)mem,
+                                   cur_len)) {
+                    dma_memory_unmap(dbs->sg->as, mem, cur_len,
+                                     dbs->dir, cur_len);
+                    mem = NULL;
+                    break;
+                }
+            }
+        }
         if (!mem)
             break;
         qemu_iovec_add(&dbs->iov, mem, cur_len);
-- 
2.25.4


