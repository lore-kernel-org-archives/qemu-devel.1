Received: from eggs.gnu.org ([209.51.188.92]:59615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hB0sT-00081e-6n
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hB0sR-0005dn-VG
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:37:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hB0sP-0005cj-Vq
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:37:43 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <877ecd1vpe.fsf@vitty.brq.redhat.com>
Date: Mon, 1 Apr 2019 20:37:33 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <1EC15A04-F334-40E2-9A43-F477404893CA@oracle.com>
References: <20190401133659.20421-1-vkuznets@redhat.com>
	<DF798996-57F7-405A-93D8-F77244B38553@oracle.com>
	<87a7h91zv3.fsf@vitty.brq.redhat.com>
	<85937523-29B7-4D0B-820A-F28376D4D9F3@oracle.com>
	<877ecd1vpe.fsf@vitty.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ioapic: allow buggy guests mishandling
 level-triggered interrupts to make progress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>



> On 1 Apr 2019, at 20:28, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>=20
> Liran Alon <liran.alon@oracle.com> writes:
>=20
>>> On 1 Apr 2019, at 18:58, Vitaly Kuznetsov <vkuznets@redhat.com> =
wrote:
>>>=20
>>> Liran Alon <liran.alon@oracle.com> writes:
>>>=20
>>>>> On 1 Apr 2019, at 16:36, Vitaly Kuznetsov <vkuznets@redhat.com> =
wrote:
>>>>>=20
>>>>> It was found that Hyper-V 2016 on KVM in some configurations (q35 =
machine +
>>>>> piix4-usb-uhci) hangs on boot. Trace analysis led us to the =
conclusion that
>>>>> it is mishandling level-triggered interrupt performing EOI without =
fixing
>>>>> the root cause.
>>>>=20
>>>> I would rephrase as:
>>>> It was found that Hyper-V 2016 on KVM in some configurations (q35 =
machine + piix4-usb-uhci) hangs on boot.
>>>> Root-cause was that one of Hyper-V level-triggered interrupt =
handler performs EOI before fixing the root-cause.
>>>> This results in IOAPIC keep re-raising the level-triggered =
interrupt
>>>> after EOI because irq-line remains asserted.
>>>=20
>>> Ok, thanks for the suggestion.
>>>=20
>>>>=20
>>>>> This causes immediate re-assertion and L2 VM (which is
>>>>> supposedly expected to fix the cause of the interrupt) is not =
making any
>>>>> progress.
>>>>=20
>>>> I don=E2=80=99t know why you assume this.
>>>> =46rom the trace we have examined, it seems that the EOI is =
performed by Hyper-V and not it=E2=80=99s guest
>>>> This means that the handler for this level-triggered interrupt is =
on
>>>> Hyper-V and not it=E2=80=99s guest.
>>>=20
>>> If you let it run (with e.g. this patch or by setting preemtion =
timer >
>>> 0) you'll see that MMIO write fixing the cause of the interrupt is
>>> happening from L2:
>>>=20
>>> (qemu) info pci:
>>>=20
>>> Bus  0, device   4, function 0:
>>>   USB controller: PCI device 8086:7112
>>>     PCI subsystem 1af4:1100
>>>     IRQ 23.
>>>     BAR4: I/O at 0x6060 [0x607f].
>>>     id ""
>>>=20
>>> ...
>>> 538597.212494: kvm_exit:             reason VMRESUME rip =
0xfffff80004250115 info 0 0
>>> 538597.212499: kvm_entry:            vcpu 0
>>> 538597.212506: kvm_exit:             reason IO_INSTRUCTION rip =
0xfffff80e02ac6a27 info 60620009 0
>>> 538597.212507: kvm_nested_vmexit:    rip fffff80e02ac6a27 reason =
IO_INSTRUCTION info1 60620009 info2 0 int_info 0 int_info_err 0
>>> 538597.212509: kvm_fpu:              unload
>>> 538597.212511: kvm_userspace_exit:   reason KVM_EXIT_IO (2)
>>> 538597.212516: kvm_fpu:              load
>>> 538597.212518: kvm_pio:              pio_read at 0x6062 size 2 count =
1 val 0x1=20
>>> 538597.212519: kvm_entry:            vcpu 0
>>> 538597.212523: kvm_exit:             reason IO_INSTRUCTION rip =
0xfffff80e02ac6a61 info 60640009 0
>>> 538597.212523: kvm_nested_vmexit:    rip fffff80e02ac6a61 reason =
IO_INSTRUCTION info1 60640009 info2 0 int_info 0 int_info_err 0
>>> 538597.212524: kvm_fpu:              unload
>>> 538597.212525: kvm_userspace_exit:   reason KVM_EXIT_IO (2)
>>> 538597.212528: kvm_fpu:              load
>>> 538597.212528: kvm_pio:              pio_read at 0x6064 size 2 count =
1 val 0xf=20
>>> ...
>>>=20
>>> and this happens after EOI from L1.
>>=20
>> I see that the L2 guest is doing I/O read to the device BAR4 but do =
these reads lower the irq-line?
>> I would expect a write to lower the irq-line.
>>=20
>> Looking at uhci_port_read(), it seems that offset 0x02 and 0x04 just =
return a value. Doesn=E2=80=99t lower irq-line.
>> (Even though offset 0x04 returns the "interrupt enable register=E2=80=9D=
).
>> In contrast, looking at uhci_port_write(), it seems that writing to =
either offset 0x02 or 0x04 could lower the irq-line.
>> So you should look for pio_write to port 0x6062 or 0x6064 to see who
>> is actually responsible for lowering the irq-line.
>=20
> Sorry, I probably like trimming traces too much. Writes happen too:
>=20
> [005] 538597.212532: kvm_exit:             reason IO_INSTRUCTION rip =
0xfffff80e02ac6a8f info 60620001 0
> [005] 538597.212533: kvm_nested_vmexit:    rip fffff80e02ac6a8f reason =
IO_INSTRUCTION info1 60620001 info2 0 int_info 0 int_info_err 0
> [005] 538597.212534: kvm_pio:              pio_write at 0x6062 size 2 =
count 1 val 0x1=20

This clears bit UHCI_STS_USBINT from =E2=80=9Cstatus=E2=80=9D register =
and zero =E2=80=9Cstatus2=E2=80=9D register.

> [005] 538597.212534: kvm_fpu:              unload
> [005] 538597.212535: kvm_userspace_exit:   reason KVM_EXIT_IO (2)
> [005] 538597.212543: kvm_fpu:              load
> [005] 538597.212544: kvm_entry:            vcpu 0
> [005] 538597.212547: kvm_exit:             reason IO_INSTRUCTION rip =
0xfffff80e02ac6a9c info 60640001 0
> [005] 538597.212548: kvm_nested_vmexit:    rip fffff80e02ac6a9c reason =
IO_INSTRUCTION info1 60640001 info2 0 int_info 0 int_info_err 0
> [005] 538597.212548: kvm_pio:              pio_write at 0x6064 size 2 =
count 1 val 0x0=20

This sets 0 in the =E2=80=9Cintr=E2=80=9D register (Interrupt enable =
register).
At this point it is indeed likely that uhci_update_irq() will lower the =
irq-line. I agree. :)

> [005] 538597.212549: kvm_fpu:              unload
> [005] 538597.212550: kvm_userspace_exit:   reason KVM_EXIT_IO (2)
>=20
> and this likely lowers the line.

OK I was convinced that L2 does the irq-line lowering.

> I honestly have no idea how this all
> works on real hw but the comment in kernel ioapic says something about
> non-immediate delivery of the reasserted interrupt. True or not, this
> gives me some peace of mind :-)

Yeah I know.
It=E2=80=99s just weird that this non-immediate delivery translates to =
=E2=80=9Cthat you can even resume into VMX non-root-mode and run a bunch =
of logic that lower irq-line=E2=80=9D before interrupt is re-raised.
That=E2=80=99s kinda crazy :)

It=E2=80=99s more likely that this also reproduce on real hardware and =
that Microsoft maybe haven=E2=80=99t checked with this hardware?
Anyway, we are on the same page here. :)

-Liran

>=20
> --=20
> Vitaly
