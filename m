Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01834C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 22:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29BA20724
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 22:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29BA20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igGD4-0002yF-TF
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 17:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jocke@infinera.com>) id 1igFGk-0002PV-L2
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jocke@infinera.com>) id 1igFGj-0008Dj-2Y
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:48:10 -0500
Received: from [31.15.61.139] (port=53679 helo=smtp.transmode.se)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <jocke@infinera.com>) id 1igFGi-0007rc-Qy
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:48:08 -0500
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com
 [10.210.71.11])
 by smtp.transmode.se (Postfix) with ESMTP id 35153118C7C6;
 Sat, 14 Dec 2019 13:20:25 +0100 (CET)
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com
 [127.0.0.1])
 by gentoo-jocke.infinera.com (8.15.2/8.14.9) with ESMTP id xBECKO5P017611;
 Sat, 14 Dec 2019 13:20:25 +0100
Received: (from jocke@localhost)
 by gentoo-jocke.infinera.com (8.15.2/8.15.2/Submit) id xBECKO39017610;
 Sat, 14 Dec 2019 13:20:24 +0100
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: make binfmt flag O require P
Date: Sat, 14 Dec 2019 13:20:22 +0100
Message-Id: <20191214122022.17255-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 31.15.61.139
X-Mailman-Approved-At: Sat, 14 Dec 2019 17:47:43 -0500
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
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>

QEMU can autodetect if it is started from Linux binfmt loader
when binfmt flag O is on.
Use that and require binfmt flag P as well which will enable QEMU
to pass in correct argv0 to the application.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
---
 linux-user/main.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 6ff7851e86..1b626e5762 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -544,7 +544,7 @@ static void usage(int exitcode)
     exit(exitcode);
 }
=20
-static int parse_args(int argc, char **argv)
+static int parse_args(int argc, char **argv, int assume_P_flag)
 {
     const char *r;
     int optind;
@@ -560,7 +560,17 @@ static int parse_args(int argc, char **argv)
             arginfo->handle_opt(r);
         }
     }
-
+    if (assume_P_flag) {
+        /* Assume started by binmisc and binfmt P flag is set */
+        if (argc < 3) {
+            fprintf(stderr, "%s: Please use me through binfmt with P fla=
g\n",
+                    argv[0]);
+            exit(1);
+        }
+        exec_path =3D argv[1];
+        /* Next argv must be argv0 for the app */
+        return 2;
+    }
     optind =3D 1;
     for (;;) {
         if (optind >=3D argc) {
@@ -659,7 +669,8 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_trace_opts);
     qemu_plugin_add_opts();
=20
-    optind =3D parse_args(argc, argv);
+    execfd =3D qemu_getauxval(AT_EXECFD);
+    optind =3D parse_args(argc, argv,  execfd > 0);
=20
     if (!trace_init_backends()) {
         exit(1);
@@ -682,7 +693,6 @@ int main(int argc, char **argv, char **envp)
=20
     init_qemu_uname_release();
=20
-    execfd =3D qemu_getauxval(AT_EXECFD);
     if (execfd =3D=3D 0) {
         execfd =3D open(exec_path, O_RDONLY);
         if (execfd < 0) {
--=20
2.24.1


