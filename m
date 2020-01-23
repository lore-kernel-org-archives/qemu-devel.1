Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89234C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF422077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1S0O0tQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF422077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugwQ-0005GQ-Vj
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufdY-0004aU-5t
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdX-0006L0-1J
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdW-0006Ki-U7
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OItQPinroiBJ0nrS4PUsgR+xJPIxf1WyoHv3BQuuxNE=;
 b=G1S0O0tQr+JhtJhfOrL1MzbuYzgnkN70XkQKWdbmDVsrFRERcW9e1BGGpYQ4o2p6HCtkVF
 75xC4AX969ik2YRGFcAh/4spaBzqPmydZzEogVwglaUQPuVTLVs9RSjjLsPfOiuT+IPrEn
 +bVxkrbhBH8dUUnqnh/wvJELuAnA7dQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-RfYKllnfNPGLQoy3t9lQmA-1; Thu, 23 Jan 2020 11:47:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 346AF1922975
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:16 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BCE019C69;
 Thu, 23 Jan 2020 16:47:15 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 021/108] virtiofsd: get/set features callbacks
Date: Thu, 23 Jan 2020 16:45:03 +0000
Message-Id: <20200123164630.91498-22-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: RfYKllnfNPGLQoy3t9lQmA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the get/set features callbacks.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 1928a2025c..4819e56568 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -46,6 +46,17 @@ struct virtio_fs_config {
     uint32_t num_queues;
 };
=20
+/* Callback from libvhost-user */
+static uint64_t fv_get_features(VuDev *dev)
+{
+    return 1ULL << VIRTIO_F_VERSION_1;
+}
+
+/* Callback from libvhost-user */
+static void fv_set_features(VuDev *dev, uint64_t features)
+{
+}
+
 /*
  * Callback from libvhost-user if there's a new fd we're supposed to liste=
n
  * to, typically a queue kick?
@@ -78,7 +89,9 @@ static bool fv_queue_order(VuDev *dev, int qidx)
 }
=20
 static const VuDevIface fv_iface =3D {
-    /* TODO: Add other callbacks */
+    .get_features =3D fv_get_features,
+    .set_features =3D fv_set_features,
+
     .queue_is_processed_in_order =3D fv_queue_order,
 };
=20
--=20
2.24.1


