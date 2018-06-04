Received: from eggs.gnu.org ([2001:4830:134:3::10]:43781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrY6-00009n-OX
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrY5-00067Y-Rw
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:37:34 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:41866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrY5-00067P-No
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:37:33 -0400
Received: by mail-qt0-x244.google.com with SMTP id y20-v6so14760661qto.8
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 08:37:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  4 Jun 2018 12:37:22 -0300
Message-Id: <20180604153722.24956-3-f4bug@amsat.org>
In-Reply-To: <20180604153722.24956-1-f4bug@amsat.org>
References: <20180604153722.24956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RESEND v2 2/2] linux-user: Use is_error() to
 avoid warnings and make the code clearer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

This fixes:

  linux-user/flatload.c:740:9: warning: Loss of sign in implicit conversion
      if (res > (unsigned long)-4096)
          ^~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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
2.17.1
