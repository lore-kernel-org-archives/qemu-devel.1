Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7B6CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E6620659
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgP8BNWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E6620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNDts-0003K5-2k
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNDXC-0004mL-VN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNDX8-0002dt-26
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:06:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24543
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNDX7-0002dQ-U4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eT/N/Nw1XOIrzstfsg+SR6TEiO5KTJAzYYzr1nmBXvs=;
 b=YgP8BNWHrodA+RXgWaSiS2FWSokSJBQ5IoUIm44Fqw8x6ojzPw6IPAwn6T/0qZFEI8cBba
 we3FHZpbjdNcRuitUFJQE9Rb0xtDZFd33lIPHr5Jxpo0gI/cbfJ5ddZZZzHS/bIzcd4ZCt
 M5QGpIVi+SJS8uJcUmGpZeZyT+zdhqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-73r6N6bOOjGOEuVfACYZ_A-1; Wed, 23 Oct 2019 06:06:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 298C01005509;
 Wed, 23 Oct 2019 10:06:21 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17ED91001E75;
 Wed, 23 Oct 2019 10:06:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/16] libqos: implement VIRTIO 1.0 FEATURES_OK step
Date: Wed, 23 Oct 2019 11:04:17 +0100
Message-Id: <20191023100425.12168-9-stefanha@redhat.com>
In-Reply-To: <20191023100425.12168-1-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 73r6N6bOOjGOEuVfACYZ_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Device initialization has an extra step in VIRTIO 1.0.  The FEATURES_OK
status bit is set to indicate that feature negotiation has completed.
The driver then reads the status register again to check that the device
agrees with the final features.

Implement this step as part of qvirtio_set_features() instead of
introducing a separate function.  This way all existing code works
without modifications.

The check in qvirtio_set_driver_ok() needs to be updated because
FEATURES_OK will be set for VIRTIO 1.0 devices.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v4:
 * Make FEATURES_OK change in qvirtio_set_driver_ok() clearer and
   mention it in the commit description [Thomas]
---
 tests/libqos/virtio.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 6049ff3b3e..fa597c2481 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -46,6 +46,20 @@ void qvirtio_set_features(QVirtioDevice *d, uint64_t fea=
tures)
 {
     d->features =3D features;
     d->bus->set_features(d, features);
+
+    /*
+     * This could be a separate function for drivers that want to access
+     * configuration space before setting FEATURES_OK, but no existing use=
rs
+     * need that and it's less code for callers if this is done implicitly=
.
+    */
+    if (features & (1ull << VIRTIO_F_VERSION_1)) {
+        uint8_t status =3D d->bus->get_status(d) |
+                         VIRTIO_CONFIG_S_FEATURES_OK;
+
+        d->bus->set_status(d, status);
+        g_assert_cmphex(d->bus->get_status(d), =3D=3D, status);
+    }
+
     d->features_negotiated =3D true;
 }
=20
@@ -86,7 +100,9 @@ void qvirtio_set_driver_ok(QVirtioDevice *d)
 {
     d->bus->set_status(d, d->bus->get_status(d) | VIRTIO_CONFIG_S_DRIVER_O=
K);
     g_assert_cmphex(d->bus->get_status(d), =3D=3D, VIRTIO_CONFIG_S_DRIVER_=
OK |
-                    VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_ACKNOWLEDGE);
+                    VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_ACKNOWLEDGE |
+                    (d->features & (1ull << VIRTIO_F_VERSION_1) ?
+                     VIRTIO_CONFIG_S_FEATURES_OK : 0));
 }
=20
 void qvirtio_wait_queue_isr(QTestState *qts, QVirtioDevice *d,
--=20
2.21.0


