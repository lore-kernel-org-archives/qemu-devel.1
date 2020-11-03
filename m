Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61842C63697
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0405C223AC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Awxldl+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0405C223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxPf-00057A-2B
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxO2-0003WT-8h
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxNz-0006FS-8p
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZjBMEEWvb1WrIiRrAnczzL8c6+117vVUqiPWdnq/tag=;
 b=Awxldl+qPupJwIOBKsi6MuzW0Lq9KgjzHZ6qhA/GQiA3rH5bLhi4sQB3TvnVB2zKAzrQ3F
 tbSIK3e3nZO30OIF64rk5axvDOb2Hr3fADZiCyKMmb9/QPIQLboPHqawmXfvFzTTvnPkmF
 7YjPSpeRQtZTBbBLXNlsm/2llxtZGFE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-WOGG1x_mNOmOS4-b1c4WOw-1; Tue, 03 Nov 2020 09:34:05 -0500
X-MC-Unique: WOGG1x_mNOmOS4-b1c4WOw-1
Received: by mail-wm1-f72.google.com with SMTP id e15so2701436wme.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=ZjBMEEWvb1WrIiRrAnczzL8c6+117vVUqiPWdnq/tag=;
 b=GiJ3HFmO8ei+WGa8s66XazdjjnyTTRScsm8xq0NBEVjGU+sitnv4LLBJdGYuEmB7/w
 o83xhFGivwEbKoA/WEcwGmWQth3noo33CtO6YWsje/k1G9uTlrBv1jOiVku+whH7DauT
 rRhRL2lQoEeqBQkELTgenzZqGnkV38LTJRb/GRtWQt6AJxOcNVT2Efabfpeo9flH2zJm
 J/7I9sJDKsb3zl3TEVQPz4RTejqAZDKeTLY8QVspPwUDL+Xst8stkVNWZiX9DFTAOdI8
 kJx8fWOnpirj3Dbc0IwRIfJZu1fVFFSZJnRXMUQbfKGpgwo8/7kn7TGjgCAuL8GlQX+c
 WzFw==
X-Gm-Message-State: AOAM533nhRZ2ScF14zetuI9lrcDpYCRcVTFW7NUq+7eK8hSqRKO1Uyau
 jjMS3Aus3jRxSEiesEzc2to30JT3YApAxcWuDwQnbf1SYIvub8CvLghJ8hvqJoaxXHPHvB0o7zs
 xX8zFvKcMj8yOmQA=
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr18062wmj.109.1604414043755;
 Tue, 03 Nov 2020 06:34:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2TZ07e3VptLUmqde/fcMvX83HGZL+tu8JOqGsvA+kle5ro08ZJPXIuQ0EOYxSUUfkxgGf7w==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr18044wmj.109.1604414043534;
 Tue, 03 Nov 2020 06:34:03 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id t1sm25549183wrs.48.2020.11.03.06.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:34:02 -0800 (PST)
Date: Tue, 3 Nov 2020 09:33:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/38] pc,pci,vhost,virtio: fixes
Message-ID: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit c7a7a877b716cf14848f1fd5c754d293e2f8d852:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201102' into staging (2020-11-03 10:38:05 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to cf0bdd0a703911f80fc645dec97f17c4415af267:

  vhost-user-blk-test: fix races by using fd passing (2020-11-03 09:19:12 -0500)

----------------------------------------------------------------
pc,pci,vhost,virtio: fixes

Lots of fixes all over the place.
virtio-mem and virtio-iommu patches are kind of fixes but
it seems better to just make them behave sanely than
try to educate users about the limitations ...

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Bharat Bhushan (7):
      virtio-iommu: Add memory notifiers for map/unmap
      virtio-iommu: Call memory notifiers in attach/detach
      virtio-iommu: Add replay() memory region callback
      virtio-iommu: Add notify_flag_changed() memory region callback
      memory: Add interface to set iommu page size mask
      vfio: Set IOMMU page size as per host supported page size
      virtio-iommu: Set supported page size mask

Cindy Lu (2):
      vhost-vdpa: Add qemu_close in vhost_vdpa_cleanup
      net: Add vhost-vdpa in show_netdevs()

Coiby Xu (1):
      test: new qTest case to test the vhost-user-blk-server

David Hildenbrand (6):
      virtio-mem: Make sure "addr" is always multiples of the block size
      virtio-mem: Make sure "usable_region_size" is always multiples of the block size
      virtio-mem: Probe THP size to determine default block size
      memory-device: Support big alignment requirements
      memory-device: Add get_min_alignment() callback
      virito-mem: Implement get_min_alignment()

Jean-Philippe Brucker (3):
      virtio-iommu: Fix virtio_iommu_mr()
      virtio-iommu: Store memory region in endpoint struct
      vfio: Don't issue full 2^64 unmap

Jin Yu (1):
      vhost-blk: set features before setting inflight feature

Michael S. Tsirkin (1):
      pc: comment style fixup

Philippe Mathieu-Daudé (2):
      hw/virtio/vhost-backend: Fix Coverity CID 1432871
      hw/smbios: Fix leaked fd in save_opt_one() error path

Stefan Hajnoczi (12):
      Revert "vhost-blk: set features before setting inflight feature"
      libvhost-user: follow QEMU comment style
      configure: introduce --enable-vhost-user-blk-server
      block/export: make vhost-user-blk config space little-endian
      block/export: fix vhost-user-blk get_config() information leak
      contrib/vhost-user-blk: fix get_config() information leak
      tests/qtest: add multi-queue test case to vhost-user-blk-test
      libqtest: add qtest_socket_server()
      vhost-user-blk-test: rename destroy_drive() to destroy_file()
      vhost-user-blk-test: close fork child file descriptors
      vhost-user-blk-test: drop unused return value
      vhost-user-blk-test: fix races by using fd passing

Xinhao Zhang (3):
      hw/acpi : Don't use '#' flag of printf format
      hw/acpi : add space before the open parenthesis '('
      hw/acpi : add spaces around operator

 configure                               |  15 +
 contrib/libvhost-user/libvhost-user.h   |  15 +-
 include/exec/memory.h                   |  38 ++
 include/hw/mem/memory-device.h          |  10 +
 include/hw/virtio/vhost.h               |   2 +-
 tests/qtest/libqos/libqtest.h           |  25 +
 tests/qtest/libqos/vhost-user-blk.h     |  48 ++
 block/export/export.c                   |   4 +-
 block/export/vhost-user-blk-server.c    |  28 +-
 contrib/vhost-user-blk/vhost-user-blk.c |   2 +
 hw/acpi/core.c                          |   2 +-
 hw/acpi/nvdimm.c                        |  20 +-
 hw/acpi/pcihp.c                         |   2 +-
 hw/block/vhost-user-blk.c               |   2 +-
 hw/i386/pc.c                            |   9 +-
 hw/mem/memory-device.c                  |  20 +-
 hw/smbios/smbios.c                      |   4 +-
 hw/vfio/common.c                        |  19 +
 hw/virtio/vhost-backend.c               |   4 +-
 hw/virtio/vhost.c                       |   8 +-
 hw/virtio/virtio-iommu.c                | 205 +++++++-
 hw/virtio/virtio-mem-pci.c              |   7 +
 hw/virtio/virtio-mem.c                  | 113 ++++-
 net/net.c                               |   3 +
 net/vhost-vdpa.c                        |   4 +
 softmmu/memory.c                        |  13 +
 tests/qtest/libqos/vhost-user-blk.c     | 129 +++++
 tests/qtest/libqtest.c                  |  76 ++-
 tests/qtest/vhost-user-blk-test.c       | 843 ++++++++++++++++++++++++++++++++
 block/export/meson.build                |   2 +-
 hw/virtio/trace-events                  |   6 +
 tests/qtest/libqos/meson.build          |   1 +
 tests/qtest/meson.build                 |   2 +
 util/meson.build                        |   2 +-
 34 files changed, 1606 insertions(+), 77 deletions(-)
 create mode 100644 tests/qtest/libqos/vhost-user-blk.h
 create mode 100644 tests/qtest/libqos/vhost-user-blk.c
 create mode 100644 tests/qtest/vhost-user-blk-test.c


