Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719D3C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 17:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278F6206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 17:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyzUkqVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278F6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX6sn-0002LP-A0
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 13:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jX6qG-0007vD-0M
 for qemu-devel@nongnu.org; Fri, 08 May 2020 13:31:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51881
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jX6qE-0006si-AO
 for qemu-devel@nongnu.org; Fri, 08 May 2020 13:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588959074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F6AJiqjPlOoVPM94aQO55ALmYj0AMJh4WzgpEAdHxNs=;
 b=XyzUkqVbkuu3rWWdNDpiB+XvgravrFbUvoM2qAoZ7+cXJwIfn6dQxo3UadC+6SGUSDXRld
 UPQwCgEvSk2Tspq7lo4EhXHFcYWu4KBdOiNjoGj/Henh4wz9bttIMtV/8YuGDdCDiboJGP
 P52yBZCghm1qZ5Ct0pjVtKu79t4G2Mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-J7P-2VgqPk2nrBBm7eXUEg-1; Fri, 08 May 2020 13:31:13 -0400
X-MC-Unique: J7P-2VgqPk2nrBBm7eXUEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3F9F80058A;
 Fri,  8 May 2020 17:31:11 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F2C961989;
 Fri,  8 May 2020 17:31:01 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 jean-philippe@linaro.org, bbhushan2@marvell.com, peterx@redhat.com,
 armbru@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 0/5] VIRTIO-IOMMU probe request support and MSI bypass on
 ARM
Date: Fri,  8 May 2020 19:30:52 +0200
Message-Id: <20200508173057.32215-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

By default the virtio-iommu translates MSI transactions. This
behavior is inherited from ARM SMMU. However the virt machine
code knows where the MSI doorbells are, so we can easily
declare those regions as VIRTIO_IOMMU_RESV_MEM_T_MSI. With that
setting the guest iommu subsystem will not need to map MSIs.
This setup will simplify the VFIO integration.

In this series, the ITS or GICV2M doorbells are declared as
HW MSI regions to be bypassed by the VIRTIO-IOMMU.

This also paves the way to the x86 integration where the MSI
region, [0xFEE00000,0xFEEFFFFF], will be exposed by the q35
machine.  However this will be handled in a separate series
when not-DT support gets resolved.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v5.0.0-virtio-iommu-msi-bypass-v2

History:

v1 -> v2:
- check which MSI controller is in use and advertise the
  corresponding MSI doorbell
- managed for both ITS and GICv2M
- various fixes spotted by Peter and Jean-Philippe, see
  individual logs

v1: Most of those patches were respinned from
  [PATCH for-5.0 v11 00/20] VIRTIO-IOMMU device
  except the last one which is new

Eric Auger (5):
  qdev: Introduce DEFINE_PROP_RESERVED_REGION
  virtio-iommu: Implement RESV_MEM probe request
  virtio-iommu: Handle reserved regions in the translation process
  virtio-iommu-pci: Add array of Interval properties
  hw/arm/virt: Let the virtio-iommu bypass MSIs

 include/exec/memory.h            |   6 ++
 include/hw/arm/virt.h            |   6 ++
 include/hw/qdev-properties.h     |   3 +
 include/hw/virtio/virtio-iommu.h |   2 +
 include/qemu/typedefs.h          |   1 +
 hw/arm/virt.c                    |  18 +++++
 hw/core/qdev-properties.c        |  89 ++++++++++++++++++++++++
 hw/virtio/virtio-iommu-pci.c     |   3 +
 hw/virtio/virtio-iommu.c         | 114 +++++++++++++++++++++++++++++--
 hw/virtio/trace-events           |   1 +
 10 files changed, 239 insertions(+), 4 deletions(-)

-- 
2.20.1


