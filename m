Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D701C33CB6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F0724673
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ65xVJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F0724673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itssH-0006PA-2O
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 07:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsbq-0006UF-Lr
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsbp-00025w-D9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:26:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45691
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsbp-00025j-8p
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4wB/TUr2SmdZJ+PPoU2IvIVgstwKAtZw/jvk+zHuYk=;
 b=LQ65xVJzcv3+I/g7Has/X3s5FGNzhHf+llMtRtyY0Z6dtp20g3YAV1vqTTuYWVFHr7KiKp
 sQ/zKcC2eVHbc6D7FlvbA6jAASIOilhVqAH8Mgv1aVunPWK7HqXzRQ8BgwfHtUvtmG4C0z
 7YHdEVfw8Va5j7j/xKntRSnuxXQrwvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-AUAD1VQJN46e7P-OoPeAMQ-1; Tue, 21 Jan 2020 07:26:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87662A0CBF;
 Tue, 21 Jan 2020 12:26:14 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D275860BE0;
 Tue, 21 Jan 2020 12:26:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 022/109] virtiofsd: Poll kick_fd for queue
Date: Tue, 21 Jan 2020 12:23:06 +0000
Message-Id: <20200121122433.50803-23-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: AUAD1VQJN46e7P-OoPeAMQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

In the queue thread poll the kick_fd we're passed.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 40 ++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 2a94bb3cca..05e7258712 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -24,6 +24,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/eventfd.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/un.h>
@@ -100,13 +101,50 @@ static void fv_panic(VuDev *dev, const char *err)
     exit(EXIT_FAILURE);
 }
=20
+/* Thread function for individual queues, created when a queue is 'started=
' */
 static void *fv_queue_thread(void *opaque)
 {
     struct fv_QueueInfo *qi =3D opaque;
     fuse_log(FUSE_LOG_INFO, "%s: Start for queue %d kick_fd %d\n", __func_=
_,
              qi->qidx, qi->kick_fd);
     while (1) {
-        /* TODO */
+        struct pollfd pf[1];
+        pf[0].fd =3D qi->kick_fd;
+        pf[0].events =3D POLLIN;
+        pf[0].revents =3D 0;
+
+        fuse_log(FUSE_LOG_DEBUG, "%s: Waiting for Queue %d event\n", __fun=
c__,
+                 qi->qidx);
+        int poll_res =3D ppoll(pf, 1, NULL, NULL);
+
+        if (poll_res =3D=3D -1) {
+            if (errno =3D=3D EINTR) {
+                fuse_log(FUSE_LOG_INFO, "%s: ppoll interrupted, going arou=
nd\n",
+                         __func__);
+                continue;
+            }
+            fuse_log(FUSE_LOG_ERR, "fv_queue_thread ppoll: %m\n");
+            break;
+        }
+        assert(poll_res =3D=3D 1);
+        if (pf[0].revents & (POLLERR | POLLHUP | POLLNVAL)) {
+            fuse_log(FUSE_LOG_ERR, "%s: Unexpected poll revents %x Queue %=
d\n",
+                     __func__, pf[0].revents, qi->qidx);
+            break;
+        }
+        assert(pf[0].revents & POLLIN);
+        fuse_log(FUSE_LOG_DEBUG, "%s: Got queue event on Queue %d\n", __fu=
nc__,
+                 qi->qidx);
+
+        eventfd_t evalue;
+        if (eventfd_read(qi->kick_fd, &evalue)) {
+            fuse_log(FUSE_LOG_ERR, "Eventfd_read for queue: %m\n");
+            break;
+        }
+        if (qi->virtio_dev->se->debug) {
+            fprintf(stderr, "%s: Queue %d gave evalue: %zx\n", __func__,
+                    qi->qidx, (size_t)evalue);
+        }
     }
=20
     return NULL;
--=20
2.24.1


