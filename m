Received: from eggs.gnu.org ([2001:4830:134:3::10]:46752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpzR-0006Z5-3S
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfpzP-0003xH-KW
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:07:17 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 10 Aug 2017 17:04:51 +0100
Message-Id: <20170810160451.32723-9-berrange@redhat.com>
In-Reply-To: <20170810160451.32723-1-berrange@redhat.com>
References: <20170810160451.32723-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 8/8] sockets: fix parsing of ipv4/ipv6 opts in
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
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

The inet_parse() function looks for 'ipv4' and 'ipv6'
flags, but only treats them as bare bool flags. The normal
QemuOpts parsing would allow on/off values to be set too.

This updated inet_parse() so that its handling of the
'ipv4' and 'ipv6' flags matches that done by QemuOpts.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/test-sockets-proto.c | 13 -------------
 util/qemu-sockets.c        | 36 ++++++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/tests/test-sockets-proto.c b/tests/test-sockets-proto.c
index a92389bef6..5805d2be5f 100644
--- a/tests/test-sockets-proto.c
+++ b/tests/test-sockets-proto.c
@@ -69,7 +69,6 @@ typedef struct {
  */
 static QSocketsData test_data[] = {
     /* Migrate with "" address */
-    /* XXX all settings with =off are disabled due to inet_parse() bug */
     { .ipv4 = 1, .ipv6 = 1, .error = false,
       .name = "/sockets/migrate/wildcard/all",
       .args = "-incoming tcp::9000" },
@@ -85,7 +84,6 @@ static QSocketsData test_data[] = {
     { .ipv4 = 0, .ipv6 = 1, .error = false,
       .name = "/sockets/migrate/wildcard/ipv6on",
       .args = "-incoming tcp::9000,ipv6=on" },
-    /*
     { .ipv4 = 0, .ipv6 = 1, .error = false,
       .name = "/sockets/migrate/wildcard/ipv4off",
       .args = "-incoming tcp::9000,ipv4=off" },
@@ -98,15 +96,12 @@ static QSocketsData test_data[] = {
     { .ipv4 = 0, .ipv6 = 1, .error = false,
       .name = "/sockets/migrate/wildcard/ipv4offipv6on",
       .args = "-incoming tcp::9000,ipv4=off,ipv6=on" },
-    */
     { .ipv4 = 1, .ipv6 = 1, .error = false,
       .name = "/sockets/migrate/wildcard/ipv4onipv6on",
       .args = "-incoming tcp::9000,ipv4=on,ipv6=on" },
-    /*
     { .ipv4 = 0, .ipv6 = 0, .error = true,
       .name = "/sockets/migrate/wildcard/ipv4offipv6off",
       .args = "-incoming tcp::9000,ipv4=off,ipv6=off" },
-    */
 
     /* Migrate with 0.0.0.0 address */
     { .ipv4 = 1, .ipv6 = 0, .error = false,
@@ -124,7 +119,6 @@ static QSocketsData test_data[] = {
     { .ipv4 = 0, .ipv6 = 0, .error = true,
       .name = "/sockets/migrate/0.0.0.0/ipv6on",
       .args = "-incoming tcp:0.0.0.0:9000,ipv6=on" },
-    /*
     { .ipv4 = 0, .ipv6 = 0, .error = true,
       .name = "/sockets/migrate/0.0.0.0/ipv4off",
       .args = "-incoming tcp:0.0.0.0:9000,ipv4=off" },
@@ -137,15 +131,12 @@ static QSocketsData test_data[] = {
     { .ipv4 = 0, .ipv6 = 0, .error = true,
       .name = "/sockets/migrate/0.0.0.0/ipv4offipv6on",
       .args = "-incoming tcp:0.0.0.0:9000,ipv4=off,ipv6=on" },
-    */
     { .ipv4 = 1, .ipv6 = 0, .error = false,
       .name = "/sockets/migrate/0.0.0.0/ipv4onipv6on",
       .args = "-incoming tcp:0.0.0.0:9000,ipv4=on,ipv6=on" },
-    /*
     { .ipv4 = 0, .ipv6 = 0, .error = true,
       .name = "/sockets/migrate/0.0.0.0/ipv4offipv6off",
       .args = "-incoming tcp:0.0.0.0:9000,ipv4=off,ipv6=off" },
-    */
 
     /* Migrate with :: address */
     { .ipv4 = 1, .ipv6 = 1, .error = false,
@@ -163,7 +154,6 @@ static QSocketsData test_data[] = {
     { .ipv4 = 0, .ipv6 = 1, .error = false,
       .name = "/sockets/migrate/::/ipv6on",
       .args = "-incoming tcp:[::]:9000,ipv6=on" },
-    /*
     { .ipv4 = 0, .ipv6 = 1, .error = false,
       .name = "/sockets/migrate/::/ipv4off",
       .args = "-incoming tcp:[::]:9000,ipv4=off" },
@@ -176,15 +166,12 @@ static QSocketsData test_data[] = {
     { .ipv4 = 0, .ipv6 = 1, .error = false,
       .name = "/sockets/migrate/::/ipv4offipv6on",
       .args = "-incoming tcp:[::]:9000,ipv4=off,ipv6=on" },
-    */
     { .ipv4 = 1, .ipv6 = 1, .error = false,
       .name = "/sockets/migrate/::/ipv4onipv6on",
       .args = "-incoming tcp:[::]:9000,ipv4=on,ipv6=on" },
-    /*
     { .ipv4 = 0, .ipv6 = 0, .error = true,
       .name = "/sockets/migrate/::/ipv4offipv6off",
       .args = "-incoming tcp:[::]:9000,ipv4=off,ipv6=off" },
-    */
 
 
 
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 1358c81bcc..76202949f5 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -616,6 +616,25 @@ err:
 }
 
 /* compatibility wrapper */
+static int inet_parse_flag(const char *flagname, const char *optstr, bool *val,
+                           Error **errp)
+{
+    char *end;
+    size_t len;
+
+    end = strstr(optstr, ",");
+    len = end ? end - optstr : strlen(optstr);
+    if (len == 0 || (len == 3 && strncmp(optstr, "=on", len) == 0)) {
+        *val = true;
+    } else if ((len == 4) && strncmp(optstr, "=off", len) == 0) {
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
@@ -623,6 +642,7 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
     char port[33];
     int to;
     int pos;
+    char *begin;
 
     memset(addr, 0, sizeof(*addr));
 
@@ -664,11 +684,19 @@ int inet_parse(InetSocketAddress *addr, const char *str, Error **errp)
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
2.13.3
