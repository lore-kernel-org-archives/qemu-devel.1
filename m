Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C922C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B2920732
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwyP9k+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B2920732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLoO-00035v-P9
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLl3-00058s-OV
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:20:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50151
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLkv-0004TG-Cz
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599502840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AV8bXAdMx6PvyzbjTr/wYn6AWfCEHVu0zQN+vxPbZpc=;
 b=SwyP9k+N6niznbLV5mfSmx4B6k7DBTgnlgDInLM9Y7BpjZ2I5F5fgo48g2fmz1ypYE5eOR
 Zin9HarDt5P8Oju35PMSMLEfIQVfRYh2k0Kd3NStgMBTjE/tsyP49NkwZFg1C3UlowTWaV
 VyY/1a85Qk6f9QIWSj3TGK72kHdUXdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-TgYwco_8MNutQOUyJ-bk0w-1; Mon, 07 Sep 2020 14:20:38 -0400
X-MC-Unique: TgYwco_8MNutQOUyJ-bk0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B01E18B9EC1;
 Mon,  7 Sep 2020 18:20:37 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6131E60BF3;
 Mon,  7 Sep 2020 18:20:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 09/29] nbd: Add writethrough to block-export-add
Date: Mon,  7 Sep 2020 20:19:51 +0200
Message-Id: <20200907182011.521007-10-kwolf@redhat.com>
In-Reply-To: <20200907182011.521007-1-kwolf@redhat.com>
References: <20200907182011.521007-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:19:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 blockdev-nbd.c         | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 7dedd893ab..d95c082a33 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -170,10 +170,15 @@
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
index 41d5542987..09247a8ded 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -216,9 +216,13 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
         goto out;
     }
 
+    if (!exp_args->has_writethrough) {
+        exp_args->writethrough = false;
+    }
+
     exp = nbd_export_new(bs, arg->name, arg->description, arg->bitmap,
                          !arg->writable, !arg->writable,
-                         NULL, false, errp);
+                         NULL, exp_args->writethrough, errp);
     if (!exp) {
         goto out;
     }
-- 
2.25.4


