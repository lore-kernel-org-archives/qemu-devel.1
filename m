Received: from eggs.gnu.org ([2001:4830:134:3::10]:49994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1eoLdS-0004hr-7r
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 23:04:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1eoLdN-0000dU-9L
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 23:04:02 -0500
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:59714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1eoLdN-0000ZJ-3x
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 23:03:57 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1L408mW037061
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 23:03:51 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 30F737E
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 23:03:52 -0500 (EST)
Received: from sendprodmail01.cc.columbia.edu (sendprodmail01.cc.columbia.edu
	[128.59.72.13]) by hazelnut (Postfix) with ESMTP id 07C1E7E
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 23:03:52 -0500 (EST)
Received: from mail-wr0-f197.google.com (mail-wr0-f197.google.com
	[209.85.128.197])
	by sendprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1L43oOD036940
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 23:03:50 -0500
Received: by mail-wr0-f197.google.com with SMTP id o20so283075wro.3
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 20:03:50 -0800 (PST)
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com.
	[209.85.128.177]) by smtp.gmail.com with ESMTPSA id
	e12sm20460963edi.29.2018.02.20.20.03.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 20 Feb 2018 20:03:48 -0800 (PST)
Received: by mail-wr0-f177.google.com with SMTP id p104so629848wrc.12
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 20:03:47 -0800 (PST)
MIME-Version: 1.0
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Tue, 20 Feb 2018 23:03:46 -0500
Message-ID: <CAHyh4xii5y-8=uMJeQGARrHZAETtW4ugmBWUypbQ923vk0P3Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] intel-iommu and vhost: Do we need 'device-iotlb' and
 'ats'?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: jasowang@redhat.com, Eric Auger <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>

Hi,

I'm using vhost with the virtual intel-iommu, and this page[1] shows
the QEMU command line example.

qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split -m 2G \
                   -device intel-iommu,intremap=on,device-iotlb=on \
                   -device ioh3420,id=pcie.1,chassis=1 \
                   -device
virtio-net-pci,bus=pcie.1,netdev=net0,disable-legacy=on,disable-modern=off,iommu_platform=on,ats=on
\
                   -netdev tap,id=net0,vhostforce \
                   $IMAGE_PATH

I wonder what's the impact of using device-iotlb and ats options as
they are described necessary.

In my understanding, vhost in the kernel only looks at
VIRTIO_F_IOMMU_PLATFORM, and when it is set, vhost uses a
device-iotlb. In addition, vhost and QEMU communicate using vhost_msg
basically to cache mappings correctly in the vhost, so I wonder what's
the role of ats in this case.

A related question is that if we use SMMU emulation[2] on ARM without
those options, does vhost cache mappings as if it has a device-iotlb?
(I guess this is the case.)

I'm pretty new to QEMU code, so I might be missing something. Can
somebody shed some light on it?

[1] https://wiki.qemu.org/Features/VT-d
[2] http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg04736.html

Thanks,
Jintack
