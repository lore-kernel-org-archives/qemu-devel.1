Received: from eggs.gnu.org ([2001:4830:134:3::10]:41147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQGbw-0008Pz-Nm
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQGXd-00077W-SJ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:51:03 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gQGXb-00070Q-TI
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 13:51:01 -0500
Received: by mail-ot1-x343.google.com with SMTP id v23so5967734otk.9
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 10:50:59 -0800 (PST)
MIME-Version: 1.0
References: <0184EA26B2509940AA629AE1405DD7F201F85395@DGGEMA503-MBX.china.huawei.com>
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F201F85395@DGGEMA503-MBX.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Nov 2018 18:50:47 +0000
Message-ID: <CAFEAcA_cZb_SG4MHocxB-wWGDPA0mCWUonjbuZF8srE_ZbOGbw@mail.gmail.com>
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

On Fri, 23 Nov 2018 at 14:31, gengdongjiu <gengdongjiu@huawei.com> wrote:
>
> Hi Peter,
>   Thanks for the comments and mail.
>
> >
> > On 22 November 2018 at 10:28, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > On 22 November 2018 at 03:05, gengdongjiu <gengdongjiu@huawei.com> wrote:
> > >>> >
> > >>> Shouldn't there be something in here to say "only report this error to the guest if we are actually reporting RAS errors to the guest" ?
> > >>
> > >> Yes, We can say something that such as "report this error to the guest", because this error is indeed triggered by guest, which is guest
> > error.
> > >
> > > I'm afraid I don't really understand what you mean. Could you try
> > > rephrasing it?
> > >
> > > My understanding was:
> > >  * we get this signal if there is a RAS error in the host memory
> > >  * if we are exposing RAS errors to the guest (ie we have
> > >    told it that in the ACPI table we passed it at startup)
> > >    then we should pass on this error to the guest
> > >
> > > but that these are two different conditions.
> > >
> > > If the host hardware detects a RAS error in memory used by the guest
> > > but the guest is not being told about RAS errors, then we cannot
> > > report the error: we have no mechanism to do so, and the guest is not
> > > expecting it.
> >
> > If you look at the x86 version of this function you can see that it tests (env->mcg_cap & MCG_SER_P), which I think is the equivalent x86 "is
> > the guest CPU/config one we can report these errors to" test.
>
> MCG_SER_P (software error recovery support present) flag indicates (when set) that the processor supports software error recovery.
> env->mcg_cap 's value should be got from KVM as shown in the QEMU code[1], it indicates whether the KVM support software error recovery.
>
> [1]:
> -------------------------------------------------------------------------------------------------------------
>   ret = kvm_get_mce_cap_supported(cs->kvm_state, &mcg_cap, &banks);
>   if (ret < 0) {
>        fprintf(stderr, "kvm_get_mce_cap_supported: %s", strerror(-ret));
>            return ret;
>    }
> -------------------------------------------------------------------------------------------------------------

Yes, but if you look at the code which calls that, it
goes on to do:
        env->mcg_cap &= mcg_cap | MCG_CAP_BANKS_MASK;

which means that if the host kernel does not support this
feature then we will clear those bits in the env->mcg_cap
field, so we do not advertise it to the guest. But we might
be not advertising it to the guest at all, if env->mcg_cap
was 0 before this code was called. That happens if we
are presenting the guest with a guest CPU type which does
not have the feature.

--------------------------------------------------------------------------------------------------------------
> void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> {
>         ...........................
>
>         if (ram_addr != RAM_ADDR_INVALID &&
>             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
>
>   If it got to here, it means the host hardware detects a RAS error in memory used by the guest using above two judgments.
>   Maybe we can test/check whether KVM supports software error recovery in [3]
>

The question is not "does the host CPU / KVM support error
reporting". It is "does the *guest* CPU / system support
error reporting". These are distinct questions which may
not have the same answer.


thanks
-- PMM
