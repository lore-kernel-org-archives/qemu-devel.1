Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F44C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 21:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCCA22CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 21:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="IKcMig98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCCA22CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3R0q-0002Vu-By
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 17:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+17973240-45d5-qemu-devel=nongnu.org@sendgrid.net>)
 id 1k3Qzv-0001rt-Jv
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 17:30:55 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:20863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+17973240-45d5-qemu-devel=nongnu.org@sendgrid.net>)
 id 1k3Qzs-0002hn-He
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 17:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:to:cc:content-type:content-transfer-encoding;
 s=smtpapi; bh=WqTxKduvpZrcsVm7jnKquaCD51/zhdc974BjMSypsqs=;
 b=IKcMig98PryJJJh1+OKM4oZZvs/341i5u8vZIy6o7ejqRm03nwXFAq3syA2a/cfumD4G
 Ay8dgDXZ3bhlocSfqpGT1J4CfttH5hc4knWiJAbhDAl572yFdJohDm/xSRqdBOavWuFdjp
 S92gzB00m9sMmOb10t6FLFn8+fVJIMR9c=
Received: by filterdrecv-p3mdw1-7ff865655c-m2ckz with SMTP id
 filterdrecv-p3mdw1-7ff865655c-m2ckz-20-5F2B2509-52
 2020-08-05 21:30:49.49766156 +0000 UTC m=+616478.486849371
Received: from swapnil-ingle.ubvm.nutanix.com (unknown)
 by ismtpd0010p1sjc2.sendgrid.net (SG) with ESMTP
 id XiLUL97RS6KSR12I3oWGuA Wed, 05 Aug 2020 21:30:49.337 +0000 (UTC)
From: Swapnil Ingle <swapnil.ingle@nutanix.com>
Subject: [PATCH] block/vhdx: Support vhdx image only with 512 bytes logical
 sector size
Date: Wed, 05 Aug 2020 21:30:49 +0000 (UTC)
Message-Id: <1596663040-172084-1-git-send-email-swapnil.ingle@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
X-SG-EID: =?us-ascii?Q?F2ZUz17l2INJHYm1t3SgcUlF+k0ID8lTNwkAb5HHXc8fLM5LiKzEftZo2hMPsh?=
 =?us-ascii?Q?g8C4Vps0UmhpJRBoOufhCJs701GHlkbgDY6uPv8?=
 =?us-ascii?Q?BmQTtbLjwsVvvNMw+TzJ7VBcuMHWBEz2X80Oyvj?=
 =?us-ascii?Q?9YlFdnsyulIcG=2FnNT1kAliNjxH4SGgKzDeq4iVv?=
 =?us-ascii?Q?LXTNpAA1eHGFZULguepuW77RrTbQQ=2Fe=2F1jBrCRF?=
 =?us-ascii?Q?E3dsCMUmMkiSNm8pYw9HynfNeYHe4dbUIgyz4ty?=
 =?us-ascii?Q?YyASenUppv7bjqJlvVjMg=3D=3D?=
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+17973240-45d5-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 17:30:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Jeff Cody <codyprime@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:VHDX" <qemu-block@nongnu.org>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

block/vhdx uses qemu block layer where sector size is always 512 byte.
This may have issues  with 4K logical sector sized vhdx image.

For e.g qemu-img convert on such images fails with following assert:

$qemu-img convert -f vhdx -O raw 4KTest1.vhdx test.raw
qemu-img: util/iov.c:388: qiov_slice: Assertion `offset + len <=
qiov->size' failed.
Aborted

This patch adds an check to return ENOTSUP for vhdx images which
has logical sector size other than 512 bytes.

Signed-off-by: Swapnil Ingle <swapnil.ingle@nutanix.com>
---
 block/vhdx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 791eb90..356ec4c 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -816,9 +816,9 @@ static int vhdx_parse_metadata(BlockDriverState *bs, BDRVVHDXState *s)
         goto exit;
     }
 
-    /* only 2 supported sector sizes */
-    if (s->logical_sector_size != 512 && s->logical_sector_size != 4096) {
-        ret = -EINVAL;
+    /* Currently we only support 512 */
+    if (s->logical_sector_size != 512) {
+        ret = -ENOTSUP;
         goto exit;
     }
 
-- 
1.8.3.1


