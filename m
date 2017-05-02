Received: from eggs.gnu.org ([2001:4830:134:3::10]:34186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1d5Y9c-0001t0-J3
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1d5Y9X-0004YK-NM
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:47:48 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:11611 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1d5Y9X-0004Xw-BY
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:47:43 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Tue,  2 May 2017 16:47:37 +0300
Message-Id: <1493732857-10721-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/1] monitor: increase amount of data for
 monitor to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

Right now QMP and HMP monitors read 1 byte at a time from the socket, which
is very inefficient. With 100+ VMs on the host this easily reasults in
a lot of unnecessary system calls and CPU usage in the system.

This patch changes the amount of data to read to 4096 bytes, which matches
buffer size on the channel level. Fortunately, monitor protocol is
synchronous right now thus we should not face side effects in reality.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Markus Armbruster <armbru@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC: Eric Blake <eblake@redhat.com>
---
 monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index be282ec..00df5d0 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3698,7 +3698,7 @@ static int monitor_can_read(void *opaque)
 {
     Monitor *mon = opaque;
 
-    return (mon->suspend_cnt == 0) ? 1 : 0;
+    return (mon->suspend_cnt == 0) ? 4096 : 0;
 }
 
 static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
-- 
2.7.4
