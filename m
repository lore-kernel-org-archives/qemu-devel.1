Received: from eggs.gnu.org ([2001:4830:134:3::10]:53039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqLba-0006TH-FY
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqLbW-00047c-Jc
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:54:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dqLbW-00046J-Cf
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:54:02 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  8 Sep 2017 16:53:59 +0100
Message-Id: <20170908155359.27952-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] slirp: Add explanation for hostfwd parsing
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

e.g.
./x86_64-softmmu/qemu-system-x86_64 -nographic -netdev 'user,id=vnet,hostfwd=:555.0.0.0:0-:22'
qemu-system-x86_64: -netdev user,id=vnet,hostfwd=:555.0.0.0:0-:22: Invalid host forwarding rule ':555.0.0.0:0-:22' (Bad host address)

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 net/slirp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/slirp.c b/net/slirp.c
index 01ed21c006..d87664d42e 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -496,9 +496,11 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str,
     char buf[256];
     int is_udp;
     char *end;
+    const char *fail_reason = "";
 
     p = redir_str;
     if (!p || get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+        fail_reason = "No : separators";
         goto fail_syntax;
     }
     if (!strcmp(buf, "tcp") || buf[0] == '\0') {
@@ -506,35 +508,43 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str,
     } else if (!strcmp(buf, "udp")) {
         is_udp = 1;
     } else {
+        fail_reason = "Bad protocol name";
         goto fail_syntax;
     }
 
     if (!legacy_format) {
         if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+            fail_reason = "Missing : separator";
             goto fail_syntax;
         }
         if (buf[0] != '\0' && !inet_aton(buf, &host_addr)) {
+            fail_reason = "Bad host address";
             goto fail_syntax;
         }
     }
 
     if (get_str_sep(buf, sizeof(buf), &p, legacy_format ? ':' : '-') < 0) {
+        fail_reason = "Bad host port separator";
         goto fail_syntax;
     }
     host_port = strtol(buf, &end, 0);
     if (*end != '\0' || host_port < 0 || host_port > 65535) {
+        fail_reason = "Bad host port";
         goto fail_syntax;
     }
 
     if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
+        fail_reason = "Missing guest address";
         goto fail_syntax;
     }
     if (buf[0] != '\0' && !inet_aton(buf, &guest_addr)) {
+        fail_reason = "Bad guest address";
         goto fail_syntax;
     }
 
     guest_port = strtol(p, &end, 0);
     if (*end != '\0' || guest_port < 1 || guest_port > 65535) {
+        fail_reason = "Bad guest port";
         goto fail_syntax;
     }
 
@@ -547,7 +557,8 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str,
     return 0;
 
  fail_syntax:
-    error_setg(errp, "Invalid host forwarding rule '%s'", redir_str);
+    error_setg(errp, "Invalid host forwarding rule '%s' (%s)", redir_str,
+               fail_reason);
     return -1;
 }
 
-- 
2.13.5
