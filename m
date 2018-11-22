Received: from eggs.gnu.org ([2001:4830:134:3::10]:40040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPmFr-0007MH-V9
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gPmEX-0000TP-RS
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:29:18 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gPmEX-0000TA-Lw
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:29:17 -0500
Received: by mail-ot1-x342.google.com with SMTP id w25so7614140otm.13
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 02:29:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F201F7D7EB@DGGEMA503-MBX.china.huawei.com>
References: <1541672989-15967-1-git-send-email-gengdongjiu@huawei.com>
	<1541672989-15967-11-git-send-email-gengdongjiu@huawei.com>
	<CAFEAcA-6UKk-WF+M+z0=AN-X7q0XRFLo2RG_yBadDeCas4A5wQ@mail.gmail.com>
	<0184EA26B2509940AA629AE1405DD7F201F7D7EB@DGGEMA503-MBX.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Nov 2018 10:28:56 +0000
Message-ID: <CAFEAcA_P9d=hOH6sAfdqdBEAwF_am6+Qq9XgAafxbzGfWLEhHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel]
	=?utf-8?b?562U5aSNOiBbUEFUQ0ggUkVTRU5EIHYxNSAxMC8x?=
	=?utf-8?q?0=5D_target-arm=3A_kvm64=3A_handle_SIGBUS_signal_from_ke?=
	=?utf-8?q?rnel_or_KVM?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, "zhengxiang (A)" <zhengxiang9@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 22 November 2018 at 03:05, gengdongjiu <gengdongjiu@huawei.com> wrote:
>> >
>> > +void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr) {
>> > +    ram_addr_t ram_addr;
>> > +    hwaddr paddr;
>> > +
>> > +    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>> > +    if (addr) {
>> > +        ram_addr = qemu_ram_addr_from_host(addr);
>> > +        if (ram_addr != RAM_ADDR_INVALID &&
>> > +            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
>> > +            kvm_hwpoison_page_add(ram_addr);
>> > +            if (code == BUS_MCEERR_AR) {
>> > +                kvm_cpu_synchronize_state(c);
>> > +                if (ghes_record_errors(ACPI_HEST_NOTIFY_SEA, paddr)) {
>> > +                    kvm_inject_arm_sea(c);
>> > +                } else {
>> > +                    fprintf(stderr, "failed to record the error\n");
>> > +                }
>>
>> Shouldn't there be something in here to say "only report this error to the guest if we are actually reporting RAS errors to the guest" ?
>
> Yes, We can say something that such as "report this error to the guest", because this error is indeed triggered by guest, which is guest error.

I'm afraid I don't really understand what you mean. Could you
try rephrasing it?

My understanding was:
 * we get this signal if there is a RAS error in the host memory
 * if we are exposing RAS errors to the guest (ie we have
   told it that in the ACPI table we passed it at startup)
   then we should pass on this error to the guest

but that these are two different conditions.

If the host hardware detects a RAS error in memory used
by the guest but the guest is not being told about RAS
errors, then we cannot report the error: we have no mechanism
to do so, and the guest is not expecting it.

thanks
-- PMM
