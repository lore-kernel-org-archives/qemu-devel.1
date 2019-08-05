Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987A0C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA7C206A2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA7C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hug9H-0000J4-Hn
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39428)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hug8R-0008F2-Ga
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hug8Q-0002vB-Fp
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:46:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:34300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hug8O-0002tb-8O; Mon, 05 Aug 2019 12:46:56 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hug8L-0008WR-4G; Mon, 05 Aug 2019 19:46:53 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon,  5 Aug 2019 19:46:52 +0300
Message-Id: <20190805164652.42409-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH] tests/test-hbitmap: test next_zero and
 _next_dirty_area after truncate
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test that hbitmap_next_zero and hbitmap_next_dirty_area can find things
after old bitmap end.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

It's a follow-up for 

    [PATCH for-4.1] util/hbitmap: update orig_size on truncate

 tests/test-hbitmap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 592d8219db..eed5d288cb 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -1004,6 +1004,15 @@ static void test_hbitmap_next_zero_4(TestHBitmapData *data, const void *unused)
     test_hbitmap_next_zero_do(data, 4);
 }
 
+static void test_hbitmap_next_zero_after_truncate(TestHBitmapData *data,
+                                                  const void *unused)
+{
+    hbitmap_test_init(data, L1, 0);
+    hbitmap_test_truncate_impl(data, L1 * 2);
+    hbitmap_set(data->hb, 0, L1);
+    test_hbitmap_next_zero_check(data, 0);
+}
+
 static void test_hbitmap_next_dirty_area_check(TestHBitmapData *data,
                                                uint64_t offset,
                                                uint64_t count)
@@ -1104,6 +1113,15 @@ static void test_hbitmap_next_dirty_area_4(TestHBitmapData *data,
     test_hbitmap_next_dirty_area_do(data, 4);
 }
 
+static void test_hbitmap_next_dirty_area_after_truncate(TestHBitmapData *data,
+                                                        const void *unused)
+{
+    hbitmap_test_init(data, L1, 0);
+    hbitmap_test_truncate_impl(data, L1 * 2);
+    hbitmap_set(data->hb, L1 + 1, 1);
+    test_hbitmap_next_dirty_area_check(data, 0, UINT64_MAX);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -1169,6 +1187,8 @@ int main(int argc, char **argv)
                      test_hbitmap_next_zero_0);
     hbitmap_test_add("/hbitmap/next_zero/next_zero_4",
                      test_hbitmap_next_zero_4);
+    hbitmap_test_add("/hbitmap/next_zero/next_zero_after_truncate",
+                     test_hbitmap_next_zero_after_truncate);
 
     hbitmap_test_add("/hbitmap/next_dirty_area/next_dirty_area_0",
                      test_hbitmap_next_dirty_area_0);
@@ -1176,6 +1196,8 @@ int main(int argc, char **argv)
                      test_hbitmap_next_dirty_area_1);
     hbitmap_test_add("/hbitmap/next_dirty_area/next_dirty_area_4",
                      test_hbitmap_next_dirty_area_4);
+    hbitmap_test_add("/hbitmap/next_dirty_area/next_dirty_area_after_truncate",
+                     test_hbitmap_next_dirty_area_after_truncate);
 
     g_test_run();
 
-- 
2.18.0


