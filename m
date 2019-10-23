Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B857FCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E88B205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgA3jtf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E88B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNDi1-0003Fq-0r
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNDWv-0004OL-S2
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNDWt-0002SA-E9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:06:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31439
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNDWk-0002My-N3
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kNGzs6XBfUuX9h6V7eDmm96BCP+yvOpdjBrhtPUVLls=;
 b=bgA3jtf//4Q8BkmlAIHnGhZ4Nk2AhmzImJxtAHZWo4wIIHU+vtbuSNGLokaugWLsvuttMl
 siTGROZQ+NUP1JTFodHoW6QKZqbKSpM6JArdA0bIKlqS1gPk1BUwruE8FacsIxZWXrzBo6
 7GfPeADi6ETacQ/9XmzJGXH0k+xtHpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-FVzT1ULeMkKffdmnER5QhA-1; Wed, 23 Oct 2019 06:05:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBE37107AD33;
 Wed, 23 Oct 2019 10:05:56 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 108C35C1B2;
 Wed, 23 Oct 2019 10:05:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/16] libqos: add missing virtio-9p feature negotiation
Date: Wed, 23 Oct 2019 11:04:15 +0100
Message-Id: <20191023100425.12168-7-stefanha@redhat.com>
In-Reply-To: <20191023100425.12168-1-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FVzT1ULeMkKffdmnER5QhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VIRTIO Device Initialization requires feature negotiation.  The libqos
virtio-9p driver lacks feature negotiation and is therefore
non-compliant.

libqos tests acknowledge all feature bits advertised by the device,
except VIRTIO_F_BAD_FEATURE (which devices use to detect broken
drivers!) and VIRTIO_RING_F_EVENT_IDX (which is not implemented in
libqos and accepting it would break notifications).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/virtio-9p.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/libqos/virtio-9p.c b/tests/libqos/virtio-9p.c
index 8c9efce3e1..77dbfb62ad 100644
--- a/tests/libqos/virtio-9p.c
+++ b/tests/libqos/virtio-9p.c
@@ -32,6 +32,12 @@ static void virtio_9p_cleanup(QVirtio9P *interface)
=20
 static void virtio_9p_setup(QVirtio9P *interface)
 {
+    uint64_t features;
+
+    features =3D qvirtio_get_features(interface->vdev);
+    features &=3D ~(QVIRTIO_F_BAD_FEATURE | (1ull << VIRTIO_RING_F_EVENT_I=
DX));
+    qvirtio_set_features(interface->vdev, features);
+
     interface->vq =3D qvirtqueue_setup(interface->vdev, alloc, 0);
     qvirtio_set_driver_ok(interface->vdev);
 }
--=20
2.21.0


