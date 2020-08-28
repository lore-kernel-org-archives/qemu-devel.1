Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1209C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7B120872
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfWPNM3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7B120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBdmH-0000OD-PL
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 08:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBdl3-0007AS-Ot
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:45:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28963
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kBdl1-0006G2-QQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598618726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzLBrjmc2gvzMbHC8xI5ss3GtnAalCmrC5gAURzAcMw=;
 b=GfWPNM3NZ354cpm2H04eTWnfCDFGj62NonmafYRkn1mUNgbW8CB/GPeWc7yoCJzADSxfG2
 L+sGBLHOc7ysL+MaumSd9ZM/FFoJodKB35JbKG8MNiMVFc0EvifR+HEnPWBHD0ciK71rga
 Ut0TkxcYoniYRjqqwjdfEY9MtJ3z+fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-eFvQ-yKBPEeLsuO3b5NbCg-1; Fri, 28 Aug 2020 08:45:24 -0400
X-MC-Unique: eFvQ-yKBPEeLsuO3b5NbCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9E4E189E61A;
 Fri, 28 Aug 2020 12:45:23 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-100.ams2.redhat.com
 [10.36.114.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4732974E12;
 Fri, 28 Aug 2020 12:45:22 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 slp@redhat.com, yezhenyu2@huawei.com, longpeng2@huawei.com,
 berrange@redhat.com
Subject: [PULL 3/8] migration: improve error reporting of block driver state
 name
Date: Fri, 28 Aug 2020 13:45:04 +0100
Message-Id: <20200828124509.311210-4-dgilbert@redhat.com>
In-Reply-To: <20200828124509.311210-1-dgilbert@redhat.com>
References: <20200828124509.311210-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 01:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

With blockdev, a BlockDriverState may not have a device name,
so using a node name is required as an alternative.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200827111606.1408275-2-berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c         | 12 ++++++------
 tests/qemu-iotests/267.out |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index a843d202b5..304d98ff78 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2682,7 +2682,7 @@ int save_snapshot(const char *name, Error **errp)
 
     if (!bdrv_all_can_snapshot(&bs)) {
         error_setg(errp, "Device '%s' is writable but does not support "
-                   "snapshots", bdrv_get_device_name(bs));
+                   "snapshots", bdrv_get_device_or_node_name(bs));
         return ret;
     }
 
@@ -2691,7 +2691,7 @@ int save_snapshot(const char *name, Error **errp)
         ret = bdrv_all_delete_snapshot(name, &bs1, errp);
         if (ret < 0) {
             error_prepend(errp, "Error while deleting snapshot on device "
-                          "'%s': ", bdrv_get_device_name(bs1));
+                          "'%s': ", bdrv_get_device_or_node_name(bs1));
             return ret;
         }
     }
@@ -2766,7 +2766,7 @@ int save_snapshot(const char *name, Error **errp)
     ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
     if (ret < 0) {
         error_setg(errp, "Error while creating snapshot on '%s'",
-                   bdrv_get_device_name(bs));
+                   bdrv_get_device_or_node_name(bs));
         goto the_end;
     }
 
@@ -2884,14 +2884,14 @@ int load_snapshot(const char *name, Error **errp)
     if (!bdrv_all_can_snapshot(&bs)) {
         error_setg(errp,
                    "Device '%s' is writable but does not support snapshots",
-                   bdrv_get_device_name(bs));
+                   bdrv_get_device_or_node_name(bs));
         return -ENOTSUP;
     }
     ret = bdrv_all_find_snapshot(name, &bs);
     if (ret < 0) {
         error_setg(errp,
                    "Device '%s' does not have the requested snapshot '%s'",
-                   bdrv_get_device_name(bs), name);
+                   bdrv_get_device_or_node_name(bs), name);
         return ret;
     }
 
@@ -2920,7 +2920,7 @@ int load_snapshot(const char *name, Error **errp)
     ret = bdrv_all_goto_snapshot(name, &bs, errp);
     if (ret < 0) {
         error_prepend(errp, "Could not load snapshot '%s' on '%s': ",
-                      name, bdrv_get_device_name(bs));
+                      name, bdrv_get_device_or_node_name(bs));
         goto err_drain;
     }
 
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index d6d80c099f..215902b3ad 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -81,11 +81,11 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
-Error: Device '' is writable but does not support snapshots
+Error: Device 'file' is writable but does not support snapshots
 (qemu) info snapshots
 No available block device supports snapshots
 (qemu) loadvm snap0
-Error: Device '' is writable but does not support snapshots
+Error: Device 'file' is writable but does not support snapshots
 (qemu) quit
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-- 
2.26.2


