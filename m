Received: from eggs.gnu.org ([2001:4830:134:3::10]:47681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTPTM-0007y1-NP
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cTPTJ-0005Lv-Fs
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:50:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cTPTJ-0005LR-6X
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:50:29 -0500
References: <1484328738-21149-1-git-send-email-ard.biesheuvel@linaro.org>
	<CAFEAcA-s4To6BCgFzUG6Bs_rpeVupatXpHm45b=26QmLJAwy8A@mail.gmail.com>
	<CAKv+Gu-hAzng0ff4=r2JZF5p=nEhhv12-kwg7wz+m7Uj4w42DA@mail.gmail.com>
	<CAFEAcA8n5grNz+z1ZcNcX9Er9s=uXRPgV-b1-3tkrzWEv-=1Uw@mail.gmail.com>
	<CAKv+Gu_+O-_x-CwQdiTf4efWAMue6LdXK3Afo9YW8Xz+6BFyzw@mail.gmail.com>
	<b6362d69-a544-1b78-fc48-1020e5d0efef@redhat.com>
	<CAKv+Gu_2srdbQhK4LjjsdoOkm_S4hkEFVdtUHmcvAnVZCVErbA@mail.gmail.com>
	<5c6571da-34a7-9a23-e229-88883302d4e9@redhat.com>
	<CAKv+Gu_Rap-_gnXqF6cRYS+CUvm2QMzxKWnSRNyJ7-wqJcdNGA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <acc3f75b-5df0-de8c-fbfa-2cf29f728031@redhat.com>
Date: Tue, 17 Jan 2017 09:50:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_Rap-_gnXqF6cRYS+CUvm2QMzxKWnSRNyJ7-wqJcdNGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/virt-acpi - reserve ECAM space
 as PNP0C02 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Andrew Jones <drjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

(my reply is no longer related to the patch, so maybe I shouldn't send
it... I can't resist, sorry :))

On 01/17/17 08:47, Ard Biesheuvel wrote:
> On 16 January 2017 at 22:35, Laszlo Ersek <lersek@redhat.com> wrote:

>> The UEFI memory map will reflect allocations from the GCD memory space,
>> for the Reserved and MMIO types. See "Figure 2. GCD Memory State
>> Transitions" in "7.2.2 GCD Memory Resources", Vol2 of the PI spec.
>>
>> See also "9.7.1 UEFI Boot Services Dependencies" in the same,
>>
>>   9.7.1.8 GetMemoryMap()
>>
>>   The GetMemoryMap() implementation must include into the UEFI memory
>>   map all GCD map entries of types EfiGcdMemoryTypeReserved and
>>   EfiPersistentMemory, and all GCD map entries of type
>>   EfiGcdMemoryTypeMemoryMappedIo that have EFI_MEMORY_RUNTIME attribute
>>   set.
>>
>> (Note that I wrote Reserved earlier, not MMIO.)
>>
> 
> What the PI spec stipulates is irrelevant: the contract between the
> firmware and the OS is in the UEFI and ACPI specifications, not in the
> PI spec.

I disagree that what the PI spec stipulates is irrelevant. For platforms
that implement both PI and UEFI, the PI spec expresses additional
requirements for the UEFI implementation (in PI terminology). So what it
says certainly matters for the ArmVirtQemu firmware specifically.

End-to-end, if we want to achieve a particular result in a UEFI OS, we
can certainly work towards that end in the PEI phase (or in the DXE
phase, using the DXE services) in a specific firmware that aims to
conform to both PI and UEFI. Because, the effects that those low-level
operations will have on the UEFI level (and consequently, on the OS) are
well defined in the PI spec.

> 
>> However, you are right that *just* the UEFI memmap entry is not
>> sufficient, according to the PCI firmware spec. (Regardless of the fact
>> that in practice, just the memmap entry does keep Linux happy. Or is it
>> about to change?)
>>
> 
> The kernel uses the UEFI memory map for two purposes:
> - finding out where memory is, and which parts are usable (i.e., non-reserved)
> - setting up page tables to allow UEFI runtime services calls, which
> may include MMIO mappings
> 
> This means that MMIO regions in the UEFI memory map are *not*
> considered reservations. [...]

Yes, I understand that. Now please understand that my suggestion was
never to cover the MMCONFIG area with MMIO type memory; all along I've
been saying "reserved memory".

(Again, this is now independent of the patch.)

Thanks,
Laszlo
