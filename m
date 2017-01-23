Received: from eggs.gnu.org ([2001:4830:134:3::10]:43721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVfZt-0000nV-Iw
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVfZs-0006Hz-5c
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:26:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVfZr-0006Hu-W0
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:26:36 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 23 Jan 2017 14:26:22 +0000
Message-Id: <20170123142629.11110-2-berrange@redhat.com>
In-Reply-To: <20170123142629.11110-1-berrange@redhat.com>
References: <20170123142629.11110-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 1/8] sockets: add ability to disable DNS
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

Add a 'numeric' flag to the InetSocketAddress struct to allow the
caller to indicate that DNS should be skipped for the host/port
fields. This is useful if the caller knows the address is already
numeric and wants to guarantee no (potentially blocking) DNS
lookups are attempted.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qapi-schema.json    | 5 +++++
 util/qemu-sockets.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index ddc8783..ac55f4a 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3983,6 +3983,10 @@
 #
 # @port: port part of the address, or lowest port if @to is present
 #
+# @numeric: #optional true if the host/port are guaranteed to be numeric,
+#           false if name resolution should be attempted. Defaults to false.
+#           (Since 2.9)
+#
 # @to: highest port to try
 #
 # @ipv4: whether to accept IPv4 addresses, default try both IPv4 and IPv6
@@ -3997,6 +4001,7 @@
   'data': {
     'host': 'str',
     'port': 'str',
+    '*numeric':  'bool',
     '*to': 'uint16',
     '*ipv4': 'bool',
     '*ipv6': 'bool' } }
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index fe1d07a..d63b011 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -141,6 +141,9 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
 
     memset(&ai,0, sizeof(ai));
     ai.ai_flags = AI_PASSIVE;
+    if (saddr->has_numeric && saddr->numeric) {
+        ai.ai_flags |= AI_NUMERICHOST | AI_NUMERICSERV;
+    }
     ai.ai_family = inet_ai_family_from_address(saddr, &err);
     ai.ai_socktype = SOCK_STREAM;
 
-- 
2.9.3
