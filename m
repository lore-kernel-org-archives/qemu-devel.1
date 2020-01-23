Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03187C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC4C2467E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFsnfVH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC4C2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucPm-0002WE-9a
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iub8o-00021P-0q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iub8m-0004yY-1m
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34564
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iub8k-0004x8-NA
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hiJBxcgPCrG5RjsyvxBWF37Jrc30qJc6rsgMOmtb7Qo=;
 b=GFsnfVH0JBRl0FvQ4K+Pnz0kN1VzfNPRervRkQNIoD4LRbl7SK7x+Q3jU9SIG20i8KnS3z
 4QQvfJVow8NCORf1uRlNw14iyDVtpWPr1ofXL0iZRHZhBc5miwJC9SLa1h+F6Bl6Ik2/0+
 k87mIGzxYNKw2UnPu/hFV9MHmstqlE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-0mkbVlc-Oo63zqsGdw_H0Q-1; Thu, 23 Jan 2020 06:59:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 825AA1800D48
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFAB81CB;
 Thu, 23 Jan 2020 11:59:10 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 020/111] virtiofsd: Add main virtio loop
Date: Thu, 23 Jan 2020 11:57:10 +0000
Message-Id: <20200123115841.138849-21-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 0mkbVlc-Oo63zqsGdw_H0Q-1
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Processes incoming requests on the vhost-user fd.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 42 ++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 2ae3c764dd..1928a2025c 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -11,12 +11,14 @@
  * See the file COPYING.LIB
  */
=20
+#include "fuse_virtio.h"
 #include "fuse_i.h"
 #include "standard-headers/linux/fuse.h"
 #include "fuse_misc.h"
 #include "fuse_opt.h"
-#include "fuse_virtio.h"
=20
+#include <assert.h>
+#include <errno.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -80,15 +82,49 @@ static const VuDevIface fv_iface =3D {
     .queue_is_processed_in_order =3D fv_queue_order,
 };
=20
+/*
+ * Main loop; this mostly deals with events on the vhost-user
+ * socket itself, and not actual fuse data.
+ */
 int virtio_loop(struct fuse_session *se)
 {
     fuse_log(FUSE_LOG_INFO, "%s: Entry\n", __func__);
=20
-    while (1) {
-        /* TODO: Add stuffing */
+    while (!fuse_session_exited(se)) {
+        struct pollfd pf[1];
+        pf[0].fd =3D se->vu_socketfd;
+        pf[0].events =3D POLLIN;
+        pf[0].revents =3D 0;
+
+        fuse_log(FUSE_LOG_DEBUG, "%s: Waiting for VU event\n", __func__);
+        int poll_res =3D ppoll(pf, 1, NULL, NULL);
+
+        if (poll_res =3D=3D -1) {
+            if (errno =3D=3D EINTR) {
+                fuse_log(FUSE_LOG_INFO, "%s: ppoll interrupted, going arou=
nd\n",
+                         __func__);
+                continue;
+            }
+            fuse_log(FUSE_LOG_ERR, "virtio_loop ppoll: %m\n");
+            break;
+        }
+        assert(poll_res =3D=3D 1);
+        if (pf[0].revents & (POLLERR | POLLHUP | POLLNVAL)) {
+            fuse_log(FUSE_LOG_ERR, "%s: Unexpected poll revents %x\n", __f=
unc__,
+                     pf[0].revents);
+            break;
+        }
+        assert(pf[0].revents & POLLIN);
+        fuse_log(FUSE_LOG_DEBUG, "%s: Got VU event\n", __func__);
+        if (!vu_dispatch(&se->virtio_dev->dev)) {
+            fuse_log(FUSE_LOG_ERR, "%s: vu_dispatch failed\n", __func__);
+            break;
+        }
     }
=20
     fuse_log(FUSE_LOG_INFO, "%s: Exit\n", __func__);
+
+    return 0;
 }
=20
 int virtio_session_mount(struct fuse_session *se)
--=20
2.24.1


