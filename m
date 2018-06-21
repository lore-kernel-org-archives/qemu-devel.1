Received: from eggs.gnu.org ([2001:4830:134:3::10]:57717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fW3nV-0006RH-EK
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fW3nQ-0002uo-Gw
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:55:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fW3nQ-0002uf-9P
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:55:00 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 153F483F3E
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 17:54:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 21 Jun 2018 14:54:51 -0300
Message-Id: <20180621175451.7948-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] Partially revert "python: futurize -f
 libfuturize.fixes.fix_absolute_import"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>

Since commit 068cf7a44cd4d65c05aa877dbebced295be5ce44, qmp-shell
is broken:

  $ ./scripts/qmp/qmp-shell
  Traceback (most recent call last):
    File "./scripts/qmp/qmp-shell", line 70, in <module>
      from . import qmp
  ValueError: Attempted relative import in non-package

Relative imports don't work on scripts that are executed
directly, so revert the change on the scripts inside scripts/qmp.

Fixes: 068cf7a44cd4d65c05aa877dbebced295be5ce44
Reported-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qmp/qemu-ga-client | 3 +--
 scripts/qmp/qmp            | 3 +--
 scripts/qmp/qmp-shell      | 3 +--
 scripts/qmp/qom-fuse       | 3 +--
 scripts/qmp/qom-get        | 3 +--
 scripts/qmp/qom-list       | 3 +--
 scripts/qmp/qom-set        | 3 +--
 scripts/qmp/qom-tree       | 3 +--
 8 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index 976e69e05f..e8cb7646a0 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -37,11 +37,10 @@
 #
 
 from __future__ import print_function
-from __future__ import absolute_import
 import base64
 import random
 
-from . import qmp
+import qmp
 
 
 class QemuGuestAgent(qmp.QEMUMonitorProtocol):
diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
index 33a0d6b73a..6cb46fdae2 100755
--- a/scripts/qmp/qmp
+++ b/scripts/qmp/qmp
@@ -11,9 +11,8 @@
 # See the COPYING file in the top-level directory.
 
 from __future__ import print_function
-from __future__ import absolute_import
 import sys, os
-from .qmp import QEMUMonitorProtocol
+from qmp import QEMUMonitorProtocol
 
 def print_response(rsp, prefix=[]):
     if type(rsp) == list:
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 26418dab95..a42306dd89 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -66,8 +66,7 @@
 # sent to QEMU, which is useful for debugging and documentation generation.
 
 from __future__ import print_function
-from __future__ import absolute_import
-from . import qmp
+import qmp
 import json
 import ast
 import readline
diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index e524e798fc..4d85970a78 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -11,12 +11,11 @@
 # the COPYING file in the top-level directory.
 ##
 
-from __future__ import absolute_import
 import fuse, stat
 from fuse import Fuse
 import os, posix
 from errno import *
-from .qmp import QEMUMonitorProtocol
+from qmp import QEMUMonitorProtocol
 
 fuse.fuse_python_api = (0, 2)
 
diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index a3f5d7660e..ec5275d53a 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -12,10 +12,9 @@
 ##
 
 from __future__ import print_function
-from __future__ import absolute_import
 import sys
 import os
-from .qmp import QEMUMonitorProtocol
+from qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 2ba25e1792..0f97440973 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -12,10 +12,9 @@
 ##
 
 from __future__ import print_function
-from __future__ import absolute_import
 import sys
 import os
-from .qmp import QEMUMonitorProtocol
+from qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index 0352668812..26ed9e3263 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -12,10 +12,9 @@
 ##
 
 from __future__ import print_function
-from __future__ import absolute_import
 import sys
 import os
-from .qmp import QEMUMonitorProtocol
+from qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index 32e708a13e..31603c681f 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -14,10 +14,9 @@
 ##
 
 from __future__ import print_function
-from __future__ import absolute_import
 import sys
 import os
-from .qmp import QEMUMonitorProtocol
+from qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
-- 
2.18.0.rc1.1.g3f1ff2140
