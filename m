Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABD6C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463EC208D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfXrhT+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463EC208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4Xl-0004En-7H
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4W3-0002Wb-0i
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:33:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4W1-0002dL-0c
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602534832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j4qxrbGVgzASt3G4rPFkAfQiWvUjMnSl4tY0/wcUnco=;
 b=hfXrhT+zlsKQr7bcxX1NOMoaOvJguFFL4hZcHz7bkJSw2QMFYcHAS4wLC/2PyiExO00qo5
 OFuSqEF+ZOf7BiESAWEM8qit2cTH3N6VgVVJUW9ygf85vL3+pU9eO7WV06qsLKMOx/fb9L
 xyBs0IDTKFKACwgcglCTerOBQnu/r4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-DsO5ujuZNACnGco76CwkJQ-1; Mon, 12 Oct 2020 16:33:48 -0400
X-MC-Unique: DsO5ujuZNACnGco76CwkJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E45F6192FDA0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:33:43 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 916D819C78
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:33:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/38] SCSI, qdev, qtest, meson patches for 2020-10-10
Date: Mon, 12 Oct 2020 16:33:05 -0400
Message-Id: <20201012203343.1105018-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a0bdf866873467271eff9a92f179ab0f77d735cb:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20201012a' into staging (2020-10-12 13:12:04 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to a0c9162c8250e121af438aee5ef93e64ec62dae1:

  meson: identify more sections of meson.build (2020-10-12 11:50:52 -0400)

----------------------------------------------------------------
* qtest documentation improvements (Eduardo, myself)
* libqtest event buffering (Maxim)
* use RCU for list of children of a bus (Maxim)
* move more files to softmmu/ (myself)
* meson.build cleanups, qemu-storage-daemon fix (Philippe)

----------------------------------------------------------------
Eduardo Habkost (3):
      docs: Move QTest documentation to its own document
      docs/devel/qtest: Include protocol spec in document
      docs/devel/qtest: Include libqtest API reference

Huacai Chen (1):
      meson.build: Re-enable KVM support for MIPS

Marc-André Lureau (1):
      build-sys: fix git version from -version

Maxim Levitsky (11):
      qtest: rename qtest_qmp_receive to qtest_qmp_receive_dict
      qtest: Reintroduce qtest_qmp_receive with QMP event buffering
      qtest: remove qtest_qmp_receive_success
      qtest: switch users back to qtest_qmp_receive
      scsi/scsi_bus: switch search direction in scsi_device_find
      device_core: use drain_call_rcu in in qmp_device_add
      device-core: use RCU for list of children of a bus
      device-core: use atomic_set on .realized property
      scsi/scsi_bus: Add scsi_device_get
      virtio-scsi: use scsi_device_get
      scsi/scsi_bus: fix races in REPORT LUNS

Paolo Bonzini (12):
      softmmu: move more files to softmmu/
      exec: split out non-softmmu-specific parts
      qom: fix objects with improper parent type
      qtest: unify extra_qtest_srcs and extra_qtest_deps
      docs/devel: update instruction on how to add new unit tests
      device-plug-test: use qtest_qmp to send the device_del command
      qtest: check that drives are really appearing and disappearing
      qemu-iotests, qtest: rewrite test 067 as a qtest
      qdev: add "check if address free" callback for buses
      scsi: switch to bus->check_address
      scsi/scsi-bus: scsi_device_find: don't return unrealized devices
      meson: identify more sections of meson.build

Philippe Mathieu-Daudé (10):
      meson.build: Add comments to clarify code organization
      meson.build: Sort sourcesets alphabetically
      hw/core: Move the creation of the library to the main meson.build
      chardev: Move the creation of the library to the main meson.build
      migration: Move the creation of the library to the main meson.build
      io: Move the creation of the library to the main meson.build
      crypto: Move the creation of the library to the main meson.build
      authz: Move the creation of the library to the main meson.build
      qom: Move the creation of the library to the main meson.build
      hw/nvram: Always register FW_CFG_DATA_GENERATOR_INTERFACE

 .gitlab-ci.yml                           |   2 +-
 MAINTAINERS                              |  16 +-
 authz/meson.build                        |  10 -
 chardev/meson.build                      |   6 -
 cpu.c                                    | 452 ++++++++++++++++++++++++++++++
 crypto/meson.build                       |  10 -
 docs/devel/index.rst                     |   1 +
 docs/devel/qtest.rst                     |  84 ++++++
 docs/devel/testing.rst                   |  64 +----
 hw/core/bus.c                            |  28 +-
 hw/core/meson.build                      |   6 -
 hw/core/qdev.c                           |  73 +++--
 hw/net/virtio-net.c                      |   2 +-
 hw/nvram/fw_cfg-interface.c              |  23 ++
 hw/nvram/fw_cfg.c                        |   7 -
 hw/nvram/meson.build                     |   3 +
 hw/scsi/scsi-bus.c                       | 262 +++++++++++-------
 hw/scsi/virtio-scsi.c                    |  27 +-
 hw/sd/core.c                             |   3 +-
 include/exec/cpu-common.h                |   3 +
 include/hw/acpi/vmgenid.h                |   2 +-
 include/hw/misc/vmcoreinfo.h             |   2 +-
 include/hw/qdev-core.h                   |  24 +-
 include/hw/scsi/scsi.h                   |   1 +
 include/net/can_host.h                   |   2 +-
 io/meson.build                           |  10 -
 meson.build                              | 126 +++++++--
 migration/meson.build                    |   8 +-
 qom/meson.build                          |   8 -
 scripts/coccinelle/qom-parent-type.cocci |  26 ++
 scripts/qemu-version.sh                  |   2 +-
 bootdevice.c => softmmu/bootdevice.c     |   0
 device_tree.c => softmmu/device_tree.c   |   0
 dma-helpers.c => softmmu/dma-helpers.c   |   0
 softmmu/meson.build                      |  11 +
 exec.c => softmmu/physmem.c              | 454 +------------------------------
 qdev-monitor.c => softmmu/qdev-monitor.c |  12 +
 qemu-seccomp.c => softmmu/qemu-seccomp.c |   0
 softmmu/qtest.c                          |  71 ++++-
 tpm.c => softmmu/tpm.c                   |   0
 tests/qemu-iotests/067                   | 157 -----------
 tests/qemu-iotests/067.out               | 414 ----------------------------
 tests/qemu-iotests/group                 |   2 +-
 tests/qtest/device-plug-test.c           |  32 +--
 tests/qtest/drive_del-test.c             | 244 +++++++++++++++--
 tests/qtest/libqos/libqtest.h            |  54 ++--
 tests/qtest/libqtest.c                   | 110 ++++----
 tests/qtest/meson.build                  |  59 ++--
 tests/qtest/migration-helpers.c          |  25 +-
 tests/qtest/pvpanic-test.c               |   4 +-
 tests/qtest/qmp-test.c                   |  18 +-
 tests/qtest/tpm-util.c                   |   8 +-
 52 files changed, 1471 insertions(+), 1497 deletions(-)
 create mode 100644 cpu.c
 create mode 100644 docs/devel/qtest.rst
 create mode 100644 hw/nvram/fw_cfg-interface.c
 create mode 100644 scripts/coccinelle/qom-parent-type.cocci
 rename bootdevice.c => softmmu/bootdevice.c (100%)
 rename device_tree.c => softmmu/device_tree.c (100%)
 rename dma-helpers.c => softmmu/dma-helpers.c (100%)
 rename exec.c => softmmu/physmem.c (91%)
 rename qdev-monitor.c => softmmu/qdev-monitor.c (98%)
 rename qemu-seccomp.c => softmmu/qemu-seccomp.c (100%)
 rename tpm.c => softmmu/tpm.c (100%)
 delete mode 100755 tests/qemu-iotests/067
 delete mode 100644 tests/qemu-iotests/067.out
-- 
2.26.2


