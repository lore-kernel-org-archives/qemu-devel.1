Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55556C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 08:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A24D2146F
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 08:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A24D2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSHcM-0002ia-Bl
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 04:56:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1hSHbX-0002KW-Pn
	for qemu-devel@nongnu.org; Sun, 19 May 2019 04:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1hSHWZ-0008NB-JE
	for qemu-devel@nongnu.org; Sun, 19 May 2019 04:50:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hSHWZ-0008Ld-A2
	for qemu-devel@nongnu.org; Sun, 19 May 2019 04:50:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C4048762B;
	Sun, 19 May 2019 08:50:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-95.ams2.redhat.com
	[10.36.116.95])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B9C8F60C7A;
	Sun, 19 May 2019 08:50:22 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Sun, 19 May 2019 14:18:15 +0530
Message-Id: <20190519084815.7410-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Sun, 19 May 2019 08:50:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] qga: check length of command-line &
 environment variables
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Niu Guoxiang <niuguoxiang@huawei.com>,
	Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Qemu guest agent while executing user commands does not seem to
check length of argument list and/or environment variables passed.
It may lead to integer overflow or infinite loop issues. Add check
to avoid it.

Reported-by: Niu Guoxiang <niuguoxiang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 qga/commands-posix.c   | 18 ++++++++++++++++++
 qga/commands-win32.c   | 13 +++++++++++++
 qga/commands.c         |  8 ++++++--
 qga/guest-agent-core.h |  2 ++
 4 files changed, 39 insertions(+), 2 deletions(-)

Update v2: add helper function ga_get_arg_max()
  -> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06360.html

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 7ee6a33cce..e0455722e0 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -60,6 +60,24 @@ extern char **environ;
 #endif
 #endif
=20
+size_t ga_get_arg_max(void)
+{
+    /* Since kernel 2.6.23, most architectures support argument size lim=
it
+     * derived from the soft RLIMIT_STACK resource limit (see getrlimit(=
2)).
+     * For these architectures, the total size is limited to 1/4 of the
+     * allowed stack size. (see execve(2))
+     *
+     * struct rlimit r;
+     *
+     * getrlimit(RLIMIT_STACK, &r);
+     * ARG_MAX =3D r.rlim_cur / 4;
+     *
+     * ARG_MAX is _NOT_ the maximum number of arguments. It is size of t=
he
+     * memory used to hold command line arguments and environment variab=
les.
+     */
+    return sysconf(_SC_ARG_MAX);
+}
+
 static void ga_wait_child(pid_t pid, int *status, Error **errp)
 {
     pid_t rpid;
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 6b67f16faf..47bbddd74a 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -92,6 +92,19 @@ static OpenFlags guest_file_open_modes[] =3D {
     g_free(suffix); \
 } while (0)
=20
+size_t ga_get_arg_max(void)
+{
+    /* Win32 environment has different values for the ARG_MAX constant.
+     * We'll go with the maximum here.
+     *
+     * https://devblogs.microsoft.com/oldnewthing/?p=3D41553
+     *
+     * ARG_MAX is _NOT_ the maximum number of arguments. It is size of t=
he
+     * memory used to hold command line arguments and environment variab=
les.
+     */
+    return 32767;
+}
+
 static OpenFlags *find_open_flag(const char *mode_str)
 {
     int mode;
diff --git a/qga/commands.c b/qga/commands.c
index 0c7d1385c2..425a4c405f 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -231,17 +231,21 @@ static char **guest_exec_get_args(const strList *en=
try, bool log)
     int count =3D 1, i =3D 0;  /* reserve for NULL terminator */
     char **args;
     char *str; /* for logging array of arguments */
-    size_t str_size =3D 1;
+    size_t str_size =3D 1, arg_max;
=20
+    arg_max =3D ga_get_arg_max();
     for (it =3D entry; it !=3D NULL; it =3D it->next) {
         count++;
         str_size +=3D 1 + strlen(it->value);
+        if (str_size >=3D arg_max || count >=3D arg_max / 2) {
+            break;
+        }
     }
=20
     str =3D g_malloc(str_size);
     *str =3D 0;
     args =3D g_malloc(count * sizeof(char *));
-    for (it =3D entry; it !=3D NULL; it =3D it->next) {
+    for (it =3D entry; it !=3D NULL && i < count; it =3D it->next) {
         args[i++] =3D it->value;
         pstrcat(str, str_size, it->value);
         if (it->next) {
diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index 60eae16f27..300ff7e482 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -46,6 +46,8 @@ const char *ga_fsfreeze_hook(GAState *s);
 int64_t ga_get_fd_handle(GAState *s, Error **errp);
 int ga_parse_whence(GuestFileWhence *whence, Error **errp);
=20
+size_t ga_get_arg_max(void);
+
 #ifndef _WIN32
 void reopen_fd_to_null(int fd);
 #endif
--=20
2.20.1


