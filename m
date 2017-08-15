Received: from eggs.gnu.org ([2001:4830:134:3::10]:56950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dhXft-0002rV-95
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dhXfo-0006eC-EL
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:58:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dhXfo-0006cL-8n
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:58:04 -0400
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Tue, 15 Aug 2017 10:57:26 +0200
Message-Id: <20170815085732.9794-5-ldoktor@redhat.com>
In-Reply-To: <20170815085732.9794-1-ldoktor@redhat.com>
References: <20170815085732.9794-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 04/10] qemu.py: Simplify QMP key-conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ldoktor@redhat.com, famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, f4bug@amsat.org

The QMP key conversion consist of '_'s to be replaced with '-'s, which
can easily be done by a single `str.replace` method which is faster and
does not require `string` module import.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qemu.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 571f852..5ba17d0 100644
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
@@ -180,14 +179,12 @@ class QEMUMachine(object):
             self._load_io_log()
             self._post_shutdown()
=20
-    underscore_to_dash =3D string.maketrans('_', '-')
-
     def qmp(self, cmd, conv_keys=3DTrue, **args):
         '''Invoke a QMP command and return the result dict'''
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
2.9.4
