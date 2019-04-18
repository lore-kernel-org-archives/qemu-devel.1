Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A3C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83072054F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83072054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHE5R-0000TM-2p
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:56:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0S-00055e-Ba
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0R-0005A7-4B
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0Q-00059G-Se
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5B81C05681F
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 85E7560852;
	Thu, 18 Apr 2019 20:51:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id F28B91132BB6; Thu, 18 Apr 2019 22:51:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:51:00 +0200
Message-Id: <20190418205135.6686-2-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Thu, 18 Apr 2019 20:51:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 01/36] qemu-io: Use
 error_[gs]et_progname()
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
Cc: Christophe Fergeau <cfergeau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418205100.wz5XIBY077FB6EF9xp5nuo_CZOQPAYsNGzVq7YOxKhA@z>

From: Christophe Fergeau <cfergeau@redhat.com>

qemu-io reimplements itself what
error_get_progname()/error_set_progname() already does.
This commit switches it to use this API from qemu-error.h

Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190131164614.19209-2-cfergeau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-io.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 6df7731af4..2c52ac0ade 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -34,8 +34,6 @@
 
 #define CMD_NOFILE_OK   0x01
 
-static char *progname;
-
 static BlockBackend *qemuio_blk;
 static bool quit_qemu_io;
 
@@ -312,7 +310,7 @@ static char *get_prompt(void)
     static char prompt[FILENAME_MAX + 2 /*"> "*/ + 1 /*"\0"*/ ];
 
     if (!prompt[0]) {
-        snprintf(prompt, sizeof(prompt), "%s> ", progname);
+        snprintf(prompt, sizeof(prompt), "%s> ", error_get_progname());
     }
 
     return prompt;
@@ -525,7 +523,7 @@ int main(int argc, char **argv)
 #endif
 
     module_call_init(MODULE_INIT_TRACE);
-    progname = g_path_get_basename(argv[0]);
+    error_set_progname(argv[0]);
     qemu_init_exec_dir(argv[0]);
 
     qcrypto_init(&error_fatal);
@@ -580,10 +578,10 @@ int main(int argc, char **argv)
             break;
         case 'V':
             printf("%s version " QEMU_FULL_VERSION "\n"
-                   QEMU_COPYRIGHT "\n", progname);
+                   QEMU_COPYRIGHT "\n", error_get_progname());
             exit(0);
         case 'h':
-            usage(progname);
+            usage(error_get_progname());
             exit(0);
         case 'U':
             force_share = true;
@@ -600,13 +598,13 @@ int main(int argc, char **argv)
             imageOpts = true;
             break;
         default:
-            usage(progname);
+            usage(error_get_progname());
             exit(1);
         }
     }
 
     if ((argc - optind) > 1) {
-        usage(progname);
+        usage(error_get_progname());
         exit(1);
     }
 
-- 
2.17.2


