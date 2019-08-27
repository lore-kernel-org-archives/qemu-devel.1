Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09912C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82942184D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="PNkZGCRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82942184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2aJ2-0000qn-Bp
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2aBM-0001vN-IK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2aBI-0003Z4-Ip
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:02:38 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:57822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i2aBI-0003Xg-49
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:02:36 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id D406F2E14EF;
 Tue, 27 Aug 2019 15:02:31 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
 [2a02:6b8:0:1619::137])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 1xQj1W69MZ-2VJqimte; Tue, 27 Aug 2019 15:02:31 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1566907351; bh=rjNZZ+XG5CcNkF0t6gN4egiScU4pZsE9TvlPlTSTsdk=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=PNkZGCRcXRLD3yp3hftWGJVvbJJPJ/nAPR14r913odENmG2rXZs1INt9uqlCAVy5e
 lMIPrKwWyTwdMzleBGg5T+4B6E8Bwm02KuLK75Uwn9x60DvBueEi/Ug820NPi0rShy
 zLCYmrzZ9rVaTXNa9z7lZObr3EfOy1s0iO9+s5zo=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:dc67:69ff:2705:c046])
 by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 2qbfJ2c4Zu-2V6KCSKX; Tue, 27 Aug 2019 15:02:31 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Aug 2019 15:02:20 +0300
Message-Id: <20190827120221.15725-3-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
References: <20190827120221.15725-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
Subject: [Qemu-devel] [PATCH 2/3] tests/libqtest: Allow to set expected exit
 status
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add qtest_set_expected_status function to set expected exit status of
child process. By default expected exit status is 0.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 tests/libqtest.c | 14 +++++++++++---
 tests/libqtest.h |  9 +++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 2713b86cf7..118d779c1b 100644
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
@@ -130,11 +136,12 @@ static void kill_qemu(QTestState *s)
      * fishy and should be logged with as much detail as possible.
      */
     wstatus =3D s->wstatus;
-    if (wstatus) {
+    if (WEXITSTATUS(wstatus) !=3D s->expected_status) {
         if (WIFEXITED(wstatus)) {
             fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU =
"
-                    "process but encountered exit status %d\n",
-                    __FILE__, __LINE__, WEXITSTATUS(wstatus));
+                    "process but encountered exit status %d (expected %d=
)\n",
+                    __FILE__, __LINE__, WEXITSTATUS(wstatus),
+                    s->expected_status);
         } else if (WIFSIGNALED(wstatus)) {
             int sig =3D WTERMSIG(wstatus);
             const char *signame =3D strsignal(sig) ?: "unknown ???";
@@ -248,6 +255,7 @@ QTestState *qtest_init_without_qmp_handshake(const ch=
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
2.22.0


