Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CB3C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 19:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA612083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 19:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA612083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52422 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he2kl-0002Tq-JG
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 15:29:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49926)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1he26x-0003qr-NA
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1he26v-0001TO-Ge
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:48:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57626)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1he26v-0008Kd-8X
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:48:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95978C18B2C8
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:47:19 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-203.ams2.redhat.com
 [10.36.117.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66CCC5B683;
 Thu, 20 Jun 2019 18:47:18 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, jasowang@redhat.com, eblake@redhat.com,
 armbru@redhat.com, laine@redhat.com
Date: Thu, 20 Jun 2019 19:47:06 +0100
Message-Id: <20190620184706.19988-6-dgilbert@redhat.com>
In-Reply-To: <20190620184706.19988-1-dgilbert@redhat.com>
References: <20190620184706.19988-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 20 Jun 2019 18:47:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 5/5] net/announce: Expand test for stopping
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
index 663cf7ea7e..7aa9622f30 100644
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
+    /* 30 packets, max gap 100ms, * 4 for wiggle */
+    deadline =3D start + 1000 * (100 * 30 * 4);
+    last_rxt =3D start;
+
+    while (true) {
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
+    };
 }
=20
 static void virtio_net_test_cleanup(void *sockets)
--=20
2.21.0


