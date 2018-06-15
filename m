Received: from eggs.gnu.org ([2001:4830:134:3::10]:41953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTrf9-0001NW-Ix
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTrf8-00064e-Ph
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:33:23 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:34049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTrf8-00064I-Kk
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:33:22 -0400
Received: by mail-ot0-x229.google.com with SMTP id r18-v6so11660503otk.1
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 09:33:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <333cd485-dc75-d295-16fd-98a1108e1e15@redhat.com>
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
	<20180516152026.2920-7-shameerali.kolothum.thodi@huawei.com>
	<bd67ed40-81d6-58dc-ccaf-efd8a40ca96f@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8386F6E04@FRAEML521-MBX.china.huawei.com>
	<20180615154441.4rr5mtcnran5cf3s@kamzik.brq.redhat.com>
	<CAFEAcA-nG4Xv=PmxzW3tzs-TStziMDHMFxYi6_teSe1GhLH=hw@mail.gmail.com>
	<333cd485-dc75-d295-16fd-98a1108e1e15@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 17:33:01 +0100
Message-ID: <CAFEAcA-+Xp6B_g_a89-7wP_DN1ftGrKTON=P6wH_6ESq9GPKKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 6/6] hw/arm: Populate non-contiguous
 memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, Linuxarm <linuxarm@huawei.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>

On 15 June 2018 at 17:13, Auger Eric <eric.auger@redhat.com> wrote:
> On 06/15/2018 05:54 PM, Peter Maydell wrote:
>> Why should the VM ever care about where the address regions in the
>> host happen to be when it comes to where it's putting its RAM
>> in the VM's address layout? I feel like I'm missing something here...

> The VM cannot use RAM GPA that matches assigned device reserved IOVA
> regions. When you assign a device, the whole VM RAM is mapped in the
> physical IOMMU and IOVA corresponds to GPA. but sometimes some IOVA
> cannot be used due to the host specificities and especially iommu
> peculiarities. Some IOVAs may be simply "bypassed" by the iommu, like on
> x86 and also with some ARM SMMU integration. In such a case the DMA
> accesses have no chance to reach the guest RAM as expected. Hope it
> clarifies.

Hmm. We don't want to have the address layout of
the VM have to cope with all the various oddities that host
systems might have. Is this kind of thing common, or rare?
I'd much rather just say "we don't support device passthrough
on that sort of system".

thanks
-- PMM
