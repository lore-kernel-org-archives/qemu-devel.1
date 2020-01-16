Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AF1C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F9820730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ku6oUC2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F9820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39861 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2sz-0006vI-5l
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 06:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1is2rZ-0005Sh-Ns
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1is2rU-0008Ed-SG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:58:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33254
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1is2rU-0008EK-Js
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579172331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yk/D/Q5Jd418j7YrcFUjgj3j8Fw7XKO6yVKG2HtGJZs=;
 b=Ku6oUC2IK0ozCiS4JCFEFOaSogaPMkGgPBR7ZIBCgpj8SxYfONzl/ZQhFBsOAqfofD+PXi
 qdhjYtR5dyUz+h2pySTrbrgqnsXJF3TtuCiPIsQIY5BGu1uC7+QcDoH4OWl2aUv6shkSe/
 pW8dFZ7bgzKHho1Ivh6rnVFgGMHbOEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-bb-16cXGOGaCa8VKzfx7Gw-1; Thu, 16 Jan 2020 05:58:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20AF5107ACC9;
 Thu, 16 Jan 2020 10:58:49 +0000 (UTC)
Received: from localhost (ovpn-117-207.ams2.redhat.com [10.36.117.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7313DA4B60;
 Thu, 16 Jan 2020 10:58:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] virtio: enable blk and scsi multi-queue by default
Date: Thu, 16 Jan 2020 10:58:37 +0000
Message-Id: <20200116105842.271179-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: bb-16cXGOGaCa8VKzfx7Gw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enabling multi-queue helps performance on SMP guests because the completion
interrupt is handled on the vCPU that submitted the I/O request.  This avoi=
ds
IPIs inside the guest.

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

Stefan Hajnoczi (5):
  virtio-scsi: introduce a constant for fixed virtqueues
  virtio: add VirtioDeviceClass->get_num_virtqueues()
  virtio-scsi: default num_queues to -smp N
  virtio-blk: default num_queues to -smp N
  vhost-user-blk: default num_queues to -smp N

 hw/block/vhost-user-blk.c          | 15 +++++++++++++++
 hw/block/virtio-blk.c              | 17 +++++++++++++++++
 hw/core/machine.c                  |  5 +++++
 hw/scsi/vhost-scsi.c               |  2 ++
 hw/scsi/vhost-user-scsi.c          |  4 +++-
 hw/scsi/virtio-scsi.c              | 25 ++++++++++++++++++++++---
 hw/virtio/vhost-scsi-pci.c         |  4 ++--
 hw/virtio/vhost-user-blk-pci.c     |  3 ++-
 hw/virtio/vhost-user-scsi-pci.c    |  4 ++--
 hw/virtio/virtio-blk-pci.c         |  3 ++-
 hw/virtio/virtio-scsi-pci.c        |  4 ++--
 include/hw/virtio/vhost-user-blk.h |  1 +
 include/hw/virtio/virtio-blk.h     |  1 +
 include/hw/virtio/virtio-scsi.h    |  4 ++++
 include/hw/virtio/virtio.h         |  7 +++++++
 15 files changed, 87 insertions(+), 12 deletions(-)

--=20
2.24.1


