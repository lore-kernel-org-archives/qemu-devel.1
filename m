Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442DFC3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1073224672
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODcGa/3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1073224672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7c5M-00063B-6s
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 04:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j7c4f-0005K9-QF
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j7c4e-00089z-GN
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:36:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32968
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j7c4e-00089P-CQ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582882607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HP8A3+C66u8HbtY/yUcAxtdPrN7FNKfQYdzMxvL5bqs=;
 b=ODcGa/3ztFjyuWtdzNreGT0GCrn2migpsv0qyPvhBz0V+RNE/JnQY3TMpC3dNO08bIyJuS
 GyFXKho5ueqofRSD/EsezNELaVElJVWomHfph/k9JGioSwn11D7h0DZJ26N6goV+kfDYu7
 ffFfXT88JvHAKciM9CFFmNZzPEY6XE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-vhHdnjwyPRy8xDoAhMRWrg-1; Fri, 28 Feb 2020 04:36:42 -0500
X-MC-Unique: vhHdnjwyPRy8xDoAhMRWrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABCDA8014CA;
 Fri, 28 Feb 2020 09:36:40 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDB4B5C28E;
 Fri, 28 Feb 2020 09:36:29 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH RFC v5 0/5] virtio-iommu: VFIO integration
To: Bharat Bhushan <bharatb.linux@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "mst@redhat.com" <mst@redhat.com>, Tomasz Nowicki <tnowicki@marvell.com>,
 "drjones@redhat.com" <drjones@redhat.com>,
 "linu.cherian@cavium.com" <linu.cherian@cavium.com>,
 "linuc.decode@gmail.com" <linuc.decode@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2a788c05-cd9b-1e69-14dd-864633a1df95@redhat.com>
Date: Fri, 28 Feb 2020 10:36:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bharat,

On 11/27/18 7:52 AM, Bharat Bhushan wrote:
> This patch series integrates VFIO with virtio-iommu. This is
> tested with assigning 2 pci devices to Virtual Machine.
> 
> This version is mainly about rebasing on v9 version on
> virtio-iommu device framework from Eric Augur.
> 
> This patch series allows PCI pass-through using virtio-iommu.
> 
> This series is based on:
>  - virtio-iommu kernel driver by Jean-Philippe Brucker
>     [PATCH v5 0/7] Add virtio-iommu driver
>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9
> 
>  - virtio-iommu device emulation by Eric Augur.
>    [RFC,v9,00/17] VIRTIO-IOMMU device
>    https://github.com/eauger/qemu/tree/v3.1.0-rc2-virtio-iommu-v0.9

Now we have the driver and the base qemu device upstream we may resume
this activity to complete the VFIO integration. Do you intend the
respin? Otherwise let me know if you want me to help.

Thanks

Eric
> 
> v4->v5:
>  - Rebase to v9 version from Eric
>  - PCIe device hotplug fix
>  - Added Patch 1/5 from Eric previous series (Eric somehow dropped in
>    last version.
>  - Patch "Translate the MSI doorbell in kvm_arch_fixup_msi_route"
>    already integrated with vsmmu3
> 
> v3->v4:
>  - Rebase to v4 version from Eric
>  - Fixes from Eric with DPDK in VM
>  - Logical division in multiple patches
> 
> v2->v3:
>  - This series is based on "[RFC v3 0/8] VIRTIO-IOMMU device"
>    Which is based on top of v2.10-rc0 that
>  - Fixed issue with two PCI devices
>  - Addressed review comments
> 
> v1->v2:
>   - Added trace events
>   - removed vSMMU3 link in patch description
> 
> Bharat Bhushan (4):
>   virtio-iommu: Add iommu notifier for iommu-map/unmap
>   virtio-iommu: Call iommu notifier on attach/detach
>   virtio-iommu: add virtio-iommu replay
>   virtio-iommu: handle IOMMU Notifier flag changes
> 
> Eric Auger (1):
>   hw/vfio/common: Do not print error when viommu translates into an mmio
>     region
> 
>  hw/vfio/common.c                 |   2 -
>  hw/virtio/trace-events           |   5 +
>  hw/virtio/virtio-iommu.c         | 190 ++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-iommu.h |   6 +
>  4 files changed, 198 insertions(+), 5 deletions(-)
> 


