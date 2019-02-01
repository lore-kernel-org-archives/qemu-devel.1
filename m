Received: from eggs.gnu.org ([209.51.188.92]:46008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpUeL-00049s-NK
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 03:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpUeK-0003Y3-SI
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 03:58:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<87o97yi67d.fsf@dusky.pond.sub.org>
	<300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
	<87d0oddxu2.fsf@dusky.pond.sub.org>
	<f4528a7d-4bb5-f607-760e-72db3eaa34ad@redhat.com>
	<877eelcgf9.fsf@dusky.pond.sub.org>
	<9c4e222f-3941-426e-3195-5598b2af1501@redhat.com>
	<87munh9gb6.fsf@dusky.pond.sub.org>
	<cb465eba-8c54-af8e-fe0e-ce90f71d213a@redhat.com>
Date: Fri, 01 Feb 2019 09:58:03 +0100
In-Reply-To: <cb465eba-8c54-af8e-fe0e-ce90f71d213a@redhat.com> (Paolo
	Bonzini's message of "Thu, 31 Jan 2019 23:57:14 +0100")
Message-ID: <87va23j36s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Krempa <pkrempa@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alexandro Sanchez Bach <alexandro@phi.nz>, "Justin Terry (VM)" <juterry@microsoft.com>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 31/01/19 13:12, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 31/01/19 10:41, Markus Armbruster wrote:
>>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>>
>>>>> On 31/01/19 09:40, Markus Armbruster wrote:
>>>>>>> Maybe we should just add pflash block properties to the machine?  And
>>>>>>> then it can create the devices if the properties are set to a non-empty
>>>>>>> value.
>>>>>> What exactly do you have in mind?  Something like
>>>>>>
>>>>>>     -machine q35,ovmf-code=OVMF-CODE-NODE,ovmf-data=OVMF-DATA-NODE
>>>>>>
>>>>>> where OVMF-CODE-NODE and OVMF-DATA-NODE are block backend node names,
>>>>>> i.e.
>>>>>>
>>>>>>     -blockdev file,node-name=OVMF-CODE-NODE,read-only=on,filename=/usr/share/edk2/ovmf/OVMF_CODE.fd
>>>>>>     -blockdev file,node-name=OVMF-DATA-NODE,read-only=on,filename=...
>>>>>
>>>>> Yes, though I would call it pflash0 and pflash1.
>>>>
>>>> Digression... should we put traditional BIOS in flash as well?  Only for
>>>> new machine types, obviously.
>>>
>>> The blocker was that very old KVM didn't support ROMD memory regions.
>>> Now on one hand we don't support those old kernel versions anymore; on
>>> the other hand we have HAX and WHPX that do not support ROMD at all.
>> 
>> This is all greek to me.  I take it there's something wrong with these
>> accelerators that makes (read-only?) flash memory not work, even though
>> the read-only mapping we now create for traditional BIOS works.  Weird,
>> but I'm of course willing to take your word for it.
>
> Yes, as I wrote in the other message even read-only flash memory
> supports commands, and these accelerators do not support direct reads +
> MMIO writes on the same memory slot.

Got it, thanks.

> At least I checked HAX code and it doesn't; I don't know about WHPX.
>
>> Aside: accepting incomplete accelerators, then letting their
>> incompleteness hold back things doesn't strike me as sound policy.
>
> Yes, there is a balance to be found between that and accepting features
> from known out-of-tree forks, in order to help these out-of-tree forks
> not remain forever on very old releases.

I support inviting forks back into the fold, and I understand why
"feature parity or go away" would be impractical there.  But I'd like to
see at least *commitment* to reaching feature parity.

> However, another important question is---if you changed the default from
> -bios to -pflash, would you also flip secure from off to on?  Only TCG
> and KVM supports SMM, and it's quite unlikely that the other
> accelerators will support it (there are also "philosophical" debates
> behind that choice...).

I would not, simply because secure has always been off by default.

>> Do we reject these accelerators when the user asks for firmware in
>> flash?  Or do we let the guest run into some more or less obscure
>> failure?
>
> For HAX it just fails to boot I think.

I'd call that a user interface bug.
