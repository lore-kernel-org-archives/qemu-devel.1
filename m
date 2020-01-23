Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A64C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A069F2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTvjcun5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A069F2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugWt-0005g6-Ci
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iueEL-0005dL-T5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iueEK-0002ho-Ll
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:17:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58954
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iueEK-0002gw-I6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579792631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=68sbMevOE0+sJzBwUQc9YIhSbLOj7g9t97LkpQaW2WI=;
 b=HTvjcun5E/flJqWl7VuRqFPMoLVB3KhzKgZuvl6d0D+UOhb6ARBBXUt3I+4odsVsHL+5BL
 wp0mRRncZjgRV419hzAc/X3Y3AbBtkCOp9YX+D08CSQV4wwLuHjs6GL3ajGP809hpbH5Rj
 eZ0wwKgEJDd5ytOsSN1REq5yjVbvecU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-jOCIGxhsNsyVylKxUwjnmg-1; Thu, 23 Jan 2020 10:17:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 034B58018A3;
 Thu, 23 Jan 2020 15:17:06 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-204-119.brq.redhat.com
 [10.40.204.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A13D05DA89;
 Thu, 23 Jan 2020 15:17:01 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 0/2] virtio-rng: add a control queue
Date: Thu, 23 Jan 2020 16:16:58 +0100
Message-Id: <20200123151700.1367857-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: jOCIGxhsNsyVylKxUwjnmg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel needs sometime to be able to cancel an ongoing command.

For instance, if the virtio-rng device uses the egd backend
and this backend doesn't provide data, the buffer provided by the
kernel is kept as long as it is needed.

On the kernel side, a read blocks until the buffer returns from QEMU.

As the read is done with a mutex held, all the hw_random interface
hangs and we cannot switch to another hw_random backend.

So this series adds a control queue to the virtio-rng device to allow
to flush the virtio-rng input queue to release the kernel mutex and
to allow to switch to another device.

The kernel side series can be found at:

https://github.com/vivier/linux/commits/virtio-rng-ctrl

Laurent Vivier (2):
  virtio-rng: prepare the introduction of a control queue
  virtio-rng: add a control queue

 hw/core/machine.c                           |  1 +
 hw/virtio/trace-events                      |  6 ++
 hw/virtio/virtio-rng.c                      | 99 ++++++++++++++++++---
 include/hw/virtio/virtio-rng.h              |  5 +-
 include/standard-headers/linux/virtio_rng.h | 14 +++
 5 files changed, 111 insertions(+), 14 deletions(-)

--=20
2.23.0


