Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6332C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B67821479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B67821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOj2Z-0002aG-SC
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:24:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hOj0j-0001TM-Fr
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hOj0i-0001dj-DH
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hOj0i-0001YQ-66
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:22:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0ED06309B167;
	Thu,  9 May 2019 13:22:43 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.40.205.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D6BE8600C7;
	Thu,  9 May 2019 13:22:35 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:22:34 +0200
Message-Id: <20190509132234.22103-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 09 May 2019 13:22:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC] rng-random: allow to use getrandom()
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
Cc: Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
	Kashyap Chamarthy <kchamart@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a parameter to select the rng-random backend mode,
from a file or from qemu_guest_getrandom():

  -object rng-random,id=3Drng0,mode=3Dfile or
  -object rng-random,id=3Drng0,mode=3Dgetrandom

by default mode is file

This patch applies on top of
"[PATCH v4 00/24] Add qemu_getrandom and ARMv8.5-RNG etc"
Based-on: <20190506173353.32206-1-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 backends/rng-random.c | 76 ++++++++++++++++++++++++++++++++++++-------
 qapi/ui.json          | 11 +++++++
 2 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/backends/rng-random.c b/backends/rng-random.c
index e2a49b0571d7..e95c71545ef9 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -14,13 +14,16 @@
 #include "sysemu/rng-random.h"
 #include "sysemu/rng.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-ui.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/main-loop.h"
+#include "qemu/guest-random.h"
=20
 struct RngRandom
 {
     RngBackend parent;
=20
+    RngRandomMode mode;
     int fd;
     char *filename;
 };
@@ -59,10 +62,27 @@ static void rng_random_request_entropy(RngBackend *b,=
 RngRequest *req)
 {
     RngRandom *s =3D RNG_RANDOM(b);
=20
-    if (QSIMPLEQ_EMPTY(&s->parent.requests)) {
-        /* If there are no pending requests yet, we need to
-         * install our fd handler. */
-        qemu_set_fd_handler(s->fd, entropy_available, NULL, s);
+    switch (s->mode) {
+    case RNG_RANDOM_MODE_FILE:
+        if (QSIMPLEQ_EMPTY(&s->parent.requests)) {
+            /* If there are no pending requests yet, we need to
+             * install our fd handler. */
+            qemu_set_fd_handler(s->fd, entropy_available, NULL, s);
+        }
+        break;
+    case RNG_RANDOM_MODE_GETRANDOM:
+        while (!QSIMPLEQ_EMPTY(&s->parent.requests)) {
+            RngRequest *req =3D QSIMPLEQ_FIRST(&s->parent.requests);
+
+            qemu_guest_getrandom_nofail(req->data, req->size);
+
+            req->receive_entropy(req->opaque, req->data, req->size);
+
+            rng_backend_finalize_request(&s->parent, req);
+        }
+        break;
+    default:
+        break;
     }
 }
=20
@@ -70,17 +90,40 @@ static void rng_random_opened(RngBackend *b, Error **=
errp)
 {
     RngRandom *s =3D RNG_RANDOM(b);
=20
-    if (s->filename =3D=3D NULL) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "filename", "a valid filename");
-    } else {
-        s->fd =3D qemu_open(s->filename, O_RDONLY | O_NONBLOCK);
-        if (s->fd =3D=3D -1) {
-            error_setg_file_open(errp, errno, s->filename);
+    switch (s->mode) {
+    case RNG_RANDOM_MODE_FILE:
+        if (s->filename =3D=3D NULL) {
+            error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                       "filename", "a valid filename");
+        } else {
+            s->fd =3D qemu_open(s->filename, O_RDONLY | O_NONBLOCK);
+            if (s->fd =3D=3D -1) {
+                error_setg_file_open(errp, errno, s->filename);
+            }
         }
+        break;
+    case RNG_RANDOM_MODE_GETRANDOM:
+        break;
+    default:
+        break;
     }
 }
=20
+static int rng_random_get_mode(Object *obj, Error **errp)
+{
+    RngRandom *s =3D RNG_RANDOM(obj);
+
+    return s->mode;
+}
+
+static void rng_random_set_mode(Object *obj, int value,
+                                       Error **errp)
+{
+    RngRandom *s =3D RNG_RANDOM(obj);
+
+    s->mode =3D value;
+}
+
 static char *rng_random_get_filename(Object *obj, Error **errp)
 {
     RngRandom *s =3D RNG_RANDOM(obj);
@@ -94,6 +137,11 @@ static void rng_random_set_filename(Object *obj, cons=
t char *filename,
     RngBackend *b =3D RNG_BACKEND(obj);
     RngRandom *s =3D RNG_RANDOM(obj);
=20
+    if (s->mode !=3D RNG_RANDOM_MODE_FILE) {
+        error_setg(errp, QERR_INVALID_PARAMETER, "filename");
+        return;
+    }
+
     if (b->opened) {
         error_setg(errp, QERR_PERMISSION_DENIED);
         return;
@@ -107,11 +155,17 @@ static void rng_random_init(Object *obj)
 {
     RngRandom *s =3D RNG_RANDOM(obj);
=20
+    object_property_add_enum(obj, "mode", "RngRandomMode",
+                            &RngRandomMode_lookup,
+                            rng_random_get_mode,
+                            rng_random_set_mode,
+                            NULL);
     object_property_add_str(obj, "filename",
                             rng_random_get_filename,
                             rng_random_set_filename,
                             NULL);
=20
+    s->mode =3D RNG_RANDOM_MODE_FILE;
     s->filename =3D g_strdup("/dev/random");
     s->fd =3D -1;
 }
diff --git a/qapi/ui.json b/qapi/ui.json
index 59e412139adc..25b33d79e9af 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1170,3 +1170,14 @@
 ##
 { 'command': 'query-display-options',
   'returns': 'DisplayOptions' }
+
+##
+# @RngRandomMode:
+#
+# Value to select random number generation mode in rng-random backend
+#
+# Since: 4.1
+#
+##
+{ 'enum': 'RngRandomMode',
+  'data': [ 'file', 'getrandom' ] }
--=20
2.20.1


