Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0F5C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07B82084D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07B82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMoy-0001zE-52
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 06:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56343)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hbMWT-0007OJ-RM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hbMWO-000644-53
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:59:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47912)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hbMWG-000601-FD
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:59:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89BDC309B15A
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:59:43 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-220.ams2.redhat.com
 [10.36.117.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DE41544EE;
 Thu, 13 Jun 2019 09:59:42 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, jasowang@redhat.com, eblake@redhat.com,
 armbru@redhat.com, laine@redhat.com
Date: Thu, 13 Jun 2019 10:59:24 +0100
Message-Id: <20190613095924.21908-6-dgilbert@redhat.com>
In-Reply-To: <20190613095924.21908-1-dgilbert@redhat.com>
References: <20190613095924.21908-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 13 Jun 2019 09:59:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 5/5] net/announce: Expand test for stopping
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
---
 tests/virtio-net-test.c | 57 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 663cf7ea7e..3b49b431dc 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -184,21 +184,72 @@ static void announce_self(void *obj, void *data, QG=
uestAllocator *t_alloc)
     QDict *rsp;
     int ret;
     uint16_t *proto =3D (uint16_t *)&buffer[12];
+    size_t total_received =3D 0;
+    uint64_t start, now, last_rxt, deadline;
=20
+    /* Send a set of packets over a few second period */
     rsp =3D qmp("{ 'execute' : 'announce-self', "
                   " 'arguments': {"
-                      " 'initial': 50, 'max': 550,"
-                      " 'rounds': 10, 'step': 50 } }");
+                      " 'initial': 20, 'max': 100,"
+                      " 'rounds': 300, 'step': 10, 'id': 'bob' } }");
     assert(!qdict_haskey(rsp, "error"));
     qobject_unref(rsp);
=20
-    /* Catch the packet and make sure it's a RARP */
+    /* Catch the first packet and make sure it's a RARP */
     ret =3D qemu_recv(sv[0], &len, sizeof(len), 0);
     g_assert_cmpint(ret, =3D=3D,  sizeof(len));
     len =3D ntohl(len);
=20
     ret =3D qemu_recv(sv[0], buffer, len, 0);
     g_assert_cmpint(*proto, =3D=3D, htons(ETH_P_RARP));
+
+    /*
+     * Stop the announcment by settings rounds to 0 on the
+     * existing timer.
+     */
+    rsp =3D qmp("{ 'execute' : 'announce-self', "
+                  " 'arguments': {"
+                      " 'initial': 20, 'max': 100,"
+                      " 'rounds': 0, 'step': 10, 'id': 'bob' } }");
+    assert(!qdict_haskey(rsp, "error"));
+    qobject_unref(rsp);
+
+    /* Now make sure the packets stop */
+
+    /* Times are in us */
+    start =3D g_get_monotonic_time();
+    /* 30 packets, max gap 100ms, * 2 for wiggle */
+    deadline =3D start + 1000 * (100 * 30 * 2);
+    last_rxt =3D start;
+
+    do {
+        int saved_err;
+        ret =3D qemu_recv(sv[0], buffer, 60, MSG_DONTWAIT);
+        saved_err =3D errno;
+        now =3D g_get_monotonic_time();
+        g_assert_cmpint(now, <, deadline);
+
+        if (ret >=3D 0) {
+            if (ret) {
+                last_rxt =3D now;
+            }
+            total_received +=3D ret;
+
+            /* Check it's not spewing loads */
+            g_assert_cmpint(total_received, <, 60 * 30 * 2);
+        } else {
+            g_assert_cmpint(saved_err, =3D=3D, EAGAIN);
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
+    } while (true);
 }
=20
 static void virtio_net_test_cleanup(void *sockets)
--=20
2.21.0


