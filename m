Received: from eggs.gnu.org ([2001:4830:134:3::10]:42977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRb-0001Sv-81
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRa-0007Hm-J8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:15 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:58 -0300
Message-Id: <20171006235023.11952-64-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 63/88] bsd-user/syscall: fix a memory leak on
 EFAULT, use g_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Kamil Rytarowski <kamil@netbsd.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Kamil are you interested in maintaining bsd-user? :)
 
 bsd-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 66492aaf5d..9120cea61e 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -227,7 +227,7 @@ static abi_long do_freebsd_sysctl(abi_ulong namep, int32_t namelen, abi_ulong ol
     void *hnamep, *holdp, *hnewp = NULL;
     size_t holdlen;
     abi_ulong oldlen = 0;
-    int32_t *snamep = g_malloc(sizeof(int32_t) * namelen), *p, *q, i;
+    int32_t *snamep, *p, *q, i;
     uint32_t kind = 0;
 
     if (oldlenp)
@@ -239,6 +239,7 @@ static abi_long do_freebsd_sysctl(abi_ulong namep, int32_t namelen, abi_ulong ol
     if (!(holdp = lock_user(VERIFY_WRITE, oldp, oldlen, 0)))
         return -TARGET_EFAULT;
     holdlen = oldlen;
+    snamep = g_new(int32_t, namelen);
     for (p = hnamep, q = snamep, i = 0; i < namelen; p++, i++)
        *q++ = tswap32(*p);
     oidfmt(snamep, namelen, NULL, &kind);
-- 
2.14.2
