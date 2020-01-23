Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295B6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE65A20718
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj9FXJEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE65A20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugkg-0007ha-Oi
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufdK-0004Iq-Oe
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdJ-0006Cf-Dz
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33230
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdJ-0006Bm-Ak
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpyzySGg83atDS+yWJ/uSWAUnEpEtPnDwxQUntkRQQY=;
 b=hj9FXJEHJtSvXF0ybq962aBGnQ/t+Yn2GIt/OOI+oLPz1e0XDI8AwVV483GFrUCWxSOUjV
 skcV9tr0eNEQpIqo1xu8O7tN/v1HIOdCRrjPtjP89KvCOCkM3fOuP6L39LcMp95Mf1mjcE
 /pQ2V6kbGmUWXR0UbR0DvifMqgETTac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-TPln2ot3PlKYJQ1VfUuu1g-1; Thu, 23 Jan 2020 11:47:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C007910509B1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:00 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDDBC28994;
 Thu, 23 Jan 2020 16:46:58 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 011/108] virtiofsd: Fix fuse_daemonize ignored return values
Date: Thu, 23 Jan 2020 16:44:53 +0000
Message-Id: <20200123164630.91498-12-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: TPln2ot3PlKYJQ1VfUuu1g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

QEMU's compiler enables warnings/errors for ignored values
and the (void) trick used in the fuse code isn't enough.
Turn all the return values into a return value on the function.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/helper.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 5e6f2051a7..d9227d7367 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -10,12 +10,10 @@
  * See the file COPYING.LIB.
  */
=20
-#include "config.h"
 #include "fuse_i.h"
 #include "fuse_lowlevel.h"
 #include "fuse_misc.h"
 #include "fuse_opt.h"
-#include "mount_util.h"
=20
 #include <errno.h>
 #include <limits.h>
@@ -171,6 +169,7 @@ int fuse_parse_cmdline(struct fuse_args *args, struct f=
use_cmdline_opts *opts)
=20
 int fuse_daemonize(int foreground)
 {
+    int ret =3D 0, rett;
     if (!foreground) {
         int nullfd;
         int waiter[2];
@@ -192,8 +191,8 @@ int fuse_daemonize(int foreground)
         case 0:
             break;
         default:
-            (void)read(waiter[0], &completed, sizeof(completed));
-            _exit(0);
+            _exit(read(waiter[0], &completed,
+                       sizeof(completed) !=3D sizeof(completed)));
         }
=20
         if (setsid() =3D=3D -1) {
@@ -201,13 +200,22 @@ int fuse_daemonize(int foreground)
             return -1;
         }
=20
-        (void)chdir("/");
+        ret =3D chdir("/");
=20
         nullfd =3D open("/dev/null", O_RDWR, 0);
         if (nullfd !=3D -1) {
-            (void)dup2(nullfd, 0);
-            (void)dup2(nullfd, 1);
-            (void)dup2(nullfd, 2);
+            rett =3D dup2(nullfd, 0);
+            if (!ret) {
+                ret =3D rett;
+            }
+            rett =3D dup2(nullfd, 1);
+            if (!ret) {
+                ret =3D rett;
+            }
+            rett =3D dup2(nullfd, 2);
+            if (!ret) {
+                ret =3D rett;
+            }
             if (nullfd > 2) {
                 close(nullfd);
             }
@@ -215,13 +223,16 @@ int fuse_daemonize(int foreground)
=20
         /* Propagate completion of daemon initialization */
         completed =3D 1;
-        (void)write(waiter[1], &completed, sizeof(completed));
+        rett =3D write(waiter[1], &completed, sizeof(completed));
+        if (!ret) {
+            ret =3D rett;
+        }
         close(waiter[0]);
         close(waiter[1]);
     } else {
-        (void)chdir("/");
+        ret =3D chdir("/");
     }
-    return 0;
+    return ret;
 }
=20
 void fuse_apply_conn_info_opts(struct fuse_conn_info_opts *opts,
--=20
2.24.1


