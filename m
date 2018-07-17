Received: from eggs.gnu.org ([2001:4830:134:3::10]:48559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZT-0005K5-CK
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZN-0007Jn-EP
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZN-0007JR-8R
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E15ED7B2B3
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 15:07:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:53 +0200
Message-Id: <1531840015-28804-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
References: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/13] i386: only parse the initrd_filename once
 for multiboot modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The multiboot code parses the initrd_filename twice, first to count how
many entries there are, and second to process each entry. This changes
the first loop to store the parse module names in a list, and the second
loop can now use these names. This avoids having to pass NULL to the
get_opt_value() method which means it can safely assume a non-NULL param.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20180514171913.17664-3-berrange@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/multiboot.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 8e26545..d519e20 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -161,6 +161,7 @@ int load_multiboot(FWCfgState *fw_cfg,
     uint8_t bootinfo[MBI_SIZE];
     uint8_t *mb_bootinfo_data;
     uint32_t cmdline_len;
+    GList *mods =3D NULL;
=20
     /* Ok, let's see if it is a multiboot image.
        The header is 12x32bit long, so the latest entry may be 8192 - 48=
. */
@@ -291,15 +292,16 @@ int load_multiboot(FWCfgState *fw_cfg,
     cmdline_len =3D strlen(kernel_filename) + 1;
     cmdline_len +=3D strlen(kernel_cmdline) + 1;
     if (initrd_filename) {
-        const char *r =3D get_opt_value(initrd_filename, NULL);
+        const char *r =3D initrd_filename;
         cmdline_len +=3D strlen(initrd_filename) + 1;
-        while (1) {
+        while (*r) {
+            char *value;
+            r =3D get_opt_value(r, &value);
             mbs.mb_mods_avail++;
-            r =3D get_opt_value(r, NULL);
-            if (!*r) {
-                break;
+            mods =3D g_list_append(mods, value);
+            if (*r) {
+                r++;
             }
-            r++;
         }
     }
=20
@@ -314,20 +316,16 @@ int load_multiboot(FWCfgState *fw_cfg,
     mbs.offset_cmdlines   =3D mbs.offset_mbinfo + mbs.mb_mods_avail * MB=
_MOD_SIZE;
     mbs.offset_bootloader =3D mbs.offset_cmdlines + cmdline_len;
=20
-    if (initrd_filename) {
-        const char *next_initrd;
-        char not_last;
-        char *one_file =3D NULL;
-
+    if (mods) {
+        GList *tmpl =3D mods;
         mbs.offset_mods =3D mbs.mb_buf_size;
=20
-        do {
+        while (tmpl) {
             char *next_space;
             int mb_mod_length;
             uint32_t offs =3D mbs.mb_buf_size;
+            char *one_file =3D tmpl->data;
=20
-            next_initrd =3D get_opt_value(initrd_filename, &one_file);
-            not_last =3D *next_initrd;
             /* if a space comes after the module filename, treat everyth=
ing
                after that as parameters */
             hwaddr c =3D mb_add_cmdline(&mbs, one_file);
@@ -352,10 +350,10 @@ int load_multiboot(FWCfgState *fw_cfg,
             mb_debug("mod_start: %p\nmod_end:   %p\n  cmdline: "TARGET_F=
MT_plx,
                      (char *)mbs.mb_buf + offs,
                      (char *)mbs.mb_buf + offs + mb_mod_length, c);
-            initrd_filename =3D next_initrd+1;
             g_free(one_file);
-            one_file =3D NULL;
-        } while (not_last);
+            tmpl =3D tmpl->next;
+        }
+        g_list_free(mods);
     }
=20
     /* Commandline support */
--=20
1.8.3.1
