Received: from eggs.gnu.org ([2001:4830:134:3::10]:40978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Vlad.Lungu@windriver.com>) id 1cHSsp-0007sm-Ub
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Vlad.Lungu@windriver.com>) id 1cHSsl-0005K9-6o
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:03:27 -0500
Received: from mail1.windriver.com ([147.11.146.13]:51592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Vlad.Lungu@windriver.com>)
	id 1cHSsk-0005Ji-So
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:03:23 -0500
From: Vlad Lungu <vlad.lungu@windriver.com>
Date: Thu, 15 Dec 2016 12:03:02 +0200
Message-ID: <1481796182-12670-1-git-send-email-vlad.lungu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCHv2] multiboot: copy the cmdline verbatim,
 unescape module strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, Vlad Lungu <vlad.lungu@windriver.com>

get_opt_value() truncates the value at the first comma
Use memcpy() instead
Unescape the module filename and parameters with get_opt_value()
before calling mb_add_cmdline()

Signed-off-by: Vlad Lungu <vlad.lungu@windriver.com>
---
 hw/i386/multiboot.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 387caa6..37e27f2 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -109,7 +109,7 @@ static uint32_t mb_add_cmdline(MultibootState *s, const char *cmdline)
     hwaddr p = s->offset_cmdlines;
     char *b = (char *)s->mb_buf + p;
 
-    get_opt_value(b, strlen(cmdline) + 1, cmdline);
+    memcpy(b, cmdline, strlen(cmdline) + 1);
     s->offset_cmdlines += strlen(b) + 1;
     return s->mb_buf_phys + p;
 }
@@ -287,7 +287,7 @@ int load_multiboot(FWCfgState *fw_cfg,
     mbs.offset_bootloader = mbs.offset_cmdlines + cmdline_len;
 
     if (initrd_filename) {
-        char *next_initrd, not_last;
+        char *next_initrd, not_last, tmpbuf[strlen(initrd_filename) + 1];
 
         mbs.offset_mods = mbs.mb_buf_size;
 
@@ -299,22 +299,24 @@ int load_multiboot(FWCfgState *fw_cfg,
             next_initrd = (char *)get_opt_value(NULL, 0, initrd_filename);
             not_last = *next_initrd;
             *next_initrd = '\0';
+            /* Unescape the filename + eventual arguments */
+            get_opt_value(tmpbuf, strlen(initrd_filename) + 1, initrd_filename);
             /* if a space comes after the module filename, treat everything
                after that as parameters */
-            hwaddr c = mb_add_cmdline(&mbs, initrd_filename);
-            if ((next_space = strchr(initrd_filename, ' ')))
+            hwaddr c = mb_add_cmdline(&mbs, tmpbuf);
+            if ((next_space = strchr(tmpbuf, ' ')))
                 *next_space = '\0';
-            mb_debug("multiboot loading module: %s\n", initrd_filename);
-            mb_mod_length = get_image_size(initrd_filename);
+            mb_debug("multiboot loading module: %s\n", tmpbuf);
+            mb_mod_length = get_image_size(tmpbuf);
             if (mb_mod_length < 0) {
-                fprintf(stderr, "Failed to open file '%s'\n", initrd_filename);
+                fprintf(stderr, "Failed to open file '%s'\n", tmpbuf);
                 exit(1);
             }
 
             mbs.mb_buf_size = TARGET_PAGE_ALIGN(mb_mod_length + mbs.mb_buf_size);
             mbs.mb_buf = g_realloc(mbs.mb_buf, mbs.mb_buf_size);
 
-            load_image(initrd_filename, (unsigned char *)mbs.mb_buf + offs);
+            load_image(tmpbuf, (unsigned char *)mbs.mb_buf + offs);
             mb_add_mod(&mbs, mbs.mb_buf_phys + offs,
                        mbs.mb_buf_phys + offs + mb_mod_length, c);
 
-- 
1.9.1
