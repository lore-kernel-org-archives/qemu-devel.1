Received: from eggs.gnu.org ([2001:4830:134:3::10]:46049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1cqGzN-0007Do-NU
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1cqGzI-0002D6-VI
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:26:05 -0400
Received: from [59.151.112.132] (port=5818 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1cqGzI-00028m-JO
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:26:00 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Tue, 21 Mar 2017 18:19:41 +0800
Message-ID: <1490091581-21912-1-git-send-email-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] elfload: Replace malloc with g_malloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 bsd-user/elfload.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 41a1309..17dfaca 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -1064,22 +1064,22 @@ static void load_symbols(struct elfhdr *hdr, int fd)
 
  found:
     /* Now know where the strtab and symtab are.  Snarf them. */
-    s = malloc(sizeof(*s));
+    s = g_malloc(sizeof(*s));
     syms = malloc(symtab.sh_size);
     if (!syms) {
-        free(s);
+        g_free(s);
         return;
     }
     s->disas_strtab = strings = malloc(strtab.sh_size);
     if (!s->disas_strtab) {
-        free(s);
+        g_free(s);
         free(syms);
         return;
     }
 
     lseek(fd, symtab.sh_offset, SEEK_SET);
     if (read(fd, syms, symtab.sh_size) != symtab.sh_size) {
-        free(s);
+        g_free(s);
         free(syms);
         free(strings);
         return;
@@ -1115,7 +1115,7 @@ static void load_symbols(struct elfhdr *hdr, int fd)
         many symbols we managed to discard. */
     new_syms = realloc(syms, nsyms * sizeof(*syms));
     if (new_syms == NULL) {
-        free(s);
+        g_free(s);
         free(syms);
         free(strings);
         return;
@@ -1126,7 +1126,7 @@ static void load_symbols(struct elfhdr *hdr, int fd)
 
     lseek(fd, strtab.sh_offset, SEEK_SET);
     if (read(fd, strings, strtab.sh_size) != strtab.sh_size) {
-        free(s);
+        g_free(s);
         free(syms);
         free(strings);
         return;
-- 
2.7.4
