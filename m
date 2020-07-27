Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243ACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15FA20786
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhuIT7Jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15FA20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0AN9-0001q2-6O
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAl-0005lk-Jc
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAj-00050l-Bp
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4YU+2DllB+WRMBKkKdzwQniGyf8W+ZI6W9hF8rTdQIM=;
 b=HhuIT7JpBbgoF0SV0TFbxDL790Wj62ycCVB0L4JP5UH9+MctCOnrl5pGc0voSG7nRtdHj3
 WpmVrpYR5zkaSc12Em49TtPLI5PY003v6g7bPpPl4Fbzj+GFY9wM17W8pkzsfxfRAlcUJU
 b03yvsOBZMOl3lxBsrpFtzGFzIeGm1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-z3Y2Q7ZUMDWmS8rYQyh41g-1; Mon, 27 Jul 2020 16:56:28 -0400
X-MC-Unique: z3Y2Q7ZUMDWmS8rYQyh41g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56B4E80183C;
 Mon, 27 Jul 2020 20:56:27 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7299619C66;
 Mon, 27 Jul 2020 20:56:26 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/24] qemu-iotests/199: prepare for new test-cases addition
Date: Mon, 27 Jul 2020 15:55:38 -0500
Message-Id: <20200727205543.206624-20-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:02:33
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

Move future common part to start_postcopy() method. Move checking
number of bitmaps to check_bitmap().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200727194236.19551-19-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index d8532e49da00..355c0b288592 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -29,6 +29,8 @@ disk_b = os.path.join(iotests.test_dir, 'disk_b')
 size = '256G'
 fifo = os.path.join(iotests.test_dir, 'mig_fifo')

+granularity = 512
+nb_bitmaps = 15

 GiB = 1024 * 1024 * 1024

@@ -61,6 +63,15 @@ def event_dist(e1, e2):
     return event_seconds(e2) - event_seconds(e1)


+def check_bitmaps(vm, count):
+    result = vm.qmp('query-block')
+
+    if count == 0:
+        assert 'dirty-bitmaps' not in result['return'][0]
+    else:
+        assert len(result['return'][0]['dirty-bitmaps']) == count
+
+
 class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
     def tearDown(self):
         if debug:
@@ -101,10 +112,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_a_events = []
         self.vm_b_events = []

-    def test_postcopy(self):
-        granularity = 512
-        nb_bitmaps = 15
-
+    def start_postcopy(self):
+        """ Run migration until RESUME event on target. Return this event. """
         for i in range(nb_bitmaps):
             result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
                                    name='bitmap{}'.format(i),
@@ -119,10 +128,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):

         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap0')
-        discards1_sha256 = result['return']['sha256']
+        self.discards1_sha256 = result['return']['sha256']

         # Check, that updating the bitmap by discards works
-        assert discards1_sha256 != empty_sha256
+        assert self.discards1_sha256 != empty_sha256

         # We want to calculate resulting sha256. Do it in bitmap0, so, disable
         # other bitmaps
@@ -135,7 +144,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):

         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap0')
-        all_discards_sha256 = result['return']['sha256']
+        self.all_discards_sha256 = result['return']['sha256']

         # Now, enable some bitmaps, to be updated during migration
         for i in range(2, nb_bitmaps, 2):
@@ -160,6 +169,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):

         event_resume = self.vm_b.event_wait('RESUME')
         self.vm_b_events.append(event_resume)
+        return event_resume
+
+    def test_postcopy_success(self):
+        event_resume = self.start_postcopy()

         # enabled bitmaps should be updated
         apply_discards(self.vm_b, discards2)
@@ -180,18 +193,15 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
             print('downtime:', downtime)
             print('postcopy_time:', postcopy_time)

-        # Assert that bitmap migration is finished (check that successor bitmap
-        # is removed)
-        result = self.vm_b.qmp('query-block')
-        assert len(result['return'][0]['dirty-bitmaps']) == nb_bitmaps
+        check_bitmaps(self.vm_b, nb_bitmaps)

         # Check content of migrated bitmaps. Still, don't waste time checking
         # every bitmap
         for i in range(0, nb_bitmaps, 5):
             result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
                                    node='drive0', name='bitmap{}'.format(i))
-            sha256 = discards1_sha256 if i % 2 else all_discards_sha256
-            self.assert_qmp(result, 'return/sha256', sha256)
+            sha = self.discards1_sha256 if i % 2 else self.all_discards_sha256
+            self.assert_qmp(result, 'return/sha256', sha)


 if __name__ == '__main__':
-- 
2.27.0


