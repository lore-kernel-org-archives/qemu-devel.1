Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744F1C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446C6214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0iTTSEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446C6214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRrp-0005fi-Bn
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVB-0005FR-47
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVA-0001Ok-1Y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40738
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRV9-0001O9-Ty
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qWo4yWSWitxRAtEY7VHnJd2BA7TsRRdjI3yj2bC4V0w=;
 b=S0iTTSEuqbS3bPykGnoJgvM6uMEZb1/Z7MxSPFbO2Q/2xfBF6qNfJpUzOT5gLdJ0rTGalb
 8eZ4dRRU+0wSdNoF14nrsVO1KzsKnNK5XTbNEsYmDYExEyQhByVyBURWo8Dbpm7Ey6gB8K
 p5nzRXIdwzgy+yL5+YLHTi3BuWYJrZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-S76t2mDTMlCgYjt-EBU6Xw-1; Thu, 12 Dec 2019 11:39:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48F93801E66
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:41 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70F3860BE1;
 Thu, 12 Dec 2019 16:39:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 019/104] virtiofsd: get/set features callbacks
Date: Thu, 12 Dec 2019 16:37:39 +0000
Message-Id: <20191212163904.159893-20-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: S76t2mDTMlCgYjt-EBU6Xw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
---
 tools/virtiofsd/fuse_virtio.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 2b64d551e8..1bbbf570ac 100644
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
2.23.0


