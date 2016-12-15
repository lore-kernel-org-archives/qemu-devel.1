Received: from eggs.gnu.org ([2001:4830:134:3::10]:37236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Vlad.Lungu@windriver.com>) id 1cHSbX-0002ne-Gg
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:45:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Vlad.Lungu@windriver.com>) id 1cHSbS-0006TJ-G5
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:45:35 -0500
Received: from mail.windriver.com ([147.11.1.11]:58055)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Vlad.Lungu@windriver.com>)
	id 1cHSbS-0006Sl-51
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:45:30 -0500
From: Vlad Lungu <vlad.lungu@windriver.com>
Date: Thu, 15 Dec 2016 11:45:22 +0200
Message-ID: <1481795122-11795-1-git-send-email-vlad.lungu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] multiboot: copy the cmdline verbatim,
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
Rename mb_add_cmdline() to mb_add_modstring()
Unescape filename too
Add new mb_add_cmdline() using  memcpy()

Signed-off-by: Vlad Lungu <vlad.lungu@windriver.com>
---
 hw/i386/multiboot.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 387caa6..bfb52fc 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -109,6 +109,16 @@ static uint32_t mb_add_cmdline(MultibootState *s, const char *cmdline)
     hwaddr p = s->offset_cmdlines;
     char *b = (char *)s->mb_buf + p;
 
+    memcpy(b, cmdline, strlen(cmdline) + 1);
+    s->offset_cmdlines += strlen(b) + 1;
+    return s->mb_buf_phys + p;
+}
+
+static uint32_t mb_add_modstring(MultibootState *s, const char *cmdline)
+{
+    hwaddr p = s->offset_cmdlines;
+    char *b = (char *)s->mb_buf + p;
+
     get_opt_value(b, strlen(cmdline) + 1, cmdline);
     s->offset_cmdlines += strlen(b) + 1;
     return s->mb_buf_phys + p;
@@ -287,7 +297,7 @@ int load_multiboot(FWCfgState *fw_cfg,
     mbs.offset_bootloader = mbs.offset_cmdlines + cmdline_len;
 
     if (initrd_filename) {
-        char *next_initrd, not_last;
+        char *next_initrd, not_last, tmpbuf[strlen(initrd_filename) + 1];
 
         mbs.offset_mods = mbs.mb_buf_size;
 
@@ -301,20 +311,21 @@ int load_multiboot(FWCfgState *fw_cfg,
             *next_initrd = '\0';
             /* if a space comes after the module filename, treat everything
                after that as parameters */
-            hwaddr c = mb_add_cmdline(&mbs, initrd_filename);
+            hwaddr c = mb_add_modstring(&mbs, initrd_filename);
             if ((next_space = strchr(initrd_filename, ' ')))
                 *next_space = '\0';
-            mb_debug("multiboot loading module: %s\n", initrd_filename);
-            mb_mod_length = get_image_size(initrd_filename);
+            get_opt_value(tmpbuf, strlen(initrd_filename) + 1, initrd_filename);
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
