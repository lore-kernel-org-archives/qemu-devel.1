Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D59C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D3B2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D3B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIbEC-0003QG-D5
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iIaqE-0005EH-EL
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iIaqD-0002yz-Eh
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iIaqD-0002xx-9A
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:59:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89C8318CB8E0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 15:59:00 +0000 (UTC)
Received: from localhost (ovpn-117-170.ams2.redhat.com [10.36.117.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 018505D6C8;
 Thu, 10 Oct 2019 15:58:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] libqos: add VIRTIO PCI 1.0 support
Date: Thu, 10 Oct 2019 16:58:46 +0100
Message-Id: <20191010155853.4325-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 10 Oct 2019 15:59:00 +0000 (UTC)
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New VIRTIO devices are Non-Transitional.  This means they only expose the
VIRTIO 1.0 PCI register interface.

The libqos virtio-pci.c code only supports Legacy and Transitional device=
s (in
Legacy mode).  This patch series add VIRTIO PCI 1.0 support so that tests=
 can
run against Non-Transitional devices too.

Note that this does not actually add VIRTIO 1.0 support to our tests.  Th=
at
would require extending feature negotiation (VIRTIO_F_VERSION_1).  I will=
 look
at this as a separate step but the most pressing issue is getting libqos =
to
work with Non-Transitional virtio-pci devices.

Stefan Hajnoczi (7):
  libqos: extract Legacy virtio-pci.c code
  libqos: add iteration support to qpci_find_capability()
  libqos: pass full QVirtQueue to set_queue_address()
  libqos: add MSI-X callbacks to QVirtioPCIDevice
  libqos: expose common virtqueue setup/cleanup functions
  libqos: make the virtio-pci BAR index configurable
  libqos: add VIRTIO PCI 1.0 support

 tests/Makefile.include           |   1 +
 tests/libqos/pci.h               |   2 +-
 tests/libqos/virtio-pci-modern.h |  17 ++
 tests/libqos/virtio-pci.h        |  34 ++-
 tests/libqos/virtio.h            |   2 +-
 tests/libqos/pci.c               |  18 +-
 tests/libqos/virtio-mmio.c       |   6 +-
 tests/libqos/virtio-pci-modern.c | 405 +++++++++++++++++++++++++++++++
 tests/libqos/virtio-pci.c        |  91 ++++---
 9 files changed, 529 insertions(+), 47 deletions(-)
 create mode 100644 tests/libqos/virtio-pci-modern.h
 create mode 100644 tests/libqos/virtio-pci-modern.c

--=20
2.21.0


