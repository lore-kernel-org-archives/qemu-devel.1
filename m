Received: from eggs.gnu.org ([2001:4830:134:3::10]:44826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFm44-0003wI-6s
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFm41-0003YA-1b
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:40:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dFm40-0003Wt-Rf
	for qemu-devel@nongnu.org; Tue, 30 May 2017 14:40:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 30 May 2017 15:40:13 -0300
Message-Id: <20170530184013.31044-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] numa: Fix format string for "Invalid node"
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, He Chen <he.chen@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Some compilers complain about the PRIu16 format string with the
MAX(src, dst) and MAX_NODES arguments.  Example output from Apple LLVM
version 7.3.0 (clang-703.0.31):

  numa.c:236:20: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                     MAX(src, dst), MAX_NODES);
  ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
  include/qapi/error.h:163:35: note: expanded from macro 'error_setg'
                          (fmt), ## __VA_ARGS__)
                                    ^~~~~~~~~~~
  glib/2.52.2/include/glib-2.0/glib/gmacros.h:288:20: note: expanded from macro 'MAX'
  #define MAX(a, b)  (((a) > (b)) ? (a) : (b))
                     ^~~~~~~~~~~~~~~~~~~~~~~~~
  numa.c:236:35: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
                     MAX(src, dst), MAX_NODES);
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
  include/qapi/error.h:163:35: note: expanded from macro 'error_setg'
                          (fmt), ## __VA_ARGS__)
                                    ^~~~~~~~~~~
  include/sysemu/sysemu.h:165:19: note: expanded from macro 'MAX_NODES'
  #define MAX_NODES 128
                    ^~~
MAX(src, dst) promotes the src and dst arguments to int, and MAX_NODES
is an int.  Use %d to silence those warnings.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 numa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/numa.c b/numa.c
index ca731455e9..be50c62aa9 100644
--- a/numa.c
+++ b/numa.c
@@ -231,8 +231,7 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
 
     if (src >= MAX_NODES || dst >= MAX_NODES) {
         error_setg(errp,
-                   "Invalid node %" PRIu16
-                   ", max possible could be %" PRIu16,
+                   "Invalid node %d, max possible could be %d",
                    MAX(src, dst), MAX_NODES);
         return;
     }
-- 
2.11.0.259.g40922b1
