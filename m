Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B89CC73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9582080C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 19:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9582080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkwGP-00028u-NQ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 15:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49424)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkw8j-0005sR-Kg
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 15:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hkw8g-0002rA-Gu
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 15:51:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hkw8c-0002kY-N1
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 15:50:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B6EE7317915D;
 Tue,  9 Jul 2019 19:43:55 +0000 (UTC)
Received: from localhost (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E19292D3A;
 Tue,  9 Jul 2019 19:43:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 23:43:26 +0400
Message-Id: <20190709194330.837-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190709194330.837-1-marcandre.lureau@redhat.com>
References: <20190709194330.837-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 09 Jul 2019 19:43:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/5] docker.py: add podman support
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a --engine option to select either docker, podman or auto.

Among other advantages, podman allows to run rootless & daemonless
containers, fortunately sharing compatible CLI with docker.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/docker/docker.py | 43 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 53a8c9c801..1f59a78b10 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -20,6 +20,7 @@ import hashlib
 import atexit
 import uuid
 import argparse
+import enum
 import tempfile
 import re
 import signal
@@ -38,6 +39,26 @@ FILTERED_ENV_NAMES =3D ['ftp_proxy', 'http_proxy', 'ht=
tps_proxy']
=20
 DEVNULL =3D open(os.devnull, 'wb')
=20
+class EngineEnum(enum.IntEnum):
+    AUTO =3D 1
+    DOCKER =3D 2
+    PODMAN =3D 3
+
+    def __str__(self):
+        return self.name.lower()
+
+    def __repr__(self):
+        return str(self)
+
+    @staticmethod
+    def argparse(s):
+        try:
+            return EngineEnum[s.upper()]
+        except KeyError:
+            return s
+
+
+USE_ENGINE =3D EngineEnum.AUTO
=20
 def _text_checksum(text):
     """Calculate a digest string unique to the text content"""
@@ -48,9 +69,14 @@ def _file_checksum(filename):
     return _text_checksum(open(filename, 'rb').read())
=20
=20
-def _guess_docker_command():
-    """ Guess a working docker command or raise exception if not found""=
"
-    commands =3D [["docker"], ["sudo", "-n", "docker"]]
+def _guess_engine_command():
+    """ Guess a working engine command or raise exception if not found""=
"
+    commands =3D []
+
+    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.PODMAN]:
+        commands +=3D [["podman"]]
+    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.DOCKER]:
+        commands +=3D [["docker"], ["sudo", "-n", "docker"]]
     for cmd in commands:
         try:
             # docker version will return the client details in stdout
@@ -61,7 +87,7 @@ def _guess_docker_command():
         except OSError:
             pass
     commands_txt =3D "\n".join(["  " + " ".join(x) for x in commands])
-    raise Exception("Cannot find working docker command. Tried:\n%s" %
+    raise Exception("Cannot find working engine command. Tried:\n%s" %
                     commands_txt)
=20
=20
@@ -190,7 +216,7 @@ def _dockerfile_preprocess(df):
 class Docker(object):
     """ Running Docker commands """
     def __init__(self):
-        self._command =3D _guess_docker_command()
+        self._command =3D _guess_engine_command()
         self._instances =3D []
         atexit.register(self._kill_instances)
         signal.signal(signal.SIGTERM, self._kill_instances)
@@ -502,6 +528,8 @@ class ProbeCommand(SubCommand):
                 print("yes")
             elif docker._command[0] =3D=3D "sudo":
                 print("sudo")
+            elif docker._command[0] =3D=3D "podman":
+                print("podman")
         except Exception:
             print("no")
=20
@@ -597,9 +625,13 @@ class CheckCommand(SubCommand):
=20
=20
 def main():
+    global USE_ENGINE
+
     parser =3D argparse.ArgumentParser(description=3D"A Docker helper",
                                      usage=3D"%s <subcommand> ..." %
                                      os.path.basename(sys.argv[0]))
+    parser.add_argument("--engine", type=3DEngineEnum.argparse, choices=3D=
list(EngineEnum),
+                        help=3D"specify which container engine to use")
     subparsers =3D parser.add_subparsers(title=3D"subcommands", help=3DN=
one)
     for cls in SubCommand.__subclasses__():
         cmd =3D cls()
@@ -608,6 +640,7 @@ def main():
         cmd.args(subp)
         subp.set_defaults(cmdobj=3Dcmd)
     args, argv =3D parser.parse_known_args()
+    USE_ENGINE =3D args.engine
     return args.cmdobj.run(args, argv)
=20
=20
--=20
2.22.0.214.g8dca754b1e


