Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D295C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1200422CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1200422CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0T2l-0000l4-H9
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0T0X-0006XC-3L
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0SvW-0001Wn-34
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:53:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45910)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i0SvV-0001WG-QR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:53:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CE68530832E9;
 Wed, 21 Aug 2019 15:53:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-61.ams2.redhat.com
 [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E27D10016E8;
 Wed, 21 Aug 2019 15:53:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 16:53:27 +0100
Message-Id: <20190821155327.25208-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 21 Aug 2019 15:53:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] tests: make filemonitor test more robust to
 event ordering
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ordering of events that are emitted during the rmdir
test have changed with kernel >=3D 5.3. Semantically both
new & old orderings are correct, so we must be able to
cope with either.

To cope with this, when we see an unexpected event, we
push it back onto the queue and look and the subsequent
event to see if that matches instead.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-util-filemonitor.c | 43 +++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.=
c
index 46e781c022..301cd2db61 100644
--- a/tests/test-util-filemonitor.c
+++ b/tests/test-util-filemonitor.c
@@ -45,6 +45,11 @@ typedef struct {
     const char *filedst;
     int64_t *watchid;
     int eventid;
+    /*
+     * Only valid with OP_EVENT - this event might be
+     * swapped with the next OP_EVENT
+     */
+    bool swapnext;
 } QFileMonitorTestOp;
=20
 typedef struct {
@@ -98,6 +103,10 @@ qemu_file_monitor_test_handler(int64_t id,
     QFileMonitorTestData *data =3D opaque;
     QFileMonitorTestRecord *rec =3D g_new0(QFileMonitorTestRecord, 1);
=20
+    if (debug) {
+        g_printerr("Queue event id %" PRIx64 " event %d file %s\n",
+                   id, event, filename);
+    }
     rec->id =3D id;
     rec->event =3D event;
     rec->filename =3D g_strdup(filename);
@@ -125,7 +134,8 @@ qemu_file_monitor_test_record_free(QFileMonitorTestRe=
cord *rec)
  * to wait for the event to be queued for us.
  */
 static QFileMonitorTestRecord *
-qemu_file_monitor_test_next_record(QFileMonitorTestData *data)
+qemu_file_monitor_test_next_record(QFileMonitorTestData *data,
+                                   QFileMonitorTestRecord *pushback)
 {
     GTimer *timer =3D g_timer_new();
     QFileMonitorTestRecord *record =3D NULL;
@@ -139,9 +149,15 @@ qemu_file_monitor_test_next_record(QFileMonitorTestD=
ata *data)
     }
     if (data->records) {
         record =3D data->records->data;
-        tmp =3D data->records;
-        data->records =3D g_list_remove_link(data->records, tmp);
-        g_list_free(tmp);
+        if (pushback) {
+            data->records->data =3D pushback;
+        } else {
+            tmp =3D data->records;
+            data->records =3D g_list_remove_link(data->records, tmp);
+            g_list_free(tmp);
+        }
+    } else if (pushback) {
+        qemu_file_monitor_test_record_free(pushback);
     }
     qemu_mutex_unlock(&data->lock);
=20
@@ -158,13 +174,15 @@ static bool
 qemu_file_monitor_test_expect(QFileMonitorTestData *data,
                               int64_t id,
                               QFileMonitorEvent event,
-                              const char *filename)
+                              const char *filename,
+                              bool swapnext)
 {
     QFileMonitorTestRecord *rec;
     bool ret =3D false;
=20
-    rec =3D qemu_file_monitor_test_next_record(data);
+    rec =3D qemu_file_monitor_test_next_record(data, NULL);
=20
+ retry:
     if (!rec) {
         g_printerr("Missing event watch id %" PRIx64 " event %d file %s\=
n",
                    id, event, filename);
@@ -172,6 +190,11 @@ qemu_file_monitor_test_expect(QFileMonitorTestData *=
data,
     }
=20
     if (id !=3D rec->id) {
+        if (swapnext) {
+            rec =3D qemu_file_monitor_test_next_record(data, rec);
+            swapnext =3D false;
+            goto retry;
+        }
         g_printerr("Expected watch id %" PRIx64 " but got %" PRIx64 "\n"=
,
                    id, rec->id);
         goto cleanup;
@@ -347,7 +370,8 @@ test_file_monitor_events(void)
           .filesrc =3D "fish", },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc =3D "", .watchid =3D &watch4,
-          .eventid =3D QFILE_MONITOR_EVENT_IGNORED },
+          .eventid =3D QFILE_MONITOR_EVENT_IGNORED,
+          .swapnext =3D true },
         { .type =3D QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc =3D "fish", .watchid =3D &watch0,
           .eventid =3D QFILE_MONITOR_EVENT_DELETED },
@@ -493,8 +517,9 @@ test_file_monitor_events(void)
                 g_printerr("Event id=3D%" PRIx64 " event=3D%d file=3D%s\=
n",
                            *op->watchid, op->eventid, op->filesrc);
             }
-            if (!qemu_file_monitor_test_expect(
-                    &data, *op->watchid, op->eventid, op->filesrc))
+            if (!qemu_file_monitor_test_expect(&data, *op->watchid,
+                                               op->eventid, op->filesrc,
+                                               op->swapnext))
                 goto cleanup;
             break;
         case QFILE_MONITOR_TEST_OP_CREATE:
--=20
2.21.0


