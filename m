Received: from eggs.gnu.org ([2001:4830:134:3::10]:33744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdj.1984@gmail.com>) id 1dCMqY-0005AC-UY
	for qemu-devel@nongnu.org; Sun, 21 May 2017 05:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdj.1984@gmail.com>) id 1dCMqX-0004i5-EV
	for qemu-devel@nongnu.org; Sun, 21 May 2017 05:08:18 -0400
MIME-Version: 1.0
In-Reply-To: <5915EFCE.7070202@arm.com>
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
	<1493530677-4919-2-git-send-email-gengdongjiu@huawei.com>
	<5908A7CE.7030008@arm.com>
	<bbceff7a-1ebf-e6de-abc6-e35b71c939f1@huawei.com>
	<5915EFCE.7070202@arm.com>
From: gengdongjiu <gengdj.1984@gmail.com>
Date: Sun, 21 May 2017 17:08:15 +0800
Message-ID: <CAMj-D2Cyj=1TthEko=Z-Nq7ntsm5hdUYUzSuPJ5YgBM+mHL_BA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] arm64: kvm: inject SError with
 virtual syndrome
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Morse <james.morse@arm.com>
Cc: gengdongjiu <gengdongjiu@huawei.com>, mtsirkin@redhat.com, kvm@vger.kernel.org, tbaicar@codeaurora.org, qemu-devel@nongnu.org, wangxiongfeng2@huawei.com, ben@skyportsystems.com, linux@armlinux.org.uk, kvmarm@lists.cs.columbia.edu, huangshaoyu@huawei.com, lersek@redhat.com, songwenjun@huawei.com, wuquanming@huawei.com, marc.zyngier@arm.com, qemu-arm@nongnu.org, imammedo@redhat.com, linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org, pbonzini@redhat.com

2017-05-13 1:24 GMT+08:00, James Morse <james.morse@arm.com>:
> Hi gengdongjiu,
>
> On 05/05/17 14:19, gengdongjiu wrote:
>> On 2017/5/2 23:37, James Morse wrote:
>> > ... I think you expect an SError to arrive at EL2 and have its ESR
>> > recorded in
>> > vcpu->arch.fault.vsesr_el2. Some time later KVM decides to inject an
>> > SError into
>> > the guest, and this ESR is reused...
>> >
>> > We shouldn't do this. Qemu/kvmtool may want to inject a virtual-SError
>> > that
>> > never started as a physical-SError. Qemu/kvmtool may choose to notify
>> > the guest
>> > of RAS events via another mechanism, or not at all.
>> >
>> > KVM should not give the guest an ESR value of its choice. For SError the
>> > ESR
>> > describes whether the error is corrected, correctable or fatal.
>> > Qemu/kvmtool
>> > must choose this.
>
>> Below is my previous solution:
>> For the SError, CPU will firstly trap to EL3 firmware and records the
>> syndrome to ESR_EL3.
>> Before jumping to El2 hypervisors, it will copy the esr_el3 to esr_el2.
>
> (Copying the ESR value won't always be the right thing to do.)
  James,  thanks for your kindly explanation, understand you  thought.

>
>
>> so in order to pass this syndrome to vsesr_el2, using the esr_el2 value to
>> assign it.
>
>> If Qemu/kvmtool chooses the ESR value and ESR only describes whether the
>> error is corrected/correctable/fatal,
>> whether the information is not enough for the guest?
>
> So the API should specify which of these three severities to use? I think
> this
> is too specific. The API should be useful for anything the VSE/VSESR
> hardware
> can do.
>
> VSESR_EL2 is described in the RAS spec: 4.4.12 [0], its a 64 bit register.
> I
> think we should let Qemu/kvmtool specify any 64bit value here, but KVM
> should
> reject values that try to set bits described as RES0.
>
> This would let Qemu/kvmtool specify any SError ISS, either setting
> ESR_ELx.IDS
> and some virtual-machine specific value, or encoding any severity in AET
> and
> choosing the DFSC/EA bits appropriately.
   it sounds reasonable

>
>
>>> > I think we need an API that allows Qemu/kvmtool to inject SError into a
>>> > guest,
>>> > but that isn't quite what you have here.
>
>> KVM provides APIs to inject the SError, Qemu/kvmtool call the API though
>> IOCTL, may be OK?
>
> (just the one API call), yes.
   Ok, have added.

>
>
> Thanks,
>
> James
>
> [0]
> https://static.docs.arm.com/ddi0587/a/RAS%20Extension-release%20candidate_march_29.pdf
>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>
