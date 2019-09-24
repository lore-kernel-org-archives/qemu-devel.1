Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB75C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036F020872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036F020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCgBW-0002Ob-K4
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 04:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iCg8i-0000gA-8S
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iCg8f-0006t1-Vo
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:25:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iCg8Z-0006rV-TG; Tue, 24 Sep 2019 04:25:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A375368DA;
 Tue, 24 Sep 2019 08:25:28 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2BFE60852;
 Tue, 24 Sep 2019 08:25:18 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com, aik@ozlabs.ru,
 david@gibson.dropbear.id.au
Subject: [PATCH v4 0/2] Allow memory_region_register_iommu_notifier() to fail
Date: Tue, 24 Sep 2019 10:25:15 +0200
Message-Id: <20190924082517.13724-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 24 Sep 2019 08:25:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

This series allows the memory_region_register_iommu_notifier()
to fail. As of now, when a MAP notifier is attempted to be
registered along with SMMUv3 or AMD IOMMU, we exit in the IOMMU
MR notify_flag_changed() callback.

In case of VFIO assigned device hotplug, this could be handled
more nicely directly within the VFIO code, simply rejecting
the hotplug without exiting. This is what the series achieves
by handling the memory_region_register_iommu_notifier() returned
value and Error object.

To propagate errors collected during vfio_listener_region_add()
we now store the error handle inside the VFIO container instead
of a returned value.

The message now is:
(QEMU) device_add id=3Dhot0 driver=3Dvfio-pci host=3D0000:89:00.0 bus=3Dp=
cie.1
{"error": {"class": "GenericError", "desc": "vfio 0000:89:00.0: failed
to setup container for group 2: memory listener initialization failed:
Region smmuv3-iommu-memory-region-0-6: device 01.00.0 requires iommu MAP
notifier which is not currently supported"}}

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.1.0_register_iommu_notifier_fail_v=
4

History:

v3 -> v4:
- added Peter's R-b on 2d patch
- 1st patch: restore hw_error, remove useless ret assignment, improve
  DMA host window error message, remove local mr variable

v2 -> v3:
- also pass an Error handle (suggested by Peter)

v1 -> v2:
- Intel IOMMU now handles the problem differently with machine init done
  notifier and machine hotplug allowed hook.
- use assert(!ret)
- message rewording in SMMUv3

Follow-up of "VFIO/SMMUv3: Fail on VFIO/HW nested paging detection"
https://patchew.org/QEMU/20190829090141.21821-1-eric.auger@redhat.com/


Eric Auger (2):
  vfio: Turn the container error into an Error handle
  memory: allow memory_region_register_iommu_notifier() to fail

 exec.c                        | 10 +++++--
 hw/arm/smmuv3.c               | 18 ++++++------
 hw/i386/amd_iommu.c           | 17 +++++++-----
 hw/i386/intel_iommu.c         |  8 ++++--
 hw/ppc/spapr_iommu.c          |  8 ++++--
 hw/vfio/common.c              | 52 +++++++++++++++++++++++------------
 hw/vfio/spapr.c               |  4 ++-
 hw/virtio/vhost.c             |  9 ++++--
 include/exec/memory.h         | 21 ++++++++++----
 include/hw/vfio/vfio-common.h |  2 +-
 memory.c                      | 31 +++++++++++++--------
 11 files changed, 120 insertions(+), 60 deletions(-)

--=20
2.20.1


