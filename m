Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354E8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B5221929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gekGuwBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B5221929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNv6w-0003Fx-LL
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eperezma@redhat.com>) id 1iNv4b-0000NQ-AP
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eperezma@redhat.com>) id 1iNv4Y-0007Xo-SW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:35:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eperezma@redhat.com>) id 1iNv4W-0007W7-Sv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571992547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SWa0e3hvZLAEYwltGM2EHtc72i/SW9NBNyfQQmgmhnw=;
 b=gekGuwBTy2s4O7MNdS+saHHJv0Jt+tLkdtb/20S3N9huCE/iAIq0VDbX/8qTFm7eaAU9Sa
 sjL0LjAoBmDnLe0ettaew7eiu+dhFZo07faF3FzMOJ3Wg2teixBICVXYEN2hR852kM0d+p
 xV+NbVjhK/xGGWQ1BIjvmZxRvF9Ozcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-k5ADMPaYPlKh3gDhSrN7Mw-1; Fri, 25 Oct 2019 04:35:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83E4F1005500;
 Fri, 25 Oct 2019 08:35:45 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15DCE60BF3;
 Fri, 25 Oct 2019 08:35:31 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 0/8] Packed virtqueue for virtio
Date: Fri, 25 Oct 2019 10:35:19 +0200
Message-Id: <20191025083527.30803-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: k5ADMPaYPlKh3gDhSrN7Mw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi:

This is an updated version of packed virtqueue support based on Wei and Jas=
on's
V6, mainly solving the clang leak detector error CI gave.

Please review.

Changes from V6:
- Commit reorder: Squash bugfix and sepparate big changes into smaller comm=
its.

Changes from V5:
- Fix qemu's CI asan error.
- Move/copy rcu comments.
- Merge duplicated vdev->broken check between split and packet version.

Eugenio P=C3=A9rez (2):
  virtio: Free blk virqueues at unrealize()
  virtio: Free rnd virqueue at unrealize()

Jason Wang (4):
  virtio: basic packed virtqueue support
  virtio: event suppression support for packed ring
  vhost_net: enable packed ring support
  virtio: add property to enable packed virtqueue

Wei Xu (2):
  virtio: basic structure for packed ring
  virtio: device/driver area size calculation refactor for split ring

 hw/block/virtio-blk.c       |    7 +-
 hw/char/virtio-serial-bus.c |    2 +-
 hw/net/vhost_net.c          |    2 +
 hw/scsi/virtio-scsi.c       |    3 +-
 hw/virtio/virtio-rng.c      |    1 +
 hw/virtio/virtio.c          | 1154 ++++++++++++++++++++++++++++++++++++++-=
----
 include/hw/virtio/virtio.h  |   14 +-
 7 files changed, 1045 insertions(+), 138 deletions(-)

--=20
2.16.5


