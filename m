Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074ECCA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC18222C2
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC18222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLiP6-0003Mi-GW
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 02:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iLiNf-00024C-09
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iLiNd-000353-TL
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:38:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iLiNZ-000329-VW; Sat, 19 Oct 2019 02:38:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 43FC418CB8E2;
 Sat, 19 Oct 2019 06:38:20 +0000 (UTC)
Received: from localhost (ovpn-116-50.ams2.redhat.com [10.36.116.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56571100EBD5;
 Sat, 19 Oct 2019 06:38:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/16] libqos: add VIRTIO PCI 1.0 support
Date: Sat, 19 Oct 2019 07:37:54 +0100
Message-Id: <20191019063810.6944-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Sat, 19 Oct 2019 06:38:20 +0000 (UTC)
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, slp@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3:
 * Now implements VIRTIO 1.0 fully (vring, device initialization).
   This required several new patches to address the following issues:
   1. Tests that do not negotiate features (non-compliant!)
   2. Tests that access configuration space before feature negotiation
      (non-compliant!)
   3. Tests that set up virtqueues before feature negotiation (non-compli=
ant!)
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
 * Fix checkpatch.pl issues, except MAINTAINERS file warning.  libqos alr=
eady
   has maintainers and the new virtio-pci-modern.[ch] files don't need ex=
tra
   entries since they are already covered by the existing libqos/ entry.

New VIRTIO devices are Non-Transitional.  This means they only expose the
VIRTIO 1.0 interface, not the Legacy interface.

The libqos only supports Legacy and Transitional devices (in Legacy mode)=
.
This patch series add VIRTIO 1.0 support so that tests can run against
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
 tests/libqos/virtio.h            |  18 +-
 tests/libqos/pci.c               |  30 ++-
 tests/libqos/virtio-9p.c         |   6 +
 tests/libqos/virtio-mmio.c       |  38 ++-
 tests/libqos/virtio-net.c        |   6 +-
 tests/libqos/virtio-pci-modern.c | 443 +++++++++++++++++++++++++++++++
 tests/libqos/virtio-pci.c        | 105 +++++---
 tests/libqos/virtio.c            | 166 +++++++++---
 tests/virtio-blk-test.c          |  66 +++--
 tests/virtio-scsi-test.c         |   8 +
 15 files changed, 805 insertions(+), 136 deletions(-)
 create mode 100644 tests/libqos/virtio-pci-modern.h
 create mode 100644 tests/libqos/virtio-pci-modern.c

--=20
2.21.0


