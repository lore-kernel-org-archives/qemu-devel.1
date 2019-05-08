Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E9C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D8621530
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D8621530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hONTI-00025u-Bl
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:23:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hONSP-0001ml-17
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hONSN-00084L-T3
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:22:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hONSN-00082O-Lv
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:22:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88878859FC
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 14:21:58 +0000 (UTC)
Received: from thuth.com (ovpn-116-100.ams2.redhat.com [10.36.116.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7BA5A611C3;
	Wed,  8 May 2019 14:21:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 16:21:53 +0200
Message-Id: <20190508142153.21555-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 08 May 2019 14:21:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] tests/drive_del-test: Use qtest_init() instead
 of qtest_start()
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qtest_start() + qtest_end() should be avoided, since they use the
global_qtest variable that we want to get rid of in the long run
Use qtest_init() and qtest_quit() instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/drive_del-test.c | 63 +++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/tests/drive_del-test.c b/tests/drive_del-test.c
index 2f9474e03c..b56b223fc2 100644
--- a/tests/drive_del-test.c
+++ b/tests/drive_del-test.c
@@ -16,32 +16,32 @@
 #include "qapi/qmp/qdict.h"
=20
 /* TODO actually test the results and get rid of this */
-#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+#define qmp_discard_response(q, ...) qobject_unref(qtest_qmp(q, __VA_ARG=
S__))
=20
-static void drive_add(void)
+static void drive_add(QTestState *qts)
 {
-    char *resp =3D hmp("drive_add 0 if=3Dnone,id=3Ddrive0");
+    char *resp =3D qtest_hmp(qts, "drive_add 0 if=3Dnone,id=3Ddrive0");
=20
     g_assert_cmpstr(resp, =3D=3D, "OK\r\n");
     g_free(resp);
 }
=20
-static void drive_del(void)
+static void drive_del(QTestState *qts)
 {
-    char *resp =3D hmp("drive_del drive0");
+    char *resp =3D qtest_hmp(qts, "drive_del drive0");
=20
     g_assert_cmpstr(resp, =3D=3D, "");
     g_free(resp);
 }
=20
-static void device_del(void)
+static void device_del(QTestState *qts)
 {
     QDict *response;
=20
     /* Complication: ignore DEVICE_DELETED event */
-    qmp_discard_response("{'execute': 'device_del',"
+    qmp_discard_response(qts, "{'execute': 'device_del',"
                          " 'arguments': { 'id': 'dev0' } }");
-    response =3D qmp_receive();
+    response =3D qtest_qmp_receive(qts);
     g_assert(response);
     g_assert(qdict_haskey(response, "return"));
     qobject_unref(response);
@@ -49,18 +49,20 @@ static void device_del(void)
=20
 static void test_drive_without_dev(void)
 {
+    QTestState *qts;
+
     /* Start with an empty drive */
-    qtest_start("-drive if=3Dnone,id=3Ddrive0");
+    qts =3D qtest_init("-drive if=3Dnone,id=3Ddrive0");
=20
     /* Delete the drive */
-    drive_del();
+    drive_del(qts);
=20
     /* Ensure re-adding the drive works - there should be no duplicate I=
D error
      * because the old drive must be gone.
      */
-    drive_add();
+    drive_add(qts);
=20
-    qtest_end();
+    qtest_quit(qts);
 }
=20
 /*
@@ -85,54 +87,53 @@ static void test_after_failed_device_add(void)
 {
     char driver[32];
     QDict *response;
+    QTestState *qts;
=20
     snprintf(driver, sizeof(driver), "virtio-blk-%s",
              qvirtio_get_dev_type());
=20
-    qtest_start("-drive if=3Dnone,id=3Ddrive0");
+    qts =3D qtest_init("-drive if=3Dnone,id=3Ddrive0");
=20
     /* Make device_add fail. If this leaks the virtio-blk device then a
      * reference to drive0 will also be held (via qdev properties).
      */
-    response =3D qmp("{'execute': 'device_add',"
-                   " 'arguments': {"
-                   "   'driver': %s,"
-                   "   'drive': 'drive0'"
-                   "}}", driver);
+    response =3D qtest_qmp(qts, "{'execute': 'device_add',"
+                              " 'arguments': {"
+                              "   'driver': %s,"
+                              "   'drive': 'drive0'"
+                              "}}", driver);
     g_assert(response);
     qmp_assert_error_class(response, "GenericError");
=20
     /* Delete the drive */
-    drive_del();
+    drive_del(qts);
=20
     /* Try to re-add the drive.  This fails with duplicate IDs if a leak=
ed
      * virtio-blk device exists that holds a reference to the old drive0=
.
      */
-    drive_add();
+    drive_add(qts);
=20
-    qtest_end();
+    qtest_quit(qts);
 }
=20
 static void test_drive_del_device_del(void)
 {
-    char *args;
+    QTestState *qts;
=20
     /* Start with a drive used by a device that unplugs instantaneously =
*/
-    args =3D g_strdup_printf("-drive if=3Dnone,id=3Ddrive0,file=3Dnull-c=
o://,format=3Draw"
-                           " -device virtio-scsi-%s"
-                           " -device scsi-hd,drive=3Ddrive0,id=3Ddev0",
-                           qvirtio_get_dev_type());
-    qtest_start(args);
+    qts =3D qtest_initf("-drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,=
format=3Draw"
+                      " -device virtio-scsi-%s"
+                      " -device scsi-hd,drive=3Ddrive0,id=3Ddev0",
+                      qvirtio_get_dev_type());
=20
     /*
      * Delete the drive, and then the device
      * Doing it in this order takes notoriously tricky special paths
      */
-    drive_del();
-    device_del();
+    drive_del(qts);
+    device_del(qts);
=20
-    qtest_end();
-    g_free(args);
+    qtest_quit(qts);
 }
=20
 int main(int argc, char **argv)
--=20
2.21.0


