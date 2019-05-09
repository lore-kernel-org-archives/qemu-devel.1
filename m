Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0325C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7502C208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7502C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50288 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeLg-0006uN-JS
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:24:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOeHP-0001xo-DQ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hOeHO-0000Km-FW
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:19:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hOeHO-0000JW-Aj
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:19:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7E71308793F;
	Thu,  9 May 2019 08:19:49 +0000 (UTC)
Received: from thuth.com (ovpn-116-115.ams2.redhat.com [10.36.116.115])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A9885B680;
	Thu,  9 May 2019 08:19:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu,  9 May 2019 10:19:21 +0200
Message-Id: <20190509081930.19081-6-thuth@redhat.com>
In-Reply-To: <20190509081930.19081-1-thuth@redhat.com>
References: <20190509081930.19081-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 09 May 2019 08:19:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/14] tests/test-hmp: Use qtest_init() instead
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qtest_start() + qtest_end() should be avoided, since they use the
global_qtest variable that we want to get rid of in the long run
Use qtest_init() and qtest_quit() instead.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190409085245.31548-5-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/test-hmp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index e344947f7c..5029c4d2c9 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -73,13 +73,13 @@ static const char *hmp_cmds[] =3D {
 };
=20
 /* Run through the list of pre-defined commands */
-static void test_commands(void)
+static void test_commands(QTestState *qts)
 {
     char *response;
     int i;
=20
     for (i =3D 0; hmp_cmds[i] !=3D NULL; i++) {
-        response =3D hmp("%s", hmp_cmds[i]);
+        response =3D qtest_hmp(qts, "%s", hmp_cmds[i]);
         if (verbose) {
             fprintf(stderr,
                     "\texecute HMP command: %s\n"
@@ -92,11 +92,11 @@ static void test_commands(void)
 }
=20
 /* Run through all info commands and call them blindly (without argument=
s) */
-static void test_info_commands(void)
+static void test_info_commands(QTestState *qts)
 {
     char *resp, *info, *info_buf, *endp;
=20
-    info_buf =3D info =3D hmp("help info");
+    info_buf =3D info =3D qtest_hmp(qts, "help info");
=20
     while (*info) {
         /* Extract the info command, ignore parameters and description *=
/
@@ -108,7 +108,7 @@ static void test_info_commands(void)
         if (verbose) {
             fprintf(stderr, "\t%s\n", info);
         }
-        resp =3D hmp("%s", info);
+        resp =3D qtest_hmp(qts, "%s", info);
         g_free(resp);
         /* And move forward to the next line */
         info =3D strchr(endp + 1, '\n');
@@ -125,14 +125,15 @@ static void test_machine(gconstpointer data)
 {
     const char *machine =3D data;
     char *args;
+    QTestState *qts;
=20
     args =3D g_strdup_printf("-S -M %s", machine);
-    qtest_start(args);
+    qts =3D qtest_init(args);
=20
-    test_info_commands();
-    test_commands();
+    test_info_commands(qts);
+    test_commands(qts);
=20
-    qtest_end();
+    qtest_quit(qts);
     g_free(args);
     g_free((void *)data);
 }
--=20
2.21.0


