Received: from eggs.gnu.org ([2001:4830:134:3::10]:39236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXJ-0006su-Al
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXI-0001MB-EQ
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:57 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:55420)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXI-0001Ls-7e
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:56 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 29 Apr 2017 18:47:42 +0200
Message-Id: <20170429164750.17414-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
References: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 1/9] slirp: allow host port 0 for hostfwd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vincent Bernat <vincent@bernat.im>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Vincent Bernat <vincent@bernat.im>

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
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 net/slirp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/slirp.c b/net/slirp.c
index f97ec23345..11b2dd249a 100644
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
