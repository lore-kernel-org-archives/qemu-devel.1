Received: from eggs.gnu.org ([2001:4830:134:3::10]:33109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNJV-0008E2-9X
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNJU-0001NG-9M
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:33:57 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNJU-0001Mz-3h
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:33:56 -0400
Received: by mail-qt0-x243.google.com with SMTP id q12-v6so1928167qtp.6
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:33:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  3 Jul 2018 12:33:35 -0300
Message-Id: <20180703153346.9050-2-f4bug@amsat.org>
In-Reply-To: <20180703153346.9050-1-f4bug@amsat.org>
References: <20180703153346.9050-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 01/12] linux-user/syscall: Verify
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
index 2117fb13b4..ad40682cee 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4154,6 +4154,11 @@ static abi_long do_recvfrom(int fd, abi_ulong msg, size_t len, int flags,
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
2.18.0
