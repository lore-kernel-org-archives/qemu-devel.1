Received: from eggs.gnu.org ([2001:4830:134:3::10]:38434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9afU-0005vr-C4
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9afP-0001ED-EP
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9afP-0001AD-3A
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:21:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:36 -0300
Message-Id: <20180420181951.7252-10-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 09/24] avocado_qemu: Ignore kernel messages on
 get_console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

The get_console (and _handle_prompt) uses the last non-empty line to
check what is going on, but when debug is enabled, kernel produces lots
of lines spoiling the output. Let's also ignore the messages that looks
like kernel debugs ([  $float] $msg).

This significantly improves the results on my machine with JeOS and
enabled debug.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/avocado_qemu/test.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_q=
emu/test.py
index 9dc6c1ef91..966936a52f 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -26,6 +26,7 @@ extra features intended for Qemu testing.
=20
 import logging
 import os
+import re
 import sys
 import time
 import uuid
@@ -120,6 +121,17 @@ def _handle_prompts(session, username, password, pro=
mpt, timeout=3D60,
     :return: If connect succeed return the output text to script for fur=
ther
              debug.
     """
+    re_kernel_message =3D re.compile(r"^\[\s*\d+.\d+\] ")
+
+    def get_last_nonempty_line(cont):
+        """Return last non-empty non-kernel line"""
+        nonempty_lines =3D [_ for _ in cont.splitlines()
+                          if _.strip() and not re_kernel_message.match(_=
)]
+        if nonempty_lines:
+            return nonempty_lines[-1]
+        else:
+            return ""
+
     password_prompt_count =3D 0
     login_prompt_count =3D 0
     last_chance =3D False
@@ -128,7 +140,7 @@ def _handle_prompts(session, username, password, prom=
pt, timeout=3D60,
     output =3D ""
     while True:
         try:
-            match, text =3D session.read_until_last_line_matches(
+            match, text =3D session.read_until_output_matches(
                 [r"[Aa]re you sure", r"[Pp]assword:\s*",
                  # Prompt of rescue mode for Red Hat.
                  r"\(or (press|type) Control-D to continue\):\s*",
@@ -137,7 +149,7 @@ def _handle_prompts(session, username, password, prom=
pt, timeout=3D60,
                  r"[Cc]onnection.*closed", r"[Cc]onnection.*refused",
                  r"[Pp]lease wait", r"[Ww]arning", r"[Ee]nter.*username"=
,
                  r"[Ee]nter.*password", r"[Cc]onnection timed out", prom=
pt,
-                 r"Escape character is.*"],
+                 r"Escape character is.*"], get_last_nonempty_line,
                 timeout=3Dtimeout, internal_timeout=3D0.5)
             output +=3D text
             if match =3D=3D 0:  # "Are you sure you want to continue con=
necting"
--=20
2.14.3
