Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0AEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF5622522
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ca+XBX7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF5622522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhho-0001MG-T1
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufev-00066q-VG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufeu-000068-Mv
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56973
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufeu-00005X-Jy
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2MWWHSa3gJDszL7gAVY1SstmCYyEN2FqLUtV3/R3cc=;
 b=ca+XBX7ZycyioeIP8pI1daK/4Oab03DeIMRfLDsKfxes++GyfDHP+LnTk2FpsXPuIlVpQm
 RE62Eb+7QV+DAQ6WF9poIAPCymJ1BODapAnF+7ab/QdKNBcuKyx0zHkqbSqpC67shb5LE6
 MfbgWF2m/cbsqpE0Uzlc2JwEvdTcwwg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-rhG6t9mgOyWAjcNMyLZhPA-1; Thu, 23 Jan 2020 11:48:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFE56108BBE1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:40 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3ADE219C69;
 Thu, 23 Jan 2020 16:48:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 095/108] virtiofsd: convert more fprintf and perror to use fuse
 log infra
Date: Thu, 23 Jan 2020 16:46:17 +0000
Message-Id: <20200123164630.91498-96-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: rhG6t9mgOyWAjcNMyLZhPA-1
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


