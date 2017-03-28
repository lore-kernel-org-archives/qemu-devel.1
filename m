Received: from eggs.gnu.org ([2001:4830:134:3::10]:36426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csuOf-0001mt-Eu
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csuOc-0000vm-ET
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:55:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csuOc-0000vC-9E
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 12:55:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F8AD61E64
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 16:55:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F3ABC97A9E
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 16:54:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Mar 2017 18:54:58 +0200
Message-Id: <1490720098-4745-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1490720098-4745-1-git-send-email-armbru@redhat.com>
References: <1490720098-4745-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9] sockets: Fix socket_address_to_string()
 hostname truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We first snprintf() to a fixed buffer, then g_strdup() the result
*boggle*.

Worse, the size of the fixed buffer INET6_ADDRSTRLEN + 5 + 4 is bogus:
the 4 correctly accounts for '[', ']', ':' and '\0', but
INET6_ADDRSTRLEN is not a suitable limit for inet->host, and 5 is not
one for inet->port!  They are for host and port in *numeric* form
(exploiting that INET6_ADDRSTRLEN > INET_ADDRSTRLEN), but inet->host
can also be a hostname, and inet->port can be a service name, to be
resolved with getaddrinfo().

Fortunately, the only user so far is the "socket" network backend's
net_socket_connected(), which uses it to initialize a NetSocketState's
info_str[].  info_str[] has considerable more space: 256 instead of
55.  So the bug's impact appears to be limited to truncated "info
networks" with the "socket" network backend.

The fix is obvious: use g_strdup_printf().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1490268208-23368-1-git-send-email-armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-sockets.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 7c120c4..40164bf 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1307,19 +1307,14 @@ char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
 {
     char *buf;
     InetSocketAddress *inet;
-    char host_port[INET6_ADDRSTRLEN + 5 + 4];
 
     switch (addr->type) {
     case SOCKET_ADDRESS_KIND_INET:
         inet = addr->u.inet.data;
         if (strchr(inet->host, ':') == NULL) {
-            snprintf(host_port, sizeof(host_port), "%s:%s", inet->host,
-                    inet->port);
-            buf = g_strdup(host_port);
+            buf = g_strdup_printf("%s:%s", inet->host, inet->port);
         } else {
-            snprintf(host_port, sizeof(host_port), "[%s]:%s", inet->host,
-                    inet->port);
-            buf = g_strdup(host_port);
+            buf = g_strdup_printf("[%s]:%s", inet->host, inet->port);
         }
         break;
 
-- 
2.7.4
