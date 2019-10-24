Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16C7CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADEE205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uk+Se7WJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADEE205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhPo-0001T4-Sb
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eperezma@redhat.com>) id 1iNggw-00026W-Gt
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eperezma@redhat.com>) id 1iNggu-0001jr-Ps
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:14:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eperezma@redhat.com>) id 1iNggu-0001jM-Ik
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571937267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MDR76UI1pO5Ow9dwfWjsK7H+3cP8m9o8KKqRhqQ1EMI=;
 b=Uk+Se7WJWD6WENDX3kiI9aIQSeblSuzHocw08blaIuagoITTuY+zicWXTxG6A5AOnxD4bg
 8t6qDSwJkemhTsDTy9vP2OJ/xfxaHen1K6zH6DKkmd+LvLMDpXIyyMz3DinAGhp2VNliSP
 MoenEi66QSeneko30xpp5QA90e7s0H8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-evkWrwYzPNmDI1V1ANi3HA-1; Thu, 24 Oct 2019 13:14:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1342F801E5F;
 Thu, 24 Oct 2019 17:14:21 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-116-206.ams2.redhat.com
 [10.36.116.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 787655D70E;
 Thu, 24 Oct 2019 17:14:11 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/9] Packed virtqueue for virtio
Date: Thu, 24 Oct 2019 19:13:57 +0200
Message-Id: <20191024171406.12504-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: evkWrwYzPNmDI1V1ANi3HA-1
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
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi:

This is an updated version of packed virtqueue support based on Wei and Jas=
on's
V5, mainly solving the clang leak detector error CI gave.

Please review.

Changes from V5:
- Fix qemu's CI asan error.
- Move/copy rcu comments.
- Merge duplicated vdev->broken check between split and packet version.

Eugenio P=C3=A9rez (3):
  virtio: Free rng and blk virqueues
  virtio: add some rcu comments
  virtio: Move vdev->broken check to dispatch drop_all

Jason Wang (4):
  virtio: basic packed virtqueue support
  virtio: event suppression support for packed ring
  vhost_net: enable packed ring support
  virtio: add property to enable packed virtqueue

Wei Xu (2):
  virtio: basic structure for packed ring
  virtio: device/driverr area size calculation refactor for split ring

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


