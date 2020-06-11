Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379D3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D36207ED
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAH2igFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D36207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQ27-0008Ep-5n
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPrP-0000Pf-6Z
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:15:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22752
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjPrN-00040z-AK
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591892120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vOZcCyG6+q6mpWKybdwSRlg7xtE0dYIf0cnK+vy6ob4=;
 b=FAH2igFOVzJvgxXSmaxbXUmblfc5UmN1DCuMmaov0wfl9Bma/1RDtnlQmfHDu6fdjEXrLS
 vIYPi+0+HiiF69RjDuBSjwataSLwhfqU4X8ousG+ub/CLaFNdL7bxkO8t0ooppjUio0Un6
 AS2kAIwLOtk3URPebn8o5N69HGT9oDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-iZ52zfHpMHiZbHQP_GDy0g-1; Thu, 11 Jun 2020 12:15:18 -0400
X-MC-Unique: iZ52zfHpMHiZbHQP_GDy0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 139F61B18BC0;
 Thu, 11 Jun 2020 16:15:17 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 474FB1024871;
 Thu, 11 Jun 2020 16:15:03 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com
Subject: [PATCH RESEND 0/9] SMMUv3.2 Range-based TLB Invalidation Support
Date: Thu, 11 Jun 2020 18:14:51 +0200
Message-Id: <20200611161500.23580-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
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
Cc: jean-philippe@linaro.org, robh@kernel.org, robin.murphy@arm.com,
 mst@redhat.com, zhangfei.gao@foxmail.com, shameerali.kolothum.thodi@huawei.com,
 will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SMMU3.2 brings the support of range-based TLB invalidation and
level hint. When this feature is supported, the SMMUv3 driver
is allowed to send TLB invalidations for a range of IOVAs instead
of using page based invalidation.

Implementing this feature in the virtual SMMUv3 device is
mandated for DPDK on guest use case: DPDK uses hugepage
buffers and guest sends invalidations for blocks. Without
this feature, a guest invalidation of a block of 1GB for instance
translates into a storm of page invalidations. Each of them
is trapped by the VMM and cascaded downto the physical IOMMU.
This completely stalls the execution. This integration issue
was initially reported in [1].

Now SMMUv3.2 specifies additional parameters to NH_VA and NH_VAA
stage 1 invalidation commands so we can support those extensions.

patches [1, 3] are cleanup patches.
patches [4, 6] changes the implementation of the VSMMUV3 IOTLB
   This IOTLB is a minimalist IOTLB implementation that avoids to
   do the page table walk in case we have an entry in the TLB.
   Previously entries were page mappings only. Now they can be
   blocks.
patches [7, 9] bring support for range invalidation.

Supporting block mappings in the IOTLB look sensible in terms of
TLB entry consumption. However looking at virtio/vhost device usage,
without block mapping and without range invalidation (< 5.7 kernels
it may be less performant. However for recent guest kernels
supporting range invalidations [2], the performance should be similar.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu.git
branch: v5.0.0-smmuv3-ril-v1

References:
[1] [RFC v2 4/4] iommu/arm-smmu-v3: add CMD_TLBI_NH_VA_AM command
for iova range invalidation
(https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023679.html

[2] 5.7+ kernels featuring
6a481a95d4c1 iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support

Eric Auger (9):
  hw/arm/smmu-common: Factorize some code in smmu_ptw_64()
  hw/arm/smmu-common: Add IOTLB helpers
  hw/arm/smmu: Simplify the IOTLB key format
  hw/arm/smmu: Introduce SMMUTLBEntry for PTW and IOTLB value
  hw/arm/smmuv3: Store the starting level in SMMUTransTableInfo
  hw/arm/smmu-common: Manage IOTLB block entries
  hw/arm/smmuv3: Introduce smmuv3_s1_range_inval() helper
  hw/arm/smmuv3: Get prepared for range invalidation
  hw/arm/smmuv3: Advertise SMMUv3.2 range invalidation

 hw/arm/smmu-internal.h       |  14 +++
 hw/arm/smmuv3-internal.h     |   5 +
 include/hw/arm/smmu-common.h |  24 ++--
 hw/arm/smmu-common.c         | 205 +++++++++++++++++++++++------------
 hw/arm/smmuv3.c              | 142 ++++++++++++------------
 hw/arm/trace-events          |  12 +-
 6 files changed, 246 insertions(+), 156 deletions(-)

-- 
2.20.1


