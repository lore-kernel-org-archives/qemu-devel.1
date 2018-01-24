Received: from eggs.gnu.org ([2001:4830:134:3::10]:51062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgi-0003Jt-1H
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgc-0005am-Jb
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:02:00 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgc-0005ab-Fa
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:54 -0500
Received: by mail-qt0-x241.google.com with SMTP id o35so9976201qtj.13
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 05:01:54 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 24 Jan 2018 10:01:25 -0300
Message-Id: <20180124130126.20871-11-f4bug@amsat.org>
In-Reply-To: <20180124130126.20871-1-f4bug@amsat.org>
References: <20180124130126.20871-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/11] linux-user/syscall: verify
 recvfrom(addr) is user-writable
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
 linux-user/syscall.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11c9116c4a..b6b9beca5b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4040,6 +4040,11 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
             ret = -TARGET_EINVAL;
             goto fail;
         }
+        if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
+            ret = -TARGET_EFAULT;
+            goto fail;
+        }
+
         addr = alloca(addrlen);
         ret = get_errno(safe_recvfrom(fd, host_msg, len, flags,
                                       addr, &addrlen));
-- 
2.15.1
