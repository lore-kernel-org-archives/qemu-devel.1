Received: from eggs.gnu.org ([2001:4830:134:3::10]:44714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSI-0004TO-PR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSE-0004zL-Pu
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:30 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:50515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSE-0004yu-Hl
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:26 -0500
Received: by mail-wm0-x244.google.com with SMTP id f71so28283658wmf.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:31 +0100
Message-Id: <1517858941-5538-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/47] sockets: fix parsing of ipv4/ipv6 opts in
 parse_socket_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

The inet_parse() function looks for 'ipv4' and 'ipv6' flags, but only
treats them as bare bool flags. The normal QemuOpts parsing would allow
on/off values to be set too.

This updates inet_parse() so that its handling of the 'ipv4' and 'ipv6'
flags matches that done by QemuOpts.

This impacts the NBD block driver parsing the legacy filename syntax and
the migration code parsing the socket scheme.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20180125171412.21627-1-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-sockets.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index d6a1e17..fbbef69 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -554,6 +554,33 @@ err:
 }
 
 /* compatibility wrapper */
+static int inet_parse_flag(const char *flagname, const char *optstr, bool *val,
+                           Error **errp)
+{
+    char *end;
+    size_t len;
+
+    end = strstr(optstr, ",");
+    if (end) {
+        if (end[1] == ',') { /* Reject 'ipv6=on,,foo' */
+            error_setg(errp, "error parsing '%s' flag '%s'", flagname, optstr);
+            return -1;
+        }
+        len = end - optstr;
+    } else {
+        len = strlen(optstr);
+    }
+    if (len == 0 || (len == 3 && strncmp(optstr, "=on", len) == 0)) {
+        *val = true;
+    } else if (len == 4 && strncmp(optstr, "=off", len) == 0) {
+        *val = false;
+    } else {
+        error_setg(errp, "error parsing '%s' flag '%s'", flagname, optstr);
+        return -1;
+    }
+    return 0;
+}
+
 int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
 {
     const char *optstr, *h;
@@ -561,6 +588,7 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
     char port[33];
     int to;
     int pos;
+    char *begin;
 
     memset(addr, 0, sizeof(*addr));
 
@@ -602,11 +630,19 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
         addr->has_to = true;
         addr->to = to;
     }
-    if (strstr(optstr, ",ipv4")) {
-        addr->ipv4 = addr->has_ipv4 = true;
+    begin = strstr(optstr, ",ipv4");
+    if (begin) {
+        if (inet_parse_flag("ipv4", begin + 5, &addr->ipv4, errp) < 0) {
+            return -1;
+        }
+        addr->has_ipv4 = true;
     }
-    if (strstr(optstr, ",ipv6")) {
-        addr->ipv6 = addr->has_ipv6 = true;
+    begin = strstr(optstr, ",ipv6");
+    if (begin) {
+        if (inet_parse_flag("ipv6", begin + 5, &addr->ipv6, errp) < 0) {
+            return -1;
+        }
+        addr->has_ipv6 = true;
     }
     return 0;
 }
-- 
1.8.3.1
