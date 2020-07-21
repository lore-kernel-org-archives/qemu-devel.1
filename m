Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BBBC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B8C20792
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYwaia1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B8C20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxqnY-0007YO-3W
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 07:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jxqmC-0005jq-Ql
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:49:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jxqmA-00065X-Jk
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595332177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBsbvbrM0hTRp1RDTWa9O+FYk+piA4Xx60yUG/qUQw4=;
 b=PYwaia1f4R3TzMN8w1c2vVgUR8j18a+ELDAO0zIPNemTUiMm3pFQZcXyddH4u82dyxeDMH
 9x2M2e59y85+iEbgnedkDjnrMhN+37+Gx7M1L0gSAzYdHcIXb8BRosqzDI17HHsclWnZ96
 0k068Za/bLB00g1P2ixUjobQqVQ1TPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-LU3e3FMyMpa0FuCnx0EbgQ-1; Tue, 21 Jul 2020 07:49:33 -0400
X-MC-Unique: LU3e3FMyMpa0FuCnx0EbgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A7FB100D0DD;
 Tue, 21 Jul 2020 11:49:32 +0000 (UTC)
Received: from localhost (ovpn-113-68.ams2.redhat.com [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CA1A709E1;
 Tue, 21 Jul 2020 11:49:31 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 3/3] block: fix bdrv_aio_cancel() for ENOMEDIUM requests
Date: Tue, 21 Jul 2020 13:49:20 +0200
Message-Id: <20200721114920.1174149-4-mreitz@redhat.com>
In-Reply-To: <20200721114920.1174149-1-mreitz@redhat.com>
References: <20200721114920.1174149-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

bdrv_aio_cancel() calls aio_poll() on the AioContext for the given I/O
request until it has completed. ENOMEDIUM requests are special because
there is no BlockDriverState when the drive has no medium!

Define a .get_aio_context() function for BlkAioEmAIOCB requests so that
bdrv_aio_cancel() can find the AioContext where the completion BH is
pending. Without this function bdrv_aio_cancel() aborts on ENOMEDIUM
requests!

libFuzzer triggered the following assertion:

  cat << EOF | qemu-system-i386 -M pc-q35-5.0 \
    -nographic -monitor none -serial none \
    -qtest stdio -trace ide\*
  outl 0xcf8 0x8000fa24
  outl 0xcfc 0xe106c000
  outl 0xcf8 0x8000fa04
  outw 0xcfc 0x7
  outl 0xcf8 0x8000fb20
  write 0x0 0x3 0x2780e7
  write 0xe106c22c 0xd 0x1130c218021130c218021130c2
  write 0xe106c218 0x15 0x110010110010110010110010110010110010110010
  EOF
  ide_exec_cmd IDE exec cmd: bus 0x56170a77a2b8; state 0x56170a77a340; cmd 0xe7
  ide_reset IDEstate 0x56170a77a340
  Aborted (core dumped)

  (gdb) bt
  #1  0x00007ffff4f93895 in abort () at /lib64/libc.so.6
  #2  0x0000555555dc6c00 in bdrv_aio_cancel (acb=0x555556765550) at block/io.c:2745
  #3  0x0000555555dac202 in blk_aio_cancel (acb=0x555556765550) at block/block-backend.c:1546
  #4  0x0000555555b1bd74 in ide_reset (s=0x555557213340) at hw/ide/core.c:1318
  #5  0x0000555555b1e3a1 in ide_bus_reset (bus=0x5555572132b8) at hw/ide/core.c:2422
  #6  0x0000555555b2aa27 in ahci_reset_port (s=0x55555720eb50, port=2) at hw/ide/ahci.c:650
  #7  0x0000555555b29fd7 in ahci_port_write (s=0x55555720eb50, port=2, offset=44, val=16) at hw/ide/ahci.c:360
  #8  0x0000555555b2a564 in ahci_mem_write (opaque=0x55555720eb50, addr=556, val=16, size=1) at hw/ide/ahci.c:513
  #9  0x000055555598415b in memory_region_write_accessor (mr=0x55555720eb80, addr=556, value=0x7fffffffb838, size=1, shift=0, mask=255, attrs=...) at softmmu/memory.c:483

Looking at bdrv_aio_cancel:

2728 /* async I/Os */
2729
2730 void bdrv_aio_cancel(BlockAIOCB *acb)
2731 {
2732     qemu_aio_ref(acb);
2733     bdrv_aio_cancel_async(acb);
2734     while (acb->refcnt > 1) {
2735         if (acb->aiocb_info->get_aio_context) {
2736             aio_poll(acb->aiocb_info->get_aio_context(acb), true);
2737         } else if (acb->bs) {
2738             /* qemu_aio_ref and qemu_aio_unref are not thread-safe, so
2739              * assert that we're not using an I/O thread.  Thread-safe
2740              * code should use bdrv_aio_cancel_async exclusively.
2741              */
2742             assert(bdrv_get_aio_context(acb->bs) == qemu_get_aio_context());
2743             aio_poll(bdrv_get_aio_context(acb->bs), true);
2744         } else {
2745             abort();     <===============
2746         }
2747     }
2748     qemu_aio_unref(acb);
2749 }

Fixes: 02c50efe08736116048d5fc355043080f4d5859c ("block: Add bdrv_aio_cancel_async")
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Buglink: https://bugs.launchpad.net/qemu/+bug/1878255
Originally-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200720100141.129739-1-stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-backend.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 0bf0188133..3a13cb5f0b 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1394,8 +1394,16 @@ typedef struct BlkAioEmAIOCB {
     bool has_returned;
 } BlkAioEmAIOCB;
 
+static AioContext *blk_aio_em_aiocb_get_aio_context(BlockAIOCB *acb_)
+{
+    BlkAioEmAIOCB *acb = container_of(acb_, BlkAioEmAIOCB, common);
+
+    return blk_get_aio_context(acb->rwco.blk);
+}
+
 static const AIOCBInfo blk_aio_em_aiocb_info = {
     .aiocb_size         = sizeof(BlkAioEmAIOCB),
+    .get_aio_context    = blk_aio_em_aiocb_get_aio_context,
 };
 
 static void blk_aio_complete(BlkAioEmAIOCB *acb)
-- 
2.26.2


