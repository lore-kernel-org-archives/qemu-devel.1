Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AD8C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68360205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 21:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="diPX4W7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68360205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnrT7-00029X-Bd
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 17:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrSA-0006ow-W7
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrS9-0006zQ-QU
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 17:27:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14135)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=09475cf9f=dmitry.fomichev@wdc.com>)
 id 1hnrS9-0006yK-If; Wed, 17 Jul 2019 17:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563398829; x=1594934829;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=boA+Z2tHFjiw8PC+GjVyKRaSk8JwNJ8dEkm+i6cC7Zo=;
 b=diPX4W7HczdBxeSCfH+rxW2n0F7cEOiZz5F4G5hjXS5sFimvRchoL8h6
 ewozTLyqntqaPye0LcZTZatDkK3mtfpLSyVpS7jQ69R8rhLojQiJYMb2d
 MFCABgedBDnuc6tPMgNebMyr29uFC2fusQ5/GQMvSzzC86w1KjGB2C9+Y
 +1nzeq/trZKPIYR3VRDwKY9QxCH88Ir2ZEF4tK/07Hgm6MVWi57PNrBZK
 3U/vJVzola0T9VhqU4kzKjnhb6caFLZFRIJ22pKUdSUH8mrWmtdy/1cDx
 RqnSDKCpovP3H55lPC/jqXEpIxEK6aCGAEDiy7IbT416+KvxwvgiSaN/9 w==;
IronPort-SDR: Prnw1PHzhfEdqwNueNAwrKVD59xmXlXzBQhfpHdbUrqYleJwSWGmTJfypmwBaznzdPYnJF9uPD
 PaueyoaOTaPy5Al2g6qEmfScJobxH2GHd5btlpji6IXhDzu8A00T9YY4uedSUszs1uZIceWYQ2
 jFmaTCASiNtAAb7/VyGhKZDpK3DuSXiQCdyTpbOXQo6PMc77Wzgg/iYKofhNLxW2RuXAEOUAmA
 X6//CUEp/GcbB5DnQxqqjn7UbPGcqKMCw3oG04N6gmQSCsrIy+I8J8C7Q7hOU/Zv646LBG6QM/
 1z8=
X-IronPort-AV: E=Sophos;i="5.64,275,1559491200"; d="scan'208";a="113319447"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2019 05:27:08 +0800
IronPort-SDR: hxbdVCgC3vjJKO0w6XQ3CCw/rQw1hAeCdzxVvU4ur0HfmRZdkCe+88BWH+HhCPdl0lHoJXb5/I
 Kt9Ju8rXuJHIePYY3S8crONoEQljh0KqYivM5ZOPSYRm/sQMg8fzRm3ZSrB7H5aDLkVLFRY+Km
 gT8Vk6SYk24yi+buJ25OvkLuSzjva0kvTflDkHiSjkzBgvTL6dxO1jxipWrc/uyimYHKKowtLp
 3BQZUIkCjpVq3/65cdyDXzfcD2QYJcRMLbZPj44DNng8HIgZQh4p0FU/rT5XOBr4cpUImb4MjK
 z/8eNOTwoo+Qsq8RMqGaBbrD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 17 Jul 2019 14:25:36 -0700
IronPort-SDR: i6dSGGfgNw2q26TUbfrnLHJlPwHuIJu1XYym0gebcG0sNlDUXfDAofW6BBUrU0+n4aQRPVO2QL
 62rU6kqfhHzP6wNsc5n9JQoXWvWOaCKFjJdC9HTxGyKOZNyNSwNpB4JBhmapE5DaOZo0/M4L65
 7Yd6Xj6tMIo0kyxpk/LyxBJo27iU1cfV1s7cr8vg3nUXM9NErlNofRkhDKVE8eezkNwQReQeHd
 5TneA//9dC2sl31RARW+SSnZ7miKzcNsLR4saSXshC3h+fVqqMz+rxwvA9OlVgPO3O8veJWOyi
 fN4=
Received: from dhcp-10-88-173-43.hgst.com ([10.88.173.43])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 Jul 2019 14:27:08 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 17 Jul 2019 17:27:02 -0400
Message-Id: <20190717212703.10205-5-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717212703.10205-1-dmitry.fomichev@wdc.com>
References: <20190717212703.10205-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v2 4/5] raw: Don't open ZBDs if backend can't
 handle them
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Abort opening a zoned device as a raw file in case the chosen
block backend driver lacks proper support for this type of
storage.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 block/file-posix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index e307cab7a4..507dba98c5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2870,6 +2870,20 @@ static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,
             goto fail;
         }
     }
+
+    /*
+     * If we are opening a zoned block device, check if the backend
+     * driver can properly handle such devices, abort if not.
+     */
+    if (bdrv_is_zoned(bs) &&
+        (shared & BLK_PERM_SUPPORT_ZONED) &&
+        !(perm & BLK_PERM_SUPPORT_ZONED)) {
+        error_setg(errp,
+                   "block backend driver doesn't support HM zoned devices");
+        ret = -ENOTSUP;
+        goto fail;
+    }
+
     return 0;
 
 fail:
-- 
2.21.0


