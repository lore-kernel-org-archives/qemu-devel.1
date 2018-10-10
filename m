Received: from eggs.gnu.org ([2001:4830:134:3::10]:38757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAN6K-0002dh-Li
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAN6H-0000J9-TI
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:37:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:36302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAN6G-0000I4-KB
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:37:05 -0400
Received: by mail-wm1-x32e.google.com with SMTP id a8-v6so7318473wmf.1
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 15:37:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Oct 2018 00:36:48 +0200
Message-Id: <20181010223656.31632-3-f4bug@amsat.org>
In-Reply-To: <20181010223656.31632-1-f4bug@amsat.org>
References: <20181010223656.31632-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 02/10] linux-user/strace: Display invalid
 pointer in print_timeval()
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

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/strace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 33f4a506a2..c95557bf83 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1173,8 +1173,10 @@ print_timeval(abi_ulong tv_addr, int last)
         struct target_timeval *tv;
 
         tv = lock_user(VERIFY_READ, tv_addr, sizeof(*tv), 1);
-        if (!tv)
+        if (!tv) {
+            print_pointer(tv_addr, last);
             return;
+        }
         gemu_log("{" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "}%s",
             tswapal(tv->tv_sec), tswapal(tv->tv_usec), get_comma(last));
         unlock_user(tv, tv_addr, 0);
-- 
2.19.1
