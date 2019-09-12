Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C78EC4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D0620684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D0620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Ppr-0005T0-1r
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUs-0007Bu-Ao
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUq-0003Cb-UV
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8PUq-0003Bf-KF
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E067718C4274;
 Thu, 12 Sep 2019 13:50:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CFB95D704;
 Thu, 12 Sep 2019 13:50:48 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, ivanren@tencent.com, peterx@redhat.com,
 richardw.yang@linux.intel.com, yury-kotov@yandex-team.ru,
 quintela@redhat.com
Date: Thu, 12 Sep 2019 14:50:01 +0100
Message-Id: <20190912135006.14820-8-dgilbert@redhat.com>
In-Reply-To: <20190912135006.14820-1-dgilbert@redhat.com>
References: <20190912135006.14820-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 12 Sep 2019 13:50:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 07/12] tests/libqtest: Allow setting expected
 exit status
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

From: Yury Kotov <yury-kotov@yandex-team.ru>

Add qtest_set_expected_status function to set expected exit status of
child process. By default expected exit status is 0.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Message-Id: <20190903162246.18524-3-yury-kotov@yandex-team.ru>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/libqtest.c | 36 +++++++++++++++++++++---------------
 tests/libqtest.h |  9 +++++++++
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 0a6b91737e..4a7556462d 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -41,6 +41,7 @@ struct QTestState
     int qmp_fd;
     pid_t qemu_pid;  /* our child QEMU process */
     int wstatus;
+    int expected_status;
     bool big_endian;
     bool irq_level[MAX_IRQ];
     GString *rx;
@@ -111,6 +112,11 @@ bool qtest_probe_child(QTestState *s)
     return false;
 }
=20
+void qtest_set_expected_status(QTestState *s, int status)
+{
+    s->expected_status =3D status;
+}
+
 static void kill_qemu(QTestState *s)
 {
     pid_t pid =3D s->qemu_pid;
@@ -124,24 +130,23 @@ static void kill_qemu(QTestState *s)
     }
=20
     /*
-     * We expect qemu to exit with status 0; anything else is
+     * Check whether qemu exited with expected exit status; anything els=
e is
      * fishy and should be logged with as much detail as possible.
      */
     wstatus =3D s->wstatus;
-    if (wstatus) {
-        if (WIFEXITED(wstatus)) {
-            fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU =
"
-                    "process but encountered exit status %d\n",
-                    __FILE__, __LINE__, WEXITSTATUS(wstatus));
-        } else if (WIFSIGNALED(wstatus)) {
-            int sig =3D WTERMSIG(wstatus);
-            const char *signame =3D strsignal(sig) ?: "unknown ???";
-            const char *dump =3D WCOREDUMP(wstatus) ? " (core dumped)" :=
 "";
-
-            fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
-                    "from signal %d (%s)%s\n",
-                    __FILE__, __LINE__, sig, signame, dump);
-        }
+    if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) !=3D s->expected_stat=
us) {
+        fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
+                "process but encountered exit status %d (expected %d)\n"=
,
+                __FILE__, __LINE__, WEXITSTATUS(wstatus), s->expected_st=
atus);
+        abort();
+    } else if (WIFSIGNALED(wstatus)) {
+        int sig =3D WTERMSIG(wstatus);
+        const char *signame =3D strsignal(sig) ?: "unknown ???";
+        const char *dump =3D WCOREDUMP(wstatus) ? " (core dumped)" : "";
+
+        fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
+                "from signal %d (%s)%s\n",
+                __FILE__, __LINE__, sig, signame, dump);
         abort();
     }
 }
@@ -246,6 +251,7 @@ QTestState *qtest_init_without_qmp_handshake(const ch=
ar *extra_args)
     g_test_message("starting QEMU: %s", command);
=20
     s->wstatus =3D 0;
+    s->expected_status =3D 0;
     s->qemu_pid =3D fork();
     if (s->qemu_pid =3D=3D 0) {
         setenv("QEMU_AUDIO_DRV", "none", true);
diff --git a/tests/libqtest.h b/tests/libqtest.h
index c8cffe5d68..a177e502d9 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -708,4 +708,13 @@ void qmp_assert_error_class(QDict *rsp, const char *=
class);
  */
 bool qtest_probe_child(QTestState *s);
=20
+/**
+ * qtest_set_expected_status:
+ * @s: QTestState instance to operate on.
+ * @status: an expected exit status.
+ *
+ * Set expected exit status of the child.
+ */
+void qtest_set_expected_status(QTestState *s, int status);
+
 #endif
--=20
2.21.0


