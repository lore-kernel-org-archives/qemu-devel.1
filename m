Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 730DF21556
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQ++j/c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730DF21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvpN-000215-ET
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iuvn3-00069l-8S
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iuvn1-0006NN-TN
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:02:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60578
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iuvn1-0006MT-Q6
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579860130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kWikCDmOGAbrSgZhG31+QcepqYLZGbzykBMQZNIcJHQ=;
 b=cQ++j/c7sPJNng5mdwiuqNuVoMxu6nP7zHeBKO+4yMSlW/pppmxdsE1dIaP8JM2lTxuS/C
 1YdmCf3KUSpha4rL84+F721Ber1Bb01k3XXb+1XQARxgsK5eq3+pZqJzD1LIr1WZRzXoXY
 b12ghttvIX0HneGOit0hfMBLYseE+uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-CrYtSojqNRGJZ9XzoeJxEg-1; Fri, 24 Jan 2020 05:02:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 242DB8017CC;
 Fri, 24 Jan 2020 10:02:06 +0000 (UTC)
Received: from localhost (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D845019481;
 Fri, 24 Jan 2020 10:02:00 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] virtio-pci: enable blk and scsi multi-queue by default
Date: Fri, 24 Jan 2020 10:01:55 +0000
Message-Id: <20200124100159.736209-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: CrYtSojqNRGJZ9XzoeJxEg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
 * Let the virtio-DEVICE-pci device select num-queues because the optimal
   multi-queue configuration may differ between virtio-pci, virtio-mmio, an=
d
   virtio-ccw [Cornelia]

Enabling multi-queue on virtio-pci storage devices improves performance on =
SMP
guests because the completion interrupt is handled on the vCPU that submitt=
ed
the I/O request.  This avoids IPIs inside the guest.

Note that performance is unchanged in these cases:
1. Uniprocessor guests.  They don't have IPIs.
2. Application threads might be scheduled on the sole vCPU that handles
   completion interrupts purely by chance.  (This is one reason why benchma=
rk
   results can vary noticably between runs.)
3. Users may bind the application to the vCPU that handles completion
   interrupts.

Set the number of queues to the number of vCPUs by default.  Older machine
types continue to default to 1 queue for live migration compatibility.

This patch improves IOPS by 1-4% on an Intel Optane SSD with 4 vCPUs, -driv=
e
aio=3Dnative, and fio bs=3D4k direct=3D1 rw=3Drandread.

Stefan Hajnoczi (4):
  virtio-scsi: introduce a constant for fixed virtqueues
  virtio-scsi: default num_queues to -smp N
  virtio-blk: default num_queues to -smp N
  vhost-user-blk: default num_queues to -smp N

 hw/block/vhost-user-blk.c          |  6 +++++-
 hw/block/virtio-blk.c              |  6 +++++-
 hw/core/machine.c                  |  5 +++++
 hw/scsi/vhost-scsi.c               |  3 ++-
 hw/scsi/vhost-user-scsi.c          |  5 +++--
 hw/scsi/virtio-scsi.c              | 13 +++++++++----
 hw/virtio/vhost-scsi-pci.c         | 10 ++++++++--
 hw/virtio/vhost-user-blk-pci.c     |  6 ++++++
 hw/virtio/vhost-user-scsi-pci.c    | 10 ++++++++--
 hw/virtio/virtio-blk-pci.c         |  9 ++++++++-
 hw/virtio/virtio-scsi-pci.c        | 10 ++++++++--
 include/hw/virtio/vhost-user-blk.h |  2 ++
 include/hw/virtio/virtio-blk.h     |  2 ++
 include/hw/virtio/virtio-scsi.h    |  5 +++++
 14 files changed, 76 insertions(+), 16 deletions(-)

--=20
2.24.1


