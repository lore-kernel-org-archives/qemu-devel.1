Received: from eggs.gnu.org ([2001:4830:134:3::10]:39868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvJ-0000CD-TA
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvI-0008Mt-OL
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:17 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Mar 2017 10:55:59 +0200
Message-Id: <1490691368-32099-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1490691368-32099-1-git-send-email-armbru@redhat.com>
References: <1490691368-32099-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 for-2.9 01/10] rbd: Reject -blockdev
 server.*.{numeric, to, ipv4, ipv6}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

We use InetSocketAddress in the QAPI schema.  However, the code
doesn't use inet_connect_saddr(), but formats "host" and "port" into a
configuration string for rados_conf_set().  Thus, members "numeric",
"to", "ipv4" and "ipv6" are silently ignored.  Not nice.  Example:

    -blockdev rbd,node-name=nn,pool=p,image=i,server.0.host=h0,server.0.port=12345,server.0.ipv4=off

Factor a suitable InetSocketAddressBase out of InetSocketAddress, and
use that.  "numeric", "to", "ipv4" and "ipv6" are now rejected.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 qapi-schema.json     | 21 ++++++++++++++-------
 qapi/block-core.json |  2 +-
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 68a4327..b921994 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4051,19 +4051,27 @@
   'data': [ 'all', 'rx', 'tx' ] }
 
 ##
+# @InetSocketAddressBase:
+#
+# @host: host part of the address
+# @port: port part of the address
+##
+{ 'struct': 'InetSocketAddressBase',
+  'data': {
+    'host': 'str',
+    'port': 'str' } }
+
+##
 # @InetSocketAddress:
 #
 # Captures a socket address or address range in the Internet namespace.
 #
-# @host: host part of the address
-#
-# @port: port part of the address, or lowest port if @to is present
-#
 # @numeric: true if the host/port are guaranteed to be numeric,
 #           false if name resolution should be attempted. Defaults to false.
 #           (Since 2.9)
 #
-# @to: highest port to try
+# @to: If present, this is range of possible addresses, with port
+#      between @port and @to.
 #
 # @ipv4: whether to accept IPv4 addresses, default try both IPv4 and IPv6
 #
@@ -4072,9 +4080,8 @@
 # Since: 1.3
 ##
 { 'struct': 'InetSocketAddress',
+  'base': 'InetSocketAddressBase',
   'data': {
-    'host': 'str',
-    'port': 'str',
     '*numeric':  'bool',
     '*to': 'uint16',
     '*ipv4': 'bool',
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0f132fc..5d2efe4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2652,7 +2652,7 @@
             '*conf': 'str',
             '*snapshot': 'str',
             '*user': 'str',
-            '*server': ['InetSocketAddress'],
+            '*server': ['InetSocketAddressBase'],
             '*auth-supported': ['RbdAuthMethod'],
             '*password-secret': 'str' } }
 
-- 
2.7.4
