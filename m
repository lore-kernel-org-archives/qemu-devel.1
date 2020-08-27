Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59478C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CB622B40
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzQQCeC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CB622B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBFu0-0005I5-F9
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBFtG-0004AK-J4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:16:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34877
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBFtE-0000mg-60
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598526978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UaJ9FIRlEa+ZpnwXZCF1dherHLU9UGuonkm1N6ye2K4=;
 b=RzQQCeC9uzvYaJ0C2oISUv+f7IOwVLQXo0rndnyi3Uo3qWRZ/E1oOqUvYRwyrmBU1I2kq9
 NK9C+L0m3r6zSRPmiFfrfYNVi45UyJ0vEyytwsZEBm/7EtiMtd07ewl3f3t9Rr0VRGH4KV
 HARhvD90ArgKaYdcSjdR2AjpZBGPdPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188--gy-qDtkMjawdd6OoXjbHg-1; Thu, 27 Aug 2020 07:16:16 -0400
X-MC-Unique: -gy-qDtkMjawdd6OoXjbHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD87A185FD78;
 Thu, 27 Aug 2020 11:16:15 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5981378370;
 Thu, 27 Aug 2020 11:16:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/7] migration: improve error reporting of block driver
 state name
Date: Thu, 27 Aug 2020 12:16:00 +0100
Message-Id: <20200827111606.1408275-2-berrange@redhat.com>
In-Reply-To: <20200827111606.1408275-1-berrange@redhat.com>
References: <20200827111606.1408275-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With blockdev, a BlockDriverState may not have a device name,
so using a node name is required as an alternative.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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


