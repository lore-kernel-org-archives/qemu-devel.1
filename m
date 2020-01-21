Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9CCC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A5E20882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfEtDJy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A5E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itsk8-0005ac-Ch
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 07:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsbC-0005UK-1G
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsbA-0001qY-R2
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:25:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsbA-0001qN-Nj
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f08sCaUGdz/X74KR/4byJlR+rckUMn3kq1q9YvV24tM=;
 b=dfEtDJy1C97QARIc2XB7o1WRgrt+dSIaA/UizzzOY9qs3nFzu8o78vt4SFMy7Ennw6Tlmy
 7RhX4W4uYkw2N6A6T0Sce26G6yLYAotdvwnsI23M8V0P/TfL298/trgHfONzx6CJCJthEb
 ICV0l6QYUNSZ2ceSGZwG+Jq4FVcJSm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-UzF5KGOuOYGAWm0HHxOsJg-1; Tue, 21 Jan 2020 07:25:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17C3B800D54;
 Tue, 21 Jan 2020 12:25:34 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6818E60BE0;
 Tue, 21 Jan 2020 12:25:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 010/109] virtiofsd: Fix fuse_daemonize ignored return values
Date: Tue, 21 Jan 2020 12:22:54 +0000
Message-Id: <20200121122433.50803-11-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: UzF5KGOuOYGAWm0HHxOsJg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

QEMU's compiler enables warnings/errors for ignored values
and the (void) trick used in the fuse code isn't enough.
Turn all the return values into a return value on the function.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tools/virtiofsd/helper.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 46466f4054..0ad34f0619 100644
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
@@ -173,6 +171,7 @@ int fuse_parse_cmdline(struct fuse_args *args, struct f=
use_cmdline_opts *opts)
=20
 int fuse_daemonize(int foreground)
 {
+    int ret =3D 0, rett;
     if (!foreground) {
         int nullfd;
         int waiter[2];
@@ -194,8 +193,8 @@ int fuse_daemonize(int foreground)
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
@@ -203,13 +202,22 @@ int fuse_daemonize(int foreground)
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
@@ -217,13 +225,16 @@ int fuse_daemonize(int foreground)
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


