Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED098C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5E922527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uq12DsXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5E922527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSbA-0004Sv-73
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWk-0007LZ-1v
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWg-0004At-9f
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49410
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWf-00047e-LO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hAU92VTf7ShHzQ4lGd1JcSMjkYw3sUy645fnFvXoh4=;
 b=Uq12DsXHG4hPzWmY4BV6BHO27Tnkjw4jPrQLwNsGcP7g/H9V1auB1RgxaERqa75vaQgqrZ
 Kv/ewdWYVObpmoeqd4WEqh7WGdPkokrIxA3ahudKnbz/fCP3Mu6yC3LUPxJ80o43kYQ4iv
 6YllDP7wVRIuJGcGbAGh5h6F4eDoX9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376--F8OmmnKOaCEoUCrI2qxjQ-1; Thu, 12 Dec 2019 11:41:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A948D189CD29
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:13 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2380160BF3;
 Thu, 12 Dec 2019 16:41:11 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 078/104] virtiofsd: cleanup allocated resource in se
Date: Thu, 12 Dec 2019 16:38:38 +0000
Message-Id: <20191212163904.159893-79-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: -F8OmmnKOaCEoUCrI2qxjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Bo <bo.liu@linux.alibaba.com>

This cleans up unfreed resources in se on quiting, including
se->virtio_dev, se->vu_socket_path, se->vu_socketfd.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 tools/virtiofsd/fuse_lowlevel.c | 7 +++++++
 tools/virtiofsd/fuse_virtio.c   | 7 +++++++
 tools/virtiofsd/fuse_virtio.h   | 2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 45125ef66a..14c9d99374 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2539,6 +2539,13 @@ void fuse_session_destroy(struct fuse_session *se)
     if (se->fd !=3D -1) {
         close(se->fd);
     }
+
+    if (se->vu_socket_path) {
+        virtio_session_close(se);
+        free(se->vu_socket_path);
+        se->vu_socket_path =3D NULL;
+    }
+
     free(se);
 }
=20
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 2f11fee46d..1b5d27fe16 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -827,3 +827,10 @@ int virtio_session_mount(struct fuse_session *se)
=20
     return 0;
 }
+
+void virtio_session_close(struct fuse_session *se)
+{
+    close(se->vu_socketfd);
+    free(se->virtio_dev);
+    se->virtio_dev =3D NULL;
+}
diff --git a/tools/virtiofsd/fuse_virtio.h b/tools/virtiofsd/fuse_virtio.h
index cc676b9193..111684032c 100644
--- a/tools/virtiofsd/fuse_virtio.h
+++ b/tools/virtiofsd/fuse_virtio.h
@@ -19,7 +19,7 @@
 struct fuse_session;
=20
 int virtio_session_mount(struct fuse_session *se);
-
+void virtio_session_close(struct fuse_session *se);
 int virtio_loop(struct fuse_session *se);
=20
=20
--=20
2.23.0


