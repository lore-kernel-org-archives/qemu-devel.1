Received: from eggs.gnu.org ([2001:4830:134:3::10]:50894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgS-00037y-Ki
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgN-0005PF-5E
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:44 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgN-0005Or-1Z
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:39 -0500
Received: by mail-qt0-x244.google.com with SMTP id z11so10022629qtm.3
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 05:01:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 24 Jan 2018 10:01:18 -0300
Message-Id: <20180124130126.20871-4-f4bug@amsat.org>
In-Reply-To: <20180124130126.20871-1-f4bug@amsat.org>
References: <20180124130126.20871-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 03/11] linux-user/strace: add
 print_sockaddr_ptr() to handle plain/pointer addrlen
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

since this argument differs between sendto()/recvfrom()

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/strace.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index e7272f4ede..9726d9b378 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -335,12 +335,15 @@ static void print_siginfo(const target_siginfo_t *tinfo)
 }
 
 static void
-print_sockaddr(abi_ulong addr, abi_long addrlen)
+print_sockaddr_ptr(abi_ulong addr, abi_long addrlen, bool addrlen_ptr)
 {
     struct target_sockaddr *sa;
     int i;
     int sa_family;
 
+    if (addrlen_ptr) {
+        get_user_ual(addrlen, addrlen);
+    }
     sa = lock_user(VERIFY_READ, addr, addrlen, 1);
     if (sa) {
         sa_family = tswap16(sa->sa_family);
@@ -417,7 +420,17 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
     } else {
         print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
     }
-    gemu_log(", "TARGET_ABI_FMT_ld, addrlen);
+    if (addrlen_ptr) {
+        gemu_log(", ["TARGET_ABI_FMT_ld"]", addrlen);
+    } else {
+        gemu_log(", "TARGET_ABI_FMT_ld, addrlen);
+    }
+}
+
+static void
+print_sockaddr(abi_ulong addr, abi_long addrlen)
+{
+    print_sockaddr_ptr(addr, addrlen, false);
 }
 
 static void
-- 
2.15.1
