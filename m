Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7425C3A5A4
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CD02342C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CD02342C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0qqo-0007eo-PK
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 13:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i0qol-0005ha-9C
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i0qoj-00031z-Vn
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:24:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39536)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i0qog-0002y8-Ds; Thu, 22 Aug 2019 13:24:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B040F10C696D;
 Thu, 22 Aug 2019 17:24:03 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E467760603;
 Thu, 22 Aug 2019 17:23:56 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, peterx@redhat.com,
 pbonzini@redhat.com, alex.williamson@redhat.com
Date: Thu, 22 Aug 2019 19:23:45 +0200
Message-Id: <20190822172350.12008-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 22 Aug 2019 17:24:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 0/5] ARM SMMUv3: Fix spurious notification
 errors and fail with VFIO
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

As of today when a guest is assigned with a host PCI device and
an SMMUv3, VFIO calls memory_region_iommu_replay() default
implementation. This translates the whole address range and
completely stalls the execution. As VFIO/SMMUv3 integration
is not supported yet (it requires SMMUv3 HW nested paging), let's
recognize this situation and fail.

Also the series silences some spurious translation configuration
decoding errors (STE out of span or invalid STE) that may happen
on guest IOVA invalidation notifications.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.1.0_smmu_vfio_fail_v4

History:

v3 -> v4:
- see individual patches

v2 -> v3:
- squash IOMMU_ATTR_VFIO_NESTED introduction and SMMUv3 usage
- assert when recognizing VFIO/NESTED case
- collect R-bs

v1 -> v2:
- Added "memory: Remove unused memory_region_iommu_replay_all()" &
  "hw/arm/smmuv3: Log a guest error when decoding an invalid STE"
- do not attempt to implement replay Cb but rather remove the call
  in case it is not needed
- explain why we do not remove other log messages on config decoding

Eric Auger (5):
  memory: Remove unused memory_region_iommu_replay_all()
  memory: Add IOMMU_ATTR_HW_NESTED_PAGING IOMMU memory region attribute
  hw/vfio/common: Fail on VFIO/HW nested paging detection
  hw/arm/smmuv3: Log a guest error when decoding an invalid STE
  hw/arm/smmuv3: Remove spurious error messages on IOVA invalidations

 hw/arm/smmuv3-internal.h |  1 +
 hw/arm/smmuv3.c          | 30 +++++++++++++++++++++++-------
 hw/vfio/common.c         | 10 ++++++++++
 include/exec/memory.h    | 18 +++++++-----------
 memory.c                 |  9 ---------
 5 files changed, 41 insertions(+), 27 deletions(-)

--=20
2.20.1


