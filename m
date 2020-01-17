Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FBDC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC302082F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC302082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isOVm-0007KR-0k
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 05:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1isOV2-0006kI-5x
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1isOUy-0003oM-Ks
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:05:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2741 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1isOUr-0003bn-38; Fri, 17 Jan 2020 05:04:57 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EFDA36E91CCDC5E96B4D;
 Fri, 17 Jan 2020 18:04:49 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 17 Jan 2020
 18:04:42 +0800
Subject: Re: [PATCH v22 8/9] target-arm: kvm64: handle SIGBUS signal from
 kernel or KVM
To: Peter Maydell <peter.maydell@linaro.org>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-9-git-send-email-gengdongjiu@huawei.com>
 <CAFEAcA_=PgkrWjwPxD89fCi85XPpcTHssXkSmE04Ctoj7AX0kA@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <c89db331-cb94-8e0b-edf8-25bfb64f826d@huawei.com>
Date: Fri, 17 Jan 2020 18:04:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_=PgkrWjwPxD89fCi85XPpcTHssXkSmE04Ctoj7AX0kA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU
 Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng Xiang <zhengxiang9@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/1/17 0:28, Peter Maydell wrote:
> On Wed, 8 Jan 2020 at 11:33, Dongjiu Geng <gengdongjiu@huawei.com> wrot=
e:
>=20
>> +void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>> +{
>> +    ram_addr_t ram_addr;
>> +    hwaddr paddr;
>> +
>> +    assert(code =3D=3D BUS_MCEERR_AR || code =3D=3D BUS_MCEERR_AO);
>> +
>> +    if (acpi_enabled && addr &&
>> +            object_property_get_bool(qdev_get_machine(), "ras", NULL)=
) {
>> +        ram_addr =3D qemu_ram_addr_from_host(addr);
>> +        if (ram_addr !=3D RAM_ADDR_INVALID &&
>> +            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &p=
addr)) {
>> +            kvm_hwpoison_page_add(ram_addr);
>> +            /*
>> +             * Asynchronous signal will be masked by main thread, so
>> +             * only handle synchronous signal.
>> +             */
>=20
> I don't understand this comment. (I think we've had discussions
> about it before, but it's still not clear to me.)
>=20
> This function (kvm_arch_on_sigbus_vcpu()) will be called in two context=
s:
>=20
> (1) in the vcpu thread:
>   * the real SIGBUS handler sigbus_handler() sets a flag and arranges
>     for an immediate vcpu exit
>   * the vcpu thread reads the flag on exit from KVM_RUN and
>     calls kvm_arch_on_sigbus_vcpu() directly
>   * the error could be MCEERR_AR or MCEERR_AOFor the vcpu thread, the e=
rror can be MCEERR_AR or MCEERR_AO,
but kernel/KVM usually uses MCEERR_AR(action required) instead of MCEERR_=
AO, because it needs do action immediately. For MCEERR_AO error, the acti=
on is optional and the error can be ignored.
At least I do not find Linux kernel/KVM deliver MCEERR_AO in the vcpu thr=
eads.

> (2) MCE errors on other threads:
>   * here SIGBUS is blocked, so MCEERR_AR (action-required)
>     errors will cause the kernel to just kill the QEMU process
>   * MCEERR_AO errors will be handled via the iothread's use
>     of signalfd(), so kvm_on_sigbus() will get called from
>     the main thread, and it will call kvm_arch_on_sigbus_vcpu()
>   * in this case the passed in CPUState will (arbitrarily) be that
>     for the first vCPU

For the MCE errors on other threads, it can only handle MCEERR_AO. If it =
is MCEERR_AR, the QEMU will assert and exit[2].

Case1: Other APP indeed can send MCEERR_AO to QEMU=EF=BC=8C QEMU handle i=
t via the iothread's use of signalfd() through above path.
Case2: But if the MCEERR_AO is delivered by kernel, I see QEMU ignore it =
because SIGBUS is masked in main thread[3], for this case, I do not see Q=
EMU handle it via signalfd() for MCEERR_AO errors from my test.

For Case1=EF=BC=8CI think we should not let guest know it, because it is =
not triggered by guest. only other APP send SIGBUS to tell QEMU do someth=
ings.
For Case2=EF=BC=8Cit does not call call kvm_arch_on_sigbus_vcpu().


[1]:
/* Called synchronously (via signalfd) in main thread.  */
int kvm_on_sigbus(int code, void *addr)
{
#ifdef KVM_HAVE_MCE_INJECTION
    /* Action required MCE kills the process if SIGBUS is blocked.  Becau=
se
     * that's what happens in the I/O thread, where we handle MCE via sig=
nalfd,
     * we can only get action optional here.
     */
[2]: assert(code !=3D BUS_MCEERR_AR);
    kvm_arch_on_sigbus_vcpu(first_cpu, code, addr);
    return 0;
#else
    return 1;
#endif
}

[3]: https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03575.html


>=20
> For MCEERR_AR, the code here looks correct -- we know this is
> only going to happen for the relevant vCPU so we can go ahead
> and do the "record it in the ACPI table and tell the guest" bit.
>=20
> But shouldn't we be doing something with the MCEERR_AO too?

Above all, from my test, for MCEERR_AO error which is triggered by guest,=
 it not call kvm_arch_on_sigbus_vcpu().
so I think currently we can just report error. If afterwards  MCEERR_AO e=
rror can call kvm_arch_on_sigbus_vcpu(), we can let the guest know about =
it.

> That of course will be trickier because we're not necessarily
> in the vcpu thread, but it would be nice to let the guest
> know about it.
>=20
> One comment that would work with the current code would be:
>=20
> /*
>  * If this is a BUS_MCEERR_AR, we know we have been called
>  * synchronously from the vCPU thread, so we can easily
>  * synchronize the state and inject an error.
>  *
>  * TODO: we currently don't tell the guest at all about BUS_MCEERR_AO.
>  * In that case we might either be being called synchronously from
>  * the vCPU thread, or a bit later from the main thread, so doing
At least I do not find Linux kernel/KVM deliver MCEERR_AO in the vcpu thr=
eads.
In the main thread, signalfd() is not called when it is BUS_MCEERR_AO whi=
ch is triggered by guest.

>  * the injection of the error would be more complicated.
>  */
>=20
> but I don't know if that's what you meant to say/implement...
we can implement MCEERR_AO logic when QEMU can receive MCEERR_AO error wh=
ich is triggered by guest.

>=20
>> +            if (code =3D=3D BUS_MCEERR_AR) {
>> +                kvm_cpu_synchronize_state(c);
>> +                if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, pa=
ddr)) {
>> +                    kvm_inject_arm_sea(c);
>> +                } else {
>> +                    error_report("failed to record the error");
>> +                    abort();
>> +                }
>> +            }
>> +            return;
>> +        }
>> +        if (code =3D=3D BUS_MCEERR_AO) {
>> +            error_report("Hardware memory error at addr %p for memory=
 used by "
>> +                "QEMU itself instead of guest system!", addr);
>> +        }
>> +    }
>> +
>> +    if (code =3D=3D BUS_MCEERR_AR) {
>> +        error_report("Hardware memory error!");
>> +        exit(1);
>> +    }
>> +}
>>
>=20
> thanks
> -- PMM
> .
>=20


