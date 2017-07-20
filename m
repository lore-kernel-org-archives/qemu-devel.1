Received: from eggs.gnu.org ([2001:4830:134:3::10]:51328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYESh-0004rz-IW
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYESe-0002ar-D6
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dYESe-0002aQ-6u
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A1E536574B
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 16:29:16 +0000 (UTC)
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
Date: Thu, 20 Jul 2017 18:28:06 +0200
Message-Id: <20170720162815.19802-3-ldoktor@redhat.com>
In-Reply-To: <20170720162815.19802-1-ldoktor@redhat.com>
References: <20170720162815.19802-1-ldoktor@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/11] qemu.py: Avoid dangerous arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ldoktor@redhat.com, apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com

The list object is mutable in python and potentially might modify other
object's arguments when used as default argument. Reproducer:

    >>> vm1 =3D QEMUMachine("qemu")
    >>> vm2 =3D QEMUMachine("qemu")
    >>> vm1._wrapper.append("foo")
    >>> print vm2._wrapper
    ['foo']

In this case the `args` is actually copied so it would be safe to keep
it, but it's not a good practice to keep it.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
---
 scripts/qemu.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 191c916..66fd863 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -23,7 +23,7 @@ import qmp.qmp
 class QEMUMachine(object):
     '''A QEMU VM'''
=20
-    def __init__(self, binary, args=3D[], wrapper=3D[], name=3DNone,
+    def __init__(self, binary, args=3DNone, wrapper=3DNone, name=3DNone,
                  test_dir=3D"/var/tmp", monitor_address=3DNone,
                  socket_scm_helper=3DNone, debug=3DFalse):
         '''
@@ -39,6 +39,10 @@ class QEMUMachine(object):
         @param debug: enable debug mode (forwarded to QMP helper and suc=
h)
         @note: Qemu process is not started until launch() is used.
         '''
+        if args is None:
+            args =3D []
+        if wrapper is None:
+            wrapper =3D []
         if name is None:
             name =3D "qemu-%d" % os.getpid()
         if monitor_address is None:
--=20
2.9.4
