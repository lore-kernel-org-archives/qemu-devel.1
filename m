Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AC8CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B4E20854
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B4E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLiVZ-0002Pb-Ib
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 02:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iLiOS-0003Jv-Pg
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iLiOR-0003qP-Nl
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:39:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iLiOP-0003mb-ER; Sat, 19 Oct 2019 02:39:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AADD158;
 Sat, 19 Oct 2019 06:39:11 +0000 (UTC)
Received: from localhost (ovpn-116-50.ams2.redhat.com [10.36.116.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9EE519C7F;
 Sat, 19 Oct 2019 06:39:01 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/16] libqos: enforce Device Initialization order
Date: Sat, 19 Oct 2019 07:38:01 +0100
Message-Id: <20191019063810.6944-8-stefanha@redhat.com>
In-Reply-To: <20191019063810.6944-1-stefanha@redhat.com>
References: <20191019063810.6944-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Sat, 19 Oct 2019 06:39:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to VIRTIO 1.1 "3.1.1 Driver Requirements: Device
Initialization", configuration space and virtqueues cannot be accessed
before features have been negotiated.  Enforce this requirement.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/virtio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 4f7e6bb8a1..2593996c98 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -13,23 +13,33 @@
 #include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_ring.h"
=20
+/* Features must be negotiated before config space or virtqueue access *=
/
+static void check_features_negotiated(QVirtioDevice *d)
+{
+    g_assert_cmphex(d->features, !=3D, 0);
+}
+
 uint8_t qvirtio_config_readb(QVirtioDevice *d, uint64_t addr)
 {
+    check_features_negotiated(d);
     return d->bus->config_readb(d, addr);
 }
=20
 uint16_t qvirtio_config_readw(QVirtioDevice *d, uint64_t addr)
 {
+    check_features_negotiated(d);
     return d->bus->config_readw(d, addr);
 }
=20
 uint32_t qvirtio_config_readl(QVirtioDevice *d, uint64_t addr)
 {
+    check_features_negotiated(d);
     return d->bus->config_readl(d, addr);
 }
=20
 uint64_t qvirtio_config_readq(QVirtioDevice *d, uint64_t addr)
 {
+    check_features_negotiated(d);
     return d->bus->config_readq(d, addr);
 }
=20
@@ -47,6 +57,7 @@ void qvirtio_set_features(QVirtioDevice *d, uint64_t fe=
atures)
 QVirtQueue *qvirtqueue_setup(QVirtioDevice *d,
                              QGuestAllocator *alloc, uint16_t index)
 {
+    check_features_negotiated(d);
     return d->bus->virtqueue_setup(d, alloc, index);
 }
=20
--=20
2.21.0


