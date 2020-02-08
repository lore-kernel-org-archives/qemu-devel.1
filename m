Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53636C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C02C2082E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3bTRNi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C02C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0OoT-0006v5-8E
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 07:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j0Omy-0004mh-Rj
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j0Omx-0008OF-LZ
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:00:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j0Omx-0008Ng-7W
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581163242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ql6sCDmwQqiMHt7RScYYvNPQPGSbR7kryjtCjoCIyoU=;
 b=D3bTRNi/wgsLyzFu/bSDqYKBpdcFPqeEaOfDdqH6kQ4HDPN73WPj4dau/Jsh8iA+f/qHJe
 D+DvqgBniXeAYvwxvFvwIKnyx60EIuOV3zweTZaZAToay4lz8a+ioj8wTJ7hWvx7fmvlUc
 VRs/f/Ui2i2C9eHpfhTmR6fK6MoWZF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-gq5crHP9OXq0Wtka23kBww-1; Sat, 08 Feb 2020 07:00:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E6948010EF;
 Sat,  8 Feb 2020 12:00:36 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFF415C545;
 Sat,  8 Feb 2020 12:00:23 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, jean-philippe@linaro.org,
 dgilbert@redhat.com, quintela@redhat.com, mst@redhat.com, peterx@redhat.com
Subject: [PATCH v15 0/9] VIRTIO-IOMMU device
Date: Sat,  8 Feb 2020 13:00:13 +0100
Message-Id: <20200208120022.1920-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: gq5crHP9OXq0Wtka23kBww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kevin.tian@intel.com, bharatb.linux@gmail.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series implements the QEMU virtio-iommu device.

This matches the v0.12 spec (voted) and the corresponding
virtio-iommu driver upstreamed in 5.3. All kernel dependencies
are resolved for DT integration. The virtio-iommu can be
instantiated in ARM virt using:

"-device virtio-iommu-pci".

Non DT mode is not yet supported as it has non resolved kernel
dependencies [1].

This feature targets 5.0.

Integration with vhost devices and vfio devices is not part
of this series. Please follow Bharat's respins [2].

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.2-virtio-iommu-v15

References:
[1] [RFC 00/13] virtio-iommu on non-devicetree platforms
[2] [PATCH RFC v5 0/5] virtio-iommu: VFIO integration

Testing:
- tested with guest using virtio-net-pci
  (,vhost=3Doff,iommu_platform,disable-modern=3Doff,disable-legacy=3Don)
  and virtio-blk-pci
- migration

History:

v14 -> v15:
- removed x-dt-binding and just kept check on hotplug_handler
- removed "tests: Add virtio-iommu test" as the check on
  hotplug_handler fails on PC machine
- destroy mappings in put_domain and remove
  g_tree_destroy(domain->mappings) in virtio_iommu_detach

v13 -> v14:
- added "virtio-iommu-pci: Introduce the x-dt-binding option"
- Removed the mappings gtree ref counting and simply delete
  the gtree when the last EP is detached from the domain
- call virtio_iommu_detach_endpoint_from_domain from
  virtio_iommu_put_endpoint

v12 -> v13:
- Take into account Peter's comments
- fix qtest error and accomodate for directory changes in
  test
- remove "[PATCH v12 01/13] migration: Support QLIST migration"
  which is now upstream
- fix iommu_find_iommu_pcibus()
- squash commits as requested by Peter
- remove spurious guest log

../..

Eric Auger (9):
  virtio-iommu: Add skeleton
  virtio-iommu: Decode the command payload
  virtio-iommu: Implement attach/detach command
  virtio-iommu: Implement map/unmap
  virtio-iommu: Implement translate
  virtio-iommu: Implement fault reporting
  virtio-iommu-pci: Add virtio iommu pci support
  hw/arm/virt: Add the virtio-iommu device tree mappings
  virtio-iommu: Support migration

 hw/arm/virt.c                    |  57 +-
 hw/virtio/Kconfig                |   5 +
 hw/virtio/Makefile.objs          |   2 +
 hw/virtio/trace-events           |  20 +
 hw/virtio/virtio-iommu-pci.c     | 103 ++++
 hw/virtio/virtio-iommu.c         | 890 +++++++++++++++++++++++++++++++
 include/hw/arm/virt.h            |   2 +
 include/hw/pci/pci.h             |   1 +
 include/hw/virtio/virtio-iommu.h |  61 +++
 qdev-monitor.c                   |   1 +
 10 files changed, 1135 insertions(+), 7 deletions(-)
 create mode 100644 hw/virtio/virtio-iommu-pci.c
 create mode 100644 hw/virtio/virtio-iommu.c
 create mode 100644 include/hw/virtio/virtio-iommu.h

--=20
2.20.1


