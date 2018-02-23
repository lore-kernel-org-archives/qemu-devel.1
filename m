Received: from eggs.gnu.org ([2001:4830:134:3::10]:45941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1ep5z1-0000pH-Gw
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 00:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1ep5y3-0004Nm-O4
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 00:33:23 -0500
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:56199)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1ep5y3-0004D2-CA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 00:32:23 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1N5Uc6o039505
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 00:32:17 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 77CB37E
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 00:32:18 -0500 (EST)
Received: from sendprodmail03.cc.columbia.edu (sendprodmail03.cc.columbia.edu
	[128.59.72.15]) by hazelnut (Postfix) with ESMTP id 623307E
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 00:32:18 -0500 (EST)
Received: from mail-wm0-f70.google.com (mail-wm0-f70.google.com [74.125.82.70])
	by sendprodmail03.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w1N5WGOv040494
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 00:32:17 -0500
Received: by mail-wm0-f70.google.com with SMTP id y11so723315wmd.5
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 21:32:16 -0800 (PST)
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com.
	[209.85.128.178]) by smtp.gmail.com with ESMTPSA id
	p93sm1339836edp.63.2018.02.22.21.32.14 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 22 Feb 2018 21:32:14 -0800 (PST)
Received: by mail-wr0-f178.google.com with SMTP id p104so12800800wrc.12
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 21:32:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223035555.GL18962@xz-mi>
References: <CAHyh4xii5y-8=uMJeQGARrHZAETtW4ugmBWUypbQ923vk0P3Lw@mail.gmail.com>
	<20180223035555.GL18962@xz-mi>
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Fri, 23 Feb 2018 00:32:13 -0500
Message-ID: <CAHyh4xiCpJQZgtQR-KDrDntZZnAK5V5D=oB7UwQbuZNy7G_z7g@mail.gmail.com>
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
To: Peter Xu <peterx@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, jasowang@redhat.com, Eric Auger <eric.auger@redhat.com>

Hi Peter,

Hope you had great holidays!

On Thu, Feb 22, 2018 at 10:55 PM, Peter Xu <peterx@redhat.com> wrote:
> On Tue, Feb 20, 2018 at 11:03:46PM -0500, Jintack Lim wrote:
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
>
> The "ats" as virtio device parameter will add ATS capability to the
> PCI device.
>
> The "device-iotlb" as intel-iommu parameter will enable ATS in the
> IOMMU device (and also report that in ACPI field).
>
> If both parameters are provided IIUC it means guest will know virtio
> device has device-iotlb and it'll treat the device specially (e.g.,
> guest will need to send device-iotlb invalidations).

Oh, I see. I was focusing on how QEMU and vhost work in the host, but
I think I missed the guest part! Thanks. I see that the Intel IOMMU
driver has has_iotlb_device flag for that purpose.

>
> We'd better keep these parameters when running virtio devices with
> vIOMMU.  For the rest of vhost/arm specific questions, I'll leave to
> others.

It seems like SMMU is not checking ATS capability - at least
ats_enabled flag - but I may miss something here as well :)

>
> PS: Though IIUC the whole ATS thing may not really be necessary for
> current VT-d emulation, since even with ATS vhost is registering UNMAP
> IOMMU notifiers (see vhost_iommu_region_add()), and IIUC that means
> vhost will receive IOTLB invalidations even without ATS support, and
> it _might_ still work.

Right. That's what I thought.

Come to think of it, I'm not sure why we need to flush mappings in
IOMMU and devices separately in the first place... Any thoughts?

Your reply was really helpful to me. I appreciate it.

Thanks,
Jintack

> But there can be other differences, like
> performance, etc.
>
>>
>> A related question is that if we use SMMU emulation[2] on ARM without
>> those options, does vhost cache mappings as if it has a device-iotlb?
>> (I guess this is the case.)
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
>
> --
> Peter Xu
>
