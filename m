Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89FECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25B220679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/fAwL4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25B220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVkf-0000ct-Bo
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQT-00044y-Q4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVQM-0004E2-Ei
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29099
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVQM-0004DS-9y
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pJitt72GamOd1XDTzZY3WEZtpM6lfsxX6lUYz+X9u4E=;
 b=f/fAwL4ZdjSeCZrEb7O98D3dAldHmPdNJ2mkLgnnYhPG0tVFC3/suA4jyVtKxnbOE10kRu
 4eBKJJ7z1DcrbBuxdv49CROo3/tkzbEjivyrX8iqKryT5swWYuEGg45+j6APCzW73piISB
 HBNyiVydWMl3NBxKKicCP4Hbce48hYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-s-IRK4VZPbCGG0T2M9QGJA-1; Mon, 21 Oct 2019 07:00:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E603476;
 Mon, 21 Oct 2019 11:00:21 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E06386060D;
 Mon, 21 Oct 2019 11:00:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 18/30] virtiofsd: get/set features callbacks
Date: Mon, 21 Oct 2019 11:58:20 +0100
Message-Id: <20191021105832.36574-19-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: s-IRK4VZPbCGG0T2M9QGJA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add the get/set features callbacks.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/fuse_virtio.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
index 9c58f11634..ee9b3af3a4 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
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
2.23.0


