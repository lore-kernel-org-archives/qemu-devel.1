Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA84C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C069B2220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRMnIQFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C069B2220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTPn-0002Vx-Lg
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTA4-000148-80
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:27:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTA0-0005Ph-7Y
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nxszKmM5Wy90ybQ5MKZ2Nz488MiNpD4pG4FzUCVCeQ8=;
 b=SRMnIQFguudLM2KXZGfCU2eB3J7hvItg8OLgJyT1Uw8Rtd4nCYAcmZOb3cKxJcEAq8eE/I
 OTJ1WlLBzSCVIQBzl60u1IURo2D2d8dwoKZjnMSPPQ/OOP0dGg06Maoq3G6NCIeDPO4M4B
 OJ6WC4hylNBZ1wrOMqQctFGoLOedmxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-5aMXD0-mN8q0S7zy4ImcFA-1; Thu, 24 Sep 2020 11:27:49 -0400
X-MC-Unique: 5aMXD0-mN8q0S7zy4ImcFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 761CB871805;
 Thu, 24 Sep 2020 15:27:48 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DB8860C04;
 Thu, 24 Sep 2020 15:27:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 09/31] nbd: Add writethrough to block-export-add
Date: Thu, 24 Sep 2020 17:26:55 +0200
Message-Id: <20200924152717.287415-10-kwolf@redhat.com>
In-Reply-To: <20200924152717.287415-1-kwolf@redhat.com>
References: <20200924152717.287415-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-nbd allows use of writethrough cache modes, which mean that write
requests made through NBD will cause a flush before they complete.
Expose the same functionality in block-export-add.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-export.json | 7 ++++++-
 blockdev-nbd.c         | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 60474bfacd..319a38be88 100644
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


