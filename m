Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3052DC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9BA206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K39XJpsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9BA206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPBGB-0000LX-1Y
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jPBFV-00080T-Il
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jPBFT-00040R-GM
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32886
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jPBFT-0003zp-9z
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587069394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PMs7kMb35HuCdMRBCSKzXefdpwtPTgWF2vukymgQgys=;
 b=K39XJpsVvIRviLy0anEM7AntPp34bsRLNflmfaSR5ECAkqUh7RXPiq0aeFMpJ8b7BiKQRL
 pveiFT8rGy4WfAZ+9JoLc9W3hgJf7CY0RU5p5jUUaxkaqG0pUCIXXgVQlpdikHJ4KrxXhw
 k2IX0VgBCWaQdD1wOSqje8738aA6GuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-tA_sbelSNwW7W2MjZZGntw-1; Thu, 16 Apr 2020 16:36:32 -0400
X-MC-Unique: tA_sbelSNwW7W2MjZZGntw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65A9A800D53;
 Thu, 16 Apr 2020 20:36:31 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4335CA09A5;
 Thu, 16 Apr 2020 20:36:25 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] RFC/WIP: Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
Date: Thu, 16 Apr 2020 23:36:20 +0300
Message-Id: <20200416203624.32366-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

This is a patch series that is a result of my discussion with Paulo on
how to correctly fix the root cause of the BZ #1812399.

The root cause of this bug is the fact that IO thread is running mostly
unlocked versus main thread on which device hotplug is done.

qdev_device_add first creates the device object, then places it on the bus,
and only then realizes it.

However some drivers and currently only virtio-scsi enumerate its child bus
devices on each request that is received from the guest and that can happen=
 on the IO
thread.

Thus we have a window when new device is on the bus but not realized and ca=
n be accessed
by the virtio-scsi driver in that state.

Fix that by doing two things:

1. Add partial RCU protection to the list of a bus's child devices.
This allows the scsi IO thread to safely enumerate the child devices
while it races with the hotplug placing the device on the bus.

2. Make the virtio-scsi driver check .realized property of the scsi device
and avoid touching the device if it isn't

I don't think that this is very pretty way to solve this, we discussed this
with Paulo and it kind of looks like the lesser evil. I am open to your tho=
ughts about this.

Note that this patch series doesn't pass some unit tests and in particular =
qtest 'drive_del-test'
I did some light debug of this test and I see that the reason for this is t=
hat now child device deletion
can be delayed due to RCU. This is also something I would like to discuss i=
n this RFC.

Note also that I might have some code style errors and bugs in this since I=
 haven't
tested the code in depth yet, because I am not yet sure that this is the ri=
ght way
to fix that bug

Also note that in the particular bug report the issue wasn't a race but rat=
her due
to combination of things, the .realize code in the middle managed to trigge=
r IO on the virtqueue
which caused the virtio-scsi driver to access the half realized device. How=
ever
since this can happen as well with real IO thread, this patch series was do=
ne,
which fixes this as well.

Best regards,
=09Maxim Levitsky

Maxim Levitsky (4):
  scsi/scsi_bus: switch search direction in scsi_device_find
  device-core: use RCU for list of childs of a bus
  device-core: use atomic_set on .realized property
  virtio-scsi: don't touch scsi devices that are not yet realized

 hw/core/bus.c                  | 43 ++++++++++++++++++++----------
 hw/core/qdev.c                 | 48 ++++++++++++++++++++++------------
 hw/scsi/scsi-bus.c             | 27 ++++++++++++++++---
 hw/scsi/virtio-scsi.c          | 24 +++++++++++++++--
 include/hw/qdev-core.h         |  3 +++
 include/hw/virtio/virtio-bus.h |  7 +++--
 6 files changed, 114 insertions(+), 38 deletions(-)

--=20
2.17.2


