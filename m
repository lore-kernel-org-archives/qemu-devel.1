Received: from eggs.gnu.org ([2001:4830:134:3::10]:40002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAVr-00065Q-B1
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAVn-0000Ig-Ro
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPAVn-0000IL-N6
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:31 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4C7B81250
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:03:31 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  5 Jan 2017 16:03:14 +0000
Message-Id: <20170105160321.21786-2-berrange@redhat.com>
In-Reply-To: <20170105160321.21786-1-berrange@redhat.com>
References: <20170105160321.21786-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 1/8] sockets: add ability to disable DNS
 resolution for InetSocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add a 'numeric' flag to the InetSocketAddress struct to allow the
caller to indicate that DNS should be skipped for the host/port
fields. This is useful if the caller knows the address is already
numeric and wants to guarantee no (potentially blocking) DNS
lookups are attempted.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qapi-schema.json    | 5 +++++
 util/qemu-sockets.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index a0d3b5d..d605c1e 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3070,6 +3070,10 @@
 #
 # @port: port part of the address, or lowest port if @to is present
 #
+# @numeric: #optional true if the host/port are guaranteed to be numeric,
+#           false if name resolution should be attempted. Defaults to false.
+#           Since 2.8
+#
 # @to: highest port to try
 #
 # @ipv4: whether to accept IPv4 addresses, default try both IPv4 and IPv6
@@ -3084,6 +3088,7 @@
   'data': {
     'host': 'str',
     'port': 'str',
+    'numeric':  'bool',
     '*to': 'uint16',
     '*ipv4': 'bool',
     '*ipv6': 'bool' } }
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index fe1d07a..6f1c10a 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -141,6 +141,9 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
 
     memset(&ai,0, sizeof(ai));
     ai.ai_flags = AI_PASSIVE;
+    if (saddr->numeric) {
+        ai.ai_flags |= AI_NUMERICHOST | AI_NUMERICSERV;
+    }
     ai.ai_family = inet_ai_family_from_address(saddr, &err);
     ai.ai_socktype = SOCK_STREAM;
 
-- 
2.9.3
