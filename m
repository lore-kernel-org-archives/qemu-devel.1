Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA88BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957E0207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFHEkq0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957E0207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBI9w-0002x3-RZ
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI8d-0000bv-Qe
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI8b-0006Ie-Rn
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598535620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=2hxtoHQ3TAiSaMzzff4e9bxIZ7e3A0BQ7Rr2LIxo2Wg=;
 b=UFHEkq0FWxHbk40XpySkFyIdBxFG1Z25/lOGOCOZPidCOGIsSHCox/KiiNQzC/Q6FSeeoD
 LsSorwbU79JWy1UVT5hbK+vcXDH38ar9EtlTC8NKhAMWxEWsMWKYmB7FkAJGabp2e6jooo
 vOziadH0Vrgxgy5PQkVbUTBkzpRsJxM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-go8haRsMMnewsqCm_xx_5A-1; Thu, 27 Aug 2020 09:40:19 -0400
X-MC-Unique: go8haRsMMnewsqCm_xx_5A-1
Received: by mail-wr1-f70.google.com with SMTP id i6so1545082wru.23
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=2hxtoHQ3TAiSaMzzff4e9bxIZ7e3A0BQ7Rr2LIxo2Wg=;
 b=ttOzZ1EOyfsKbOPkQRfQsCIDcKfpgzCBlNvvmll9xGWoZkBt7nCn0lzBpWps28ptF4
 /gvU6dJt1wXmY6et+tOInEJd8gkSq4eYcfgXAnWsj58bHPUMSAeMJ5iL3SbUs84LK/tH
 zFlwHjQey0icqUuKDmVUKFqehNDYEfMlkpAzQTM2qiEDc4q0DUFTMJrDVLFIJ2njG9pK
 hvcPNy5ltfJ8hPYMA5cePypO+6BiTGGyTQcU9LsuktHX6qricWxd0ztKQTXhdG5flEgP
 5YKtFhVUviTfMjdYd3UAA6N8mCbOayENX1AimyrlMLp4U8ZZEr3qWTTJNMRiMgEXxzkA
 Q1GQ==
X-Gm-Message-State: AOAM530NkITrEwTwN4EYGl5a68omBoJO96jPgdr4TSJwkapPmcBedODm
 uvfw8oCAR7RZv0O6dO2Dnw+XqkvwAGPY6uJ6U8w61otM94nHA0TFxUDCJqFBkjM2/tAnDngF/z1
 yX+3OThFeIQpXObY=
X-Received: by 2002:a1c:98c7:: with SMTP id
 a190mr12580951wme.131.1598535613875; 
 Thu, 27 Aug 2020 06:40:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyhGYe1V3G2/qfArTFBNf7f4Am3sTx/qUBm7XRb0A2DwH/Vb9WMvvHdrKwe4EkE17wQVvuiA==
X-Received: by 2002:a1c:98c7:: with SMTP id
 a190mr12580928wme.131.1598535613618; 
 Thu, 27 Aug 2020 06:40:13 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id o128sm5470180wmo.39.2020.08.27.06.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:40:12 -0700 (PDT)
Date: Thu, 27 Aug 2020 09:40:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] virtio,pc,acpi: features, fixes
Message-ID: <20200827133954.2118749-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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

The following changes since commit 8e49197ca5e76fdb8928833b2649ef13fc5aab2f:

  Merge remote-tracking branch 'remotes/hdeller/tags/target-hppa-v3-pull-request' into staging (2020-08-26 22:23:53 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to e1647539b1d04f121b70f1f6f438976477450f10:

  tests/bios-tables-test: add smbios cpu speed test (2020-08-27 08:29:13 -0400)

----------------------------------------------------------------
virtio,pc,acpi: features, fixes

better number of queues for vhost
smbios speed options
acpi fixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ani Sinha (1):
      Introduce a new flag for i440fx to disable PCI hotplug on the root bus

Michael S. Tsirkin (5):
      acpi: allow DSDT changes
      i386/acpi: fix inconsistent QEMU/OVMF device paths
      arm/acpi: fix an out of spec _UID for PCI root
      disassemble-aml: -o actually works
      acpi: update expected DSDT files with _UID changes

Stefan Hajnoczi (5):
      virtio-pci: add virtio_pci_optimal_num_queues() helper
      virtio-scsi: introduce a constant for fixed virtqueues
      virtio-scsi-pci: default num_queues to -smp N
      virtio-blk-pci: default num_queues to -smp N
      vhost-user-blk-pci: default num_queues to -smp N

Ying Fang (2):
      hw/smbios: add options for type 4 max-speed and current-speed
      tests/bios-tables-test: add smbios cpu speed test

 hw/virtio/virtio-pci.h             |   9 ++++++++
 include/hw/acpi/pcihp.h            |   2 +-
 include/hw/virtio/vhost-user-blk.h |   2 ++
 include/hw/virtio/virtio-blk.h     |   2 ++
 include/hw/virtio/virtio-scsi.h    |   5 +++++
 hw/acpi/pcihp.c                    |  23 +++++++++++++++++++-
 hw/acpi/piix4.c                    |   5 ++++-
 hw/arm/virt-acpi-build.c           |   2 +-
 hw/block/vhost-user-blk.c          |   6 +++++-
 hw/block/virtio-blk.c              |   6 +++++-
 hw/core/machine.c                  |   8 ++++++-
 hw/i386/acpi-build.c               |   4 ++--
 hw/scsi/vhost-scsi.c               |   3 ++-
 hw/scsi/vhost-user-scsi.c          |   5 +++--
 hw/scsi/virtio-scsi.c              |  13 ++++++++----
 hw/smbios/smbios.c                 |  36 +++++++++++++++++++++++++++----
 hw/virtio/vhost-scsi-pci.c         |   9 ++++++--
 hw/virtio/vhost-user-blk-pci.c     |   4 ++++
 hw/virtio/vhost-user-scsi-pci.c    |   9 ++++++--
 hw/virtio/virtio-blk-pci.c         |   7 ++++++-
 hw/virtio/virtio-pci.c             |  32 ++++++++++++++++++++++++++++
 hw/virtio/virtio-scsi-pci.c        |   9 ++++++--
 tests/qtest/bios-tables-test.c     |  42 +++++++++++++++++++++++++++++++++++++
 qemu-options.hx                    |   2 +-
 tests/data/acpi/disassemle-aml.sh  |  11 +++++++---
 tests/data/acpi/pc/DSDT            | Bin 4934 -> 4934 bytes
 tests/data/acpi/pc/DSDT.acpihmat   | Bin 6258 -> 6258 bytes
 tests/data/acpi/pc/DSDT.bridge     | Bin 6793 -> 6793 bytes
 tests/data/acpi/pc/DSDT.cphp       | Bin 5397 -> 5397 bytes
 tests/data/acpi/pc/DSDT.dimmpxm    | Bin 6587 -> 6587 bytes
 tests/data/acpi/pc/DSDT.ipmikcs    | Bin 5006 -> 5006 bytes
 tests/data/acpi/pc/DSDT.memhp      | Bin 6293 -> 6293 bytes
 tests/data/acpi/pc/DSDT.numamem    | Bin 4940 -> 4940 bytes
 tests/data/acpi/q35/DSDT           | Bin 7678 -> 7678 bytes
 tests/data/acpi/q35/DSDT.acpihmat  | Bin 9002 -> 9002 bytes
 tests/data/acpi/q35/DSDT.bridge    | Bin 7695 -> 7695 bytes
 tests/data/acpi/q35/DSDT.cphp      | Bin 8141 -> 8141 bytes
 tests/data/acpi/q35/DSDT.dimmpxm   | Bin 9331 -> 9331 bytes
 tests/data/acpi/q35/DSDT.ipmibt    | Bin 7753 -> 7753 bytes
 tests/data/acpi/q35/DSDT.memhp     | Bin 9037 -> 9037 bytes
 tests/data/acpi/q35/DSDT.mmio64    | Bin 8808 -> 8808 bytes
 tests/data/acpi/q35/DSDT.numamem   | Bin 7684 -> 7684 bytes
 tests/data/acpi/q35/DSDT.tis       | Bin 8283 -> 8283 bytes
 tests/data/acpi/virt/DSDT          | Bin 5205 -> 5200 bytes
 tests/data/acpi/virt/DSDT.memhp    | Bin 6566 -> 6561 bytes
 tests/data/acpi/virt/DSDT.numamem  | Bin 5205 -> 5200 bytes
 46 files changed, 225 insertions(+), 31 deletions(-)


