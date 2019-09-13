Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E016C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 08:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CB620830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 08:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CB620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8h5t-0006rd-2g
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 04:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i8h4J-0005EH-Td
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 04:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i8h4I-0007vh-P1
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 04:36:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i8h4E-0007sU-NI; Fri, 13 Sep 2019 04:36:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 45A701DA4;
 Fri, 13 Sep 2019 08:36:32 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-33.ams2.redhat.com [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C60360E3E;
 Fri, 13 Sep 2019 08:36:18 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Date: Fri, 13 Sep 2019 10:36:09 +0200
Message-Id: <20190913083615.14719-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 13 Sep 2019 08:36:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 0/6] Allow
 memory_region_register_iommu_notifier() to fail
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series allows the memory_region_register_iommu_notifier()
to fail. As of now, when a MAP notifier is attempted to be
registered along with SMMUv3, Intel iommu without caching mode
or AMD IOMMU, we exit in the IOMMU MR notify_flag_changed()
callback. In case of VFIO assigned device hotplug, this could be
handled more nicely directly within the VFIO code, simply rejecting
the hotplug without exiting. This is what the series achieves
by handling the memory_region_register_iommu_notifier() returned
value.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.1.0_register_iommu_notifier_fail_v=
1

History:

Follow-up of "VFIO/SMMUv3: Fail on VFIO/HW nested paging detection"
https://patchew.org/QEMU/20190829090141.21821-1-eric.auger@redhat.com/

Eric Auger (6):
  memory: allow memory_region_register_iommu_notifier() to fail
  vfio/common: Handle memory_region_register_iommu_notifier() failure
  exec: assert on memory_region_register_iommu_notifier() failure
  vhost: assert on memory_region_register_iommu_notifier() failure
  intel_iommu: Let vtd_iommu_notify_flag_changed() fail
  amd_iommu: Let amdvi_iommu_notify_flag_changed() fail

 exec.c                |  3 ++-
 hw/arm/smmuv3.c       |  8 +++++---
 hw/i386/amd_iommu.c   |  9 +++++----
 hw/i386/intel_iommu.c |  9 +++++----
 hw/ppc/spapr_iommu.c  |  7 ++++---
 hw/vfio/common.c      |  8 ++++++--
 hw/virtio/vhost.c     |  2 +-
 include/exec/memory.h | 18 +++++++++++++-----
 memory.c              | 28 ++++++++++++++++++----------
 9 files changed, 59 insertions(+), 33 deletions(-)

--=20
2.20.1


