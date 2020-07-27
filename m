Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF94C433F1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A544520809
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tig4AZJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A544520809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ADe-00020j-PD
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAE-00050s-QQ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAD-0004sd-5P
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c88SJ1ynOV3k49UvCPQbS7iGEmD+ITDXGccJB9WpNSQ=;
 b=Tig4AZJ1kvZClzoZfdRCg7kTgsRf4a6Cf725/OIpetg9C1tWv+U4z3yFV0buWd9lMUaaqx
 qFx4AcCTZ+KP9MOioUM2//Q3LKNafCzv+BrAinitXtt+zDF1un0TW76iVbEATlhpcnuScB
 hiiC7A0FXm35wK0GQaI5niq3qOqwAuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-crgLTz4DNI-hhyJ0GgrmVA-1; Mon, 27 Jul 2020 16:55:56 -0400
X-MC-Unique: crgLTz4DNI-hhyJ0GgrmVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0236F8015F7;
 Mon, 27 Jul 2020 20:55:55 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EFC719945;
 Mon, 27 Jul 2020 20:55:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/24] qemu-iotests/199: improve performance: set bitmap by
 discard
Date: Mon, 27 Jul 2020 15:55:24 -0500
Message-Id: <20200727205543.206624-6-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Discard dirties dirty-bitmap as well as write, but works faster. Let's
use it instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200727194236.19551-5-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index dd6044768c76..190e820b8408 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -67,8 +67,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         os.mkfifo(fifo)
         qemu_img('create', '-f', iotests.imgfmt, disk_a, size)
         qemu_img('create', '-f', iotests.imgfmt, disk_b, size)
-        self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a)
-        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b)
+        self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a,
+                                                          'discard=unmap')
+        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b,
+                                                          'discard=unmap')
         self.vm_b.add_incoming("exec: cat '" + fifo + "'")
         self.vm_a.launch()
         self.vm_b.launch()
@@ -78,7 +80,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_b_events = []

     def test_postcopy(self):
-        write_size = 0x40000000
+        discard_size = 0x40000000
         granularity = 512
         chunk = 4096

@@ -86,25 +88,32 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
                                name='bitmap', granularity=granularity)
         self.assert_qmp(result, 'return', {})

+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap')
+        empty_sha256 = result['return']['sha256']
+
         s = 0
-        while s < write_size:
-            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
+        while s < discard_size:
+            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
             s += 0x10000
         s = 0x8000
-        while s < write_size:
-            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
+        while s < discard_size:
+            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
             s += 0x10000

         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap')
         sha256 = result['return']['sha256']

+        # Check, that updating the bitmap by discards works
+        assert sha256 != empty_sha256
+
         result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
                                name='bitmap')
         self.assert_qmp(result, 'return', {})
         s = 0
-        while s < write_size:
-            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
+        while s < discard_size:
+            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
             s += 0x10000

         caps = [{'capability': 'dirty-bitmaps', 'state': True},
@@ -126,8 +135,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_b_events.append(event_resume)

         s = 0x8000
-        while s < write_size:
-            self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
+        while s < discard_size:
+            self.vm_b.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
             s += 0x10000

         match = {'data': {'status': 'completed'}}
-- 
2.27.0


