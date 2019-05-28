Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED85C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC75208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="zrgj79QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC75208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59628 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYG5-0007qc-TF
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:19:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hVYE6-0006hY-LI
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hVYE4-00012e-JY
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:16:58 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:50950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1hVYE4-0000zt-9P
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:16:56 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::119])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 18D472E0EB5;
	Tue, 28 May 2019 12:16:48 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net
	[2a02:6b8:0:1a2d::30])
	by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	2WeRwYFXd8-Gl5W0UBE; Tue, 28 May 2019 12:16:48 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1559035008; bh=VJP/L1QXJL3VObIUrvaQxckHzR+KVw14Xz8TE2LqtCI=;
	h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
	b=zrgj79QAE6xmvBnHjK8SP1qDZ/ec4ioNHj3yvyawDlytuEq8jmvuXQWOboIZwLp0O
	mFmEpG9gQWMpj+q6Xwpd2wI01OMuwVpuDYmRVsHOctjOxebvTWrwWlYD2Kb5FHKqQ3
	N/P4GhCopnXinJbJAbqbbUVHRDamhmhc5WvOcwS0=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:40c:5d26:9eea:30af:86bd])
	by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	JeN6ka38JZ-GllmOqVr; Tue, 28 May 2019 12:16:47 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 May 2019 12:16:33 +0300
Message-Id: <20190528091633.12246-3-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528091633.12246-1-yury-kotov@yandex-team.ru>
References: <20190528091633.12246-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a02:6b8:0:1619::183
Subject: [Qemu-devel] [PATCH v2 2/2] migration-test: Add a test for fd
 protocol
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
	yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 tests/libqtest.c       |  80 ++++++++++++++++++++++++++++++--
 tests/libqtest.h       |  51 ++++++++++++++++++++-
 tests/migration-test.c | 101 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+), 5 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 8ac0c02af4..64f65bea22 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -32,6 +32,7 @@
=20
 #define MAX_IRQ 256
 #define SOCKET_TIMEOUT 50
+#define SOCKET_MAX_FDS 16
=20
 QTestState *global_qtest;
=20
@@ -391,6 +392,40 @@ static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestStat=
e *s, const char *fmt, ...)
     va_end(ap);
 }
=20
+/* Sends a message and file descriptors to the socket.
+ * It's needed for qmp-commands like getfd/add-fd */
+static void socket_send_fds(int socket_fd, int *fds, size_t fds_num,
+                            const char *buf, size_t buf_size)
+{
+    ssize_t ret;
+    struct msghdr msg =3D { 0 };
+    char control[CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS)] =3D { 0 };
+    size_t fdsize =3D sizeof(int) * fds_num;
+    struct cmsghdr *cmsg;
+    struct iovec iov =3D { .iov_base =3D (char *)buf, .iov_len =3D buf_s=
ize };
+
+    msg.msg_iov =3D &iov;
+    msg.msg_iovlen =3D 1;
+
+    if (fds && fds_num > 0) {
+        g_assert_cmpuint(fds_num, <, SOCKET_MAX_FDS);
+
+        msg.msg_control =3D control;
+        msg.msg_controllen =3D CMSG_SPACE(fdsize);
+
+        cmsg =3D CMSG_FIRSTHDR(&msg);
+        cmsg->cmsg_len =3D CMSG_LEN(fdsize);
+        cmsg->cmsg_level =3D SOL_SOCKET;
+        cmsg->cmsg_type =3D SCM_RIGHTS;
+        memcpy(CMSG_DATA(cmsg), fds, fdsize);
+    }
+
+    do {
+        ret =3D sendmsg(socket_fd, &msg, 0);
+    } while (ret < 0 && errno =3D=3D EINTR);
+    g_assert_cmpint(ret, >, 0);
+}
+
 static GString *qtest_recv_line(QTestState *s)
 {
     GString *line;
@@ -545,7 +580,8 @@ QDict *qtest_qmp_receive(QTestState *s)
  * in the case that they choose to discard all replies up until
  * a particular EVENT is received.
  */
-void qmp_fd_vsend(int fd, const char *fmt, va_list ap)
+void qmp_fd_vsend_fds(int fd, int *fds, size_t fds_num,
+                      const char *fmt, va_list ap)
 {
     QObject *qobj;
=20
@@ -569,25 +605,49 @@ void qmp_fd_vsend(int fd, const char *fmt, va_list =
ap)
             fprintf(stderr, "%s", str);
         }
         /* Send QMP request */
-        socket_send(fd, str, qstring_get_length(qstr));
+        if (fds && fds_num > 0) {
+            socket_send_fds(fd, fds, fds_num, str, qstring_get_length(qs=
tr));
+        } else {
+            socket_send(fd, str, qstring_get_length(qstr));
+        }
=20
         qobject_unref(qstr);
         qobject_unref(qobj);
     }
 }
=20
+void qmp_fd_vsend(int fd, const char *fmt, va_list ap)
+{
+    qmp_fd_vsend_fds(fd, NULL, 0, fmt, ap);
+}
+
+void qtest_qmp_vsend_fds(QTestState *s, int *fds, size_t fds_num,
+                         const char *fmt, va_list ap)
+{
+    qmp_fd_vsend_fds(s->qmp_fd, fds, fds_num, fmt, ap);
+}
+
 void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
 {
-    qmp_fd_vsend(s->qmp_fd, fmt, ap);
+    qmp_fd_vsend_fds(s->qmp_fd, NULL, 0, fmt, ap);
 }
=20
 QDict *qmp_fdv(int fd, const char *fmt, va_list ap)
 {
-    qmp_fd_vsend(fd, fmt, ap);
+    qmp_fd_vsend_fds(fd, NULL, 0, fmt, ap);
=20
     return qmp_fd_receive(fd);
 }
=20
+QDict *qtest_vqmp_fds(QTestState *s, int *fds, size_t fds_num,
+                      const char *fmt, va_list ap)
+{
+    qtest_qmp_vsend_fds(s, fds, fds_num, fmt, ap);
+
+    /* Receive reply */
+    return qtest_qmp_receive(s);
+}
+
 QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
 {
     qtest_qmp_vsend(s, fmt, ap);
@@ -616,6 +676,18 @@ void qmp_fd_send(int fd, const char *fmt, ...)
     va_end(ap);
 }
=20
+QDict *qtest_qmp_fds(QTestState *s, int *fds, size_t fds_num,
+                     const char *fmt, ...)
+{
+    va_list ap;
+    QDict *response;
+
+    va_start(ap, fmt);
+    response =3D qtest_vqmp_fds(s, fds, fds_num, fmt, ap);
+    va_end(ap);
+    return response;
+}
+
 QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
 {
     va_list ap;
diff --git a/tests/libqtest.h b/tests/libqtest.h
index a98ea15b7d..e61ebaced1 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -84,6 +84,21 @@ QTestState *qtest_init_with_serial(const char *extra_a=
rgs, int *sock_fd);
  */
 void qtest_quit(QTestState *s);
=20
+/**
+ * qtest_qmp_fds:
+ * @s: #QTestState instance to operate on.
+ * @fds: array of file descriptors
+ * @fds_num: number of elements in @fds
+ * @fmt...: QMP message to send to qemu, formatted like
+ * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * supported after '%'.
+ *
+ * Sends a QMP message to QEMU with fds and returns the response.
+ */
+QDict *qtest_qmp_fds(QTestState *s, int *fds, size_t fds_num,
+                     const char *fmt, ...)
+    GCC_FMT_ATTR(4, 5);
+
 /**
  * qtest_qmp:
  * @s: #QTestState instance to operate on.
@@ -120,7 +135,23 @@ void qtest_qmp_send_raw(QTestState *s, const char *f=
mt, ...)
     GCC_FMT_ATTR(2, 3);
=20
 /**
- * qtest_qmpv:
+ * qtest_vqmp_fds:
+ * @s: #QTestState instance to operate on.
+ * @fds: array of file descriptors
+ * @fds_num: number of elements in @fds
+ * @fmt: QMP message to send to QEMU, formatted like
+ * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * supported after '%'.
+ * @ap: QMP message arguments
+ *
+ * Sends a QMP message to QEMU with fds and returns the response.
+ */
+QDict *qtest_vqmp_fds(QTestState *s, int *fds, size_t fds_num,
+                      const char *fmt, va_list ap)
+    GCC_FMT_ATTR(4, 0);
+
+/**
+ * qtest_vqmp:
  * @s: #QTestState instance to operate on.
  * @fmt: QMP message to send to QEMU, formatted like
  * qobject_from_jsonf_nofail().  See parse_escape() for what's
@@ -132,6 +163,22 @@ void qtest_qmp_send_raw(QTestState *s, const char *f=
mt, ...)
 QDict *qtest_vqmp(QTestState *s, const char *fmt, va_list ap)
     GCC_FMT_ATTR(2, 0);
=20
+/**
+ * qtest_qmp_vsend_fds:
+ * @s: #QTestState instance to operate on.
+ * @fds: array of file descriptors
+ * @fds_num: number of elements in @fds
+ * @fmt: QMP message to send to QEMU, formatted like
+ * qobject_from_jsonf_nofail().  See parse_escape() for what's
+ * supported after '%'.
+ * @ap: QMP message arguments
+ *
+ * Sends a QMP message to QEMU and leaves the response in the stream.
+ */
+void qtest_qmp_vsend_fds(QTestState *s, int *fds, size_t fds_num,
+                         const char *fmt, va_list ap)
+    GCC_FMT_ATTR(4, 0);
+
 /**
  * qtest_qmp_vsend:
  * @s: #QTestState instance to operate on.
@@ -877,6 +924,8 @@ static inline int64_t clock_step(int64_t step)
 }
=20
 QDict *qmp_fd_receive(int fd);
+void qmp_fd_vsend_fds(int fd, int *fds, size_t fds_num,
+                      const char *fmt, va_list ap) GCC_FMT_ATTR(4, 0);
 void qmp_fd_vsend(int fd, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0=
);
 void qmp_fd_send(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 void qmp_fd_send_raw(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
diff --git a/tests/migration-test.c b/tests/migration-test.c
index bd3f5c3125..e0407576cb 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -174,6 +174,21 @@ static void stop_cb(void *opaque, const char *name, =
QDict *data)
     }
 }
=20
+/*
+ * Events can get in the way of responses we are actually waiting for.
+ */
+GCC_FMT_ATTR(3, 4)
+static QDict *wait_command_fd(QTestState *who, int fd, const char *comma=
nd, ...)
+{
+    va_list ap;
+
+    va_start(ap, command);
+    qtest_qmp_vsend_fds(who, &fd, 1, command, ap);
+    va_end(ap);
+
+    return qtest_qmp_receive_success(who, stop_cb, NULL);
+}
+
 /*
  * Events can get in the way of responses we are actually waiting for.
  */
@@ -480,6 +495,7 @@ static void migrate(QTestState *who, const char *uri,=
 const char *fmt, ...)
     qdict_put_str(args, "uri", uri);
=20
     rsp =3D qmp("{ 'execute': 'migrate', 'arguments': %p}", args);
+
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 }
@@ -1027,6 +1043,90 @@ static void test_precopy_tcp(void)
     g_free(uri);
 }
=20
+static void test_migrate_fd_proto(void)
+{
+    QTestState *from, *to;
+    int ret;
+    int pair[2];
+    QDict *rsp;
+    const char *error_desc;
+
+    if (test_migrate_start(&from, &to, "defer", false, false)) {
+        return;
+    }
+
+    /*
+     * We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    /* 1 ms should make it not converge */
+    migrate_set_parameter(from, "downtime-limit", 1);
+    /* 1GB/s */
+    migrate_set_parameter(from, "max-bandwidth", 1000000000);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    /* Create two connected sockets for migration */
+    ret =3D socketpair(PF_LOCAL, SOCK_STREAM, 0, pair);
+    g_assert_cmpint(ret, =3D=3D, 0);
+
+    /* Send the 1st socket to the target */
+    rsp =3D wait_command_fd(to, pair[0],
+                          "{ 'execute': 'getfd',"
+                          "  'arguments': { 'fdname': 'fd-mig' }}");
+    qobject_unref(rsp);
+    close(pair[0]);
+
+    /* Start incoming migration from the 1st socket */
+    rsp =3D wait_command(to, "{ 'execute': 'migrate-incoming',"
+                           "  'arguments': { 'uri': 'fd:fd-mig' }}");
+    qobject_unref(rsp);
+
+    /* Send the 2nd socket to the target */
+    rsp =3D wait_command_fd(from, pair[1],
+                          "{ 'execute': 'getfd',"
+                          "  'arguments': { 'fdname': 'fd-mig' }}");
+    qobject_unref(rsp);
+    close(pair[1]);
+
+    /* Start migration to the 2nd socket*/
+    migrate(from, "fd:fd-mig", "{}");
+
+    wait_for_migration_pass(from);
+
+    /* 300ms should converge */
+    migrate_set_parameter(from, "downtime-limit", 300);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+    qtest_qmp_eventwait(to, "RESUME");
+
+    /* Test closing fds */
+    /* We assume, that QEMU removes named fd from its list,
+     * so this should fail */
+    rsp =3D qtest_qmp(from, "{ 'execute': 'closefd',"
+                          "  'arguments': { 'fdname': 'fd-mig' }}");
+    g_assert_true(qdict_haskey(rsp, "error"));
+    error_desc =3D qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
+    g_assert_cmpstr(error_desc, =3D=3D, "File descriptor named 'fd-mig' =
not found");
+    qobject_unref(rsp);
+
+    rsp =3D qtest_qmp(to, "{ 'execute': 'closefd',"
+                        "  'arguments': { 'fdname': 'fd-mig' }}");
+    g_assert_true(qdict_haskey(rsp, "error"));
+    error_desc =3D qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
+    g_assert_cmpstr(error_desc, =3D=3D, "File descriptor named 'fd-mig' =
not found");
+    qobject_unref(rsp);
+
+    /* Complete migration */
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+    test_migrate_end(from, to, true);
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -1081,6 +1181,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); *=
/
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
+    qtest_add_func("/migration/fd_proto", test_migrate_fd_proto);
=20
     ret =3D g_test_run();
=20
--=20
2.21.0


