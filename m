Received: from eggs.gnu.org ([2001:4830:134:3::10]:60269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csUfU-00026p-TP
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csUfO-0006Nr-Fd
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csUfO-0006ND-5W
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C04F3F725
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 13:26:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Mar 2017 15:26:25 +0200
Message-Id: <1490621195-2228-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-1-git-send-email-armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 for-2.9 01/11] rbd: Reject -blockdev
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
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

We use InetSocketAddress in the QAPI schema.  However, the code
doesn't use inet_connect_saddr(), but formats "host" and "port" into a
configuration string for rados_conf_set().  Thus, members "numeric",
"to", "ipv4" and "ipv6" are silently ignored.  Not nice.  Example:

    -blockdev rbd,node-name=nn,pool=p,image=i,server.0.host=h0,server.0.port=12345,server.0.ipv4=off

Factor a suitable InetSocketAddressBase out of InetSocketAddress, and
use that.  "numeric", "to", "ipv4" and "ipv6" are now rejected.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
