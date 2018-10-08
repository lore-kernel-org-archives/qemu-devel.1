Received: from eggs.gnu.org ([2001:4830:134:3::10]:41433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNh-0005B7-48
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9ZNb-0005oS-Du
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9ZNa-0005i5-Nd
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:31:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 854B031E7DE
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 17:31:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Oct 2018 19:31:06 +0200
Message-Id: <20181008173125.19678-13-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-1-armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 12/31] l2tpv3: Improve
 -netdev/netdev_add/-net/... error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

When -netdev l2tpv3 fails, it first reports a specific error, then a
generic one, like this:

    $ qemu-system-x86_64 -netdev l2tpv3,id=foo,src=,dst=,txsession=1
    qemu-system-x86_64: -netdev l2tpv3,id=foo,src=,dst=,txsession=1: l2tpv3_open : could not resolve src, errno = Name or service not known
    qemu-system-x86_64: Device 'l2tpv3' could not be initialized

With the command line, the messages go to stderr.  In HMP, they go to
the monitor.  In QMP, the second one becomes the error reply, and the
first one goes to stderr.

Convert net_init_tap() to Error.  This suppresses the unwanted second
message, and makes the specific error the QMP error reply.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 net/l2tpv3.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index 6745b78990..0c5dd22ef7 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -28,6 +28,7 @@
 #include <netdb.h>
 #include "net/net.h"
 #include "clients.h"
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
@@ -528,7 +529,6 @@ int net_init_l2tpv3(const Netdev *netdev,
                     const char *name,
                     NetClientState *peer, Error **errp)
 {
-    /* FIXME error_setg(errp, ...) on failure */
     const NetdevL2TPv3Options *l2tpv3;
     NetL2TPV3State *s;
     NetClientState *nc;
@@ -555,7 +555,7 @@ int net_init_l2tpv3(const Netdev *netdev,
     }
 
     if ((l2tpv3->has_offset) && (l2tpv3->offset > 256)) {
-        error_report("l2tpv3_open : offset must be less than 256 bytes");
+        error_setg(errp, "l2tpv3_open : offset must be less than 256 bytes");
         goto outerr;
     }
 
@@ -563,6 +563,8 @@ int net_init_l2tpv3(const Netdev *netdev,
         if (l2tpv3->has_rxcookie && l2tpv3->has_txcookie) {
             s->cookie = true;
         } else {
+            error_setg(errp,
+                       "require both 'rxcookie' and 'txcookie' or neither");
             goto outerr;
         }
     } else {
@@ -578,7 +580,8 @@ int net_init_l2tpv3(const Netdev *netdev,
     if (l2tpv3->has_udp && l2tpv3->udp) {
         s->udp = true;
         if (!(l2tpv3->has_srcport && l2tpv3->has_dstport)) {
-            error_report("l2tpv3_open : need both src and dst port for udp");
+            error_setg(errp,
+                       "l2tpv3_open : need both src and dst port for udp");
             goto outerr;
         } else {
             srcport = l2tpv3->srcport;
@@ -639,20 +642,19 @@ int net_init_l2tpv3(const Netdev *netdev,
     gairet = getaddrinfo(l2tpv3->src, srcport, &hints, &result);
 
     if ((gairet != 0) || (result == NULL)) {
-        error_report(
-            "l2tpv3_open : could not resolve src, errno = %s",
-            gai_strerror(gairet)
-        );
+        error_setg(errp, "l2tpv3_open : could not resolve src, errno = %s",
+                   gai_strerror(gairet));
         goto outerr;
     }
     fd = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
     if (fd == -1) {
         fd = -errno;
-        error_report("l2tpv3_open : socket creation failed, errno = %d", -fd);
+        error_setg(errp, "l2tpv3_open : socket creation failed, errno = %d",
+                   -fd);
         goto outerr;
     }
     if (bind(fd, (struct sockaddr *) result->ai_addr, result->ai_addrlen)) {
-        error_report("l2tpv3_open :  could not bind socket err=%i", errno);
+        error_setg(errp, "l2tpv3_open :  could not bind socket err=%i", errno);
         goto outerr;
     }
     if (result) {
@@ -677,10 +679,8 @@ int net_init_l2tpv3(const Netdev *netdev,
     result = NULL;
     gairet = getaddrinfo(l2tpv3->dst, dstport, &hints, &result);
     if ((gairet != 0) || (result == NULL)) {
-        error_report(
-            "l2tpv3_open : could not resolve dst, error = %s",
-            gai_strerror(gairet)
-        );
+        error_setg(errp, "l2tpv3_open : could not resolve dst, error = %s",
+                   gai_strerror(gairet));
         goto outerr;
     }
 
-- 
2.17.1
