Received: from eggs.gnu.org ([2001:4830:134:3::10]:60107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fNUl7-0005bw-Uo
	for qemu-devel@nongnu.org; Mon, 28 May 2018 22:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fNUl3-0007qd-8a
	for qemu-devel@nongnu.org; Mon, 28 May 2018 22:53:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2622 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1fNUl2-0007mM-Te
	for qemu-devel@nongnu.org; Mon, 28 May 2018 22:53:09 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 29 May 2018 10:52:40 +0800
Message-ID: <20180529025240.520-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] socket: dont't free msgfds if error equals
 EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, wangxinxin.wang@huawei.com, linzhecheng <linzhecheng@huawei.com>

Signed-off-by: linzhecheng <linzhecheng@huawei.com>

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 159e69c3b1..17519ec589 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -134,8 +134,8 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
                                         s->write_msgfds,
                                         s->write_msgfds_num);
 
-        /* free the written msgfds, no matter what */
-        if (s->write_msgfds_num) {
+        /* free the written msgfds in any cases other than errno==EAGAIN */
+        if (EAGAIN != errno && s->write_msgfds_num) {
             g_free(s->write_msgfds);
             s->write_msgfds = 0;
             s->write_msgfds_num = 0;
-- 
2.12.2.windows.2
