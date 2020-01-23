Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A156AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6892077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnEfY2DL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6892077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudRV-0003BT-9i
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iubAf-0004EE-QI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iubAd-0006Z2-O0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60561
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iubAb-0006Wq-Uu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2MWWHSa3gJDszL7gAVY1SstmCYyEN2FqLUtV3/R3cc=;
 b=LnEfY2DLkyvcgPEpauLaUso5rDEwYGTlNAXYFfPL3OWUxPglg0XdDfFHyxGtUVvpTrNM6Q
 JXqOmX1/H/5WRxc8KgGJT9WvPH4lLyiDtMurYz3PRNMiTikh9KO90pmSCxMsBNEqLQDfMm
 a0wBblqJ86cp7nmvz5WX6Cyf2HZVQzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-x7_OP1YbOiSokjvwNwDXvA-1; Thu, 23 Jan 2020 07:01:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98A9B1005510
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:01:06 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D473A85754;
 Thu, 23 Jan 2020 12:01:05 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 098/111] virtiofsd: convert more fprintf and perror to use fuse
 log infra
Date: Thu, 23 Jan 2020 11:58:28 +0000
Message-Id: <20200123115841.138849-99-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: x7_OP1YbOiSokjvwNwDXvA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: Eryu Guan <eguan@linux.alibaba.com>

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_signals.c | 7 +++++--
 tools/virtiofsd/helper.c       | 9 ++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/virtiofsd/fuse_signals.c b/tools/virtiofsd/fuse_signals.=
c
index dc7c8ac025..f18625b6e2 100644
--- a/tools/virtiofsd/fuse_signals.c
+++ b/tools/virtiofsd/fuse_signals.c
@@ -12,6 +12,7 @@
 #include "fuse_i.h"
 #include "fuse_lowlevel.h"
=20
+#include <errno.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -47,13 +48,15 @@ static int set_one_signal_handler(int sig, void (*handl=
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
-        perror("fuse: cannot set signal handler");
+        fuse_log(FUSE_LOG_ERR, "fuse: cannot set signal handler: %s\n",
+                 strerror(errno));
         return -1;
     }
     return 0;
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 33749bfcb7..f98d8f2eb2 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -208,7 +208,8 @@ int fuse_daemonize(int foreground)
         char completed;
=20
         if (pipe(waiter)) {
-            perror("fuse_daemonize: pipe");
+            fuse_log(FUSE_LOG_ERR, "fuse_daemonize: pipe: %s\n",
+                     strerror(errno));
             return -1;
         }
=20
@@ -218,7 +219,8 @@ int fuse_daemonize(int foreground)
          */
         switch (fork()) {
         case -1:
-            perror("fuse_daemonize: fork");
+            fuse_log(FUSE_LOG_ERR, "fuse_daemonize: fork: %s\n",
+                     strerror(errno));
             return -1;
         case 0:
             break;
@@ -228,7 +230,8 @@ int fuse_daemonize(int foreground)
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
2.24.1


