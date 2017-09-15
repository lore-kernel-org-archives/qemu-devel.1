Received: from eggs.gnu.org ([2001:4830:134:3::10]:56313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0BW-0005Bh-Sd
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0BT-0001Lu-Qf
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0BT-0001Ku-LF
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 19:38:07 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Sep 2017 20:37:28 -0300
Message-Id: <20170915233739.26860-5-ehabkost@redhat.com>
In-Reply-To: <20170915233739.26860-1-ehabkost@redhat.com>
References: <20170915233739.26860-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/15] qemu.py: Simplify QMP key-conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <apahim@redhat.com>

From: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

The QMP key conversion consist of '_'s to be replaced with '-'s, which
can easily be done by a single `str.replace` method which is faster and
does not require `string` module import.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170818142613.32394-5-ldoktor@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index d8c169b31e..bde8da8fe7 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -13,7 +13,6 @@
 #
=20
 import errno
-import string
 import os
 import sys
 import subprocess
@@ -195,14 +194,12 @@ class QEMUMachine(object):
             self._load_io_log()
             self._post_shutdown()
=20
-    underscore_to_dash =3D string.maketrans('_', '-')
-
     def qmp(self, cmd, conv_keys=3DTrue, **args):
         '''Invoke a QMP command and return the response dict'''
         qmp_args =3D dict()
         for key, value in args.iteritems():
             if conv_keys:
-                qmp_args[key.translate(self.underscore_to_dash)] =3D val=
ue
+                qmp_args[key.replace('_', '-')] =3D value
             else:
                 qmp_args[key] =3D value
=20
--=20
2.13.5
