Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EE8C282CE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2D3206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2D3206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIX3Z-0002rB-3F
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 07:24:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIWzJ-0007sk-1H
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIWzI-0001RK-6I
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:19:53 -0400
Received: from mail.ispras.ru ([83.149.199.45]:46812)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIWzH-0001R9-VE
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:19:52 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id 184905400A9;
	Mon, 22 Apr 2019 14:19:51 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 14:19:50 +0300
Message-ID:
 <155593199090.21079.10732123392374470125.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH for-4.1 02/24] block: implement
 bdrv_snapshot_goto for blkreplay
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com,
	pavel.dovgaluk@ispras.ru, pbonzini@redhat.com,
	crosthwaite.peter@gmail.com, ciro.santilli@gmail.com,
	jasowang@redhat.com, quintela@redhat.com, armbru@redhat.com,
	mreitz@redhat.com, alex.bennee@linaro.org,
	maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
	boost.lists@gmail.com, thomas.dullien@googlemail.com,
	dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
	dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422111950.ZqTSRI9AL948TF_RFkmUOBCx5c8uh3uCxkNctA2HGyw@z>

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch enables making snapshots with blkreplay used in
block devices.
This function is required to make bdrv_snapshot_goto without
calling .bdrv_open which is not implemented.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Acked-by: Kevin Wolf <kwolf@redhat.com>
---
 block/blkreplay.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/blkreplay.c b/block/blkreplay.c
index b5d9efdeca..142dfe3157 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -126,6 +126,12 @@ static int coroutine_fn blkreplay_co_flush(BlockDriverState *bs)
     return ret;
 }
 
+static int blkreplay_snapshot_goto(BlockDriverState *bs,
+                                   const char *snapshot_id)
+{
+    return bdrv_snapshot_goto(bs->file->bs, snapshot_id, NULL);
+}
+
 static BlockDriver bdrv_blkreplay = {
     .format_name            = "blkreplay",
     .instance_size          = 0,
@@ -140,6 +146,8 @@ static BlockDriver bdrv_blkreplay = {
     .bdrv_co_pwrite_zeroes  = blkreplay_co_pwrite_zeroes,
     .bdrv_co_pdiscard       = blkreplay_co_pdiscard,
     .bdrv_co_flush          = blkreplay_co_flush,
+
+    .bdrv_snapshot_goto     = blkreplay_snapshot_goto,
 };
 
 static void bdrv_blkreplay_init(void)


