Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C0CC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A7120850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="E5eb1g6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A7120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49749 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEae4-0005Wk-Rt
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 10:25:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEaca-0004ch-VH
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEaca-000120-18
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:24:08 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:49196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hEacZ-00011Q-LC; Thu, 11 Apr 2019 10:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=gm9gzrh60/aW5yEJfW6bCvZ7dai+MaRbJhO1rJNnMWo=; 
	b=E5eb1g6gsQRGxqcgsJFlHjHZAAKz1o1E7sc5G5aGjuA1vCoOH9i9D1/eiOoU5Nl+LIHFP7FIb+5W4RiA+OEyjkaELqLj7U+oWlcY2XAtXjlfYdqDjWNzAnyGA5fx4ZEj5jTVYKzVgReyBKWd440WriX/UbEY8PSanCkiM+uKbgVvQA5GOdEvrLIbkh9rQRqNXeOVC4Cibs54nEWBT/nSaWzZG+GpTxrdRLZUDNBUc7NrQTC18fzZZj0kyoGy4D5j9nb16SmnGPa4XZGjE9B6AIC9lYVQ8nrVMk3WAu/X8nMBldw0OZvkHO4qrz7m1YaT9ZMvkzezi2wPvLYI0/zugA==;
Received: from 178-55-128-240.bb.dnainternet.fi ([178.55.128.240]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hEacW-00019K-81; Thu, 11 Apr 2019 16:24:04 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hEacH-0001i1-1K; Thu, 11 Apr 2019 17:23:49 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 17:23:45 +0300
Message-Id:
 <f1f5fd6b89d74151dda9dbe758ae9f5f53e744e2.1554992449.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1554992449.git.berto@igalia.com>
References: <cover.1554992449.git.berto@igalia.com>
In-Reply-To: <cover.1554992449.git.berto@igalia.com>
References: <cover.1554992449.git.berto@igalia.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH for-4.1 1/2] block: Fix check for default
 backing files in bdrv_reopen_prepare()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411142345.xlv6bdKsph6_YEBwMvdgMHbmntlUGoYilGLiGh5Wa-g@z>

x-blockdev-reopen requires that the 'backing' parameter is specified
when an image has a backing file attached or when there is a default
backing file in the image metadata.

The latter can be checked by reading bs->auto_backing_file, but
bdrv_reopen_prepare() is using bs->backing_file.

This bug should be detected by iotest 245, but unfortunately the test
expectation is wrong so it must be corrected as well.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reported-by: Max Reitz <mreitz@redhat.com>
---
 block.c                | 3 ++-
 tests/qemu-iotests/245 | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 16615bc876..e496999e2f 100644
--- a/block.c
+++ b/block.c
@@ -3634,7 +3634,8 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
      * its metadata. Otherwise the 'backing' option can be omitted.
      */
     if (drv->supports_backing && reopen_state->backing_missing &&
-        (backing_bs(reopen_state->bs) || reopen_state->bs->backing_file[0])) {
+        (backing_bs(reopen_state->bs) ||
+         reopen_state->bs->auto_backing_file[0])) {
         error_setg(errp, "backing is missing for '%s'",
                    reopen_state->bs->node_name);
         ret = -EINVAL;
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 7891a210c1..9784ca3ced 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -716,7 +716,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
 
         # Detach hd2 from hd0.
         self.reopen(opts, {'backing': None})
-        self.reopen(opts, {}, "backing is missing for 'hd0'")
+        self.reopen(opts)
 
         # Remove both hd0 and hd2
         result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd0')
-- 
2.11.0


