Received: from eggs.gnu.org ([2001:4830:134:3::10]:52373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cv1MU-0001LX-1M
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cv1MP-00011u-Lw
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:34 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cv1MP-000118-FS
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:45:29 -0400
Received: by mail-wr0-x229.google.com with SMTP id k6so162836978wre.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:45:27 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  3 Apr 2017 13:45:16 +0100
Message-Id: <20170403124524.10824-2-alex.bennee@linaro.org>
In-Reply-To: <20170403124524.10824-1-alex.bennee@linaro.org>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 1/9] scripts/qemugdb/mtree.py: fix up
 mtree dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dovgaluk@ispras.ru, rth@twiddle.net, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Since QEMU has been able to build with native Int128 support this was
broken as it attempts to fish values out of the non-existent
structure. Also the alias print was trying to make a %x out of
gdb.ValueType directly which didn't seem to work.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/qemugdb/mtree.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/qemugdb/mtree.py b/scripts/qemugdb/mtree.py
index cc8131c2e7..e6791b7885 100644
--- a/scripts/qemugdb/mtree.py
+++ b/scripts/qemugdb/mtree.py
@@ -21,7 +21,15 @@ def isnull(ptr):
     return ptr == gdb.Value(0).cast(ptr.type)
 
 def int128(p):
-    return int(p['lo']) + (int(p['hi']) << 64)
+    '''Read an Int128 type to a python integer.
+
+    QEMU can be built with native Int128 support so we need to detect
+    if the value is a structure or the native type.
+    '''
+    if p.type.code == gdb.TYPE_CODE_STRUCT:
+        return int(p['lo']) + (int(p['hi']) << 64)
+    else:
+        return int(("%s" % p), 16)
 
 class MtreeCommand(gdb.Command):
     '''Display the memory tree hierarchy'''
@@ -69,7 +77,7 @@ class MtreeCommand(gdb.Command):
             gdb.write('%s    alias: %s@%016x (@ %s)\n' %
                       ('  ' * level,
                        alias['name'].string(),
-                       ptr['alias_offset'],
+                       int(ptr['alias_offset']),
                        alias,
                        ),
                       gdb.STDOUT)
-- 
2.11.0
