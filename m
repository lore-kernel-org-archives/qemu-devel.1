Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2BACA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E7720663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHeHkTA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E7720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNDng-0007JG-2f
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNDWz-0004R6-1A
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNDWw-0002VN-Lm
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:06:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42254
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNDWw-0002Ua-IL
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1ZWAZET2aCYr6F3lk3hGVyaMah3+lLXcCNuqtgSeG0=;
 b=dHeHkTA/cP0kqaLelhGd6GnyLhnSiQfQvMuYwPfVLD3nc7+jYDExTeZk9Mtz+PpSRD/FJk
 vtXfn2/uIYyXuB1MKJgkeHXSdh6ZZGydqJ0+USUejERh4TQoOeiuJ+0Mw6wbnL9W0la1ki
 3P5c3DFCmYn6JxUackBBEShHB3XgmXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-RBN4SAoMMrKpRGUTfQPEcA-1; Wed, 23 Oct 2019 06:06:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA66647B;
 Wed, 23 Oct 2019 10:06:09 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 492556061E;
 Wed, 23 Oct 2019 10:05:58 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/16] libqos: enforce Device Initialization order
Date: Wed, 23 Oct 2019 11:04:16 +0100
Message-Id: <20191023100425.12168-8-stefanha@redhat.com>
In-Reply-To: <20191023100425.12168-1-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: RBN4SAoMMrKpRGUTfQPEcA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to VIRTIO 1.1 "3.1.1 Driver Requirements: Device
Initialization", configuration space and virtqueues cannot be accessed
before features have been negotiated.  Enforce this requirement.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v4:
 * Introduce bool d->features_negotiated so that tests can negotiate a
   0 feature bit set in Legacy mode [Thomas]
---
 tests/libqos/virtio.h | 1 +
 tests/libqos/virtio.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index a5c99fb3c9..0e8f823c7b 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -23,6 +23,7 @@ typedef struct QVirtioDevice {
     uint16_t device_type;
     uint64_t features;
     bool big_endian;
+    bool features_negotiated;
 } QVirtioDevice;
=20
 typedef struct QVirtQueue {
diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 4f7e6bb8a1..6049ff3b3e 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -15,21 +15,25 @@
=20
 uint8_t qvirtio_config_readb(QVirtioDevice *d, uint64_t addr)
 {
+    g_assert_true(d->features_negotiated);
     return d->bus->config_readb(d, addr);
 }
=20
 uint16_t qvirtio_config_readw(QVirtioDevice *d, uint64_t addr)
 {
+    g_assert_true(d->features_negotiated);
     return d->bus->config_readw(d, addr);
 }
=20
 uint32_t qvirtio_config_readl(QVirtioDevice *d, uint64_t addr)
 {
+    g_assert_true(d->features_negotiated);
     return d->bus->config_readl(d, addr);
 }
=20
 uint64_t qvirtio_config_readq(QVirtioDevice *d, uint64_t addr)
 {
+    g_assert_true(d->features_negotiated);
     return d->bus->config_readq(d, addr);
 }
=20
@@ -42,11 +46,13 @@ void qvirtio_set_features(QVirtioDevice *d, uint64_t fe=
atures)
 {
     d->features =3D features;
     d->bus->set_features(d, features);
+    d->features_negotiated =3D true;
 }
=20
 QVirtQueue *qvirtqueue_setup(QVirtioDevice *d,
                              QGuestAllocator *alloc, uint16_t index)
 {
+    g_assert_true(d->features_negotiated);
     return d->bus->virtqueue_setup(d, alloc, index);
 }
=20
@@ -60,6 +66,7 @@ void qvirtio_reset(QVirtioDevice *d)
 {
     d->bus->set_status(d, 0);
     g_assert_cmphex(d->bus->get_status(d), =3D=3D, 0);
+    d->features_negotiated =3D false;
 }
=20
 void qvirtio_set_acknowledge(QVirtioDevice *d)
--=20
2.21.0


