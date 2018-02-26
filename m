Received: from eggs.gnu.org ([2001:4830:134:3::10]:49764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1eqPdu-0001MG-Hv
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 15:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1eqPdp-0004Uk-Md
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 15:45:02 -0500
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:37478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1eqPdp-0004Sq-IB
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 15:44:57 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1QKhoqd052725
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 15:44:51 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id A7E238C
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 15:44:52 -0500 (EST)
Received: from sendprodmail04.cc.columbia.edu (sendprodmail04.cc.columbia.edu
	[128.59.72.16]) by hazelnut (Postfix) with ESMTP id C09CBC7
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 15:44:44 -0500 (EST)
Received: from mail-wr0-f199.google.com (mail-wr0-f199.google.com
	[209.85.128.199])
	by sendprodmail04.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1QKigPj016896
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 15:44:43 -0500
Received: by mail-wr0-f199.google.com with SMTP id c37so12418791wra.5
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 12:44:43 -0800 (PST)
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com.
	[209.85.128.169]) by smtp.gmail.com with ESMTPSA id
	f19sm9494195edd.84.2018.02.26.12.44.40 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 26 Feb 2018 12:44:40 -0800 (PST)
Received: by mail-wr0-f169.google.com with SMTP id s5so22650793wra.0
	for <qemu-devel@nongnu.org>; Mon, 26 Feb 2018 12:44:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a69c1fcb-9902-720a-12ed-c8e979163f61@redhat.com>
References: <CAHyh4xii5y-8=uMJeQGARrHZAETtW4ugmBWUypbQ923vk0P3Lw@mail.gmail.com>
	<a69c1fcb-9902-720a-12ed-c8e979163f61@redhat.com>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Mon, 26 Feb 2018 15:44:39 -0500
Message-ID: <CAHyh4xhbheoCzMquUMFy5zPTq2z+_t9gEY_dcZSv5amg+CWiWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] intel-iommu and vhost: Do we need 'device-iotlb'
 and 'ats'?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, jasowang@redhat.com, Peter Xu <peterx@redhat.com>

Hi Eric,

On Mon, Feb 26, 2018 at 5:14 AM, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Jintack,
>
> On 21/02/18 05:03, Jintack Lim wrote:
>> Hi,
>>
>> I'm using vhost with the virtual intel-iommu, and this page[1] shows
>> the QEMU command line example.
>>
>> qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split -m 2G \
>>                    -device intel-iommu,intremap=on,device-iotlb=on \
>>                    -device ioh3420,id=pcie.1,chassis=1 \
>>                    -device
>> virtio-net-pci,bus=pcie.1,netdev=net0,disable-legacy=on,disable-modern=off,iommu_platform=on,ats=on
>> \
>>                    -netdev tap,id=net0,vhostforce \
>>                    $IMAGE_PATH
>>
>> I wonder what's the impact of using device-iotlb and ats options as
>> they are described necessary.
>>
>> In my understanding, vhost in the kernel only looks at
>> VIRTIO_F_IOMMU_PLATFORM, and when it is set, vhost uses a
>> device-iotlb. In addition, vhost and QEMU communicate using vhost_msg
>> basically to cache mappings correctly in the vhost, so I wonder what's
>> the role of ats in this case.
>>
>> A related question is that if we use SMMU emulation[2] on ARM without
>> those options, does vhost cache mappings as if it has a device-iotlb?
>> (I guess this is the case.)
> vsmmuv3 emulation code does not support ATS at the moment. vhost support
> is something different. As Peter explained it comes with the capability
> of the virtio device to register unmap notifiers. Those notifiers get
> called each time there are TLB invalidation commands. That way the
> in-kernel vhost cache can be invalidated. vhost support was there until
> vsmmuv3 v7. With latest versions, I removed it to help reviewers
> concentrate on the root functionality. However I will send it to you
> based on v9.

Thanks, Eric. I'm happy to take a look at those patches!

Thanks,
Jintack

>
> Thanks
>
> Eric
>>
>> I'm pretty new to QEMU code, so I might be missing something. Can
>> somebody shed some light on it?
>>
>> [1] https://wiki.qemu.org/Features/VT-d
>> [2] http://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg04736.html
>>
>> Thanks,
>> Jintack
>>
>>
>
