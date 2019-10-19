Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F89CCA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A0B222C2
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A0B222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLiTE-0008Uo-Sb
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 02:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iLiOG-0002xN-5d
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iLiOF-0003fl-3E
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:39:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iLiOC-0003d7-Ua; Sat, 19 Oct 2019 02:39:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3775F308A98C;
 Sat, 19 Oct 2019 06:39:00 +0000 (UTC)
Received: from localhost (ovpn-116-50.ams2.redhat.com [10.36.116.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5A3B600C8;
 Sat, 19 Oct 2019 06:38:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/16] libqos: add missing virtio-9p feature negotiation
Date: Sat, 19 Oct 2019 07:38:00 +0100
Message-Id: <20191019063810.6944-7-stefanha@redhat.com>
In-Reply-To: <20191019063810.6944-1-stefanha@redhat.com>
References: <20191019063810.6944-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Sat, 19 Oct 2019 06:39:00 +0000 (UTC)
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

VIRTIO Device Initialization requires feature negotiation.  The libqos
virtio-9p driver lacks feature negotiation and is therefore
non-compliant.

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
+    features &=3D ~(QVIRTIO_F_BAD_FEATURE | (1ull << VIRTIO_RING_F_EVENT=
_IDX));
+    qvirtio_set_features(interface->vdev, features);
+
     interface->vq =3D qvirtqueue_setup(interface->vdev, alloc, 0);
     qvirtio_set_driver_ok(interface->vdev);
 }
--=20
2.21.0


