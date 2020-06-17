Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF16C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A012073E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHVZWbdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A012073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZPb-0005na-QB
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNa-0002pp-QT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNT-0001de-An
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ILZS1thQRzoOTqI/fiVPAQY6fXjGov5mUghI+dKbF48=;
 b=UHVZWbddnElxIOZ/3K5rkzcqRn+Xh657tPlP0Wrr3lgbdPqBiUKo/3NSaolojYpHyfnseZ
 YCVy2Zz7DBy2qShZWEOC9nYiIKAFgxHHxB0W9eHfn6NHhX1UqDxPAFiVRxmL9Higdo8/k0
 a1EL9GfzmWueKlNj6nk69tKEUnLy/XY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-1zilAIhINqqXKBuFR51egg-1; Wed, 17 Jun 2020 10:49:14 -0400
X-MC-Unique: 1zilAIhINqqXKBuFR51egg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E18B81EE4F;
 Wed, 17 Jun 2020 14:49:13 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EEEC7CAA5;
 Wed, 17 Jun 2020 14:49:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/43] Block layer patches
Date: Wed, 17 Jun 2020 16:48:26 +0200
Message-Id: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 5c24bce3056ff209a1ecc50ff4b7e65b85ad8e74:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-plugin-160620-2' into staging (2020-06-16 14:57:15 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 3419ec713f04c323b030e0763459435335b25476:

  iotests: Add copyright line in qcow2.py (2020-06-17 16:21:21 +0200)

----------------------------------------------------------------
Block layer patches:

- enhance handling of size-related BlockConf properties
- nvme: small fixes, refactoring and cleanups
- virtio-blk: On restart, process queued requests in the proper context
- icount: make dma reads deterministic
- iotests: Some fixes for rarely run cases
- .gitignore: Ignore storage-daemon files
- Minor code cleanups

----------------------------------------------------------------
Eric Blake (3):
      block: Refactor subdirectory recursion during make
      qcow2: Tweak comments on qcow2_get_persistent_dirty_bitmap_size
      iotests: Add copyright line in qcow2.py

Klaus Jensen (21):
      hw/block/nvme: fix pci doorbell size calculation
      hw/block/nvme: rename trace events to pci_nvme
      hw/block/nvme: remove superfluous breaks
      hw/block/nvme: move device parameters to separate struct
      hw/block/nvme: use constants in identify
      hw/block/nvme: refactor nvme_addr_read
      hw/block/nvme: fix pin-based interrupt behavior
      hw/block/nvme: add max_ioqpairs device parameter
      hw/block/nvme: remove redundant cmbloc/cmbsz members
      hw/block/nvme: factor out property/constraint checks
      hw/block/nvme: factor out device state setup
      hw/block/nvme: factor out block backend setup
      hw/block/nvme: add namespace helpers
      hw/block/nvme: factor out namespace setup
      hw/block/nvme: factor out pci setup
      hw/block/nvme: factor out cmb setup
      hw/block/nvme: factor out pmr setup
      hw/block/nvme: do cmb/pmr init as part of pci init
      hw/block/nvme: factor out controller identify setup
      hw/block/nvme: add msix_qsize parameter
      hw/block/nvme: verify msix_init_exclusive_bar() return value

Max Reitz (5):
      iotests.py: Add skip_for_formats() decorator
      iotests/041: Skip test_small_target for qed
      iotests/292: data_file is unsupported
      iotests/229: data_file is unsupported
      iotests/{190,291}: compat=0.10 is unsupported

Pavel Dovgaluk (1):
      icount: make dma reads deterministic

Philippe Mathieu-Daudé (2):
      hw/ide: Make IDEDMAOps handlers take a const IDEDMA pointer
      hw/block/nvme: Verify msix_vector_use() returned value

Roman Bolshakov (1):
      .gitignore: Ignore storage-daemon files

Roman Kagan (8):
      virtio-blk: store opt_io_size with correct size
      block: consolidate blocksize properties consistency checks
      qdev-properties: blocksize: use same limits in code and description
      qdev-properties: add size32 property type
      qdev-properties: make blocksize accept size suffixes
      block: make BlockConf size props 32bit and accept size suffixes
      qdev-properties: add getter for size32 and blocksize
      block: lift blocksize property limit to 2 MiB

Sergio Lopez (2):
      virtio-blk: Refactor the code that processes queued requests
      virtio-blk: On restart, process queued requests in the proper context

 hw/block/nvme.h                    |  34 ++-
 include/block/nvme.h               |   8 +
 include/hw/block/block.h           |  14 +-
 include/hw/ide/internal.h          |  12 +-
 include/hw/qdev-properties.h       |   5 +-
 include/hw/virtio/virtio-blk.h     |   1 +
 block/qcow2-bitmap.c               |   9 +-
 dma-helpers.c                      |  22 ++
 hw/block/block.c                   |  40 ++-
 hw/block/dataplane/virtio-blk.c    |   8 +
 hw/block/fdc.c                     |   5 +-
 hw/block/nvme.c                    | 574 +++++++++++++++++++++----------------
 hw/block/swim.c                    |   5 +-
 hw/block/virtio-blk.c              |  39 +--
 hw/block/xen-block.c               |   6 +-
 hw/core/qdev-properties.c          |  85 +++++-
 hw/ide/ahci.c                      |  18 +-
 hw/ide/core.c                      |   6 +-
 hw/ide/macio.c                     |   6 +-
 hw/ide/pci.c                       |  12 +-
 hw/ide/qdev.c                      |   5 +-
 hw/scsi/scsi-disk.c                |  12 +-
 hw/usb/dev-storage.c               |   5 +-
 tests/qemu-iotests/iotests.py      |  16 ++
 tests/qemu-iotests/qcow2.py        |   2 +
 tests/qemu-iotests/qcow2_format.py |   1 +
 .gitignore                         |  17 +-
 Makefile.objs                      |   2 +-
 block/Makefile.objs                |   1 +
 hw/block/trace-events              | 180 ++++++------
 tests/qemu-iotests/041             |   2 +
 tests/qemu-iotests/118             |   7 +-
 tests/qemu-iotests/172.out         | 532 +++++++++++++++++-----------------
 tests/qemu-iotests/190             |   2 +
 tests/qemu-iotests/229             |   3 +
 tests/qemu-iotests/291             |   2 +
 tests/qemu-iotests/292             |   5 +
 37 files changed, 1005 insertions(+), 698 deletions(-)


