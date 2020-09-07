Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226FCC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34D2206D4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMrhRKyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34D2206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFHW-0001UM-Mj
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2n-0003LS-4n
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2j-00087A-Tz
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aH1+kto0i3t0ycjEfMZwgAcpLuKv+7o/APyPRc+HhHc=;
 b=EMrhRKypxwLZbAykLNSMqr1TudTAC2nmPFPM79xKr3o0T+Yz4NUENr+/HY/6af+xk83muL
 6z+Cq91xgfpmaYQiQ+b06MY9EZpB0GaY3FulXymiPmc2kUXQer2M/iqPORRNHfSNCTJpah
 Jct9njwmzsU4USO9jnNygEb3gllztxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-utsaJ9CsOrOrrJg68FXlbw-1; Mon, 07 Sep 2020 07:10:35 -0400
X-MC-Unique: utsaJ9CsOrOrrJg68FXlbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DDD31DDEF;
 Mon,  7 Sep 2020 11:10:34 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A8657E43B;
 Mon,  7 Sep 2020 11:10:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 38/64] block: Use CAFs for debug breakpoints
Date: Mon,  7 Sep 2020 13:09:10 +0200
Message-Id: <20200907110936.261684-39-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Max Reitz <mreitz@redhat.com>

When looking for a blkdebug node (which implements debug breakpoints),
use bdrv_primary_bs() to iterate through the graph, because that is
where a blkdebug node would be.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/block.c b/block.c
index ed29d1edb4..ac4ab07f07 100644
--- a/block.c
+++ b/block.c
@@ -5568,17 +5568,7 @@ void bdrv_debug_event(BlockDriverState *bs, BlkdebugEvent event)
 static BlockDriverState *bdrv_find_debug_node(BlockDriverState *bs)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_breakpoint) {
-        if (bs->file) {
-            bs = bs->file->bs;
-            continue;
-        }
-
-        if (bs->drv->is_filter && bs->backing) {
-            bs = bs->backing->bs;
-            continue;
-        }
-
-        break;
+        bs = bdrv_primary_bs(bs);
     }
 
     if (bs && bs->drv && bs->drv->bdrv_debug_breakpoint) {
@@ -5613,7 +5603,7 @@ int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag)
 int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
 {
     while (bs && (!bs->drv || !bs->drv->bdrv_debug_resume)) {
-        bs = bs->file ? bs->file->bs : NULL;
+        bs = bdrv_primary_bs(bs);
     }
 
     if (bs && bs->drv && bs->drv->bdrv_debug_resume) {
@@ -5626,7 +5616,7 @@ int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
 bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_is_suspended) {
-        bs = bs->file ? bs->file->bs : NULL;
+        bs = bdrv_primary_bs(bs);
     }
 
     if (bs && bs->drv && bs->drv->bdrv_debug_is_suspended) {
-- 
2.25.4


