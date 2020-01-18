Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE81C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E482468B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dTXZtkbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E482468B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1istXW-000657-IO
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1istTs-0001Rv-8d
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1istTr-0004OO-6u
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:10:00 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:48323)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1istTq-0004N2-JA; Sat, 18 Jan 2020 14:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=BZKfhQ5ZLUQf4N/TkgPawId09t6hU5S5JwF1mA9yA/I=; 
 b=dTXZtkbEyE9mopPGlMbZ8IzDbmcBGqWyUj8RWUv681G48QNo0SJTBhD2yRXeYQVemmwd0p2jc+DAq6mjv7uUaub2A6q7jxCijZU3r88j8cfuxl/uPwUVTda5ly/DBpya/3yI+ncjDxamt52xUB00uZQgC9IndhyruAHmZ+fDEHCdNhrjUDP/jJTFP3l2reprXzEP7rg259WSKbZHiZ4np+zJquYZJRI5rGhqCoSvdbZRQWf4/mTulmOQtgvpwVBt2mtsr/hm0vnOr00bbbX/NVZocze4qhU3JGXXSTc17mXNqOPyIjqnoGOXis0g8gVs0kHe4MqfA9MIUwfQNFqQyQ==;
Received: from [80.30.177.7] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1istTn-00065A-D9; Sat, 18 Jan 2020 20:09:55 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1istTW-0002Jd-Sb; Sat, 18 Jan 2020 20:09:38 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/5] qcow2: Use BDRV_SECTOR_SIZE instead of the hardcoded
 value
Date: Sat, 18 Jan 2020 20:09:30 +0100
Message-Id: <b5f74b606c2d9873b12d29acdb7fd498029c4025.1579374329.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1579374329.git.berto@igalia.com>
References: <cover.1579374329.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This replaces all remaining instances in the qcow2 code.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index a6b0d4ee1d..6cc13e388c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3273,7 +3273,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
     /* Validate options and set default values */
     if (!QEMU_IS_ALIGNED(qcow2_opts->size, BDRV_SECTOR_SIZE)) {
-        error_setg(errp, "Image size must be a multiple of 512 bytes");
+        error_setg(errp, "Image size must be a multiple of %u bytes",
+                   (unsigned) BDRV_SECTOR_SIZE);
         ret = -EINVAL;
         goto out;
     }
@@ -3947,8 +3948,9 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         return -ENOTSUP;
     }
 
-    if (offset & 511) {
-        error_setg(errp, "The new size must be a multiple of 512");
+    if (!QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE)) {
+        error_setg(errp, "The new size must be a multiple of %u",
+                   (unsigned) BDRV_SECTOR_SIZE);
         return -EINVAL;
     }
 
-- 
2.20.1


