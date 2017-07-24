Received: from eggs.gnu.org ([2001:4830:134:3::10]:50747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6g-00011R-GE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6f-0005e7-Gd
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:42 -0300
Message-Id: <20170724182751.18261-27-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 26/35] linux-user: use is_error() to
 avoid warnings and make the code clearer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

linux-user/flatload.c:740:9: warning: Loss of sign in implicit conversion
    if (res > (unsigned long)-4096)
        ^~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/flatload.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index a35a560904..10c529910f 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -224,8 +224,9 @@ static int decompress_exec(
 		ret = bprm->file->f_op->read(bprm->file, buf, LBUFSIZE, &fpos);
 		if (ret <= 0)
 			break;
-		if (ret >= (unsigned long) -4096)
+                if (is_error(ret)) {
 			break;
+                }
 		len -= ret;
 
 		strm.next_in = buf;
@@ -283,8 +284,7 @@ calc_reloc(abi_ulong r, struct lib_info *p, int curid, int internalp)
                     "in same module (%d != %d)\n",
                     (unsigned) r, curid, id);
             goto failed;
-        } else if ( ! p[id].loaded &&
-                    load_flat_shared_library(id, p) > (unsigned long) -4096) {
+        } else if (!p[id].loaded && is_error(load_flat_shared_library(id, p))) {
             fprintf(stderr, "BINFMT_FLAT: failed to load library %d\n", id);
             goto failed;
         }
@@ -523,9 +523,10 @@ static int load_flat_file(struct linux_binprm * bprm,
                 fpos = 0;
                 result = bprm->file->f_op->read(bprm->file,
                                 (char *) textpos, text_len, &fpos);
-                if (result < (unsigned long) -4096)
+                if (!is_error(result)) {
                         result = decompress_exec(bprm, text_len, (char *) datapos,
                                          data_len + (relocs * sizeof(unsigned long)), 0);
+                }
         }
         else
 #endif
@@ -693,8 +694,9 @@ static int load_flat_shared_library(int id, struct lib_info *libs)
 
 	res = prepare_binprm(&bprm);
 
-	if (res <= (unsigned long)-4096)
+        if (!is_error(res)) {
 		res = load_flat_file(&bprm, libs, id, NULL);
+        }
 	if (bprm.file) {
 		allow_write_access(bprm.file);
 		fput(bprm.file);
@@ -737,8 +739,9 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
 
 
     res = load_flat_file(bprm, libinfo, 0, &stack_len);
-    if (res > (unsigned long)-4096)
+    if (is_error(res)) {
             return res;
+    }
 
     /* Update data segment pointers for all libraries */
     for (i=0; i<MAX_SHARED_LIBS; i++) {
-- 
2.13.3
