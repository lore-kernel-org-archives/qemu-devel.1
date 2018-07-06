Received: from eggs.gnu.org ([2001:4830:134:3::10]:51071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK5-0001DR-25
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fbUK3-0000mF-Qz
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:09 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fbUK3-0000lw-Ju
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:15:07 -0400
Received: by mail-wm0-x242.google.com with SMTP id s12-v6so15581981wmc.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 10:15:07 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Jul 2018 19:14:25 +0200
Message-Id: <1530897268-22932-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
References: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/8] qemu-char: check errno together with ret < 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "xinhua.Cao" <caoxinhua@huawei.com>

From: "xinhua.Cao" <caoxinhua@huawei.com>

In the tcp_chr_write function, we checked errno,
but errno was not reset before a read or write operation.
Therefore, this check of errno's actions is often
incorrect after EAGAIN has occurred.
we need check errno together with ret < 0.

Signed-off-by: xinhua.Cao <caoxinhua@huawei.com>
Message-Id: <20180704033642.15996-1-caoxinhua@huawei.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Fixes: 9fc53a10f81d3a9027b23fa810147d21be29e614
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 17519ec..efbad6e 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -134,8 +134,11 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
                                         s->write_msgfds,
                                         s->write_msgfds_num);
 
-        /* free the written msgfds in any cases other than errno==EAGAIN */
-        if (EAGAIN != errno && s->write_msgfds_num) {
+        /* free the written msgfds in any cases
+         * other than ret < 0 && errno == EAGAIN
+         */
+        if (!(ret < 0 && EAGAIN == errno)
+            && s->write_msgfds_num) {
             g_free(s->write_msgfds);
             s->write_msgfds = 0;
             s->write_msgfds_num = 0;
-- 
1.8.3.1
