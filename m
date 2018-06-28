Received: from eggs.gnu.org ([2001:4830:134:3::10]:46196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYNu6-00088F-Tn
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYNu6-0000ms-0e
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:47:30 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:41212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYNu5-0000mf-S8
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:47:29 -0400
Received: by mail-qk0-x243.google.com with SMTP id d22-v6so2263687qkc.8
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:47:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 00:46:50 -0300
Message-Id: <20180628034652.24152-11-f4bug@amsat.org>
In-Reply-To: <20180628034652.24152-1-f4bug@amsat.org>
References: <20180628034652.24152-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 10/12] linux-user/strace: Add
 print_sockaddr_ptr() to handle plain/pointer addrlen
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

While very similar to send()/recv(), the format used by
sendto()/recvfrom() is slightly different: the 'addrlen'
is not a plain sockaddr_t but a pointer to it.

Split the current function to handle both formats.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
---
 linux-user/strace.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 1bacf75213..5a52d98f3b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -68,6 +68,7 @@ UNUSED static void print_timezone(abi_ulong, int);
 UNUSED static void print_number(abi_long, int);
 UNUSED static void print_signal(abi_ulong, int);
 UNUSED static void print_sockaddr(abi_ulong addr, abi_long addrlen, int);
+UNUSED static void print_sockaddr_ptr(abi_ulong addr, abi_long addrlen_ptr, int);
 UNUSED static void print_socket_domain(int domain);
 UNUSED static void print_socket_type(int type);
 UNUSED static void print_socket_protocol(int domain, int type, int protocol);
@@ -336,7 +337,8 @@ static void print_siginfo(const target_siginfo_t *tinfo)
 }
 
 static void
-print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
+print_sockaddr_ex(abi_ulong addr, abi_long addrlen,
+                  bool addrlen_is_ptr, int last)
 {
     struct target_sockaddr *sa;
     int i;
@@ -418,7 +420,29 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
     } else {
         print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
     }
-    gemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
+    gemu_log(", %s"TARGET_ABI_FMT_ld"%s%s",
+             (addrlen_is_ptr ? "[" : ""), addrlen,
+             (addrlen_is_ptr ? "]" : ""), get_comma(last));
+}
+
+static void
+print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
+{
+    print_sockaddr_ex(addr, addrlen, false, last);
+}
+
+static void
+print_sockaddr_ptr(abi_ulong addr, abi_long addrlen_ptr, int last)
+{
+    abi_ulong addrlen;
+
+    if (!addr) {
+        print_sockaddr_ex(0, 0, false, last);
+        return;
+    }
+
+    get_user_ual(addrlen, addrlen_ptr);
+    print_sockaddr_ex(addr, addrlen, true, last);
 }
 
 static void
-- 
2.18.0
