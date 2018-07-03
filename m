Received: from eggs.gnu.org ([2001:4830:134:3::10]:33205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNJh-0008Ly-Sd
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNJg-0001Tr-0E
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:34:09 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:45758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNJf-0001Tf-R7
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:34:07 -0400
Received: by mail-qk0-x22a.google.com with SMTP id c192-v6so1202545qkg.12
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:34:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  3 Jul 2018 12:33:40 -0300
Message-Id: <20180703153346.9050-7-f4bug@amsat.org>
In-Reply-To: <20180703153346.9050-1-f4bug@amsat.org>
References: <20180703153346.9050-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 06/12] linux-user/syscall: Introduce
 target_sockaddr_nl
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
---
 linux-user/syscall_defs.h | 7 +++++++
 linux-user/syscall.c      | 6 ++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 40bb60ef4c..5a0b76721f 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -152,6 +152,13 @@ struct target_sockaddr_un {
     uint8_t sun_path[108];
 };
 
+struct target_sockaddr_nl {
+    uint16_t nl_family;     /* AF_NETLINK */
+    uint16_t __pad;
+    uint32_t nl_pid;
+    uint32_t nl_groups;
+};
+
 struct target_in_addr {
     uint32_t s_addr; /* big endian */
 };
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ad40682cee..9a11f8c4a6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1696,8 +1696,10 @@ static inline abi_long host_to_target_sockaddr(abi_ulong target_addr,
         sizeof(target_saddr->sa_family)) {
         target_saddr->sa_family = tswap16(addr->sa_family);
     }
-    if (addr->sa_family == AF_NETLINK && len >= sizeof(struct sockaddr_nl)) {
-        struct sockaddr_nl *target_nl = (struct sockaddr_nl *)target_saddr;
+    if (addr->sa_family == AF_NETLINK &&
+        len >= sizeof(struct target_sockaddr_nl)) {
+        struct target_sockaddr_nl *target_nl =
+               (struct target_sockaddr_nl *)target_saddr;
         target_nl->nl_pid = tswap32(target_nl->nl_pid);
         target_nl->nl_groups = tswap32(target_nl->nl_groups);
     } else if (addr->sa_family == AF_PACKET) {
-- 
2.18.0
