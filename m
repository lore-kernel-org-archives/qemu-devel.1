Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C179C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32132183F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 03:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32132183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi9ly-0007iJ-Lz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 23:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50457)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hi8aI-0004o9-N8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hi8aG-0003f2-Sg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hi8aG-0003dQ-Iw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 22:31:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 037157FDCD;
 Tue,  2 Jul 2019 02:31:51 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-232.pek2.redhat.com
 [10.72.12.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66862BA4D;
 Tue,  2 Jul 2019 02:31:49 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 10:31:20 +0800
Message-Id: <1562034689-6539-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 02 Jul 2019 02:31:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/17] net/announce: Allow optional list of
 interfaces
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

Allow the caller to restrict the set of interfaces that announces are
sent on.  The default is still to send on all interfaces.

e.g.

  { "execute": "announce-self", "arguments": { "initial": 50, "max": 550, "rounds": 5, "step": 50, "interfaces": ["vn2", "vn1"] } }

This doesn't affect the behaviour of migraiton announcments.

Note: There's still only one timer for the qmp command, so that
performing an 'announce-self' on one list of interfaces followed
by another 'announce-self' on another list will stop the announces
on the existing set.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/net/announce.h |  2 +-
 net/announce.c         | 39 ++++++++++++++++++++++++++++++++-------
 net/trace-events       |  2 +-
 qapi/net.json          | 11 ++++++++---
 4 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/include/net/announce.h b/include/net/announce.h
index 04a035f..7734704 100644
--- a/include/net/announce.h
+++ b/include/net/announce.h
@@ -22,7 +22,7 @@ struct AnnounceTimer {
 /* Returns: update the timer to the next time point */
 int64_t qemu_announce_timer_step(AnnounceTimer *timer);
 
-/* Delete the underlying timer */
+/* Delete the underlying timer and other data */
 void qemu_announce_timer_del(AnnounceTimer *timer);
 
 /*
diff --git a/net/announce.c b/net/announce.c
index 91e9a6e..1ce42b5 100644
--- a/net/announce.c
+++ b/net/announce.c
@@ -38,6 +38,8 @@ void qemu_announce_timer_del(AnnounceTimer *timer)
         timer_free(timer->tm);
         timer->tm = NULL;
     }
+    qapi_free_strList(timer->params.interfaces);
+    timer->params.interfaces = NULL;
 }
 
 /*
@@ -96,24 +98,47 @@ static int announce_self_create(uint8_t *buf,
 
 static void qemu_announce_self_iter(NICState *nic, void *opaque)
 {
+    AnnounceTimer *timer = opaque;
     uint8_t buf[60];
     int len;
+    bool skip;
+
+    if (timer->params.has_interfaces) {
+        strList *entry = timer->params.interfaces;
+        /* Skip unless we find our name in the requested list */
+        skip = true;
+
+        while (entry) {
+            if (!strcmp(entry->value, nic->ncs->name)) {
+                /* Found us */
+                skip = false;
+                break;
+            }
+            entry = entry->next;
+        }
+    } else {
+        skip = false;
+    }
+
+    trace_qemu_announce_self_iter(nic->ncs->name,
+                                  qemu_ether_ntoa(&nic->conf->macaddr), skip);
 
-    trace_qemu_announce_self_iter(qemu_ether_ntoa(&nic->conf->macaddr));
-    len = announce_self_create(buf, nic->conf->macaddr.a);
+    if (!skip) {
+        len = announce_self_create(buf, nic->conf->macaddr.a);
 
-    qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
+        qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
 
-    /* if the NIC provides it's own announcement support, use it as well */
-    if (nic->ncs->info->announce) {
-        nic->ncs->info->announce(nic->ncs);
+        /* if the NIC provides it's own announcement support, use it as well */
+        if (nic->ncs->info->announce) {
+            nic->ncs->info->announce(nic->ncs);
+        }
     }
 }
 static void qemu_announce_self_once(void *opaque)
 {
     AnnounceTimer *timer = (AnnounceTimer *)opaque;
 
-    qemu_foreach_nic(qemu_announce_self_iter, NULL);
+    qemu_foreach_nic(qemu_announce_self_iter, timer);
 
     if (--timer->round) {
         qemu_announce_timer_step(timer);
diff --git a/net/trace-events b/net/trace-events
index a7937f3..875ef2a 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -1,7 +1,7 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # announce.c
-qemu_announce_self_iter(const char *mac) "%s"
+qemu_announce_self_iter(const char *name, const char *mac, int skip) "%s:%s skip: %d"
 
 # vhost-user.c
 vhost_user_event(const char *chr, int event) "chr: %s got event: %d"
diff --git a/qapi/net.json b/qapi/net.json
index 5f7bff1..6f2cd4f 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -699,6 +699,9 @@
 #
 # @step: Delay increase (in ms) after each self-announcement attempt
 #
+# @interfaces: An optional list of interface names, which restricts the
+#        announcement to the listed interfaces. (Since 4.1)
+#
 # Since: 4.0
 ##
 
@@ -706,7 +709,8 @@
   'data': { 'initial': 'int',
             'max': 'int',
             'rounds': 'int',
-            'step': 'int' } }
+            'step': 'int',
+            '*interfaces': ['str'] } }
 
 ##
 # @announce-self:
@@ -718,9 +722,10 @@
 #
 # Example:
 #
-# -> { "execute": "announce-self"
+# -> { "execute": "announce-self",
 #      "arguments": {
-#          "initial": 50, "max": 550, "rounds": 10, "step": 50 } }
+#          "initial": 50, "max": 550, "rounds": 10, "step": 50,
+#          "interfaces": ["vn2", "vn3"] } }
 # <- { "return": {} }
 #
 # Since: 4.0
-- 
2.5.0


