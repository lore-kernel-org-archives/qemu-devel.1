Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92766C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675BC2253D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPYfclk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675BC2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSs7-0005kG-0b
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX1-0007nL-KZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRX0-0004pc-Ek
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58129
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRX0-0004oC-AM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfSe41TLUp+GhrlKGSyL7HvQZ5ppxCVRsLJMopRQC34=;
 b=LPYfclk88Bfk0nVf3ojsjPFRJ3M8fjEMA0eW1KsIGMRop4sZZ1uBj52yhqCQhwIKy35Qhp
 M0jqBFZSp1LSrvsPNBnJSpZjmxxfA9aDp6k6hcmqijbNO+0CjFaMp9YhPiuQLUCsX7tIEh
 vGFLa5dSzuabqvwt5RccW8hxsLI2XfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-qMAXncyqNyeU3NCPdaJ7vA-1; Thu, 12 Dec 2019 11:41:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D22BC1572974
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:35 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F33FB60BE1;
 Thu, 12 Dec 2019 16:41:34 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 095/104] virtiofsd: convert more fprintf and perror to use
 fuse log infra
Date: Thu, 12 Dec 2019 16:38:55 +0000
Message-Id: <20191212163904.159893-96-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qMAXncyqNyeU3NCPdaJ7vA-1
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

From: Eryu Guan <eguan@linux.alibaba.com>

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
 tools/virtiofsd/fuse_signals.c | 6 +++++-
 tools/virtiofsd/helper.c       | 9 ++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/virtiofsd/fuse_signals.c b/tools/virtiofsd/fuse_signals.=
c
index 10a6f88088..edabf24e0d 100644
--- a/tools/virtiofsd/fuse_signals.c
+++ b/tools/virtiofsd/fuse_signals.c
@@ -11,6 +11,7 @@
 #include "fuse_i.h"
 #include "fuse_lowlevel.h"
=20
+#include <errno.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -46,12 +47,15 @@ static int set_one_signal_handler(int sig, void (*handl=
er)(int), int remove)
     sa.sa_flags =3D 0;
=20
     if (sigaction(sig, NULL, &old_sa) =3D=3D -1) {
-        perror("fuse: cannot get old signal handler");
+        fuse_log(FUSE_LOG_ERR, "fuse: cannot get old signal handler: %s\n"=
,
+                 strerror(errno));
         return -1;
     }
=20
     if (old_sa.sa_handler =3D=3D (remove ? handler : SIG_DFL) &&
         sigaction(sig, &sa, NULL) =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "fuse: cannot set signal handler: %s\n",
+                 strerror(errno));
         perror("fuse: cannot set signal handler");
         return -1;
     }
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 7b28507a38..bcb8c05063 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -200,7 +200,8 @@ int fuse_daemonize(int foreground)
         char completed;
=20
         if (pipe(waiter)) {
-            perror("fuse_daemonize: pipe");
+            fuse_log(FUSE_LOG_ERR, "fuse_daemonize: pipe: %s\n",
+                     strerror(errno));
             return -1;
         }
=20
@@ -210,7 +211,8 @@ int fuse_daemonize(int foreground)
          */
         switch (fork()) {
         case -1:
-            perror("fuse_daemonize: fork");
+            fuse_log(FUSE_LOG_ERR, "fuse_daemonize: fork: %s\n",
+                     strerror(errno));
             return -1;
         case 0:
             break;
@@ -220,7 +222,8 @@ int fuse_daemonize(int foreground)
         }
=20
         if (setsid() =3D=3D -1) {
-            perror("fuse_daemonize: setsid");
+            fuse_log(FUSE_LOG_ERR, "fuse_daemonize: setsid: %s\n",
+                     strerror(errno));
             return -1;
         }
=20
--=20
2.23.0


