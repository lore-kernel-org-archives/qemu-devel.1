Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B902C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4222086A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsmT2QpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4222086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcjd-00032D-Je
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcex-0004lk-Gy
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcev-0002vD-K2
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590511352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6tpp61MDA8VB4l9tCN713iGLe0RwF9nSSBZ98FZeJlg=;
 b=ZsmT2QpJYmy/dguCNGkoxEgqwW6NHupYwauEalvdUSGDHlPcRaWCx9+z+79MgY9JSgtytu
 +MWAqjHak5Oui4rVP2eIHFj+ChCcf80OOMTaIIp/imYKSfM6PF7sd55wZx+KKYSPh3vjMe
 Jt0wNkTbPlHLH+xEihNG7oI7ynuoxO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-IiGtZ8A4MquxAkewbgW7iA-1; Tue, 26 May 2020 12:42:28 -0400
X-MC-Unique: IiGtZ8A4MquxAkewbgW7iA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8949F18FE861;
 Tue, 26 May 2020 16:42:27 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 179737D975;
 Tue, 26 May 2020 16:42:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] iotests: 194: test also migration of dirty bitmap
Date: Tue, 26 May 2020 11:42:04 -0500
Message-Id: <20200526164211.1569366-5-eblake@redhat.com>
In-Reply-To: <20200526164211.1569366-1-eblake@redhat.com>
References: <20200526164211.1569366-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Test that dirty bitmap migration works when we deal with mirror.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200521220648.3255-5-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/194     | 14 ++++++++++----
 tests/qemu-iotests/194.out |  6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 8b1f720af4d8..3fad7c6c1ab6 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -42,6 +42,8 @@ with iotests.FilePath('source.img') as source_img_path, \
             .add_incoming('unix:{0}'.format(migration_sock_path))
             .launch())

+    source_vm.qmp_log('block-dirty-bitmap-add', node='drive0', name='bitmap0')
+
     iotests.log('Launching NBD server on destination...')
     iotests.log(dest_vm.qmp('nbd-server-start', addr={'type': 'unix', 'data': {'path': nbd_sock_path}}))
     iotests.log(dest_vm.qmp('nbd-server-add', device='drive0', writable=True))
@@ -61,12 +63,14 @@ with iotests.FilePath('source.img') as source_img_path, \
                 filters=[iotests.filter_qmp_event])

     iotests.log('Starting migration...')
-    source_vm.qmp('migrate-set-capabilities',
-                  capabilities=[{'capability': 'events', 'state': True}])
-    dest_vm.qmp('migrate-set-capabilities',
-                capabilities=[{'capability': 'events', 'state': True}])
+    capabilities = [{'capability': 'events', 'state': True},
+                    {'capability': 'dirty-bitmaps', 'state': True}]
+    source_vm.qmp('migrate-set-capabilities', capabilities=capabilities)
+    dest_vm.qmp('migrate-set-capabilities', capabilities=capabilities)
     iotests.log(source_vm.qmp('migrate', uri='unix:{0}'.format(migration_sock_path)))

+    source_vm.qmp_log('migrate-start-postcopy')
+
     while True:
         event1 = source_vm.event_wait('MIGRATION')
         iotests.log(event1, filters=[iotests.filter_qmp_event])
@@ -82,3 +86,5 @@ with iotests.FilePath('source.img') as source_img_path, \
             iotests.log('Stopping the NBD server on destination...')
             iotests.log(dest_vm.qmp('nbd-server-stop'))
             break
+
+    iotests.log(source_vm.qmp('query-block')['return'][0]['dirty-bitmaps'])
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index 71857853fb4d..dd60dcc14f11 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -1,4 +1,6 @@
 Launching VMs...
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
 Launching NBD server on destination...
 {"return": {}}
 {"return": {}}
@@ -8,11 +10,15 @@ Waiting for `drive-mirror` to complete...
 {"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Starting migration...
 {"return": {}}
+{"execute": "migrate-start-postcopy", "arguments": {}}
+{"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Gracefully ending the `drive-mirror` job on source...
 {"return": {}}
 {"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Stopping the NBD server on destination...
 {"return": {}}
+[{"busy": false, "count": 0, "granularity": 65536, "name": "bitmap0", "persistent": false, "recording": true, "status": "active"}]
-- 
2.26.2


