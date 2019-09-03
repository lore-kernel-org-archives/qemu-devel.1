Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A16C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0A92339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="uSXe3MzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0A92339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5C6Q-00050q-C0
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i5BaD-0007T8-U7
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i5BaB-0003A7-I6
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:23:04 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:45046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i5BaB-000387-72
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:23:03 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C0F3A2E1533;
 Tue,  3 Sep 2019 19:22:59 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
 [2a02:6b8:0:1619::137])
 by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 mRGa1WauMs-MxIaUBAv; Tue, 03 Sep 2019 19:22:59 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1567527779; bh=OzYzDUl2ej0rQaG+Yi94pCPWjiFGmhtGq4xX1lU8F84=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=uSXe3MzV5AlVY5jpWL+fe+Qh0BK2wi7itcRbJ1u+dBeWAtGBA94Vf2oSyQIPS0Juo
 7s1Kqa7sJxoLcul2JWernRgkJqM0FQMgSuS7QUUC4GDQMeFKmNMXguLC7QWA3Vt7hR
 sd/9B3oFy5+XoqXga4+TqN1hx2yRPgnhbyu6Igv4=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:c43c:5d37:585c:b5d6])
 by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 YFfYaDvJaP-MwfauTO4; Tue, 03 Sep 2019 19:22:58 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Date: Tue,  3 Sep 2019 19:22:45 +0300
Message-Id: <20190903162246.18524-3-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190903162246.18524-1-yury-kotov@yandex-team.ru>
References: <20190903162246.18524-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
Subject: [Qemu-devel] [PATCH v2 2/3] tests/libqtest: Allow setting expected
 exit status
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add qtest_set_expected_status function to set expected exit status of
child process. By default expected exit status is 0.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 tests/libqtest.c | 36 +++++++++++++++++++++---------------
 tests/libqtest.h |  9 +++++++++
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 2713b86cf7..a79d4887ae 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -43,6 +43,7 @@ struct QTestState
     int qmp_fd;
     pid_t qemu_pid;  /* our child QEMU process */
     int wstatus;
+    int expected_status;
     bool big_endian;
     bool irq_level[MAX_IRQ];
     GString *rx;
@@ -113,6 +114,11 @@ bool qtest_probe_child(QTestState *s)
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
@@ -126,24 +132,23 @@ static void kill_qemu(QTestState *s)
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
@@ -248,6 +253,7 @@ QTestState *qtest_init_without_qmp_handshake(const ch=
ar *extra_args)
     g_test_message("starting QEMU: %s", command);
=20
     s->wstatus =3D 0;
+    s->expected_status =3D 0;
     s->qemu_pid =3D fork();
     if (s->qemu_pid =3D=3D 0) {
         setenv("QEMU_AUDIO_DRV", "none", true);
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 07ea35867c..c00bca94af 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -997,4 +997,13 @@ void qmp_assert_error_class(QDict *rsp, const char *=
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
2.17.1


