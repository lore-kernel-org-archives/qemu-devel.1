Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2498C433EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A052070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1iVpES4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A052070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0AKB-00057t-OG
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAk-0005kM-U8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAi-00050W-PO
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0SsZalrTNJQpz+pmftCyRtrAIMx1wRHI8kl7yGvixY=;
 b=R1iVpES4/dA4iaVFHamkTWPcs0rjsvMhXOI6YSGTr5n5GDdu6bKWnN8npe0nxsIk0VgXft
 a/8gJYYPrsSKaHQK27lUwz+34z1gneQZkO2eiYCa9mwVrUIDnQCW8c+jW1hWWT8TFZYrf1
 CqM6v/P55iZYnrlwqt7Qt4JVDluwB2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-uOGbgQnnOkCJ2khiIWhinw-1; Mon, 27 Jul 2020 16:56:29 -0400
X-MC-Unique: uOGbgQnnOkCJ2khiIWhinw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D764186A822;
 Mon, 27 Jul 2020 20:56:28 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99CC319C66;
 Mon, 27 Jul 2020 20:56:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/24] qemu-iotests/199: check persistent bitmaps
Date: Mon, 27 Jul 2020 15:55:39 -0500
Message-Id: <20200727205543.206624-21-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Check that persistent bitmaps are not stored on source and that bitmaps
are persistent on destination.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200727194236.19551-20-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index 355c0b288592..5fd34f0fcdfa 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -117,7 +117,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         for i in range(nb_bitmaps):
             result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
                                    name='bitmap{}'.format(i),
-                                   granularity=granularity)
+                                   granularity=granularity,
+                                   persistent=True)
             self.assert_qmp(result, 'return', {})

         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
@@ -193,6 +194,19 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
             print('downtime:', downtime)
             print('postcopy_time:', postcopy_time)

+        # check that there are no bitmaps stored on source
+        self.vm_a_events += self.vm_a.get_qmp_events()
+        self.vm_a.shutdown()
+        self.vm_a.launch()
+        check_bitmaps(self.vm_a, 0)
+
+        # check that bitmaps are migrated and persistence works
+        check_bitmaps(self.vm_b, nb_bitmaps)
+        self.vm_b.shutdown()
+        # recreate vm_b, so there is no incoming option, which prevents
+        # loading bitmaps from disk
+        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b)
+        self.vm_b.launch()
         check_bitmaps(self.vm_b, nb_bitmaps)

         # Check content of migrated bitmaps. Still, don't waste time checking
-- 
2.27.0


