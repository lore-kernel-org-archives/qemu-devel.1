Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908BEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C5920724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3UuAzTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C5920724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfJy-0004IA-Gf
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jnfIn-0002ed-Hx
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:33:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49775
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jnfIl-0001Uq-LN
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592904791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H/OOYivHtK1EqqOCmpNUBH4sDbP3d0GHSHFNyxUxWwc=;
 b=S3UuAzTmSLzp9Z4YcVvv8eQT/DBzF4qEvId5wTTF4J9vqWdAk3vu8KhGWaLLUTAcdLPnLy
 NpxBfp468esFon5kvrXPez31GGa4LUACcKSdPo4F4FrC4spLHAcHBAOWbZ4x/xLNcJhHn3
 sKZ7FrBe61CKUTb1YO86Bt1b6trslLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418--VGKtiyzMt2epouh41bAEw-1; Tue, 23 Jun 2020 05:33:09 -0400
X-MC-Unique: -VGKtiyzMt2epouh41bAEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4893107ACF4;
 Tue, 23 Jun 2020 09:33:07 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02A4719D7F;
 Tue, 23 Jun 2020 09:32:56 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, pbonzini@redhat.com, jean-philippe@linaro.org,
 bbhushan2@marvell.com, peterx@redhat.com
Subject: [PATCH v4 0/5] VIRTIO-IOMMU probe request support and MSI bypass on
 ARM
Date: Tue, 23 Jun 2020 11:32:39 +0200
Message-Id: <20200623093244.24931-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
https://github.com/eauger/qemu/tree/v5.0.0-virtio-iommu-msi-bypass-v4

History:

v3 -> v4:
- collected Jean and markus's R-bs
- tool into account all Markus' comments in [1/5] (except removal of
  goto)
- use ':' as delimitor instead of commas
- add example in 4/5 commit message as suggested by Markus

v2 -> v3:
- Introduce VIRT_MSI_CTRL_NONE in VirtMSIControllerType
- do not fill the remainder of the probe buffer

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
 include/hw/arm/virt.h            |   7 ++
 include/hw/qdev-properties.h     |   3 +
 include/hw/virtio/virtio-iommu.h |   2 +
 include/qemu/typedefs.h          |   1 +
 hw/arm/virt.c                    |  18 +++++
 hw/core/qdev-properties.c        |  89 +++++++++++++++++++++++++
 hw/virtio/virtio-iommu-pci.c     |   3 +
 hw/virtio/virtio-iommu.c         | 110 +++++++++++++++++++++++++++++--
 hw/virtio/trace-events           |   1 +
 10 files changed, 236 insertions(+), 4 deletions(-)

-- 
2.20.1


