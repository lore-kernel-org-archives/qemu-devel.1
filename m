Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D1BCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00762084B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q160q0ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00762084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNDbn-0006dB-SV
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNDWc-0004Hv-F8
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNDWb-0002E0-8D
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:05:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24810
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNDWb-00022M-3T
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5KzSIxiecHCvl5ctY9GrjtfvWnST80K49H0MHB8Pcs=;
 b=Q160q0ihQ7Ab52I+7MyokAT0LAEkS1kFb5ThdCK5nannGmREKxPRoFEdarjl2bI8o3QwiB
 fiK8ZlYpanoHp17bhZzaklCCaSNFB/DXmHAEqJqGNqdNaU6Igqg981gZMSGaEwaOR+8A64
 wwpZqELSJkDEcndoArMzQVm8A5XUVlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-UiNrvFj8Mqqbd-RCEuDClg-1; Wed, 23 Oct 2019 06:05:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 931241800D6B;
 Wed, 23 Oct 2019 10:05:31 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF2E85DC1E;
 Wed, 23 Oct 2019 10:05:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/16] virtio-scsi-test: add missing feature negotiation
Date: Wed, 23 Oct 2019 11:04:13 +0100
Message-Id: <20191023100425.12168-5-stefanha@redhat.com>
In-Reply-To: <20191023100425.12168-1-stefanha@redhat.com>
References: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: UiNrvFj8Mqqbd-RCEuDClg-1
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

VIRTIO Device Initialization requires feature negotiation.  Currently
virtio-scsi-test.c is non-compliant.

libqos tests acknowledge all feature bits advertised by the device,
except VIRTIO_F_BAD_FEATURE (which devices use to detect broken
drivers!) and VIRTIO_RING_F_EVENT_IDX (which is not implemented in
libqos and accepting it would break notifications).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/virtio-scsi-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index 7c8f9b27f8..0415e75876 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -123,10 +123,16 @@ static QVirtioSCSIQueues *qvirtio_scsi_init(QVirtioDe=
vice *dev)
     QVirtioSCSIQueues *vs;
     const uint8_t test_unit_ready_cdb[VIRTIO_SCSI_CDB_SIZE] =3D {};
     struct virtio_scsi_cmd_resp resp;
+    uint64_t features;
     int i;
=20
     vs =3D g_new0(QVirtioSCSIQueues, 1);
     vs->dev =3D dev;
+
+    features =3D qvirtio_get_features(dev);
+    features &=3D ~(QVIRTIO_F_BAD_FEATURE | (1ull << VIRTIO_RING_F_EVENT_I=
DX));
+    qvirtio_set_features(dev, features);
+
     vs->num_queues =3D qvirtio_config_readl(dev, 0);
=20
     g_assert_cmpint(vs->num_queues, <, MAX_NUM_QUEUES);
@@ -135,6 +141,8 @@ static QVirtioSCSIQueues *qvirtio_scsi_init(QVirtioDevi=
ce *dev)
         vs->vq[i] =3D qvirtqueue_setup(dev, alloc, i);
     }
=20
+    qvirtio_set_driver_ok(dev);
+
     /* Clear the POWER ON OCCURRED unit attention */
     g_assert_cmpint(virtio_scsi_do_command(vs, test_unit_ready_cdb,
                                            NULL, 0, NULL, 0, &resp),
--=20
2.21.0


