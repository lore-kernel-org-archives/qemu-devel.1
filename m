Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9DFC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F43B2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F43B2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylr7-00018r-5g
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylSB-0001aX-2W
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylS9-0007q8-Rd
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:16:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylS9-0007pf-MN; Fri, 16 Aug 2019 19:16:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 07BCD306F4A9;
 Fri, 16 Aug 2019 23:16:13 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FBF417BB9;
 Fri, 16 Aug 2019 23:16:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:16:07 -0400
Message-Id: <20190816231609.9521-2-jsnow@redhat.com>
In-Reply-To: <20190816231609.9521-1-jsnow@redhat.com>
References: <20190816231609.9521-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 16 Aug 2019 23:16:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/3] dma-helpers: ensure AIO callback is invoked
 after cancellation
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

dma_aio_cancel unschedules the BH if there is one, which corresponds
to the reschedule_dma case of dma_blk_cb.  This can stall the DMA
permanently, because dma_complete will never get invoked and therefore
nobody will ever invoke the original AIO callback in dbs->common.cb.

Fix this by invoking the callback (which is ensured to happen after
a bdrv_aio_cancel_async, or done manually in the dbs->bh case), and
add assertions to check that the DMA state machine is indeed waiting
for dma_complete or reschedule_dma, but never both.

Reported-by: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20190729213416.1972-1-pbonzini@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 dma-helpers.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/dma-helpers.c b/dma-helpers.c
index 2d7e02d35e5..d3871dc61ea 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -90,6 +90,7 @@ static void reschedule_dma(void *opaque)
 {
     DMAAIOCB *dbs =3D (DMAAIOCB *)opaque;
=20
+    assert(!dbs->acb && dbs->bh);
     qemu_bh_delete(dbs->bh);
     dbs->bh =3D NULL;
     dma_blk_cb(dbs, 0);
@@ -111,15 +112,12 @@ static void dma_complete(DMAAIOCB *dbs, int ret)
 {
     trace_dma_complete(dbs, ret, dbs->common.cb);
=20
+    assert(!dbs->acb && !dbs->bh);
     dma_blk_unmap(dbs);
     if (dbs->common.cb) {
         dbs->common.cb(dbs->common.opaque, ret);
     }
     qemu_iovec_destroy(&dbs->iov);
-    if (dbs->bh) {
-        qemu_bh_delete(dbs->bh);
-        dbs->bh =3D NULL;
-    }
     qemu_aio_unref(dbs);
 }
=20
@@ -179,14 +177,21 @@ static void dma_aio_cancel(BlockAIOCB *acb)
=20
     trace_dma_aio_cancel(dbs);
=20
+    assert(!(dbs->acb && dbs->bh));
     if (dbs->acb) {
+        /* This will invoke dma_blk_cb.  */
         blk_aio_cancel_async(dbs->acb);
+        return;
     }
+
     if (dbs->bh) {
         cpu_unregister_map_client(dbs->bh);
         qemu_bh_delete(dbs->bh);
         dbs->bh =3D NULL;
     }
+    if (dbs->common.cb) {
+        dbs->common.cb(dbs->common.opaque, -ECANCELED);
+    }
 }
=20
 static AioContext *dma_get_aio_context(BlockAIOCB *acb)
--=20
2.21.0


