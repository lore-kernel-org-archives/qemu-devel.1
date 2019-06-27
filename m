Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0256DC4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 21:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3E82133F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 21:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3E82133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgbzi-0006l7-6W
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 17:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59979)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hgbwf-0004ve-T9
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 17:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hgbwe-0007fD-RC
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 17:28:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hgbwc-0007ZW-B5; Thu, 27 Jun 2019 17:28:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8879C81F1B;
 Thu, 27 Jun 2019 21:28:29 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F96E5D978;
 Thu, 27 Jun 2019 21:28:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 17:28:16 -0400
Message-Id: <20190627212816.27298-4-jsnow@redhat.com>
In-Reply-To: <20190627212816.27298-1-jsnow@redhat.com>
References: <20190627212816.27298-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 27 Jun 2019 21:28:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH v2 3/3] QEMUMachine: Don't suppress stack
 traces on close
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do need to run cleanup, but we should re-raise the error.

Rename _post_shutdown to _shutdown_cleanup, then use the
_post_shutdown name for the routine that will always run
at the conclusion of the shutdown() method.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine.py | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 49445e675b..b36f0c3ef9 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -264,7 +264,8 @@ class QEMUMachine(object):
     def _post_launch(self):
         self._qmp.accept()
=20
-    def _post_shutdown(self):
+    def _shutdown_cleanup(self):
+        self._load_io_log()
         if self._qemu_log_file is not None:
             self._qemu_log_file.close()
             self._qemu_log_file =3D None
@@ -326,8 +327,20 @@ class QEMUMachine(object):
         """
         self._popen.wait()
         self._qmp.close()
-        self._load_io_log()
-        self._post_shutdown()
+        self._shutdown_cleanup()
+
+    def _post_shutdown(self):
+        self._shutdown_cleanup()
+        exitcode =3D self.exitcode()
+        if exitcode is not None and exitcode < 0:
+            msg =3D 'qemu received signal %i: %s'
+            if self._qemu_full_args:
+                command =3D ' '.join(self._qemu_full_args)
+            else:
+                command =3D ''
+            LOG.warning(msg, -int(exitcode), command)
+
+        self._launched =3D False
=20
     def shutdown(self):
         """
@@ -339,21 +352,13 @@ class QEMUMachine(object):
                 self._qmp.close()
             except:
                 self._popen.kill()
-            self._popen.wait()
-
-        self._load_io_log()
-        self._post_shutdown()
-
-        exitcode =3D self.exitcode()
-        if exitcode is not None and exitcode < 0:
-            msg =3D 'qemu received signal %i: %s'
-            if self._qemu_full_args:
-                command =3D ' '.join(self._qemu_full_args)
-            else:
-                command =3D ''
-            LOG.warning(msg, -exitcode, command)
-
-        self._launched =3D False
+                # Don't hide exceptions from crashes
+                raise
+            finally:
+                self._popen.wait()
+                self._post_shutdown()
+        else:
+            self._post_shutdown()
=20
     def qmp(self, cmd, conv_keys=3DTrue, **args):
         """
--=20
2.21.0


