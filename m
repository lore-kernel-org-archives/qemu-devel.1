Received: from eggs.gnu.org ([2001:4830:134:3::10]:38753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAN6K-0002de-LR
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAN6H-0000J3-SW
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:37:08 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAN6G-0000He-Il
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:37:05 -0400
Received: by mail-wr1-x433.google.com with SMTP id q5-v6so7443782wrw.12
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 15:37:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Oct 2018 00:36:47 +0200
Message-Id: <20181010223656.31632-2-f4bug@amsat.org>
In-Reply-To: <20181010223656.31632-1-f4bug@amsat.org>
References: <20181010223656.31632-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 01/10] linux-user/syscall: Verify
 recvfrom(addr) is user-writable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ae3c0dfef7..ea503381aa 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2968,6 +2968,11 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
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
2.19.1
