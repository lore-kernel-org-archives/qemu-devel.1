Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5E1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A450206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/2w7Ee7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A450206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVcD-0008NV-11
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPj-0003T0-2R
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPh-0003s7-3q
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21719
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVPf-0003rZ-R2
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XjPcznlZf+ROMdwQ7pzkewzzR75tPPpuD1lfu0Vhk60=;
 b=R/2w7Ee7ykqI+6OubxhXLFb7sifTcMegI874V/MxVx4tUzGrl34FI1jyu9ii8VaNUejrNh
 AsiRKRA7XkcYJT99n4nGdFwqgn3gPKxRQZr/9glqCtg6/KqoJhbkzcVo4m8ftOsDTkLlxf
 D0BWZZc0qmPns/oC6RNcOhfHsQIghFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-c929s5gkONq6sIZgL2QUsA-1; Mon, 21 Oct 2019 06:59:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D6341800DC7;
 Mon, 21 Oct 2019 10:59:42 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FDBD614C1;
 Mon, 21 Oct 2019 10:59:37 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 10/30] virtiofsd: Fix common header and define for QEMU builds
Date: Mon, 21 Oct 2019 11:58:12 +0100
Message-Id: <20191021105832.36574-11-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: c929s5gkONq6sIZgL2QUsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

All of the fuse files include config.h and define GNU_SOURCE
where we don't have either under our build - remove them.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/buffer.c         |  3 ---
 contrib/virtiofsd/fuse_i.h         |  3 +++
 contrib/virtiofsd/fuse_loop_mt.c   |  3 +--
 contrib/virtiofsd/fuse_lowlevel.c  |  9 ---------
 contrib/virtiofsd/fuse_opt.c       |  1 -
 contrib/virtiofsd/fuse_signals.c   |  3 +--
 contrib/virtiofsd/passthrough_ll.c | 10 +++-------
 7 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/contrib/virtiofsd/buffer.c b/contrib/virtiofsd/buffer.c
index 5ab9b87455..3c9b443fa0 100644
--- a/contrib/virtiofsd/buffer.c
+++ b/contrib/virtiofsd/buffer.c
@@ -9,9 +9,6 @@
   See the file COPYING.LIB
 */
=20
-#define _GNU_SOURCE
-
-#include "config.h"
 #include "fuse_i.h"
 #include "fuse_lowlevel.h"
 #include <string.h>
diff --git a/contrib/virtiofsd/fuse_i.h b/contrib/virtiofsd/fuse_i.h
index bcd6a140fc..6c3f432d0e 100644
--- a/contrib/virtiofsd/fuse_i.h
+++ b/contrib/virtiofsd/fuse_i.h
@@ -6,6 +6,9 @@
   See the file COPYING.LIB
 */
=20
+#define FUSE_USE_VERSION 31
+
+
 #include "fuse.h"
 #include "fuse_lowlevel.h"
=20
diff --git a/contrib/virtiofsd/fuse_loop_mt.c b/contrib/virtiofsd/fuse_loop=
_mt.c
index 6fcd47e42c..e45b2337a0 100644
--- a/contrib/virtiofsd/fuse_loop_mt.c
+++ b/contrib/virtiofsd/fuse_loop_mt.c
@@ -8,11 +8,10 @@
   See the file COPYING.LIB.
 */
=20
-#include "config.h"
+#include "fuse_i.h"
 #include "fuse_lowlevel.h"
 #include "fuse_misc.h"
 #include "fuse_kernel.h"
-#include "fuse_i.h"
=20
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index a36a00e793..5ea113ab49 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -9,14 +9,10 @@
   See the file COPYING.LIB
 */
=20
-#define _GNU_SOURCE
-
-#include "config.h"
 #include "fuse_i.h"
 #include "fuse_kernel.h"
 #include "fuse_opt.h"
 #include "fuse_misc.h"
-#include "mount_util.h"
=20
 #include <stdio.h>
 #include <stdlib.h>
@@ -1954,7 +1950,6 @@ static struct {
 =09[FUSE_READDIRPLUS] =3D { do_readdirplus,=09"READDIRPLUS"},
 =09[FUSE_RENAME2]     =3D { do_rename2,      "RENAME2"    },
 =09[FUSE_COPY_FILE_RANGE] =3D { do_copy_file_range, "COPY_FILE_RANGE" },
-=09[CUSE_INIT]=09   =3D { cuse_lowlevel_init, "CUSE_INIT"   },
 };
=20
 #define FUSE_MAXOP (sizeof(fuse_ll_ops) / sizeof(fuse_ll_ops[0]))
@@ -2073,7 +2068,6 @@ void fuse_lowlevel_version(void)
 {
 =09printf("using FUSE kernel interface version %i.%i\n",
 =09       FUSE_KERNEL_VERSION, FUSE_KERNEL_MINOR_VERSION);
-=09fuse_mount_version();
 }
=20
 void fuse_lowlevel_help(void)
@@ -2151,9 +2145,6 @@ struct fuse_session *fuse_session_new(struct fuse_arg=
s *args,
 =09=09goto out4;
 =09}
=20
-=09if (se->debug)
-=09=09fuse_log(FUSE_LOG_DEBUG, "FUSE library version: %s\n", PACKAGE_VERSI=
ON);
-
 =09se->bufsize =3D FUSE_MAX_MAX_PAGES * getpagesize() +
 =09=09FUSE_BUFFER_HEADER_SIZE;
=20
diff --git a/contrib/virtiofsd/fuse_opt.c b/contrib/virtiofsd/fuse_opt.c
index 93066b926e..b81d4bc4c9 100644
--- a/contrib/virtiofsd/fuse_opt.c
+++ b/contrib/virtiofsd/fuse_opt.c
@@ -9,7 +9,6 @@
   See the file COPYING.LIB
 */
=20
-#include "config.h"
 #include "fuse_i.h"
 #include "fuse_opt.h"
 #include "fuse_misc.h"
diff --git a/contrib/virtiofsd/fuse_signals.c b/contrib/virtiofsd/fuse_sign=
als.c
index 4271947bd4..e8f9b1e9a6 100644
--- a/contrib/virtiofsd/fuse_signals.c
+++ b/contrib/virtiofsd/fuse_signals.c
@@ -8,9 +8,8 @@
   See the file COPYING.LIB
 */
=20
-#include "config.h"
-#include "fuse_lowlevel.h"
 #include "fuse_i.h"
+#include "fuse_lowlevel.h"
=20
 #include <stdio.h>
 #include <string.h>
diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 8f94dcbc92..72fae9d10b 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -34,12 +34,7 @@
  * \include passthrough_ll.c
  */
=20
-#define _GNU_SOURCE
-#define FUSE_USE_VERSION 31
-
-#include "config.h"
-
-#include <fuse_lowlevel.h>
+#include "fuse_lowlevel.h"
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -57,6 +52,8 @@
=20
 #include "passthrough_helpers.h"
=20
+#define HAVE_POSIX_FALLOCATE 1
+
 /* We are re-using pointers to our `struct lo_inode` and `struct
    lo_dirp` elements as inodes. This means that we must be able to
    store uintptr_t values in a fuse_ino_t variable. The following
@@ -1224,7 +1221,6 @@ int main(int argc, char *argv[])
 =09=09ret =3D 0;
 =09=09goto err_out1;
 =09} else if (opts.show_version) {
-=09=09printf("FUSE library version %s\n", fuse_pkgversion());
 =09=09fuse_lowlevel_version();
 =09=09ret =3D 0;
 =09=09goto err_out1;
--=20
2.23.0


