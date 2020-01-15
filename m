Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACD7C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E1C2081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ttjm7LA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E1C2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irrMU-0004ea-9Y
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 17:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1irrLJ-0003Pq-1I
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@redhat.com>) id 1irrLF-0002BW-Fl
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:40:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55645
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@redhat.com>) id 1irrLF-00027Z-0F
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579128048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1hg+i6H7dUzjJHM1xiAqzgFnnRMeW9TJDqerA50DnL0=;
 b=Ttjm7LA+CCEBJ4rN0hcymNov17fmIy9/5bsi8QnyAzqRPOLPXdCqN3Trz/1bU1F8FOyJwr
 taecP1p+bk7z7D8WjsSUEN0iUJsqbmo5ZznKuDZXzSL+uGIFD6YG69YoXfb/3mjDn3VsmV
 AnasVAJ4qmxqYu+d2VXiFfhc0ZPLHtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-iAtbGuqUNsGOGaGpL02Eug-1; Wed, 15 Jan 2020 17:40:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B55ED800D41
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 22:40:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-94.brq.redhat.com
 [10.40.204.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E118682062;
 Wed, 15 Jan 2020 22:40:32 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] virtio-balloon: Reject qmp_balloon during hot-unplug
Date: Wed, 15 Jan 2020 23:40:23 +0100
Message-Id: <20200115224025.538368-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: iAtbGuqUNsGOGaGpL02Eug-1
X-Mimecast-Spam-Score: 0
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Julia Suvorova (2):
  qdev: Introduce qdev_get_bus_device
  virtio-balloon: Reject qmp_balloon during hot-unplug

 balloon.c                           |  2 +-
 hw/core/qdev.c                      |  5 +++++
 hw/pci-bridge/pci_expander_bridge.c |  4 +++-
 hw/scsi/scsi-bus.c                  |  4 +++-
 hw/usb/bus.c                        |  4 +++-
 hw/usb/dev-smartcard-reader.c       | 32 +++++++++++++++++++++--------
 hw/virtio/virtio-balloon.c          |  9 +++++++-
 hw/virtio/virtio-pci.c              | 16 +++++++++++++--
 include/hw/qdev-core.h              |  2 ++
 include/sysemu/balloon.h            |  2 +-
 10 files changed, 64 insertions(+), 16 deletions(-)

--=20
2.24.1


