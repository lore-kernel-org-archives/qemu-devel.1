Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3669EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E6D20809
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3bChZA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E6D20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ADt-0002L9-8a
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAK-0005DT-3x
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34776
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAI-0004uq-1q
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cA9n+9vu4RgRBMfOB0BWmNw9KgmpftfRQAnntZebbp8=;
 b=O3bChZA04s3hqNhXKcpzDWE/VhCXfBUP5fQYs2bVAJeP863pychiY+lMLRdQWGNt4uK7Sp
 ugHFW+/fm1SV6W1fjtFbk4cGN77fjKmQYHVlqoheeJByVza063XRawpXXSU2DzTNWSkKRL
 r0b6N3FEMjHG31Ex0TbdtDh6Zv1Ryc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-sT8M28lkPWyJpMFtz0h3Qg-1; Mon, 27 Jul 2020 16:56:01 -0400
X-MC-Unique: sT8M28lkPWyJpMFtz0h3Qg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2934101C8A0;
 Mon, 27 Jul 2020 20:55:59 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D6ED19945;
 Mon, 27 Jul 2020 20:55:59 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/24] qemu-iotests/199: increase postcopy period
Date: Mon, 27 Jul 2020 15:55:26 -0500
Message-Id: <20200727205543.206624-8-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

The test wants to force a bitmap postcopy. Still, the resulting
postcopy period is very small. Let's increase it by adding more
bitmaps to migrate. Also, test disabled bitmaps migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200727194236.19551-7-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 66 +++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index da4dae01fb5d..d8532e49da00 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -103,30 +103,46 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):

     def test_postcopy(self):
         granularity = 512
+        nb_bitmaps = 15

-        result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
-                               name='bitmap', granularity=granularity)
-        self.assert_qmp(result, 'return', {})
+        for i in range(nb_bitmaps):
+            result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
+                                   name='bitmap{}'.format(i),
+                                   granularity=granularity)
+            self.assert_qmp(result, 'return', {})

         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
-                               node='drive0', name='bitmap')
+                               node='drive0', name='bitmap0')
         empty_sha256 = result['return']['sha256']

-        apply_discards(self.vm_a, discards1 + discards2)
-
-        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
-                               node='drive0', name='bitmap')
-        sha256 = result['return']['sha256']
-
-        # Check, that updating the bitmap by discards works
-        assert sha256 != empty_sha256
-
-        result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
-                               name='bitmap')
-        self.assert_qmp(result, 'return', {})
-
         apply_discards(self.vm_a, discards1)

+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap0')
+        discards1_sha256 = result['return']['sha256']
+
+        # Check, that updating the bitmap by discards works
+        assert discards1_sha256 != empty_sha256
+
+        # We want to calculate resulting sha256. Do it in bitmap0, so, disable
+        # other bitmaps
+        for i in range(1, nb_bitmaps):
+            result = self.vm_a.qmp('block-dirty-bitmap-disable', node='drive0',
+                                   name='bitmap{}'.format(i))
+            self.assert_qmp(result, 'return', {})
+
+        apply_discards(self.vm_a, discards2)
+
+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap0')
+        all_discards_sha256 = result['return']['sha256']
+
+        # Now, enable some bitmaps, to be updated during migration
+        for i in range(2, nb_bitmaps, 2):
+            result = self.vm_a.qmp('block-dirty-bitmap-enable', node='drive0',
+                                   name='bitmap{}'.format(i))
+            self.assert_qmp(result, 'return', {})
+
         caps = [{'capability': 'dirty-bitmaps', 'state': True},
                 {'capability': 'events', 'state': True}]

@@ -145,6 +161,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         event_resume = self.vm_b.event_wait('RESUME')
         self.vm_b_events.append(event_resume)

+        # enabled bitmaps should be updated
         apply_discards(self.vm_b, discards2)

         match = {'data': {'status': 'completed'}}
@@ -158,7 +175,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         downtime = event_dist(event_stop, event_resume)
         postcopy_time = event_dist(event_resume, event_complete)

-        # TODO: assert downtime * 10 < postcopy_time
+        assert downtime * 10 < postcopy_time
         if debug:
             print('downtime:', downtime)
             print('postcopy_time:', postcopy_time)
@@ -166,12 +183,15 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         # Assert that bitmap migration is finished (check that successor bitmap
         # is removed)
         result = self.vm_b.qmp('query-block')
-        assert len(result['return'][0]['dirty-bitmaps']) == 1
+        assert len(result['return'][0]['dirty-bitmaps']) == nb_bitmaps

-        # Check content of migrated (and updated by new writes) bitmap
-        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
-                               node='drive0', name='bitmap')
-        self.assert_qmp(result, 'return/sha256', sha256)
+        # Check content of migrated bitmaps. Still, don't waste time checking
+        # every bitmap
+        for i in range(0, nb_bitmaps, 5):
+            result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
+                                   node='drive0', name='bitmap{}'.format(i))
+            sha256 = discards1_sha256 if i % 2 else all_discards_sha256
+            self.assert_qmp(result, 'return/sha256', sha256)


 if __name__ == '__main__':
-- 
2.27.0


