Received: from eggs.gnu.org ([2001:4830:134:3::10]:35911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfOtk-0000F0-VB
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 07:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfOtj-00021o-Mk
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 07:11:36 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dfOtj-000219-De
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 07:11:35 -0400
Received: by mail-wm0-x22b.google.com with SMTP id m85so28248546wma.1
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 04:11:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c03faf70-9bad-aea7-00ed-8825e8770d03@redhat.com>
References: <743158bc-15e4-46fe-38cb-161397b5b240@linaro.org>
	<3685aed3-735f-ae62-73a9-8f4a5c7cd459@redhat.com>
	<9be585e2-4641-329e-f442-69ae05faadba@redhat.com>
	<ea6acc7c-09a6-70ed-9ff0-865bd45a47f3@redhat.com>
	<24fa9f25-912e-8903-920e-b28feba492d2@redhat.com>
	<0f748b72-69de-1122-767d-b36dadad46fc@redhat.com>
	<c03faf70-9bad-aea7-00ed-8825e8770d03@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Aug 2017 12:11:11 +0100
Message-ID: <CAFEAcA_7hhP-w3HzFSwdABgK00sgJfbC0nSJQfU9m3BjRKcc1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Qemu and 32 PCIe devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Drew Jones <drjones@redhat.com>, Christoffer Dall <cdall@linaro.org>, Gema Gomez-Solano <gema.gomez-solano@linaro.org>, Marc Zygnier <marc.zyngier@arm.com>

On 9 August 2017 at 11:56, Laszlo Ersek <lersek@redhat.com> wrote:
> Now that I look at the "info mtree" monitor output of a random VM, I see
> the following "address-space"s:
> - memory
> - I/O
> - cpu-memory
> - bunch of nameless ones, with top level regions called
>   "bus master container"
> - several named "virtio-pci-cfg-as"
> - KVM-SMRAM
>
> I (sort of) understand MemoryRegions and aliases, but:
> - I don't know why "memory" and "cpu-memory" exist separately, for example,

"memory" is the "system address space", ie the default overall
view of memory where most devices appear and which gets
used by DMA'ing devices that don't have a proper model of
what their view of the world should be.
"cpu-memory" is specifically the view of the world that
the CPU has. Per-CPU memory mapped devices and devices
that are visible to the CPU but not to random DMA'ing
things can appear here (and not in the 'memory' address space).

Generally "cpu-memory" will be created effectively as
"memory" plus some other stuff.

Some CPU architectures have more than one address space
per CPU -- notably ARM TrustZone-supporting  CPUs
have "cpu-memory" for the NonSecure view and "cpu-secure-memory"
for the Secure view.

The overall aim here is to better model the real world,
where different memory transaction masters can sit on
different buses or in different places in the bus fabric,
and thus have access to different things. Anything that
is a bus master should ideally have its own AddressSpace,
because for QEMU an AddressSpace is the endpoint that
you use to initiate memory transactions. MemoryRegions
on the other hand are what you use for building up the
hierarchy of devices sitting on buses and so on, so
when you're setting up the simulation you pass a device
which is a bus master a MemoryRegion defining "this is
the world you can see", and the device creates an
AddressSpace from it in order to be able to interact
with it.

(We have address_space_init_shareable() to reduce the
proliferation of theoretically distinct but in
practice identical AddressSpaces.)

Similarly, I'm not familiar with the PCI code, but
conceptually each PCI device is a bus master and wants
an AddressSpace to do transactions into.

thanks
-- PMM
