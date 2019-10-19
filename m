Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D89CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE788222C2
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE788222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLiPX-000484-Dy
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 02:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iLiNn-0002EX-J4
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iLiNm-0003Aw-Bn
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:38:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iLiNj-00038i-VW; Sat, 19 Oct 2019 02:38:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20DB58553A;
 Sat, 19 Oct 2019 06:38:31 +0000 (UTC)
Received: from localhost (ovpn-116-50.ams2.redhat.com [10.36.116.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9210600C8;
 Sat, 19 Oct 2019 06:38:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/16] libqos: read QVIRTIO_MMIO_VERSION register
Date: Sat, 19 Oct 2019 07:37:56 +0100
Message-Id: <20191019063810.6944-3-stefanha@redhat.com>
In-Reply-To: <20191019063810.6944-1-stefanha@redhat.com>
References: <20191019063810.6944-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Sat, 19 Oct 2019 06:38:31 +0000 (UTC)
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

There was no real virtio-mmio ABI change between Legacy and VIRTIO 1.0
except that the Version field was incremented from 1 to 2.

However, QEMU does not allow Legacy drivers to perform VIRTIO 1.0
operations like accessing 64-bit feature bits.  Since we will introduce
64-bit feature bit support we need a way to differentiate between
virtio-mmio Version 1 and 2 to avoid upsetting QEMU when we operate in
Legacy mode.

Stash away the Version field so later patches can change behavior
depending on the version.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/virtio-mmio.h | 1 +
 tests/libqos/virtio-mmio.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tests/libqos/virtio-mmio.h b/tests/libqos/virtio-mmio.h
index 17a17141c3..0e45778b07 100644
--- a/tests/libqos/virtio-mmio.h
+++ b/tests/libqos/virtio-mmio.h
@@ -40,6 +40,7 @@ typedef struct QVirtioMMIODevice {
     uint64_t addr;
     uint32_t page_size;
     uint32_t features; /* As it cannot be read later, save it */
+    uint32_t version;
 } QVirtioMMIODevice;
=20
 extern const QVirtioBus qvirtio_mmio;
diff --git a/tests/libqos/virtio-mmio.c b/tests/libqos/virtio-mmio.c
index d0047876a8..7154b03c1d 100644
--- a/tests/libqos/virtio-mmio.c
+++ b/tests/libqos/virtio-mmio.c
@@ -223,6 +223,9 @@ void qvirtio_mmio_init_device(QVirtioMMIODevice *dev,=
 QTestState *qts,
     magic =3D qtest_readl(qts, addr + QVIRTIO_MMIO_MAGIC_VALUE);
     g_assert(magic =3D=3D ('v' | 'i' << 8 | 'r' << 16 | 't' << 24));
=20
+    dev->version =3D qtest_readl(qts, addr + QVIRTIO_MMIO_VERSION);
+    g_assert(dev->version =3D=3D 1 || dev->version =3D=3D 2);
+
     dev->qts =3D qts;
     dev->addr =3D addr;
     dev->page_size =3D page_size;
--=20
2.21.0


