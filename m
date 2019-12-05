Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51867C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 06:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C97F20707
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 06:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JydRla8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C97F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ickif-0006LH-9T
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 01:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1ickhp-0005p1-EG
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 01:33:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1ickhm-0002v7-05
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 01:33:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57426
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ickhl-0002oj-G8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 01:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575527616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uann5yvEuq3udAu6ej8cq9ot9VledIB2oOikqNTWQEg=;
 b=JydRla8A8w0XiNEzdoUksAQD74wKOPsk4CQ7HJbFx3OfBfGBnqW41Si3G2lBcqUJivm7rL
 Ol8uVizyi7fqnQOBcoY3wHuBXjpsm9FUlRuKEA94uJZi96Gk4heEhFD4dPKeWDt6ZIRx9m
 Jq4aUQn5MCClf3eugrsp5Arm9xYGt6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-ijXDY0RjMK2LL723yd9R1Q-1; Thu, 05 Dec 2019 01:33:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 296A98017DF;
 Thu,  5 Dec 2019 06:33:30 +0000 (UTC)
Received: from [10.72.12.247] (ovpn-12-247.pek2.redhat.com [10.72.12.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B697A5DA32;
 Thu,  5 Dec 2019 06:33:21 +0000 (UTC)
Subject: Re: [RFC PATCH 0/9] Introduce mediate ops in vfio-pci
To: Yan Zhao <yan.y.zhao@intel.com>, alex.williamson@redhat.com
References: <20191205032419.29606-1-yan.y.zhao@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8bcf603c-f142-f96d-bb11-834d686f5519@redhat.com>
Date: Thu, 5 Dec 2019 14:33:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191205032419.29606-1-yan.y.zhao@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ijXDY0RjMK2LL723yd9R1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kevin.tian@intel.com, kvm@vger.kernel.org, libvir-list@redhat.com,
 cohuck@redhat.com, linux-kernel@vger.kernel.org, zhenyuw@linux.intel.com,
 qemu-devel@nongnu.org, shaopeng.he@intel.com, zhi.a.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi:

On 2019/12/5 =E4=B8=8A=E5=8D=8811:24, Yan Zhao wrote:
> For SRIOV devices, VFs are passthroughed into guest directly without host
> driver mediation. However, when VMs migrating with passthroughed VFs,
> dynamic host mediation is required to  (1) get device states, (2) get
> dirty pages. Since device states as well as other critical information
> required for dirty page tracking for VFs are usually retrieved from PFs,
> it is handy to provide an extension in PF driver to centralizingly contro=
l
> VFs' migration.
>
> Therefore, in order to realize (1) passthrough VFs at normal time, (2)
> dynamically trap VFs' bars for dirty page tracking and


A silly question, what's the reason for doing this, is this a must for=20
dirty page tracking?


>   (3) centralizing
> VF critical states retrieving and VF controls into one driver, we propose
> to introduce mediate ops on top of current vfio-pci device driver.
>
>
>                                     _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
>                                   =20
>   __________   register mediate ops|  ___________     ___________    |
> |          |<-----------------------|     VF    |   |           |
> | vfio-pci |                      | |  mediate  |   | PF driver |   |
> |__________|----------------------->|   driver  |   |___________|
>       |            open(pdev)      |  -----------          |         |
>       |                                                    |
>       |                            |_ _ _ _ _ _ _ _ _ _ _ _|_ _ _ _ _|
>      \|/                                                  \|/
> -----------                                         ------------
> |    VF   |                                         |    PF    |
> -----------                                         ------------
>
>
> VF mediate driver could be a standalone driver that does not bind to
> any devices (as in demo code in patches 5-6) or it could be a built-in
> extension of PF driver (as in patches 7-9) .
>
> Rather than directly bind to VF, VF mediate driver register a mediate
> ops into vfio-pci in driver init. vfio-pci maintains a list of such
> mediate ops.
> (Note that: VF mediate driver can register mediate ops into vfio-pci
> before vfio-pci binding to any devices. And VF mediate driver can
> support mediating multiple devices.)
>
> When opening a device (e.g. a VF), vfio-pci goes through the mediate ops
> list and calls each vfio_pci_mediate_ops->open() with pdev of the opening
> device as a parameter.
> VF mediate driver should return success or failure depending on it
> supports the pdev or not.
> E.g. VF mediate driver would compare its supported VF devfn with the
> devfn of the passed-in pdev.
> Once vfio-pci finds a successful vfio_pci_mediate_ops->open(), it will
> stop querying other mediate ops and bind the opening device with this
> mediate ops using the returned mediate handle.
>
> Further vfio-pci ops (VFIO_DEVICE_GET_REGION_INFO ioctl, rw, mmap) on the
> VF will be intercepted into VF mediate driver as
> vfio_pci_mediate_ops->get_region_info(),
> vfio_pci_mediate_ops->rw,
> vfio_pci_mediate_ops->mmap, and get customized.
> For vfio_pci_mediate_ops->rw and vfio_pci_mediate_ops->mmap, they will
> further return 'pt' to indicate whether vfio-pci should further
> passthrough data to hw.
>
> when vfio-pci closes the VF, it calls its vfio_pci_mediate_ops->release()
> with a mediate handle as parameter.
>
> The mediate handle returned from vfio_pci_mediate_ops->open() lets VF
> mediate driver be able to differentiate two opening VFs of the same devic=
e
> id and vendor id.
>
> When VF mediate driver exits, it unregisters its mediate ops from
> vfio-pci.
>
>
> In this patchset, we enable vfio-pci to provide 3 things:
> (1) calling mediate ops to allow vendor driver customizing default
> region info/rw/mmap of a region.
> (2) provide a migration region to support migration


What's the benefit of introducing a region? It looks to me we don't=20
expect the region to be accessed directly from guest. Could we simply=20
extend device fd ioctl for doing such things?


> (3) provide a dynamic trap bar info region to allow vendor driver
> control trap/untrap of device pci bars
>
> This vfio-pci + mediate ops way differs from mdev way in that
> (1) medv way needs to create a 1:1 mdev device on top of one VF, device
> specific mdev parent driver is bound to VF directly.
> (2) vfio-pci + mediate ops way does not create mdev devices and VF
> mediate driver does not bind to VFs. Instead, vfio-pci binds to VFs.
>
> The reason why we don't choose the way of writing mdev parent driver is
> that
> (1) VFs are almost all the time directly passthroughed. Directly binding
> to vfio-pci can make most of the code shared/reused.


Can we split out the common parts from vfio-pci?


>   If we write a
> vendor specific mdev parent driver, most of the code (like passthrough
> style of rw/mmap) still needs to be copied from vfio-pci driver, which is
> actually a duplicated and tedious work.


The mediate ops looks quite similar to what vfio-mdev did. And it looks=20
to me we need to consider live migration for mdev as well. In that case,=20
do we still expect mediate ops through VFIO directly?


> (2) For features like dynamically trap/untrap pci bars, if they are in
> vfio-pci, they can be available to most people without repeated code
> copying and re-testing.
> (3) with a 1:1 mdev driver which passthrough VFs most of the time, people
> have to decide whether to bind VFs to vfio-pci or mdev parent driver befo=
re
> it runs into a real migration need. However, if vfio-pci is bound
> initially, they have no chance to do live migration when there's a need
> later.


We can teach management layer to do this.

Thanks


>
> In this patchset,
> - patches 1-4 enable vfio-pci to call mediate ops registered by vendor
>    driver to mediate/customize region info/rw/mmap.
>
> - patches 5-6 provide a standalone sample driver to register a mediate op=
s
>    for Intel Graphics Devices. It does not bind to IGDs directly but deci=
des
>    what devices it supports via its pciidlist. It also demonstrates how t=
o
>    dynamic trap a device's PCI bars. (by adding more pciids in its
>    pciidlist, this sample driver actually is not necessarily limited to
>    support IGDs)
>
> - patch 7-9 provide a sample on i40e driver that supports Intel(R)
>    Ethernet Controller XL710 Family of devices. It supports VF precopy li=
ve
>    migration on Intel's 710 SRIOV. (but we commented out the real
>    implementation of dirty page tracking and device state retrieving part
>    to focus on demonstrating framework part. Will send out them in future
>    versions)
>  =20
>    patch 7 registers/unregisters VF mediate ops when PF driver
>    probes/removes. It specifies its supporting VFs via
>    vfio_pci_mediate_ops->open(pdev)
>
>    patch 8 reports device cap of VFIO_PCI_DEVICE_CAP_MIGRATION and
>    provides a sample implementation of migration region.
>    The QEMU part of vfio migration is based on v8
>    https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg05542.html.
>    We do not based on recent v9 because we think there are still opens in
>    dirty page track part in that series.
>
>    patch 9 reports device cap of VFIO_PCI_DEVICE_CAP_DYNAMIC_TRAP_BAR and
>    provides an example on how to trap part of bar0 when migration starts
>    and passthrough this part of bar0 again when migration fails.
>
> Yan Zhao (9):
>    vfio/pci: introduce mediate ops to intercept vfio-pci ops
>    vfio/pci: test existence before calling region->ops
>    vfio/pci: register a default migration region
>    vfio-pci: register default dynamic-trap-bar-info region
>    samples/vfio-pci/igd_dt: sample driver to mediate a passthrough IGD
>    sample/vfio-pci/igd_dt: dynamically trap/untrap subregion of IGD bar0
>    i40e/vf_migration: register mediate_ops to vfio-pci
>    i40e/vf_migration: mediate migration region
>    i40e/vf_migration: support dynamic trap of bar0
>
>   drivers/net/ethernet/intel/Kconfig            |   2 +-
>   drivers/net/ethernet/intel/i40e/Makefile      |   3 +-
>   drivers/net/ethernet/intel/i40e/i40e.h        |   2 +
>   drivers/net/ethernet/intel/i40e/i40e_main.c   |   3 +
>   .../ethernet/intel/i40e/i40e_vf_migration.c   | 626 ++++++++++++++++++
>   .../ethernet/intel/i40e/i40e_vf_migration.h   |  78 +++
>   drivers/vfio/pci/vfio_pci.c                   | 189 +++++-
>   drivers/vfio/pci/vfio_pci_private.h           |   2 +
>   include/linux/vfio.h                          |  18 +
>   include/uapi/linux/vfio.h                     | 160 +++++
>   samples/Kconfig                               |   6 +
>   samples/Makefile                              |   1 +
>   samples/vfio-pci/Makefile                     |   2 +
>   samples/vfio-pci/igd_dt.c                     | 367 ++++++++++
>   14 files changed, 1455 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/net/ethernet/intel/i40e/i40e_vf_migration.c
>   create mode 100644 drivers/net/ethernet/intel/i40e/i40e_vf_migration.h
>   create mode 100644 samples/vfio-pci/Makefile
>   create mode 100644 samples/vfio-pci/igd_dt.c
>


