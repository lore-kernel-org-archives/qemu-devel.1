Received: from eggs.gnu.org ([2001:4830:134:3::10]:52764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxC0b-0000vZ-6Y
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxC0R-0006fa-Nj
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxC0R-0006fK-Hd
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:04:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76B1381229
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 13:04:02 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 10:03:35 -0300
Message-Id: <20170927130339.21444-2-ehabkost@redhat.com>
In-Reply-To: <20170927130339.21444-1-ehabkost@redhat.com>
References: <20170927130339.21444-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] guestperf: Configure logging on all shell
 frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

The logging module will eventually replace the 'debug' parameter
in QEMUMachine and QEMUMonitorProtocol.

Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/migration/guestperf/shell.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestperf/shell.py
index 7992459a97..e378cf0cfa 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -26,6 +26,7 @@ sys.path.append(os.path.join(os.path.dirname(__file__),
 import argparse
 import fnmatch
 import platform
+import logging
 
 from guestperf.hardware import Hardware
 from guestperf.engine import Engine
@@ -64,6 +65,11 @@ class BaseShell(object):
 
         self._parser = parser
 
+    def init_logging(self, args):
+        logging.basicConfig(level=(logging.DEBUG if args.debug else
+                                   logging.INFO if args.verbose else
+                                   logging.WARN))
+
     def get_engine(self, args):
         return Engine(binary=args.binary,
                       dst_host=args.dst_host,
@@ -147,6 +153,7 @@ class Shell(BaseShell):
 
     def run(self, argv):
         args = self._parser.parse_args(argv)
+        self.init_logging(args)
 
         engine = self.get_engine(args)
         hardware = self.get_hardware(args)
@@ -179,6 +186,7 @@ class BatchShell(BaseShell):
 
     def run(self, argv):
         args = self._parser.parse_args(argv)
+        self.init_logging(args)
 
         engine = self.get_engine(args)
         hardware = self.get_hardware(args)
@@ -231,6 +239,7 @@ class PlotShell(object):
 
     def run(self, argv):
         args = self._parser.parse_args(argv)
+        self.init_logging(args)
 
         if len(args.reports) == 0:
             print >>sys.stderr, "At least one report required"
-- 
2.13.5
