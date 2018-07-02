Received: from eggs.gnu.org ([2001:4830:134:3::10]:54557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoxinhua@huawei.com>) id 1fZn2I-0002kf-DX
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 20:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoxinhua@huawei.com>) id 1fZn2F-00081W-AI
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 20:49:46 -0400
Received: from [45.249.212.35] (port=45075 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <caoxinhua@huawei.com>)
	id 1fZn2E-0007yG-Tn
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 20:49:43 -0400
From: xinhua.Cao <caoxinhua@huawei.com>
Date: Mon, 2 Jul 2018 08:49:10 +0800
Message-ID: <20180702004910.13216-1-caoxinhua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] qemu-char: reset errno before qemu char write
 or read action
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, eblake@redhat.com, anton.nefedov@virtuozzo.com, vsementsov@virtuozzo.com
Cc: weidong.huang@huawei.com, weifuqiang@huawei.com, king.wang@huawei.com, arei.gonglei@huawei.com, liuyongan@huawei.com, qemu-devel@nongnu.org, "xinhua.Cao" <caoxinhua@huawei.com>

In the tcp_chr_write function, we checked errno,
but errno was not reset before a read or write operation.
Therefore, this check of errno's actions is often
incorrect after EAGAIN has occurred.
We reset errno before reading and writing to
ensure the correctness of errno's judgment

Signed-off-by: xinhua.Cao <caoxinhua@huawei.com>
---
 chardev/char-fe.c | 1 +
 chardev/char.c    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index b1f228e..d96ca6f 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -69,6 +69,7 @@ int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
 
     while (offset < len) {
     retry:
+        errno = 0;
         res = CHARDEV_GET_CLASS(s)->chr_sync_read(s, buf + offset,
                                                   len - offset);
         if (res == -1 && errno == EAGAIN) {
diff --git a/chardev/char.c b/chardev/char.c
index 76d866e..3387442 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -85,6 +85,7 @@ static void qemu_chr_write_log(Chardev *s, const uint8_t *buf, size_t len)
 
     while (done < len) {
     retry:
+        errno = 0;
         ret = write(s->logfd, buf + done, len - done);
         if (ret == -1 && errno == EAGAIN) {
             g_usleep(100);
@@ -109,6 +110,7 @@ static int qemu_chr_write_buffer(Chardev *s,
     qemu_mutex_lock(&s->chr_write_lock);
     while (*offset < len) {
     retry:
+        errno = 0;
         res = cc->chr_write(s, buf + *offset, len - *offset);
         if (res < 0 && errno == EAGAIN && write_all) {
             g_usleep(100);
-- 
2.8.3
