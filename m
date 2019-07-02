Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2823AC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E7821479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E7821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiAHp-0006WK-8h
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50515)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi8aP-00054S-IC
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi8aO-0003ir-Dt
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46567)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi8aO-0003iO-4Z
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:32:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7154E307D853;
 Tue,  2 Jul 2019 02:31:59 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-232.pek2.redhat.com
 [10.72.12.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1ECC60C43;
 Tue,  2 Jul 2019 02:31:57 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 10:31:24 +0800
Message-Id: <1562034689-6539-13-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 02 Jul 2019 02:31:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/17] net/announce: Expand test for stopping
 self announce
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
Cc: Jason Wang <jasowang@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Expand self-announce test to check we can stop an announce timer.
We set it up to send 300 packets, but after we receive
the first one we tell it to stop.

We error if:
   a) We receive more than 30 of the packets
   b) We're still receiving packets after a lot longer than the
      30 seconds should have arrived

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tests/virtio-net-test.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 663cf7e..7aa9622 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -184,21 +184,72 @@ static void announce_self(void *obj, void *data, QGuestAllocator *t_alloc)
     QDict *rsp;
     int ret;
     uint16_t *proto = (uint16_t *)&buffer[12];
+    size_t total_received = 0;
+    uint64_t start, now, last_rxt, deadline;
 
+    /* Send a set of packets over a few second period */
     rsp = qmp("{ 'execute' : 'announce-self', "
                   " 'arguments': {"
-                      " 'initial': 50, 'max': 550,"
-                      " 'rounds': 10, 'step': 50 } }");
+                      " 'initial': 20, 'max': 100,"
+                      " 'rounds': 300, 'step': 10, 'id': 'bob' } }");
     assert(!qdict_haskey(rsp, "error"));
     qobject_unref(rsp);
 
-    /* Catch the packet and make sure it's a RARP */
+    /* Catch the first packet and make sure it's a RARP */
     ret = qemu_recv(sv[0], &len, sizeof(len), 0);
     g_assert_cmpint(ret, ==,  sizeof(len));
     len = ntohl(len);
 
     ret = qemu_recv(sv[0], buffer, len, 0);
     g_assert_cmpint(*proto, ==, htons(ETH_P_RARP));
+
+    /*
+     * Stop the announcment by settings rounds to 0 on the
+     * existing timer.
+     */
+    rsp = qmp("{ 'execute' : 'announce-self', "
+                  " 'arguments': {"
+                      " 'initial': 20, 'max': 100,"
+                      " 'rounds': 0, 'step': 10, 'id': 'bob' } }");
+    assert(!qdict_haskey(rsp, "error"));
+    qobject_unref(rsp);
+
+    /* Now make sure the packets stop */
+
+    /* Times are in us */
+    start = g_get_monotonic_time();
+    /* 30 packets, max gap 100ms, * 4 for wiggle */
+    deadline = start + 1000 * (100 * 30 * 4);
+    last_rxt = start;
+
+    while (true) {
+        int saved_err;
+        ret = qemu_recv(sv[0], buffer, 60, MSG_DONTWAIT);
+        saved_err = errno;
+        now = g_get_monotonic_time();
+        g_assert_cmpint(now, <, deadline);
+
+        if (ret >= 0) {
+            if (ret) {
+                last_rxt = now;
+            }
+            total_received += ret;
+
+            /* Check it's not spewing loads */
+            g_assert_cmpint(total_received, <, 60 * 30 * 2);
+        } else {
+            g_assert_cmpint(saved_err, ==, EAGAIN);
+
+            /* 400ms, i.e. 4 worst case gaps */
+            if ((now - last_rxt) > (1000 * 100 * 4)) {
+                /* Nothings arrived for a while - must have stopped */
+                break;
+            };
+
+            /* 100ms */
+            g_usleep(1000 * 100);
+        }
+    };
 }
 
 static void virtio_net_test_cleanup(void *sockets)
-- 
2.5.0


