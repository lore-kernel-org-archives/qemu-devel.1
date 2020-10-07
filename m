Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7097C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3FE21582
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3FE21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCgy-0005a2-3J
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kQCL5-0002ht-No
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:30:52 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:53408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kQCL3-0006tX-IC
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:30:51 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-woNdAhJrNJaB4jyVptT_Dw-1; Wed, 07 Oct 2020 12:30:45 -0400
X-MC-Unique: woNdAhJrNJaB4jyVptT_Dw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B77681F002;
 Wed,  7 Oct 2020 16:30:44 +0000 (UTC)
Received: from bahia.lan (ovpn-114-178.ams2.redhat.com [10.36.114.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22182756A8;
 Wed,  7 Oct 2020 16:30:34 +0000 (UTC)
Subject: [PATCH] vhost: Don't special case vq->used_phys in
 vhost_get_log_size()
From: Greg Kurz <groug@kaod.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Date: Wed, 07 Oct 2020 18:30:34 +0200
Message-ID: <160208823418.29027.15172801181796272300.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 12:30:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The first loop in vhost_get_log_size() computes the size of the dirty log
bitmap so that it allows to track changes in the entire guest memory, in
terms of GPA.

When not using a vIOMMU, the address of the vring's used structure,
vq->used_phys, is a GPA. It is thus already covered by the first loop.

When using a vIOMMU, vq->used_phys is a GIOVA that will be translated
to an HVA when the vhost backend needs to update the used structure. It
will log the corresponding GPAs into the bitmap but it certainly won't
log the GIOVA.

So in any case, vq->used_phys shouldn't be explicitly used to size the
bitmap. Drop the second loop.

This fixes a crash of the source when migrating a guest using in-kernel
vhost-net and iommu_platform=3Don on POWER, because DMA regions are put
over 0x800000000000000ULL. The resulting insanely huge log size causes
g_malloc0() to abort.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1879349
Signed-off-by: Greg Kurz <groug@kaod.org>
---

This supersedes "vhost: Ignore vrings in dirty log when using a vIOMMU"

http://patchwork.ozlabs.org/project/qemu-devel/patch/160105498386.68108.214=
5229309875282336.stgit@bahia.lan/
---
 hw/virtio/vhost.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 011951625442..c02b658b597f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -172,16 +172,6 @@ static uint64_t vhost_get_log_size(struct vhost_dev *d=
ev)
                                        reg->memory_size);
         log_size =3D MAX(log_size, last / VHOST_LOG_CHUNK + 1);
     }
-    for (i =3D 0; i < dev->nvqs; ++i) {
-        struct vhost_virtqueue *vq =3D dev->vqs + i;
-
-        if (!vq->used_phys && !vq->used_size) {
-            continue;
-        }
-
-        uint64_t last =3D vq->used_phys + vq->used_size - 1;
-        log_size =3D MAX(log_size, last / VHOST_LOG_CHUNK + 1);
-    }
     return log_size;
 }
=20



