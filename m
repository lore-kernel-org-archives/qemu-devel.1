Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C1FC282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E0020883
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E0020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49426 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDPrx-00051S-S9
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 04:43:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPlZ-00088u-Eo
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPlX-0003cq-Uz
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDPlX-0003cE-Jj
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE22F3092662;
	Mon,  8 Apr 2019 08:36:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F8735C5DF;
	Mon,  8 Apr 2019 08:36:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id DD1A91132B74; Mon,  8 Apr 2019 10:36:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 10:36:16 +0200
Message-Id: <20190408083627.7479-5-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-1-armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 08 Apr 2019 08:36:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 04/15] loader-fit: Wean off error_printf()
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408083616.VOGgowl0l-tWJIX9VdsZ2KW8mDO3HQs7OvbmW1sjJsA@z>

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
---
 hw/core/loader-fit.c | 62 +++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 447f60857d..f27b6af942 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/units.h"
 #include "exec/memory.h"
 #include "hw/loader.h"
@@ -33,7 +34,7 @@
 #define FIT_LOADER_MAX_PATH (128)
 
 static const void *fit_load_image_alloc(const void *itb, const char *name,
-                                        int *poff, size_t *psz)
+                                        int *poff, size_t *psz, Error **errp)
 {
     const void *data;
     const char *comp;
@@ -46,6 +47,7 @@ static const void *fit_load_image_alloc(const void *itb, const char *name,
 
     off = fdt_path_offset(itb, path);
     if (off < 0) {
+        error_setg(errp, "can't find node %s", path);
         return NULL;
     }
     if (poff) {
@@ -54,6 +56,7 @@ static const void *fit_load_image_alloc(const void *itb, const char *name,
 
     data = fdt_getprop(itb, off, "data", &sz);
     if (!data) {
+        error_setg(errp, "can't get %s/data", path);
         return NULL;
     }
 
@@ -73,7 +76,7 @@ static const void *fit_load_image_alloc(const void *itb, const char *name,
 
         uncomp_len = gunzip(uncomp_data, uncomp_len, (void *) data, sz);
         if (uncomp_len < 0) {
-            error_printf("unable to decompress %s image\n", name);
+            error_setg(errp, "unable to decompress %s image", name);
             g_free(uncomp_data);
             return NULL;
         }
@@ -85,18 +88,19 @@ static const void *fit_load_image_alloc(const void *itb, const char *name,
         return data;
     }
 
-    error_printf("unknown compression '%s'\n", comp);
+    error_setg(errp, "unknown compression '%s'", comp);
     return NULL;
 }
 
 static int fit_image_addr(const void *itb, int img, const char *name,
-                          hwaddr *addr)
+                          hwaddr *addr, Error **errp)
 {
     const void *prop;
     int len;
 
     prop = fdt_getprop(itb, img, name, &len);
     if (!prop) {
+        error_setg(errp, "can't find %s address", name);
         return -ENOENT;
     }
 
@@ -108,13 +112,14 @@ static int fit_image_addr(const void *itb, int img, const char *name,
         *addr = fdt64_to_cpu(*(fdt64_t *)prop);
         return 0;
     default:
-        error_printf("invalid %s address length %d\n", name, len);
+        error_setg(errp, "invalid %s address length %d", name, len);
         return -EINVAL;
     }
 }
 
 static int fit_load_kernel(const struct fit_loader *ldr, const void *itb,
-                           int cfg, void *opaque, hwaddr *pend)
+                           int cfg, void *opaque, hwaddr *pend,
+                           Error **errp)
 {
     const char *name;
     const void *data;
@@ -126,26 +131,26 @@ static int fit_load_kernel(const struct fit_loader *ldr, const void *itb,
 
     name = fdt_getprop(itb, cfg, "kernel", NULL);
     if (!name) {
-        error_printf("no kernel specified by FIT configuration\n");
+        error_setg(errp, "no kernel specified by FIT configuration");
         return -EINVAL;
     }
 
-    load_data = data = fit_load_image_alloc(itb, name, &img_off, &sz);
+    load_data = data = fit_load_image_alloc(itb, name, &img_off, &sz, errp);
     if (!data) {
-        error_printf("unable to load kernel image from FIT\n");
+        error_prepend(errp, "unable to load kernel image from FIT: ");
         return -EINVAL;
     }
 
-    err = fit_image_addr(itb, img_off, "load", &load_addr);
+    err = fit_image_addr(itb, img_off, "load", &load_addr, errp);
     if (err) {
-        error_printf("unable to read kernel load address from FIT\n");
+        error_prepend(errp, "unable to read kernel load address from FIT: ");
         ret = err;
         goto out;
     }
 
-    err = fit_image_addr(itb, img_off, "entry", &entry_addr);
+    err = fit_image_addr(itb, img_off, "entry", &entry_addr, errp);
     if (err) {
-        error_printf("unable to read kernel entry address from FIT\n");
+        error_prepend(errp, "unable to read kernel entry address from FIT: ");
         ret = err;
         goto out;
     }
@@ -172,7 +177,7 @@ out:
 
 static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
                         int cfg, void *opaque, const void *match_data,
-                        hwaddr kernel_end)
+                        hwaddr kernel_end, Error **errp)
 {
     const char *name;
     const void *data;
@@ -187,16 +192,18 @@ static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
         return 0;
     }
 
-    load_data = data = fit_load_image_alloc(itb, name, &img_off, &sz);
+    load_data = data = fit_load_image_alloc(itb, name, &img_off, &sz, errp);
     if (!data) {
-        error_printf("unable to load FDT image from FIT\n");
+        error_prepend(errp, "unable to load FDT image from FIT: ");
         return -EINVAL;
     }
 
-    err = fit_image_addr(itb, img_off, "load", &load_addr);
+    err = fit_image_addr(itb, img_off, "load", &load_addr, errp);
     if (err == -ENOENT) {
         load_addr = ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
+        error_free(*errp);
     } else if (err) {
+        error_prepend(errp, "unable to read FDT load address from FIT: ");
         ret = err;
         goto out;
     }
@@ -229,7 +236,7 @@ static bool fit_cfg_compatible(const void *itb, int cfg, const char *compat)
         return false;
     }
 
-    fdt = fit_load_image_alloc(itb, fdt_name, NULL, NULL);
+    fdt = fit_load_image_alloc(itb, fdt_name, NULL, NULL, NULL);
     if (!fdt) {
         return false;
     }
@@ -252,11 +259,12 @@ out:
 
 int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque)
 {
+    Error *err = NULL;
     const struct fit_loader_match *match;
     const void *itb, *match_data = NULL;
     const char *def_cfg_name;
     char path[FIT_LOADER_MAX_PATH];
-    int itb_size, configs, cfg_off, off, err;
+    int itb_size, configs, cfg_off, off;
     hwaddr kernel_end;
     int ret;
 
@@ -267,6 +275,7 @@ int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque)
 
     configs = fdt_path_offset(itb, "/configurations");
     if (configs < 0) {
+        error_report("can't find node /configurations");
         ret = configs;
         goto out;
     }
@@ -301,20 +310,21 @@ int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque)
     }
 
     if (cfg_off < 0) {
-        /* couldn't find a configuration to use */
+        error_report("can't find configuration");
         ret = cfg_off;
         goto out;
     }
 
-    err = fit_load_kernel(ldr, itb, cfg_off, opaque, &kernel_end);
-    if (err) {
-        ret = err;
+    ret = fit_load_kernel(ldr, itb, cfg_off, opaque, &kernel_end, &err);
+    if (ret) {
+        error_report_err(err);
         goto out;
     }
 
-    err = fit_load_fdt(ldr, itb, cfg_off, opaque, match_data, kernel_end);
-    if (err) {
-        ret = err;
+    ret = fit_load_fdt(ldr, itb, cfg_off, opaque, match_data, kernel_end,
+                       &err);
+    if (ret) {
+        error_report_err(err);
         goto out;
     }
 
-- 
2.17.2


