Received: from eggs.gnu.org ([2001:4830:134:3::10]:51342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdj.1984@gmail.com>) id 1d6cbR-0004xu-KY
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdj.1984@gmail.com>) id 1d6cbQ-0001zx-Dx
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:44:57 -0400
MIME-Version: 1.0
In-Reply-To: <590B4D73.60000@arm.com>
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
	<5908A5BC.1060202@arm.com> <590B4D73.60000@arm.com>
From: gengdongjiu <gengdj.1984@gmail.com>
Date: Fri, 5 May 2017 20:44:55 +0800
Message-ID: <CAMj-D2Bjb=oDRUhY_dxUmZTuGkNZcCs6EYhKUsvjxAU4v55N7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 1/3] arm64: kvm: support kvmtool to
 detect RAS extension feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Morse <james.morse@arm.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>, mtsirkin@redhat.com, kvm@vger.kernel.org, Tyler Baicar <tbaicar@codeaurora.org>, qemu-devel@nongnu.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>, Benjamin Warren <ben@skyportsystems.com>, linux@armlinux.org.uk, kvmarm@lists.cs.columbia.edu, huangshaoyu@huawei.com, lersek@redhat.com, songwenjun@huawei.com, wuquanming@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, qemu-arm@nongnu.org, imammedo@redhat.com, linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, pbonzini@redhat.com

Hi James,
     Thanks a lot for your comments.

2017-05-04 23:49 GMT+08:00 James Morse <james.morse@arm.com>:
> Hi Dongjiu Geng,
>
> On 02/05/17 16:29, James Morse wrote:
>> I think we need a new API for injecting SError for SEI from Qemu/kvmtool, but it
>> shouldn't be related to the RAS extensions. All v8.0 CPUs have HCR_EL2.VSE, so
>> we need to know KVM supports this API.
>
> Thinking about this some more, it is slightly more nuanced, KVM can always
> provide an API to inject SError, but it can only set the VSESR if the CPU has
> the RAS Extensions.

James, do you mean we need to add a new API instead of adding the
VSESR in the old API kvm_inject_vabt?

 /**
  * kvm_inject_vabt - inject an async abort / SError into the guest
  * @vcpu: The VCPU to receive the exception
  *
  * It is assumed that this code is called from the VCPU thread and that the
  * VCPU therefore is not currently executing guest code.
  */
 void kvm_inject_vabt(struct kvm_vcpu *vcpu)
 {
     vcpu_set_hcr(vcpu, vcpu_get_hcr(vcpu) | HCR_VSE);
 }



>
> Only offering the inject-SError API call if we can also set the VSESR looks a
> bit funny, but no-one has needed the no-ESR version so far.
>
> I still don't think we should let user-space make the 'RAS Extensions means
> VSESR' logical step.

 Ok. got it.

>
> So my comments on this patch become:
> Don't read id registers directly, use cpus_have_cap() which handles features
> that differ across CPUs or were turned off at compile time.
>
> Please don't call this 'KVM_CAP_ARM_RAS_EXTENSION', if we are building an API to
> inject SError, call it that instead.

Ok, thanks for your suggestion.

>
>
> Thanks,
>
> James
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
