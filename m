Received: from eggs.gnu.org ([2001:4830:134:3::10]:55320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRKdj-0005C3-01
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRKdi-00012W-4g
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:25:42 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRKdh-00012A-VF
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:25:42 -0500
Received: by mail-oi1-x243.google.com with SMTP id i6so4951807oia.6
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 09:25:41 -0800 (PST)
MIME-Version: 1.0
References: <0184EA26B2509940AA629AE1405DD7F201F96E93@dggema523-mbx.china.huawei.com>
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F201F96E93@dggema523-mbx.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Nov 2018 17:25:30 +0000
Message-ID: <CAFEAcA-00K2y9Xknkxdtop5Yj7E_j9jd6zFe6n0hw=aOGz963A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH RESEND v15 10/10] target-arm:
 kvm64: handle SIGBUS signal from kernel or KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 26 Nov 2018 at 17:18, gengdongjiu <gengdongjiu@huawei.com> wrote:
>
> Hi Peter,
>    Thanks for the comments.
>
> >
> > Yes, but if you look at the code which calls that, it goes on to do:
> >         env->mcg_cap &= mcg_cap | MCG_CAP_BANKS_MASK;
> >
> > which means that if the host kernel does not support this feature then we will clear those bits in the env->mcg_cap field, so we do not
> > advertise it to the guest. But we might be not advertising it to the guest at all, if env->mcg_cap was 0 before this code was called. That
> > happens if we are presenting the guest with a guest CPU type which does not have the feature.
>
> So you mean "env->mcg_cap" uses a bit to indicate that whether guest CPU support error recovery, right? If so, how we know whether guest CPU have this feature?
> Should we initialized MCG_SER_P bit of env->mcg_cap to 1 or 0 before initializing the vcpu?  Please together see the reply in the [2], thanks.

This is an x86-specific field. We need to identify the Arm
equivalent.

> > The question is not "does the host CPU / KVM support error reporting". It is "does the *guest* CPU / system support error reporting".
> > These are distinct questions which may not have the same answer.
>
> [2]:
> But QEMU should not know whether *guest* CPU / system support error reporting.

It should and it must. Otherwise we will deliver
an exception to a guest that cannot handle it.

> From my understanding, in the X86 platform, if host CPU / KVM support error reporting,
> then it will think guest CPU supports error reporting, and set the
> MCG_SER_P bit of env->mcg_cap to 1

No, this is not correct. If you look at the code quoted above.
it ANDs in the mcg_cap value. This code is run after the
CPU is initially created with a default env->mcg_cap which
depends on what CPU model is being exposed to the guest.
So we only set env->mcg_cap to 1 if the guest vCPU model
supports error reporting AND the host KVM does.

thanks
-- PMM
