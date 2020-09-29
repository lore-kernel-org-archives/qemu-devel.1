Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E05FC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66664206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gj/nEIpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66664206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBSf-0002Qg-8x
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kNBQj-0000uc-1N
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kNBQh-0000E8-2q
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:56:12 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601369770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=u/J84kmOSP7AfNvh9mEFkOHuirkAtr85pDh5FYd6++Y=;
 b=Gj/nEIpaRBhX89GYutyxJJZzrIXTe2nv6nKd3mpE5NkoOswmRJme+FH9KPPCubcaU/zgCA
 LZE3j4r98DmTA3FIC30Z1muY7pC5GTitRJGBEeunFeyZduhDUr4LbsRsMTiVAcQxZF/Mxr
 xj0/3uQUoBapnDmpB2kBqJs+P3eWTAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-4CM3dNo7PcG31xkYascORQ-1; Tue, 29 Sep 2020 04:56:08 -0400
X-MC-Unique: 4CM3dNo7PcG31xkYascORQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7C9A9CC02;
 Tue, 29 Sep 2020 08:56:06 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2BDB3782;
 Tue, 29 Sep 2020 08:55:54 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 philmd@redhat.com, alex.williamson@redhat.com
Subject: [PATCH v2 0/2] NVMe passthrough: Take into account host IOVA reserved
 regions
Date: Tue, 29 Sep 2020 10:55:48 +0200
Message-Id: <20200929085550.30926-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: lvivier@redhat.com, kwolf@redhat.com, cohuck@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current IOVA allocator allocates within the [0x10000, 1ULL << 39]
window, without paying attention to the host IOVA reserved regions.
This prevents NVMe passthtrough from working on ARM as the fixed
IOVAs rapidly grow up to the MSI reserved region [0x8000000, 0x8100000]
causing some VFIO MAP DMA failures. This series collects the usable
IOVA regions using VFIO GET_INFO (this requires the host to support
VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE) and rework the fixed and
temporary IOVA allocators to avoid those latter.

For the time being we do not change the arbitrary min/max IOVAs.
In theory they could be dynamically determined but the kernel
currently fails to expose some HW limitations described in the ACPI
tables (such as PCI root complex Device Memory Address Size Limit).
See kernel thread related to "[RFC 0/3] iommu: Reserved regions for
IOVAs beyond dma_mask and iommu aperture" for more details:
https://lkml.org/lkml/2020/9/28/1102

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/nvme_resv_v2

This was tested on ARM only.

History:
v1 -> v2:
- remove "util/vfio-helpers: Dynamically compute the min/max IOVA" to
  relax the kernel dependency
- Fix cabapbility enumeration loop
- set s->usable_iova_ranges=NULL to avoid double free
- handle possible u64 wrap

Eric Auger (2):
  util/vfio-helpers: Collect IOVA reserved regions
  util/vfio-helpers: Rework the IOVA allocator to avoid IOVA reserved
    regions

 util/vfio-helpers.c | 129 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 123 insertions(+), 6 deletions(-)

-- 
2.21.3


