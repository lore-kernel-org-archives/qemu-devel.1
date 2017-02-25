Received: from eggs.gnu.org ([2001:4830:134:3::10]:50507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bernat@luffy.cx>) id 1chjwv-00019t-Ag
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 16:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bernat@luffy.cx>) id 1chjwq-0001Pl-Tl
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 16:32:16 -0500
Received: from bart.luffy.cx ([78.47.78.131]:41932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bernat@luffy.cx>) id 1chjwq-0001Mf-GT
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 16:32:12 -0500
From: Vincent Bernat <vincent@bernat.im>
Date: Sat, 25 Feb 2017 22:31:58 +0100
Message-Id: <20170225213158.32452-1-vincent@bernat.im>
Subject: [Qemu-devel] [PATCH] slirp: allow host port 0 for hostfwd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vincent Bernat <vincent@bernat.im>

The OS will allocate automatically a free port. This is useful if you
want to be sure to not get any port conflict. You still have to figure
out which port you got, for example with "lsof" (this could be exposed
in the monitor if needed).

Example of use:

     $ qemu-system-x86_64 -net user,hostfwd=127.0.0.1:0-:22 ...

Then, get your port with:

     $ lsof -np 1474 | grep LISTEN
     qemu-syst 31777 bernat 12u IPv4 [...] TCP 127.0.0.1:35145 (LISTEN)

Signed-off-by: Vincent Bernat <vincent@bernat.im>
---
 net/slirp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/slirp.c b/net/slirp.c
index f97ec233454e..11b2dd249a79 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -487,7 +487,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str,
         goto fail_syntax;
     }
     host_port = strtol(buf, &end, 0);
-    if (*end != '\0' || host_port < 1 || host_port > 65535) {
+    if (*end != '\0' || host_port < 0 || host_port > 65535) {
         goto fail_syntax;
     }
 
-- 
2.11.0
