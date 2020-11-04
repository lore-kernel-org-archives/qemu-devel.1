Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6451CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F7A206C1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6dPVPfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F7A206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNkK-0001kj-Kg
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNin-0008R9-LC
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNil-0001tL-PD
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/J2NEj6EQpC5cKRTprcfELq+k2GWUiIro3Y1abL+e4Y=;
 b=Q6dPVPfAHTHrTxY/xP12bsbQTqcfVgjGFXF2FFyuPUv2WG4/EpWoKE1cH4gpyGrp6wsvr1
 C4fbnpj4ZyAVSFsS8ILpno1MFhz3VJQUBmQvcrIQQWLTAWOfhXpwSz96CSbLamvcQn7BE4
 56GUGcdO8fUCK2xdpkrp5d/KxweKTZY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-q1bIzgWJNHagxVSgGPnEqg-1; Wed, 04 Nov 2020 13:41:19 -0500
X-MC-Unique: q1bIzgWJNHagxVSgGPnEqg-1
Received: by mail-wr1-f71.google.com with SMTP id j15so9617617wrd.16
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=/J2NEj6EQpC5cKRTprcfELq+k2GWUiIro3Y1abL+e4Y=;
 b=OMCGNhKVV/e10SALXqQ1wQQC8bAGdyUwejsSASaetCc3MpeWn9e3Ci+GGY/KY207O1
 Gmkfwewly5YPmjIh86jWJNmaYg1+AbnKbI9YqggYua/RtJevSD6YWxtmHQHbThVp7ooq
 gsjNYLa9rd4N32a+W4nEJFXSjcm6KkAR1KPn5+Pf8S3jC62HO/OsvUGBrryVyFMik6CO
 lVSH9vWC/x+21ZRwjY4ZNNhCy4IrFyNnXUXcxYTYquIJ+oe61NZLjNJ1/OWqWMyWvUyn
 Z6TI/EjikVPgCoqqA2zPd09kfJBuyc9bRtjXHj5e3ZBPDWdEG58jw/cula/ZSLg4DTGu
 K7+w==
X-Gm-Message-State: AOAM5312GHSQfW3MSzkVyDXWuIbEQvv5uzS+xuEqTmHCujXQx5BEE5FF
 5q4LktSDAts9kH93YOUI52BbCQ6fI8pN8rvT9WC4iBL3QFWeRkFrENBQhjby9+AfZjLzAgL6Gux
 DzIZsIwtjGJO79Y4=
X-Received: by 2002:a1c:9916:: with SMTP id b22mr6347708wme.105.1604515278255; 
 Wed, 04 Nov 2020 10:41:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztFlzfu543oFbMVwqkCBXbvKKMy8mORtFGWx2WNLF/shdXwsXAANkPDPQh1A7uZ0zSYlUmWg==
X-Received: by 2002:a1c:9916:: with SMTP id b22mr6347693wme.105.1604515278044; 
 Wed, 04 Nov 2020 10:41:18 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id z6sm3302515wmi.1.2020.11.04.10.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:41:17 -0800 (PST)
Date: Wed, 4 Nov 2020 13:41:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/31] pc,pci,vhost,virtio: fixes
Message-ID: <20201104184040.285057-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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

changes from v2:
    drop patches causing issues on BE

The following changes since commit c7a7a877b716cf14848f1fd5c754d293e2f8d852:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201102' into staging (2020-11-03 10:38:05 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 9f6df01d0e128c2df179789b37140d6aeddfcb92:

  contrib/vhost-user-blk: fix get_config() information leak (2020-11-03 16:39:05 -0500)

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

Stefan Hajnoczi (6):
      Revert "vhost-blk: set features before setting inflight feature"
      libvhost-user: follow QEMU comment style
      configure: introduce --enable-vhost-user-blk-server
      block/export: make vhost-user-blk config space little-endian
      block/export: fix vhost-user-blk get_config() information leak
      contrib/vhost-user-blk: fix get_config() information leak

Xinhao Zhang (3):
      hw/acpi : Don't use '#' flag of printf format
      hw/acpi : add space before the open parenthesis '('
      hw/acpi : add spaces around operator

 configure                               |  15 +++
 contrib/libvhost-user/libvhost-user.h   |  15 ++-
 include/exec/memory.h                   |  38 ++++++
 include/hw/mem/memory-device.h          |  10 ++
 include/hw/virtio/vhost.h               |   2 +-
 block/export/export.c                   |   4 +-
 block/export/vhost-user-blk-server.c    |  28 +++--
 contrib/vhost-user-blk/vhost-user-blk.c |   2 +
 hw/acpi/core.c                          |   2 +-
 hw/acpi/nvdimm.c                        |  20 ++--
 hw/acpi/pcihp.c                         |   2 +-
 hw/block/vhost-user-blk.c               |   2 +-
 hw/i386/pc.c                            |   9 +-
 hw/mem/memory-device.c                  |  20 +++-
 hw/smbios/smbios.c                      |   4 +-
 hw/vfio/common.c                        |  19 +++
 hw/virtio/vhost-backend.c               |   4 +-
 hw/virtio/vhost.c                       |   8 +-
 hw/virtio/virtio-iommu.c                | 205 +++++++++++++++++++++++++++++++-
 hw/virtio/virtio-mem-pci.c              |   7 ++
 hw/virtio/virtio-mem.c                  | 113 +++++++++++++++++-
 net/net.c                               |   3 +
 net/vhost-vdpa.c                        |   4 +
 softmmu/memory.c                        |  13 ++
 block/export/meson.build                |   2 +-
 hw/virtio/trace-events                  |   6 +
 util/meson.build                        |   2 +-
 27 files changed, 501 insertions(+), 58 deletions(-)


