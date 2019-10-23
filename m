Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8FCCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7955F205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 10:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHbVAkOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7955F205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNDcC-0007Av-FM
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 06:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNDVZ-0003x6-94
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNDVW-0001F7-Br
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:04:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNDVW-0001CL-4k
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571825084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QmMBb8HSzILN2HbYCv6AJeBCV8YBTJZzTlnuexK3qq8=;
 b=OHbVAkOpU6NOMMLe2ebBwSxeFKrCsWyLWtGzGqLuUaAfgSm9iCv4woUtvWpXYcAtptL7wf
 McJ2kqt2gA6CQnzJuzzEI4voQPP35NCxJ4wCEmcebiEEaJChl9ThgxQ65lSlGMEqL1gQK5
 x5Q2J/FeD5haRD+5grrbUpCI1hOeMpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-jDvPS2jRPfWn_rOBjtdgCA-1; Wed, 23 Oct 2019 06:04:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A743800D49;
 Wed, 23 Oct 2019 10:04:39 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 547A319C78;
 Wed, 23 Oct 2019 10:04:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/16] libqos: add VIRTIO PCI 1.0 support
Date: Wed, 23 Oct 2019 11:04:09 +0100
Message-Id: <20191023100425.12168-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jDvPS2jRPfWn_rOBjtdgCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v4:
 * Introduce bool d->features_negotiated so that tests can negotiate a
   0 feature bit set in Legacy mode [Thomas]
 * Make the FEATURES_OK code change in qvirtio_set_driver_ok() clearer and
   mention it in the commit description [Thomas]
 * Fix indentation in qvring_init() [Thomas]
v3:
 * Now implements VIRTIO 1.0 fully (vring, device initialization).
   This required several new patches to address the following issues:
   1. Tests that do not negotiate features (non-compliant!)
   2. Tests that access configuration space before feature negotiation
      (non-compliant!)
   3. Tests that set up virtqueues before feature negotiation (non-complian=
t!)
   4. vring accesses require byte-swapping when VIRTIO 1.0 is used with a
      big-endian guest because the qtest_readX/writeX() API automatically
      converts to guest-endian
   5. VIRTIO 1.0 has an additional FEATURES_OK step during Device
      Initialization
 * Change uint8_t bar_idx to int [Thomas]
 * Document qpci_find_capability() [Thomas]
 * Every commit tested with arm, ppc64, and x86_64 targets using:
   git rebase -i origin/master -x 'make tests/qos-test &&
   QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 tests/qos-test &&
   QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 tests/qos-test'
   QTEST_QEMU_BINARY=3Darm-softmmu/qemu-system-arm tests/qos-test'
v2:
 * Fix checkpatch.pl issues, except MAINTAINERS file warning.  libqos alrea=
dy
   has maintainers and the new virtio-pci-modern.[ch] files don't need extr=
a
   entries since they are already covered by the existing libqos/ entry.

New VIRTIO devices are Non-Transitional.  This means they only expose the
VIRTIO 1.0 interface, not the Legacy interface.

The libqos only supports Legacy and Transitional devices (in Legacy mode).
This patch series adds VIRTIO 1.0 support so that tests can run against
Non-Transitional devices too.

The virtio-fs device is Non-Transitional, so this is a prerequisite for
virtio-fs qos tests.

Stefan Hajnoczi (16):
  tests/virtio-blk-test: read config space after feature negotiation
  libqos: read QVIRTIO_MMIO_VERSION register
  libqos: extend feature bits to 64-bit
  virtio-scsi-test: add missing feature negotiation
  tests/virtio-blk-test: set up virtqueue after feature negotiation
  libqos: add missing virtio-9p feature negotiation
  libqos: enforce Device Initialization order
  libqos: implement VIRTIO 1.0 FEATURES_OK step
  libqos: access VIRTIO 1.0 vring in little-endian
  libqos: add iteration support to qpci_find_capability()
  libqos: pass full QVirtQueue to set_queue_address()
  libqos: add MSI-X callbacks to QVirtioPCIDevice
  libqos: expose common virtqueue setup/cleanup functions
  libqos: make the virtio-pci BAR index configurable
  libqos: extract Legacy virtio-pci.c code
  libqos: add VIRTIO PCI 1.0 support

 tests/Makefile.include           |   1 +
 tests/libqos/pci.h               |   2 +-
 tests/libqos/virtio-mmio.h       |   1 +
 tests/libqos/virtio-pci-modern.h |  17 ++
 tests/libqos/virtio-pci.h        |  34 ++-
 tests/libqos/virtio.h            |  19 +-
 tests/libqos/pci.c               |  30 ++-
 tests/libqos/virtio-9p.c         |   6 +
 tests/libqos/virtio-mmio.c       |  38 ++-
 tests/libqos/virtio-net.c        |   6 +-
 tests/libqos/virtio-pci-modern.c | 443 +++++++++++++++++++++++++++++++
 tests/libqos/virtio-pci.c        | 105 +++++---
 tests/libqos/virtio.c            | 160 ++++++++---
 tests/virtio-blk-test.c          |  66 +++--
 tests/virtio-scsi-test.c         |   8 +
 15 files changed, 802 insertions(+), 134 deletions(-)
 create mode 100644 tests/libqos/virtio-pci-modern.h
 create mode 100644 tests/libqos/virtio-pci-modern.c

--=20
2.21.0


