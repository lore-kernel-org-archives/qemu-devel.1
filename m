Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA82C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BAC2205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYWE4mdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAC2205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifS4L-00041b-7i
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRW1-0006LR-KA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRW0-0002oC-CB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35912
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRW0-0002nI-7b
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTsbTmjXGySrUE5zs/n5qZKAmmP3lDqBaYyOa+YlryE=;
 b=PYWE4mdqs5TzUXaiPmP2ZuLAbE2IdOvq1aCGH/d2f2yIPUXVizIYOFOe9aEMgFVd/ldybW
 fayaC3jB+/mrRImWEWxKm1ET+Trw3bG93R97ltj3dn6QXGW7TfxDZG/pNrOk2nL40yuEI3
 bYrgYCtNPHzVH/y1/cyjeuceRdEwNNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-d4vcgBpxOKWLofUATTdNEg-1; Thu, 12 Dec 2019 11:40:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A503B64A7F
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:32 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE04160BF3;
 Thu, 12 Dec 2019 16:40:31 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 054/104] virtiofsd: set maximum RLIMIT_NOFILE limit
Date: Thu, 12 Dec 2019 16:38:14 +0000
Message-Id: <20191212163904.159893-55-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: d4vcgBpxOKWLofUATTdNEg-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

virtiofsd can exceed the default open file descriptor limit easily on
most systems.  Take advantage of the fact that it runs as root to raise
the limit.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index ab318a6f36..139bf08f4c 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -52,6 +52,7 @@
 #include <sys/file.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
+#include <sys/resource.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -2250,6 +2251,35 @@ static void setup_sandbox(struct lo_data *lo, struct=
 fuse_session *se)
     setup_seccomp();
 }
=20
+/* Raise the maximum number of open file descriptors */
+static void setup_nofile_rlimit(void)
+{
+    const rlim_t max_fds =3D 1000000;
+    struct rlimit rlim;
+
+    if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
+        fuse_log(FUSE_LOG_ERR, "getrlimit(RLIMIT_NOFILE): %m\n");
+        exit(1);
+    }
+
+    if (rlim.rlim_cur >=3D max_fds) {
+        return; /* nothing to do */
+    }
+
+    rlim.rlim_cur =3D max_fds;
+    rlim.rlim_max =3D max_fds;
+
+    if (setrlimit(RLIMIT_NOFILE, &rlim) < 0) {
+        /* Ignore SELinux denials */
+        if (errno =3D=3D EPERM) {
+            return;
+        }
+
+        fuse_log(FUSE_LOG_ERR, "setrlimit(RLIMIT_NOFILE): %m\n");
+        exit(1);
+    }
+}
+
 int main(int argc, char *argv[])
 {
     struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
@@ -2371,6 +2401,8 @@ int main(int argc, char *argv[])
=20
     fuse_daemonize(opts.foreground);
=20
+    setup_nofile_rlimit();
+
     /* Must be before sandbox since it wants /proc */
     setup_capng();
=20
--=20
2.23.0


