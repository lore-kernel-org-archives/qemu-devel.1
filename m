Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D03C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B8E2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B8E2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylsi-0003MM-IO
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylQ4-00078l-Jx
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylQ2-0006OP-OC
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:14:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPz-0006J4-5h; Fri, 16 Aug 2019 19:13:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D6C57CA1FE;
 Fri, 16 Aug 2019 23:13:55 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 311CB19C6A;
 Fri, 16 Aug 2019 23:13:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:13:18 -0400
Message-Id: <20190816231318.8650-37-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 16 Aug 2019 23:13:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 36/36] tests/test-hbitmap: test next_zero and
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
Cc: peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, jsnow@redhat.com,
 qemu-stable@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Test that hbitmap_next_zero and hbitmap_next_dirty_area can find things
after old bitmap end.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190805164652.42409-1-vsementsov@virtuozzo.com
Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/test-hbitmap.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 592d8219db2..eed5d288cbc 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -1004,6 +1004,15 @@ static void test_hbitmap_next_zero_4(TestHBitmapDa=
ta *data, const void *unused)
     test_hbitmap_next_zero_do(data, 4);
 }
=20
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
@@ -1104,6 +1113,15 @@ static void test_hbitmap_next_dirty_area_4(TestHBi=
tmapData *data,
     test_hbitmap_next_dirty_area_do(data, 4);
 }
=20
+static void test_hbitmap_next_dirty_area_after_truncate(TestHBitmapData =
*data,
+                                                        const void *unus=
ed)
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
=20
     hbitmap_test_add("/hbitmap/next_dirty_area/next_dirty_area_0",
                      test_hbitmap_next_dirty_area_0);
@@ -1176,6 +1196,8 @@ int main(int argc, char **argv)
                      test_hbitmap_next_dirty_area_1);
     hbitmap_test_add("/hbitmap/next_dirty_area/next_dirty_area_4",
                      test_hbitmap_next_dirty_area_4);
+    hbitmap_test_add("/hbitmap/next_dirty_area/next_dirty_area_after_tru=
ncate",
+                     test_hbitmap_next_dirty_area_after_truncate);
=20
     g_test_run();
=20
--=20
2.21.0


