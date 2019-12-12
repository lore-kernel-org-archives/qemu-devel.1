Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BD6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4221B2173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9H7Jn6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4221B2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSOl-0006LM-VA
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWp-0007Qv-3Q
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWn-0004Ly-Qo
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56626
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWn-0004KG-Kz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6k1teDJ1Q7lOJlVrnMFV+zsUU1IFDongSuB3S+yHow=;
 b=e9H7Jn6XeNPxUbKABpZeTXIXS3uUTdK7Ub/Ck2Y0TSKHaM6vjwyFJixKt9g10OCi15QXOb
 bQ7iBnw/n6OsAv4BKvarMdsIQcdrgYZAbxz7eQQwSn8D7fg/XEj8tb6tlW2QCEaHcdrzZI
 8x6AVulgUMXKeGAcawAuElOJwTZGVqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-VPaR8OBqP-i3HfFwWAAKcQ-1; Thu, 12 Dec 2019 11:41:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D32C802B7C
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:17 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7433560BF3;
 Thu, 12 Dec 2019 16:41:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 081/104] virtiofsd: Prevent multiply running with same
 vhost_user_socket
Date: Thu, 12 Dec 2019 16:38:41 +0000
Message-Id: <20191212163904.159893-82-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: VPaR8OBqP-i3HfFwWAAKcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

virtiofsd can run multiply even if the vhost_user_socket is same path.

  ]# ./virtiofsd -o vhost_user_socket=3D/tmp/vhostqemu -o source=3D/tmp/sha=
re &
  [1] 244965
  virtio_session_mount: Waiting for vhost-user socket connection...
  ]# ./virtiofsd -o vhost_user_socket=3D/tmp/vhostqemu -o source=3D/tmp/sha=
re &
  [2] 244966
  virtio_session_mount: Waiting for vhost-user socket connection...
  ]#

The user will get confused about the situation and maybe the cause of the
unexpected problem. So it's better to prevent the multiple running.

Create a regular file under localstatedir directory to exclude the
vhost_user_socket. To create and lock the file, use qemu_write_pidfile()
because the API has some sanity checks and file lock.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Applied fixes from Stefan's review and moved osdep include
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/fuse_lowlevel.c |  1 +
 tools/virtiofsd/fuse_virtio.c   | 49 ++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 14c9d99374..b1ff684de9 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -17,6 +17,7 @@
=20
 #include <assert.h>
 #include <errno.h>
+#include <glib.h>
 #include <limits.h>
 #include <stdbool.h>
 #include <stddef.h>
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 1b5d27fe16..7b22ae8d4f 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -13,11 +13,12 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
-#include "fuse_virtio.h"
+#include "qapi/error.h"
 #include "fuse_i.h"
 #include "standard-headers/linux/fuse.h"
 #include "fuse_misc.h"
 #include "fuse_opt.h"
+#include "fuse_virtio.h"
=20
 #include <assert.h>
 #include <errno.h>
@@ -733,6 +734,42 @@ int virtio_loop(struct fuse_session *se)
     return 0;
 }
=20
+static void strreplace(char *s, char old, char new)
+{
+    for (; *s; ++s) {
+        if (*s =3D=3D old) {
+            *s =3D new;
+        }
+    }
+}
+
+static bool fv_socket_lock(struct fuse_session *se)
+{
+    g_autofree gchar *sk_name =3D NULL;
+    g_autofree gchar *pidfile =3D NULL;
+    g_autofree gchar *dir =3D NULL;
+    Error *local_err =3D NULL;
+
+    dir =3D qemu_get_local_state_pathname("run/virtiofsd");
+
+    if (g_mkdir_with_parents(dir, S_IRWXU) < 0) {
+        fuse_log(FUSE_LOG_ERR, "%s: Failed to create directory %s: %s",
+                 __func__, dir, strerror(errno));
+        return false;
+    }
+
+    sk_name =3D g_strdup(se->vu_socket_path);
+    strreplace(sk_name, '/', '.');
+    pidfile =3D g_strdup_printf("%s/%s.pid", dir, sk_name);
+
+    if (!qemu_write_pidfile(pidfile, &local_err)) {
+        error_report_err(local_err);
+        return false;
+    }
+
+    return true;
+}
+
 static int fv_create_listen_socket(struct fuse_session *se)
 {
     struct sockaddr_un un;
@@ -748,6 +785,16 @@ static int fv_create_listen_socket(struct fuse_session=
 *se)
         return -1;
     }
=20
+    if (!strlen(se->vu_socket_path)) {
+        fuse_log(FUSE_LOG_ERR, "Socket path is empty\n");
+        return -1;
+    }
+
+    /* Check the vu_socket_path is already used */
+    if (!fv_socket_lock(se)) {
+        return -1;
+    }
+
     /*
      * Create the Unix socket to communicate with qemu
      * based on QEMU's vhost-user-bridge
--=20
2.23.0


