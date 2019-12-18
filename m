Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66816C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BC32465E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ah2CfLyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BC32465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihb2e-0003Es-10
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 10:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <4866c87cb19f3191b977fc7fbe2857abf1da80b6@lizzy.crudebyte.com>)
 id 1ihb1F-0001ku-2q
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <4866c87cb19f3191b977fc7fbe2857abf1da80b6@lizzy.crudebyte.com>)
 id 1ihb1D-0006Sx-RI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:13:44 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:54257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <4866c87cb19f3191b977fc7fbe2857abf1da80b6@lizzy.crudebyte.com>)
 id 1ihb1D-0001Ee-DX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=KBohi6m8+kT0YLSCXjzWFKtZubkOcD4kA+IhcBSo+mw=; b=ah2Cf
 LyXsVtfD5kaavf/HCnjbAyxDT4DplQ1n7xL6ZK4e4x7ElOm15ExiWi8uhv2LgdmB1XxgrvNGAK5R8
 knYy/sJlL48B0U9ZusyF3TzsDq/TZnQP7IevfJP9QCIJNBLGz1S08tbKpDBdZd2TGjFSq/TYz2wIo
 pYYOCN9QCMh27TwrcfPQEQFik+HxqjW9p4lgamz8xIJE/bEPLbWUMI3nrRpVP8UMEcjnskZlWY1Mo
 b3iPde73l/ePUs5ftWtVeUpk7rA0tEyeAtKvju9Y9d72SEbPsIycAzyuSxbSr2EOssf3DxRcBcWhA
 6yrDdtB9LGmOn3ztqM+d3Arx/bwsw==;
Message-Id: <4866c87cb19f3191b977fc7fbe2857abf1da80b6.1576678644.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1576678644.git.qemu_oss@crudebyte.com>
References: <cover.1576678644.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Date: Wed, 18 Dec 2019 14:17:59 +0100
Subject: [PATCH v2 2/9] 9pfs: validate count sent by client with T_readdir
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.194.90.13
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

A good 9p client sends T_readdir with "count" parameter that's
sufficiently smaller than client's initially negotiated msize
(maximum message size). We perform a check for that though to
avoid the server to be interrupted with a "Failed to encode
VirtFS reply type 41" error message by bad clients.

Note: we should probably also check for a minimum size of
msize during T_version to avoid issues and/or too complicated
count/size checks later on in other requests of that client.
T_version should submit an msize that's at least as large as
the largest request's header size.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 520177f40c..30e33b6573 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2414,6 +2414,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     int32_t count;
     uint32_t max_count;
     V9fsPDU *pdu = opaque;
+    V9fsState *s = pdu->s;
 
     retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
                            &initial_offset, &max_count);
@@ -2422,6 +2423,13 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     }
     trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset, max_count);
 
+    if (max_count > s->msize - P9_IOHDRSZ) {
+        max_count = s->msize - P9_IOHDRSZ;
+        warn_report_once(
+            "9p: bad client: T_readdir with count > msize - P9_IOHDRSZ"
+        );
+    }
+
     fidp = get_fid(pdu, fid);
     if (fidp == NULL) {
         retval = -EINVAL;
-- 
2.20.1


