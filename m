Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC80C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 01:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AFA42072F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 01:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdkFwQYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFA42072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jipOE-0003Y4-II
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 21:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jipMq-0001gp-Bo
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 21:17:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54282
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jipMo-000335-5B
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 21:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591751840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vjv8KqL88MELOQhMPbFrgWtPvuZ6GUJ1qKYsIWH3Ps=;
 b=FdkFwQYY6dblWNOefbNrmpqIBT7kOAUBPq+C/1D9ihrzPVXrnbGEyPOnOSL7Z0TrytSqkh
 u/bq/WhD1SmhJyr2VUNuyv9M0LwTEhfY9YIpTiZQf7kVlAprbPLYRwYWjWAo2QWYS+hdQZ
 KABd4KxJHHUc0fJs3nQyEl824mj814c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-wmoRCw1kNvSShltqgT1kzQ-1; Tue, 09 Jun 2020 21:17:18 -0400
X-MC-Unique: wmoRCw1kNvSShltqgT1kzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99BAE2E93;
 Wed, 10 Jun 2020 01:17:17 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A97A5C1BD;
 Wed, 10 Jun 2020 01:17:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] iotests: 194: wait for migration completion on target too
Date: Tue,  9 Jun 2020 20:17:11 -0500
Message-Id: <20200610011713.3687895-2-eblake@redhat.com>
In-Reply-To: <20200610011713.3687895-1-eblake@redhat.com>
References: <20200610011713.3687895-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

It is possible, that shutdown on target occurs earlier than migration
finish. In this case we crash in bdrv_release_dirty_bitmap_locked()
on assertion "assert(!bdrv_dirty_bitmap_busy(bitmap));" as we do have
busy bitmap, as bitmap migration is ongoing.

We'll fix bitmap migration to gracefully cancel on early shutdown soon.
Now let's fix iotest 194 to wait migration completion before shutdown.

Note that in this test dest_vm.shutdown() is called implicitly, as vms
used as context-providers, see __exit__() method of QEMUMachine class.

Actually, not waiting migration finish is a wrong thing, but the test
started to crash after commit ae00aa239847682
"iotests: 194: test also migration of dirty bitmap", which added dirty
bitmaps here. So, Fixes: tag won't hurt.

Fixes: ae00aa2398476824f0eca80461da215e7cdc1c3b
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: grammar tweak]
Message-Id: <20200604083341.26978-1-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/194     | 10 ++++++++++
 tests/qemu-iotests/194.out |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 3fad7c6c1ab6..da7c4265ecb2 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -87,4 +87,14 @@ with iotests.FilePath('source.img') as source_img_path, \
             iotests.log(dest_vm.qmp('nbd-server-stop'))
             break

+    iotests.log('Wait for migration completion on target...')
+    migr_events = (('MIGRATION', {'data': {'status': 'completed'}}),
+                   ('MIGRATION', {'data': {'status': 'failed'}}))
+    event = dest_vm.events_wait(migr_events)
+    iotests.log(event, filters=[iotests.filter_qmp_event])
+
+    iotests.log('Check bitmaps on source:')
     iotests.log(source_vm.qmp('query-block')['return'][0]['dirty-bitmaps'])
+
+    iotests.log('Check bitmaps on target:')
+    iotests.log(dest_vm.qmp('query-block')['return'][0]['dirty-bitmaps'])
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index dd60dcc14f11..a51bdb2d4fc9 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -21,4 +21,9 @@ Gracefully ending the `drive-mirror` job on source...
 {"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Stopping the NBD server on destination...
 {"return": {}}
+Wait for migration completion on target...
+{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Check bitmaps on source:
+[{"busy": false, "count": 0, "granularity": 65536, "name": "bitmap0", "persistent": false, "recording": true, "status": "active"}]
+Check bitmaps on target:
 [{"busy": false, "count": 0, "granularity": 65536, "name": "bitmap0", "persistent": false, "recording": true, "status": "active"}]
-- 
2.27.0


