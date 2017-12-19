Received: from eggs.gnu.org ([2001:4830:134:3::10]:43517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tuxillo@quantumachine.net>) id 1eR5ek-0002F1-SG
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 19:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tuxillo@quantumachine.net>) id 1eR5eh-00035w-LJ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 19:21:14 -0500
Received: from mailrelay.quantumachine.net ([37.59.103.225]:34526)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tuxillo@quantumachine.net>) id 1eR5eh-00034m-DW
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 19:21:11 -0500
Received: from mail.quantumachine.net (unknown [89.128.97.235])
	by mailrelay.quantumachine.net (Postfix) with ESMTP id 7955045
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 01:21:07 +0100 (CET)
Date: Tue, 19 Dec 2017 00:21:05 +0000
Message-ID: <20171219002105.Horde.McUB5OjQ4CcwjyzfFEIWM2V@www.quantumachine.net>
From: Antonio Huete =?utf-8?b?Smltw6luZXo=?= <tuxillo@quantumachine.net>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] sockets: Fix test for DragonFly BSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com

 From f57cdc7ec2d5a5e906fa8b795eeede2d7b66aa56 Mon Sep 17 00:00:00 2001
From: Antonio Huete Jimenez <tuxillo@quantumachine.net>
Date: Fri, 15 Dec 2017 01:08:10 +0100
Subject: [PATCH] sockets: Fix test for DragonFly BSD

DragonFly BSD does not implement AI_V4MAPPED for its getaddrinfo() so
probe and discard that flag instead of aborting the test.

Test that fails:
     ERROR:tests/test-char.c:448:char_udp_test_internal: 'chr' should  
not be NULL

Signed-off-by: Antonio Huete Jimenez <tuxillo@quantumachine.net>
---
  util/qemu-sockets.c | 25 ++++++++++++++++++++++---
  1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index af4f01211a..5a9c55c303 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -43,6 +43,8 @@
  # define AI_NUMERICSERV 0
  #endif

+int useV4Mapped = 1;
+

  static int inet_getport(struct addrinfo *e)
  {
@@ -383,7 +385,6 @@ static struct addrinfo  
*inet_parse_connect_saddr(InetSocketAddress *saddr,
      struct addrinfo ai, *res;
      int rc;
      Error *err = NULL;
-    static int useV4Mapped = 1;

      memset(&ai, 0, sizeof(ai));

@@ -474,7 +475,11 @@ static int inet_dgram_saddr(InetSocketAddress *sraddr,

      /* lookup peer addr */
      memset(&ai,0, sizeof(ai));
-    ai.ai_flags = AI_CANONNAME | AI_V4MAPPED | AI_ADDRCONFIG;
+    ai.ai_flags = AI_CANONNAME | AI_ADDRCONFIG;
+    if (atomic_read(&useV4Mapped)) {
+        ai.ai_flags |= AI_V4MAPPED;
+    }
+
      ai.ai_family = inet_ai_family_from_address(sraddr, &err);
      ai.ai_socktype = SOCK_DGRAM;

@@ -493,7 +498,21 @@ static int inet_dgram_saddr(InetSocketAddress *sraddr,
          goto err;
      }

-    if ((rc = getaddrinfo(addr, port, &ai, &peer)) != 0) {
+    /* lookup */
+    rc = getaddrinfo(addr, port, &ai, &peer);
+
+    /* At least FreeBSD and OS-X 10.6 declare AI_V4MAPPED but
+     * then don't implement it in their getaddrinfo(). Detect
+     * this and retry without the flag since that's preferrable
+     * to a fatal error
+     */
+    if (rc == EAI_BADFLAGS &&
+        (ai.ai_flags & AI_V4MAPPED)) {
+        atomic_set(&useV4Mapped, 0);
+        ai.ai_flags &= ~AI_V4MAPPED;
+        rc = getaddrinfo(addr, port, &ai, &peer);
+    }
+    if (rc != 0) {
          error_setg(errp, "address resolution failed for %s:%s: %s",  
addr, port,
                     gai_strerror(rc));
          goto err;
-- 
2.15.0
