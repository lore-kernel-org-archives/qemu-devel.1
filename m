Received: from eggs.gnu.org ([2001:4830:134:3::10]:50769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6k-00015l-Nm
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6i-0005fL-BZ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:43 -0300
Message-Id: <20170724182751.18261-28-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 27/35] syscall: fix dereference of
 undefined pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Clang's scan-build-5.0 reports:

linux-user/syscall.c:5581:9: warning: Dereference of undefined pointer value
    if (*host_rt_dev_ptr != 0) {
        ^~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Suggested-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fcd20fa276..e79b5baec4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5524,7 +5524,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
     int target_size;
     void *argptr;
     abi_ulong *target_rt_dev_ptr;
-    unsigned long *host_rt_dev_ptr;
+    unsigned long *host_rt_dev_ptr = NULL;
     abi_long ret;
     int i;
 
@@ -5570,6 +5570,7 @@ static abi_long do_ioctl_rt(const IOCTLEntry *ie, uint8_t *buf_temp,
     unlock_user(argptr, arg, 0);
 
     ret = get_errno(safe_ioctl(fd, ie->host_cmd, buf_temp));
+    assert(host_rt_dev_ptr);
     if (*host_rt_dev_ptr != 0) {
         unlock_user((void *)*host_rt_dev_ptr,
                     *target_rt_dev_ptr, 0);
-- 
2.13.3
