Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF060C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A768120881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A768120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38351 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpFO-0002dL-VN
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:03:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hTpBS-0006o7-0I
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hTpBQ-00032W-OK
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:59:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hTpBQ-0002ti-GD
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:59:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C295CC329C
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 14:58:49 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-235.ams2.redhat.com
	[10.36.117.235])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C9EA620C5;
	Thu, 23 May 2019 14:58:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, jasowang@redhat.com, eblake@redhat.com,
	armbru@redhat.com, laine@redhat.com
Date: Thu, 23 May 2019 15:58:39 +0100
Message-Id: <20190523145840.11774-2-dgilbert@redhat.com>
In-Reply-To: <20190523145840.11774-1-dgilbert@redhat.com>
References: <20190523145840.11774-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 23 May 2019 14:58:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] net/announce: Allow optional list of
 interfaces
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Allow the caller to restrict the set of interfaces that announces are
sent on.  The default is still to send on all interfaces.

e.g.

  { "execute": "announce-self", "arguments": { "initial": 50, "max": 550,=
 "rounds": 5, "step": 50, "ifaces": ["vn2","vn1"] } }

Note: There's still only one timer for the qmp command, so that
performing an 'announce-self' on one list of interfaces followed
by another 'announce-self' on another list will stop the announces
on the existing set.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/net/announce.h |  2 +-
 net/announce.c         | 39 ++++++++++++++++++++++++++++++++-------
 net/trace-events       |  2 +-
 qapi/net.json          |  8 +++++---
 4 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/include/net/announce.h b/include/net/announce.h
index 892d302b65..3ebffe517e 100644
--- a/include/net/announce.h
+++ b/include/net/announce.h
@@ -23,7 +23,7 @@ struct AnnounceTimer {
 /* Returns: update the timer to the next time point */
 int64_t qemu_announce_timer_step(AnnounceTimer *timer);
=20
-/* Delete the underlying timer */
+/* Delete the underlying timer and other data */
 void qemu_announce_timer_del(AnnounceTimer *timer);
=20
 /*
diff --git a/net/announce.c b/net/announce.c
index 91e9a6e267..2a85a72280 100644
--- a/net/announce.c
+++ b/net/announce.c
@@ -38,6 +38,8 @@ void qemu_announce_timer_del(AnnounceTimer *timer)
         timer_free(timer->tm);
         timer->tm =3D NULL;
     }
+    qapi_free_strList(timer->params.ifaces);
+    timer->params.ifaces =3D NULL;
 }
=20
 /*
@@ -96,24 +98,47 @@ static int announce_self_create(uint8_t *buf,
=20
 static void qemu_announce_self_iter(NICState *nic, void *opaque)
 {
+    AnnounceTimer *timer =3D opaque;
     uint8_t buf[60];
     int len;
+    bool skip;
+
+    if (timer->params.has_ifaces) {
+        strList *entry =3D timer->params.ifaces;
+        /* Skip unless we find our name in the requested list */
+        skip =3D true;
+
+        while (entry) {
+            if (!strcmp(entry->value, nic->ncs->name)) {
+                /* Found us */
+                skip =3D false;
+                break;
+            }
+            entry =3D entry->next;
+        }
+    } else {
+        skip =3D false;
+    }
+
+    trace_qemu_announce_self_iter(nic->ncs->name,
+                                  qemu_ether_ntoa(&nic->conf->macaddr), =
skip);
=20
-    trace_qemu_announce_self_iter(qemu_ether_ntoa(&nic->conf->macaddr));
-    len =3D announce_self_create(buf, nic->conf->macaddr.a);
+    if (!skip) {
+        len =3D announce_self_create(buf, nic->conf->macaddr.a);
=20
-    qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
+        qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
=20
-    /* if the NIC provides it's own announcement support, use it as well=
 */
-    if (nic->ncs->info->announce) {
-        nic->ncs->info->announce(nic->ncs);
+        /* if the NIC provides it's own announcement support, use it as =
well */
+        if (nic->ncs->info->announce) {
+            nic->ncs->info->announce(nic->ncs);
+        }
     }
 }
 static void qemu_announce_self_once(void *opaque)
 {
     AnnounceTimer *timer =3D (AnnounceTimer *)opaque;
=20
-    qemu_foreach_nic(qemu_announce_self_iter, NULL);
+    qemu_foreach_nic(qemu_announce_self_iter, timer);
=20
     if (--timer->round) {
         qemu_announce_timer_step(timer);
diff --git a/net/trace-events b/net/trace-events
index a7937f3f3a..875ef2a0f3 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -1,7 +1,7 @@
 # See docs/devel/tracing.txt for syntax documentation.
=20
 # announce.c
-qemu_announce_self_iter(const char *mac) "%s"
+qemu_announce_self_iter(const char *name, const char *mac, int skip) "%s=
:%s skip: %d"
=20
 # vhost-user.c
 vhost_user_event(const char *chr, int event) "chr: %s got event: %d"
diff --git a/qapi/net.json b/qapi/net.json
index 5f7bff1637..871cfa7405 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -706,7 +706,8 @@
   'data': { 'initial': 'int',
             'max': 'int',
             'rounds': 'int',
-            'step': 'int' } }
+            'step': 'int',
+            '*ifaces': ['str'] } }
=20
 ##
 # @announce-self:
@@ -718,9 +719,10 @@
 #
 # Example:
 #
-# -> { "execute": "announce-self"
+# -> { "execute": "announce-self",
 #      "arguments": {
-#          "initial": 50, "max": 550, "rounds": 10, "step": 50 } }
+#          "initial": 50, "max": 550, "rounds": 10, "step": 50,
+#          "ifaces": ["vn2","vn3"] } }
 # <- { "return": {} }
 #
 # Since: 4.0
--=20
2.21.0


