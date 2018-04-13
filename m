Received: from eggs.gnu.org ([2001:4830:134:3::10]:48328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6zM4-00065y-5z
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6zM3-0003Ag-Du
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:07:08 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:43389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6zM3-0003AF-7v
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:07:07 -0400
Received: by mail-ot0-x243.google.com with SMTP id d9-v6so9976186oth.10
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 07:07:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57b01152-1179-9735-eb6a-a9dbfc933a6c@redhat.com>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
	<1522160122-10744-9-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_O3QK0t5DHfnAFEOHv_yyxvL9HZX+0geHs0ibVVwTbNQ@mail.gmail.com>
	<57b01152-1179-9735-eb6a-a9dbfc933a6c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 15:06:46 +0100
Message-ID: <CAFEAcA-wT8vERbkjq_HoROi1ymPauAe+y3oc16zoCJXsHKqBoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 8/8] hw/arm/virt: Allow up to 512 vcpus along
 with KVM VGICv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <cdall@kernel.org>, Shannon Zhao <zhaoshenglong@huawei.com>

On 13 April 2018 at 15:01, Auger Eric <eric.auger@redhat.com> wrote:
> On 13/04/18 15:41, Peter Maydell wrote:
>> I think it would be better to explicitly check "do we have
>> support for split redistributors" rather than looking at
>> KVM_MAX_VCPUS. It's not impossible that a distro kernel
>> might have chosen to backport support for one but not the
>> other.
>
> The issue is we have race here:
> to check whether the new ATTR is supported I need to query the GICV3 KVM
> device. This later is created in the GICv3 initialize. But to initialize
> the VGIC I need the VCPUs to be created. And to create the VCPUs I need
> to check their max number. Or do I miss somethinh?
>
> The KVM device create dry-run mode cannot be used here. I would need to
> really create the KVM device and then delete it. The issue is there is
> no kvm device DELETE ioctl at kernel level since KVM devices are deleted
> on VM deletion if I understand correctly. Adding a KVM device delete at
> kernel level may not be straightforward as I suspect some
> simplifications could be made in KVM device deletion knowing the VM was
> under deletion.

Two possibilities:

(1) do like we do in kvm_arm_get_host_cpu_features() where we
create a scratch VM to interrogate it and then throw it away
when we have the info we need

(2) add an API to the kernel to make it easier to query it
for this sort of feature

thanks
-- PMM
