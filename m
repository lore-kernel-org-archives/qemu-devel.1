Received: from eggs.gnu.org ([209.51.188.92]:49161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nshah@disroot.org>) id 1gjq0i-0004dv-JI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nshah@disroot.org>) id 1gjq0h-0000uz-KK
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:33:56 -0500
From: Nisarg Shah <nshah@disroot.org>
Date: Thu, 17 Jan 2019 00:03:58 +0530
Message-Id: <20190116183358.30287-1-nshah@disroot.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] device-crash-test: Convert to Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, ehabkost@redhat.com, Nisarg Shah <nshah@disroot.org>

Apply 2to3 tool to scripts/device-crash-test.
Restrict whitelist entry stats in debug mode to be sorted only by "count"=
, since Python 3 does
not implicitly support comparing dictionaries.

Signed-off-by: Nisarg Shah <nshah@disroot.org>
---
 scripts/device-crash-test | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index e93a7c0c84..ecdc9828c2 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -23,7 +23,7 @@
 Run QEMU with all combinations of -machine and -device types,
 check for crashes and unexpected errors.
 """
-from __future__ import print_function
+
=20
 import sys
 import os
@@ -272,7 +272,7 @@ def qemuOptsEscape(s):
=20
 def formatTestCase(t):
     """Format test case info as "key=3Dvalue key=3Dvalue" for prettier l=
ogging output"""
-    return ' '.join('%s=3D%s' % (k, v) for k, v in t.items())
+    return ' '.join('%s=3D%s' % (k, v) for k, v in list(t.items()))
=20
=20
 def qomListTypeNames(vm, **kwargs):
@@ -574,7 +574,8 @@ def main():
         logger.info("Skipped %d test cases", skipped)
=20
     if args.debug:
-        stats =3D sorted([(len(wl_stats.get(i, [])), wl) for i, wl in en=
umerate(ERROR_WHITELIST)])
+        stats =3D sorted([(len(wl_stats.get(i, [])), wl) for i, wl in
+                         enumerate(ERROR_WHITELIST)], key=3Dlambda x: x[=
0])
         for count, wl in stats:
             dbg("whitelist entry stats: %d: %r", count, wl)
=20
--=20
2.19.2
