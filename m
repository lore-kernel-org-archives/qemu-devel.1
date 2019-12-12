Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5715DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F75D21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhGxNLa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F75D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRaT-00035T-G7
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRV3-0005A6-QK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRV2-0001DB-CM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30580
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRV2-0001Bo-8C
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRRjerRpuN4Dt176CUE+aUh+f+XW9HBjlO7drQNxgPs=;
 b=VhGxNLa+c6pz+9wQaRgwzApz4AtEgseUqP83uNV5pYlcCmgMpv8LPo3XwQjFgTqmFUlBGf
 8OMHszfFuGI6cbPlYtOz2iiBn7O5rZPJKIWUh0HBNxg5K8vFb9oQeRNvOSmNSV8ZZdqJWC
 sqJfla9gZZjEVK7bBwGh7adAeYQ2jxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-ySQLvTRgPkqWnytq93IIeA-1; Thu, 12 Dec 2019 11:39:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 274C6107ACC7
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:32 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D5AF60C05;
 Thu, 12 Dec 2019 16:39:31 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 011/104] virtiofsd: Fix common header and define for QEMU
 builds
Date: Thu, 12 Dec 2019 16:37:31 +0000
Message-Id: <20191212163904.159893-12-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ySQLvTRgPkqWnytq93IIeA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

All of the fuse files include config.h and define GNU_SOURCE
where we don't have either under our build - remove them.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/buffer.c         |  3 ---
 tools/virtiofsd/fuse_i.h         |  3 +++
 tools/virtiofsd/fuse_loop_mt.c   |  3 +--
 tools/virtiofsd/fuse_lowlevel.c  | 12 +-----------
 tools/virtiofsd/fuse_opt.c       |  1 -
 tools/virtiofsd/fuse_signals.c   |  1 -
 tools/virtiofsd/passthrough_ll.c |  9 ++-------
 7 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
index 38521f5889..1d7e6d2439 100644
--- a/tools/virtiofsd/buffer.c
+++ b/tools/virtiofsd/buffer.c
@@ -9,9 +9,6 @@
  * See the file COPYING.LIB
  */
=20
-#define _GNU_SOURCE
-
-#include "config.h"
 #include "fuse_i.h"
 #include "fuse_lowlevel.h"
 #include <assert.h>
diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index 1119e85e57..0b5acc8765 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -6,6 +6,9 @@
  * See the file COPYING.LIB
  */
=20
+#define FUSE_USE_VERSION 31
+
+
 #include "fuse.h"
 #include "fuse_lowlevel.h"
=20
diff --git a/tools/virtiofsd/fuse_loop_mt.c b/tools/virtiofsd/fuse_loop_mt.=
c
index 39e080d9ff..00138b2ab3 100644
--- a/tools/virtiofsd/fuse_loop_mt.c
+++ b/tools/virtiofsd/fuse_loop_mt.c
@@ -8,11 +8,10 @@
  * See the file COPYING.LIB.
  */
=20
-#include "config.h"
 #include "fuse_i.h"
-#include "fuse_kernel.h"
 #include "fuse_lowlevel.h"
 #include "fuse_misc.h"
+#include "standard-headers/linux/fuse.h"
=20
 #include <assert.h>
 #include <errno.h>
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 0d7b2c3dc9..497eb25487 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -9,14 +9,10 @@
  * See the file COPYING.LIB
  */
=20
-#define _GNU_SOURCE
-
-#include "config.h"
 #include "fuse_i.h"
-#include "fuse_kernel.h"
+#include "standard-headers/linux/fuse.h"
 #include "fuse_misc.h"
 #include "fuse_opt.h"
-#include "mount_util.h"
=20
 #include <assert.h>
 #include <errno.h>
@@ -2093,7 +2089,6 @@ static struct {
     [FUSE_RENAME2] =3D { do_rename2, "RENAME2" },
     [FUSE_COPY_FILE_RANGE] =3D { do_copy_file_range, "COPY_FILE_RANGE" },
     [FUSE_LSEEK] =3D { do_lseek, "LSEEK" },
-    [CUSE_INIT] =3D { cuse_lowlevel_init, "CUSE_INIT" },
 };
=20
 #define FUSE_MAXOP (sizeof(fuse_ll_ops) / sizeof(fuse_ll_ops[0]))
@@ -2220,7 +2215,6 @@ void fuse_lowlevel_version(void)
 {
     printf("using FUSE kernel interface version %i.%i\n", FUSE_KERNEL_VERS=
ION,
            FUSE_KERNEL_MINOR_VERSION);
-    fuse_mount_version();
 }
=20
 void fuse_lowlevel_help(void)
@@ -2310,10 +2304,6 @@ struct fuse_session *fuse_session_new(struct fuse_ar=
gs *args,
         goto out4;
     }
=20
-    if (se->debug) {
-        fuse_log(FUSE_LOG_DEBUG, "FUSE library version: %s\n", PACKAGE_VER=
SION);
-    }
-
     se->bufsize =3D FUSE_MAX_MAX_PAGES * getpagesize() + FUSE_BUFFER_HEADE=
R_SIZE;
=20
     list_init_req(&se->list);
diff --git a/tools/virtiofsd/fuse_opt.c b/tools/virtiofsd/fuse_opt.c
index edd36f4a3b..1fee55e266 100644
--- a/tools/virtiofsd/fuse_opt.c
+++ b/tools/virtiofsd/fuse_opt.c
@@ -10,7 +10,6 @@
  */
=20
 #include "fuse_opt.h"
-#include "config.h"
 #include "fuse_i.h"
 #include "fuse_misc.h"
=20
diff --git a/tools/virtiofsd/fuse_signals.c b/tools/virtiofsd/fuse_signals.=
c
index 19d6791cb9..10a6f88088 100644
--- a/tools/virtiofsd/fuse_signals.c
+++ b/tools/virtiofsd/fuse_signals.c
@@ -8,7 +8,6 @@
  * See the file COPYING.LIB
  */
=20
-#include "config.h"
 #include "fuse_i.h"
 #include "fuse_lowlevel.h"
=20
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index a79ec2c70d..0e543353a4 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -35,15 +35,10 @@
  * \include passthrough_ll.c
  */
=20
-#define _GNU_SOURCE
-#define FUSE_USE_VERSION 31
-
-#include "config.h"
-
+#include "fuse_lowlevel.h"
 #include <assert.h>
 #include <dirent.h>
 #include <errno.h>
-#include <fuse_lowlevel.h>
 #include <inttypes.h>
 #include <limits.h>
 #include <pthread.h>
@@ -58,6 +53,7 @@
=20
 #include "passthrough_helpers.h"
=20
+#define HAVE_POSIX_FALLOCATE 1
 /*
  * We are re-using pointers to our `struct lo_inode` and `struct
  * lo_dirp` elements as inodes. This means that we must be able to
@@ -1303,7 +1299,6 @@ int main(int argc, char *argv[])
         ret =3D 0;
         goto err_out1;
     } else if (opts.show_version) {
-        printf("FUSE library version %s\n", fuse_pkgversion());
         fuse_lowlevel_version();
         ret =3D 0;
         goto err_out1;
--=20
2.23.0


