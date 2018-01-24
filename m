Received: from eggs.gnu.org ([2001:4830:134:3::10]:51043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgg-0003H6-2o
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:02:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgf-0005gZ-8i
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:58 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgf-0005fz-4r
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:57 -0500
Received: by mail-qt0-x242.google.com with SMTP id s39so10009075qth.7
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 05:01:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 24 Jan 2018 10:01:26 -0300
Message-Id: <20180124130126.20871-12-f4bug@amsat.org>
In-Reply-To: <20180124130126.20871-1-f4bug@amsat.org>
References: <20180124130126.20871-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/11] linux-user/syscall: simplify recvfrom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/syscall.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b6b9beca5b..e082af2911 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4023,8 +4023,8 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
                             abi_ulong target_addr,
                             abi_ulong target_addrlen)
 {
-    socklen_t addrlen;
-    void *addr;
+    socklen_t addrlen = 0;
+    void *addr = NULL;
     void *host_msg;
     abi_long ret;
 
@@ -4046,12 +4046,9 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
         }
 
         addr = alloca(addrlen);
-        ret = get_errno(safe_recvfrom(fd, host_msg, len, flags,
-                                      addr, &addrlen));
-    } else {
-        addr = NULL; /* To keep compiler quiet.  */
-        ret = get_errno(safe_recvfrom(fd, host_msg, len, flags, NULL, 0));
     }
+    ret = get_errno(safe_recvfrom(fd, host_msg, len, flags, addr, &addrlen));
+
     if (!is_error(ret)) {
         if (fd_trans_host_to_target_data(fd)) {
             ret = fd_trans_host_to_target_data(fd)(host_msg, ret);
-- 
2.15.1
