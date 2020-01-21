Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402EDC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C52A206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMWeUwbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C52A206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittWt-00025a-Kp
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itshr-0003St-BF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itshn-0004uh-Es
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21332
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itshn-0004uV-Ax
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t1mhUJkaeuz9jE9w2fi1h9pAeOU7ZWMxwzi69tqNU9o=;
 b=SMWeUwbz5ElkGnmY/ViHjqIFReUcykCc7F/lOoHQzycwjMG8rhNQcXEc6KhWT7MW5W1EsV
 /ho5UnE/wryj3E5HAoGFgvmHVzl04O7FVitxffHSQKx2XjhaJ6hZbxBdgjEnzB04Nr9CNX
 1AOus5nyi6Lsyf8EWOYi2XdJ7nSenN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-Anue0ZOHP9-yVunXY7KmVA-1; Tue, 21 Jan 2020 07:32:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90CE1800D41;
 Tue, 21 Jan 2020 12:32:24 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2D9360BE0;
 Tue, 21 Jan 2020 12:32:22 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 097/109] virtiofsd: convert more fprintf and perror to use
 fuse log infra
Date: Tue, 21 Jan 2020 12:24:21 +0000
Message-Id: <20200121122433.50803-98-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Anue0ZOHP9-yVunXY7KmVA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eryu Guan <eguan@linux.alibaba.com>

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 tools/virtiofsd/fuse_signals.c | 7 +++++--
 tools/virtiofsd/helper.c       | 9 ++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/virtiofsd/fuse_signals.c b/tools/virtiofsd/fuse_signals.=
c
index 10a6f88088..5364cbe984 100644
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
@@ -46,13 +47,15 @@ static int set_one_signal_handler(int sig, void (*handl=
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
index 781c47031c..a19959926c 100644
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


