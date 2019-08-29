Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EF0C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4232215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4232215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3GLa-0003Xt-E3
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 05:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i3GJb-0001q8-PT
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i3GJZ-0000z5-F5
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i3GJW-0000vL-JA; Thu, 29 Aug 2019 05:01:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2B5183F3B;
 Thu, 29 Aug 2019 09:01:53 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 850F61001B09;
 Thu, 29 Aug 2019 09:01:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 alex.williamson@redhat.com
Date: Thu, 29 Aug 2019 11:01:39 +0200
Message-Id: <20190829090141.21821-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 29 Aug 2019 09:01:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 0/2] VFIO/SMMUv3: Fail on VFIO/HW nested
 paging detection
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
Cc: aik@ozlabs.ru, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As of today when a guest is assigned with a host PCI device and
an SMMUv3, VFIO calls memory_region_iommu_replay() default
implementation. This translates the whole address range and
completely stalls the execution. As VFIO/SMMUv3 integration
is not supported yet (it requires SMMUv3 HW nested paging), let's
recognize this situation and fail.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.1.0_smmu_vfio_fail_v5

History:

v4 -> v5:
- v4 patches: 1, 4, 5 were upstreamed separately
- IOMMU_ATTR_HW_NESTED_PAGING renamed into
  IOMMU_ATTR_NEED_HW_NESTED_PAGING

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


Eric Auger (2):
  memory: Add IOMMU_ATTR_NEED_HW_NESTED_PAGING IOMMU memory region
    attribute
  hw/vfio/common: Fail on VFIO/HW nested paging detection

 hw/arm/smmuv3.c       | 12 ++++++++++++
 hw/vfio/common.c      | 10 ++++++++++
 include/exec/memory.h |  8 +++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

--=20
2.20.1


