Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18705C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD22A20869
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD22A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47204 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHE8Y-0003Ch-21
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 17:00:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0V-00056R-B4
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0S-0005CR-Hg
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0S-0005Ah-7q
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6681090901;
	Thu, 18 Apr 2019 20:51:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 01276104C41C;
	Thu, 18 Apr 2019 20:51:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 380D71132A03; Thu, 18 Apr 2019 22:51:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:51:06 +0200
Message-Id: <20190418205135.6686-8-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 18 Apr 2019 20:51:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 07/36] loader-fit: Wean off
 error_printf()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Paul Burton <pburton@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418205106.lKz6pJVIrf2zkSH5rew_a5o0_wuHoSkhBC_zDE0ijco@z>

load_fit() reports errors with error_printf() instead of
error_report().  Worse, it even reports errors it actually recovers
from, in fit_cfg_compatible() and fit_load_fdt().  Messed up in
initial commit 51b58561c1d.

Convert the helper functions for load_fit() to Error.  Make sure each
failure path sets an error.

Fix fit_cfg_compatible() and fit_load_fdt() not to report errors they
actually recover from.

Convert load_fit() to error_report().

Cc: Paul Burton <pburton@wavecomp.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190417190641.26814-4-armbru@redhat.com>
---
 hw/core/loader-fit.c | 62 +++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 447f60857d..f27b6af942 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/units.h"
 #include "exec/memory.h"
 #include "hw/loader.h"
@@ -33,7 +34,7 @@
 #define FIT_LOADER_MAX_PATH (128)
=20
 static const void *fit_load_image_alloc(const void *itb, const char *nam=
e,
-                                        int *poff, size_t *psz)
+                                        int *poff, size_t *psz, Error **=
errp)
 {
     const void *data;
     const char *comp;
@@ -46,6 +47,7 @@ static const void *fit_load_image_alloc(const void *itb=
, const char *name,
=20
     off =3D fdt_path_offset(itb, path);
     if (off < 0) {
+        error_setg(errp, "can't find node %s", path);
         return NULL;
     }
     if (poff) {
@@ -54,6 +56,7 @@ static const void *fit_load_image_alloc(const void *itb=
, const char *name,
=20
     data =3D fdt_getprop(itb, off, "data", &sz);
     if (!data) {
+        error_setg(errp, "can't get %s/data", path);
         return NULL;
     }
=20
@@ -73,7 +76,7 @@ static const void *fit_load_image_alloc(const void *itb=
, const char *name,
=20
         uncomp_len =3D gunzip(uncomp_data, uncomp_len, (void *) data, sz=
);
         if (uncomp_len < 0) {
-            error_printf("unable to decompress %s image\n", name);
+            error_setg(errp, "unable to decompress %s image", name);
             g_free(uncomp_data);
             return NULL;
         }
@@ -85,18 +88,19 @@ static const void *fit_load_image_alloc(const void *i=
tb, const char *name,
         return data;
     }
=20
-    error_printf("unknown compression '%s'\n", comp);
+    error_setg(errp, "unknown compression '%s'", comp);
     return NULL;
 }
=20
 static int fit_image_addr(const void *itb, int img, const char *name,
-                          hwaddr *addr)
+                          hwaddr *addr, Error **errp)
 {
     const void *prop;
     int len;
=20
     prop =3D fdt_getprop(itb, img, name, &len);
     if (!prop) {
+        error_setg(errp, "can't find %s address", name);
         return -ENOENT;
     }
=20
@@ -108,13 +112,14 @@ static int fit_image_addr(const void *itb, int img,=
 const char *name,
         *addr =3D fdt64_to_cpu(*(fdt64_t *)prop);
         return 0;
     default:
-        error_printf("invalid %s address length %d\n", name, len);
+        error_setg(errp, "invalid %s address length %d", name, len);
         return -EINVAL;
     }
 }
=20
 static int fit_load_kernel(const struct fit_loader *ldr, const void *itb=
,
-                           int cfg, void *opaque, hwaddr *pend)
+                           int cfg, void *opaque, hwaddr *pend,
+                           Error **errp)
 {
     const char *name;
     const void *data;
@@ -126,26 +131,26 @@ static int fit_load_kernel(const struct fit_loader =
*ldr, const void *itb,
=20
     name =3D fdt_getprop(itb, cfg, "kernel", NULL);
     if (!name) {
-        error_printf("no kernel specified by FIT configuration\n");
+        error_setg(errp, "no kernel specified by FIT configuration");
         return -EINVAL;
     }
=20
-    load_data =3D data =3D fit_load_image_alloc(itb, name, &img_off, &sz=
);
+    load_data =3D data =3D fit_load_image_alloc(itb, name, &img_off, &sz=
, errp);
     if (!data) {
-        error_printf("unable to load kernel image from FIT\n");
+        error_prepend(errp, "unable to load kernel image from FIT: ");
         return -EINVAL;
     }
=20
-    err =3D fit_image_addr(itb, img_off, "load", &load_addr);
+    err =3D fit_image_addr(itb, img_off, "load", &load_addr, errp);
     if (err) {
-        error_printf("unable to read kernel load address from FIT\n");
+        error_prepend(errp, "unable to read kernel load address from FIT=
: ");
         ret =3D err;
         goto out;
     }
=20
-    err =3D fit_image_addr(itb, img_off, "entry", &entry_addr);
+    err =3D fit_image_addr(itb, img_off, "entry", &entry_addr, errp);
     if (err) {
-        error_printf("unable to read kernel entry address from FIT\n");
+        error_prepend(errp, "unable to read kernel entry address from FI=
T: ");
         ret =3D err;
         goto out;
     }
@@ -172,7 +177,7 @@ out:
=20
 static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
                         int cfg, void *opaque, const void *match_data,
-                        hwaddr kernel_end)
+                        hwaddr kernel_end, Error **errp)
 {
     const char *name;
     const void *data;
@@ -187,16 +192,18 @@ static int fit_load_fdt(const struct fit_loader *ld=
r, const void *itb,
         return 0;
     }
=20
-    load_data =3D data =3D fit_load_image_alloc(itb, name, &img_off, &sz=
);
+    load_data =3D data =3D fit_load_image_alloc(itb, name, &img_off, &sz=
, errp);
     if (!data) {
-        error_printf("unable to load FDT image from FIT\n");
+        error_prepend(errp, "unable to load FDT image from FIT: ");
         return -EINVAL;
     }
=20
-    err =3D fit_image_addr(itb, img_off, "load", &load_addr);
+    err =3D fit_image_addr(itb, img_off, "load", &load_addr, errp);
     if (err =3D=3D -ENOENT) {
         load_addr =3D ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
+        error_free(*errp);
     } else if (err) {
+        error_prepend(errp, "unable to read FDT load address from FIT: "=
);
         ret =3D err;
         goto out;
     }
@@ -229,7 +236,7 @@ static bool fit_cfg_compatible(const void *itb, int c=
fg, const char *compat)
         return false;
     }
=20
-    fdt =3D fit_load_image_alloc(itb, fdt_name, NULL, NULL);
+    fdt =3D fit_load_image_alloc(itb, fdt_name, NULL, NULL, NULL);
     if (!fdt) {
         return false;
     }
@@ -252,11 +259,12 @@ out:
=20
 int load_fit(const struct fit_loader *ldr, const char *filename, void *o=
paque)
 {
+    Error *err =3D NULL;
     const struct fit_loader_match *match;
     const void *itb, *match_data =3D NULL;
     const char *def_cfg_name;
     char path[FIT_LOADER_MAX_PATH];
-    int itb_size, configs, cfg_off, off, err;
+    int itb_size, configs, cfg_off, off;
     hwaddr kernel_end;
     int ret;
=20
@@ -267,6 +275,7 @@ int load_fit(const struct fit_loader *ldr, const char=
 *filename, void *opaque)
=20
     configs =3D fdt_path_offset(itb, "/configurations");
     if (configs < 0) {
+        error_report("can't find node /configurations");
         ret =3D configs;
         goto out;
     }
@@ -301,20 +310,21 @@ int load_fit(const struct fit_loader *ldr, const ch=
ar *filename, void *opaque)
     }
=20
     if (cfg_off < 0) {
-        /* couldn't find a configuration to use */
+        error_report("can't find configuration");
         ret =3D cfg_off;
         goto out;
     }
=20
-    err =3D fit_load_kernel(ldr, itb, cfg_off, opaque, &kernel_end);
-    if (err) {
-        ret =3D err;
+    ret =3D fit_load_kernel(ldr, itb, cfg_off, opaque, &kernel_end, &err=
);
+    if (ret) {
+        error_report_err(err);
         goto out;
     }
=20
-    err =3D fit_load_fdt(ldr, itb, cfg_off, opaque, match_data, kernel_e=
nd);
-    if (err) {
-        ret =3D err;
+    ret =3D fit_load_fdt(ldr, itb, cfg_off, opaque, match_data, kernel_e=
nd,
+                       &err);
+    if (ret) {
+        error_report_err(err);
         goto out;
     }
=20
--=20
2.17.2


