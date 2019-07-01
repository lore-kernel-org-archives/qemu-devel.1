Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0D9C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E96214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E96214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvhh-0002Jw-TE
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hhvaC-0003Jy-OJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hhva9-0000NP-3J
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:38:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hhva8-0000BV-Ol
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:38:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A0043091740;
 Mon,  1 Jul 2019 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.33.36.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B9AB18376;
 Mon,  1 Jul 2019 12:38:29 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Qemu Developers <qemu-devel@nongnu.org>
Date: Mon,  1 Jul 2019 18:05:58 +0530
Message-Id: <20190701123558.30512-4-ppandit@redhat.com>
In-Reply-To: <20190701123558.30512-1-ppandit@redhat.com>
References: <20190701123558.30512-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 01 Jul 2019 12:38:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/3] net: tap: refactor
 net_bridge_run_helper routine
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
Cc: Riccardo Schirone <rschiron@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Refactor 'net_bridge_run_helper' routine to avoid buffer
formatting to prepare 'helper_cmd' and using shell to invoke
helper command. Instead directly execute helper program with
due arguments.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 net/tap.c | 43 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

Update v3: remove buffer formatting and use of shell to invoke helper
  -> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00071.html

diff --git a/net/tap.c b/net/tap.c
index e8aadd8d4b..bc9b3407a6 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -478,7 +478,6 @@ static int net_bridge_run_helper(const char *helper, =
const char *bridge,
     sigset_t oldmask, mask;
     int pid, status;
     char *args[5];
-    char **parg;
     int sv[2];
=20
     sigemptyset(&mask);
@@ -498,9 +497,6 @@ static int net_bridge_run_helper(const char *helper, =
const char *bridge,
     }
     if (pid =3D=3D 0) {
         int open_max =3D sysconf(_SC_OPEN_MAX), i;
-        char fd_buf[6+10];
-        char br_buf[6+IFNAMSIZ] =3D {0};
-        char helper_cmd[PATH_MAX + sizeof(fd_buf) + sizeof(br_buf) + 15]=
;
=20
         for (i =3D 3; i < open_max; i++) {
             if (i !=3D sv[1]) {
@@ -508,39 +504,18 @@ static int net_bridge_run_helper(const char *helper=
, const char *bridge,
             }
         }
=20
-        snprintf(fd_buf, sizeof(fd_buf), "%s%d", "--fd=3D", sv[1]);
+        args[0] =3D (char *)helper;
+        args[1] =3D (char *)"--use-vnet";
+        args[2] =3D g_strdup_printf("%s%d", "--fd=3D", sv[1]);
+        args[3] =3D g_strdup_printf("%s%s", "--br=3D", bridge);
+        args[4] =3D NULL;
=20
-        if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
-            /* assume helper is a command */
+        execv(helper, args);
=20
-            if (strstr(helper, "--br=3D") =3D=3D NULL) {
-                snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=3D", brid=
ge);
-            }
+        g_free(args[2]);
+        g_free(args[3]);
+        fprintf(stderr, "failed to execute helper: %s\n", helper);
=20
-            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s",
-                     helper, "--use-vnet", fd_buf, br_buf);
-
-            parg =3D args;
-            *parg++ =3D (char *)"sh";
-            *parg++ =3D (char *)"-c";
-            *parg++ =3D helper_cmd;
-            *parg++ =3D NULL;
-
-            execv("/bin/sh", args);
-        } else {
-            /* assume helper is just the executable path name */
-
-            snprintf(br_buf, sizeof(br_buf), "%s%s", "--br=3D", bridge);
-
-            parg =3D args;
-            *parg++ =3D (char *)helper;
-            *parg++ =3D (char *)"--use-vnet";
-            *parg++ =3D fd_buf;
-            *parg++ =3D br_buf;
-            *parg++ =3D NULL;
-
-            execv(helper, args);
-        }
         _exit(1);
=20
     } else {
--=20
2.21.0


