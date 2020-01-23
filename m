Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4044AC33CB8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDE62077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8GFUprp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDE62077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iud1M-0001pR-MK
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub9R-0002t8-4R
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub9P-0005Qy-W7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24738
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub9P-0005QO-Re
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jI2BIHNRFTBCHwS7byo7jj/dJYediopJO6Eq5eVljCI=;
 b=d8GFUprpg1DAZQuP9RMdzKxJkC/l6XRwmqSmU6Yf3ZZJCGBEcThZKQxRba0LxhinGudEiZ
 9a006K5QT+lWs5DsBsm+m/Kt5X/Vs/M1qpaUmsTw/FcyIMfrl9wKVGs069z4l50PBn2ul8
 hfLOH/wqI4ZGIdkxXQYotmkpB65XqUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-nqgWbCBbPeKutZw2HJPPbw-1; Thu, 23 Jan 2020 06:59:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4B5A1088381
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:52 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CCD11CB;
 Thu, 23 Jan 2020 11:59:52 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 056/111] virtiofsd: set maximum RLIMIT_NOFILE limit
Date: Thu, 23 Jan 2020 11:57:46 +0000
Message-Id: <20200123115841.138849-57-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: nqgWbCBbPeKutZw2HJPPbw-1
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

From: Stefan Hajnoczi <stefanha@redhat.com>

virtiofsd can exceed the default open file descriptor limit easily on
most systems.  Take advantage of the fact that it runs as root to raise
the limit.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index d53cb1e005..c281d817af 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -53,6 +53,7 @@
 #include <sys/file.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
+#include <sys/resource.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -2268,6 +2269,35 @@ static void setup_sandbox(struct lo_data *lo, struct=
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
@@ -2389,6 +2419,8 @@ int main(int argc, char *argv[])
=20
     fuse_daemonize(opts.foreground);
=20
+    setup_nofile_rlimit();
+
     /* Must be before sandbox since it wants /proc */
     setup_capng();
=20
--=20
2.24.1


