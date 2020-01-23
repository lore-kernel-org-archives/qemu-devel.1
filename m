Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2456C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA50F22522
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXBDlvCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA50F22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiw2-0008V9-Tk
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 15:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iuff9-0006Ni-EP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iuff8-0000PF-5G
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52417
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iuff8-0000Oy-2d
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AsLIGnsc4Kc2PIcdInCoGUfJ3yiSTnFajKGCNhtMMv0=;
 b=CXBDlvCo2rKBLhH/E8Zz21ZDcVLhvHBTulPLMee+QuT1OSBlE8mz1dRhIYY+4jaRYXVPSt
 vmT1Vjgk+acKD18gHBVjNzXjQ08LFZX7aRKZqDeTOOqB5EMvesHWEeq8yZP9cayy2PWSXv
 Ht24gOGgVm+I4eJLxm+J8zCM3lyibrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-NjNHBdyHOWGKJj3ZUFlPzA-1; Thu, 23 Jan 2020 11:48:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B09E2F60
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:55 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67CD128993;
 Thu, 23 Jan 2020 16:48:54 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 107/108] virtiofsd: stop all queue threads on exit in
 virtio_loop()
Date: Thu, 23 Jan 2020 16:46:29 +0000
Message-Id: <20200123164630.91498-108-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NjNHBdyHOWGKJj3ZUFlPzA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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

On guest graceful shutdown, virtiofsd receives VHOST_USER_GET_VRING_BASE
request from VMM and shuts down virtqueues by calling fv_set_started(),
which joins fv_queue_thread() threads. So when virtio_loop() returns,
there should be no thread is still accessing data in fuse session and/or
virtio dev.

But on abnormal exit, e.g. guest got killed for whatever reason,
vhost-user socket is closed and virtio_loop() breaks out the main loop
and returns to main(). But it's possible fv_queue_worker()s are still
working and accessing fuse session and virtio dev, which results in
crash or use-after-free.

Fix it by stopping fv_queue_thread()s before virtio_loop() returns,
to make sure there's no-one could access fuse session and virtio dev.

Reported-by: Qingming Su <qingming.su@linux.alibaba.com>
Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 9f6582343c..80a6e929df 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -815,6 +815,19 @@ int virtio_loop(struct fuse_session *se)
         }
     }
=20
+    /*
+     * Make sure all fv_queue_thread()s quit on exit, as we're about to
+     * free virtio dev and fuse session, no one should access them anymore=
.
+     */
+    for (int i =3D 0; i < se->virtio_dev->nqueues; i++) {
+        if (!se->virtio_dev->qi[i]) {
+            continue;
+        }
+
+        fuse_log(FUSE_LOG_INFO, "%s: Stopping queue %d thread\n", __func__=
, i);
+        fv_queue_cleanup_thread(se->virtio_dev, i);
+    }
+
     fuse_log(FUSE_LOG_INFO, "%s: Exit\n", __func__);
=20
     return 0;
--=20
2.24.1


