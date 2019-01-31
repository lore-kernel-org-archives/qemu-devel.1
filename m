Received: from eggs.gnu.org ([209.51.188.92]:49202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gp7tl-0007NP-Q4
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:40:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gp7tl-0003YD-0R
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 03:40:37 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<87o97yi67d.fsf@dusky.pond.sub.org>
	<300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
Date: Thu, 31 Jan 2019 09:40:21 +0100
In-Reply-To: <300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com> (Paolo
	Bonzini's message of "Wed, 30 Jan 2019 15:33:58 +0100")
Message-ID: <87d0oddxu2.fsf@dusky.pond.sub.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/01/19 15:13, Markus Armbruster wrote:
>>     -global driver=cfi.pflash01,property=secure,value=on
>> 
>> Affects *all* such devices, but fortunately we have at most two, and the
>> one we don't want to affect happens to ignore the property value.
>
> Is this true?  I think both need secure=on, at least on x86.
>
>> For libvirt, plumbing the base address from the firmware's descriptor to
>> QEMU would be the lesser mess (for the firmware, providing the base
>> address there would be no mess at all).
>> 
>> For human users, it's perhaps the greater mess.  They can continue to
>> use -drive if=pflash.
>> 
>> Perhaps we *should* redo board configuration from the ground up.
>> Perhaps a board should be a composite object that exposes properties of
>> its own and its part, just like other composite devices, and so that
>> "create, set properties, realize" works.  That would extend our common
>> device configuration mechanism naturally to onboard devices.
>> 
>> Of course, "we should" doesn't imply "I could".
>
> Maybe we should just add pflash block properties to the machine?  And
> then it can create the devices if the properties are set to a non-empty
> value.

What exactly do you have in mind?  Something like

    -machine q35,ovmf-code=OVMF-CODE-NODE,ovmf-data=OVMF-DATA-NODE

where OVMF-CODE-NODE and OVMF-DATA-NODE are block backend node names,
i.e.

    -blockdev file,node-name=OVMF-CODE-NODE,read-only=on,filename=/usr/share/edk2/ovmf/OVMF_CODE.fd
    -blockdev file,node-name=OVMF-DATA-NODE,read-only=on,filename=...

perhaps?

[...]
