Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DB7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8E020855
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZF0zr6i4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8E020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GJL-0000jx-Vj
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G97-0005AG-38
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:32:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30877
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G94-0001dz-KJ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C8SgDTwlgkg5p1J3JQ9ls3CbSfFYP8z+m2nDCnM2oXk=;
 b=ZF0zr6i4hBSMsfQAEpEwnXf8BJb8NQ61XlxydvVf1SfMRwbedeTarZ2naSQ5Bl/BFnELjr
 maoqTL5kuP46E4zdLifttsbK37Gy9ObYa7ve/pBvF5oqwVFUDQHUx+jXQqkVXTxWV1zoHR
 m+Qh0mTT+14KZyK34lNWRClZ4fzaPrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-Hnwv18d_PL-Sex7cEPoggQ-1; Thu, 13 Aug 2020 12:30:00 -0400
X-MC-Unique: Hnwv18d_PL-Sex7cEPoggQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2EC0800050;
 Thu, 13 Aug 2020 16:29:59 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8460C5C1A3;
 Thu, 13 Aug 2020 16:29:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 09/22] nbd: Add writethrough to block-export-add
Date: Thu, 13 Aug 2020 18:29:22 +0200
Message-Id: <20200813162935.210070-10-kwolf@redhat.com>
In-Reply-To: <20200813162935.210070-1-kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:44:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-nbd allows use of writethrough cache modes, which mean that write
requests made through NBD will cause a flush before they complete.
Expose the same functionality in block-export-add.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json | 7 ++++++-
 blockdev-nbd.c         | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 1fdc55c53a..4ce163411f 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -167,10 +167,15 @@
 # Describes a block export, i.e. how single node should be exported on an
 # external interface.
 #
+# @writethrough: If true, caches are flushed after every write request to the
+#                export before completion is signalled. (since: 5.2;
+#                default: false)
+#
 # Since: 4.2
 ##
 { 'union': 'BlockExportOptions',
-  'base': { 'type': 'BlockExportType' },
+  'base': { 'type': 'BlockExportType',
+            '*writethrough': 'bool' },
   'discriminator': 'type',
   'data': {
       'nbd': 'BlockExportOptionsNbd'
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 28159a92b2..17417c1b6b 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -218,7 +218,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
 
     exp = nbd_export_new(bs, arg->name, arg->description, arg->bitmap,
                          !arg->writable, !arg->writable,
-                         NULL, false, errp);
+                         NULL, exp_args->writethrough, errp);
     if (!exp) {
         goto out;
     }
-- 
2.25.4


