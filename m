Received: from eggs.gnu.org ([2001:4830:134:3::10]:36006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cdall@linaro.org>) id 1ctHdr-0006kV-B1
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cdall@linaro.org>) id 1ctHdo-00032w-6X
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:44:19 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cdall@linaro.org>) id 1ctHdn-00032V-SJ
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:44:16 -0400
Received: by mail-wr0-x234.google.com with SMTP id w11so24716860wrc.3
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 10:44:15 -0700 (PDT)
Date: Wed, 29 Mar 2017 19:44:12 +0200
From: Christoffer Dall <cdall@linaro.org>
Message-ID: <20170329174412.GA4472@cbox>
References: <58DA3F68.6090901@arm.com> <20170328112328.GA31156@cbox>
	<20170328115413.GJ23682@e104320-lin>
	<b1c6e747-2fa7-b7a1-60d5-4a9c480b9dc9@huawei.com>
	<58DA67BA.8070404@arm.com>
	<5b7352f4-4965-3ed5-3879-db871797be47@huawei.com>
	<20170329103658.GQ23682@e104320-lin>
	<CAMj-D2BT3ByY-iFrRVVK7y=G7zhRBtM031VgLn6JzwUE-WCdWQ@mail.gmail.com>
	<20170329144822.GA1020@cbox>
	<fa712d47-4f77-7710-c4f7-cd7eab9fed9e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa712d47-4f77-7710-c4f7-cd7eab9fed9e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] kvm: pass the virtual SEI syndrome to
 guest OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: gengdongjiu <gengdj.1984@gmail.com>, Achin Gupta <achin.gupta@arm.com>, gengdongjiu <gengdongjiu@huawei.com>, ard.biesheuvel@linaro.org, edk2-devel@lists.01.org, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, James Morse <james.morse@arm.com>, xiexiuqi@huawei.com, Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, christoffer.dall@linaro.org, rkrcmar@redhat.com, suzuki.poulose@arm.com, andre.przywara@arm.com, mark.rutland@arm.com, vladimir.murzin@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, wangxiongfeng2@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com, Leif.Lindholm@linaro.comnd@arm.com

On Wed, Mar 29, 2017 at 05:37:49PM +0200, Laszlo Ersek wrote:
> On 03/29/17 16:48, Christoffer Dall wrote:
> > On Wed, Mar 29, 2017 at 10:36:51PM +0800, gengdongjiu wrote:
> >> 2017-03-29 18:36 GMT+08:00, Achin Gupta <achin.gupta@arm.com>:
> 
> >>> Qemu is essentially fulfilling the role of secure firmware at the
> >>> EL2/EL1 interface (as discussed with Christoffer below). So it
> >>> should generate the CPER before injecting the error.
> >>>
> >>> This is corresponds to (1) above apart from notifying UEFI (I am
> >>> assuming you mean guest UEFI). At this time, the guest OS already
> >>> knows where to pick up the CPER from through the HEST. Qemu has
> >>> to create the CPER and populate its address at the address
> >>> exported in the HEST. Guest UEFI should not be involved in this 
> >>> flow. Its job was to create the HEST at boot and that has been
> >>> done by this stage.
> >>
> >> Sorry,  As I understand it, after Qemu generate the CPER table, it
> >> should pass the CPER table to the guest UEFI, then Guest UEFI  place
> >> this CPER table to the guest OS memory. In this flow, the Guest UEFI
> >> should be involved, else the Guest OS can not see the CPER table.
> >>
> > 
> > I think you need to explain the "pass the CPER table to the guest UEFI"
> > concept in terms of what really happens, step by step, and when you say
> > "then Guest UEFI place the CPER table to the guest OS memory", I'm
> > curious who is running what code on the hardware when doing that.
> 
> I strongly suggest to keep the guest firmware's runtime involvement to
> zero. Two reasons:
> 
> (1) As you explained above (... which I conveniently snipped), when you
> inject an interrupt to the guest, the handler registered for that
> interrupt will come from the guest kernel.
> 
> The only exception to this is when the platform provides a type of
> interrupt whose handler can be registered and then locked down by the
> firmware. On x86, this is the SMI.
> 
> In practice though,
> - in OVMF (x86), we only do synchronous (software-initiated) SMIs (for
> privileged UEFI varstore access),
> - and in ArmVirtQemu (ARM / aarch64), none of the management mode stuff
> exists at all.
> 
> I understand that the Platform Init 1.5 (or 1.6?) spec abstracted away
> the MM (management mode) protocols from Intel SMM, but at this point
> there is zero code in ArmVirtQemu for that. (And I'm unsure how much of
> any eligible underlying hw emulation exists in QEMU.)
> 
> So you can't get the guest firmware to react to the injected interrupt
> without the guest OS coming between first.
> 
> (2) Achin's description matches really-really closely what is possible,
> and what should be done with QEMU, ArmVirtQemu, and the guest kernel.
> 
> In any solution for this feature, the firmware has to reserve some
> memory from the OS at boot. The current facilities we have enable this.
> As I described previously, the ACPI linker/loader actions can be mapped
> more or less 1:1 to Achin's design. From a practical perspective, you
> really want to keep the guest firmware as dumb as possible (meaning: as
> generic as possible), and keep the ACPI specifics to the QEMU and the
> guest kernel sides.
> 
> The error serialization actions -- the co-operation between guest kernel
> and QEMU on the special memory areas -- that were mentioned earlier by
> Michael and Punit look like a complication. But, IMO, they don't differ
> from any other device emulation -- DMA actions in particular -- that
> QEMU already does. Device models are what QEMU *does*. Read the command
> block that the guest driver placed in guest memory, parse it, sanity
> check it, verify it, execute it, write back the status code, inject an
> interrupt (and/or let any polling guest driver notice it "soon after" --
> use barriers as necessary).
> 
> Thus, I suggest to rely on the generic ACPI linker/loader interface
> (between QEMU and guest firmware) *only* to make the firmware lay out
> stuff (= reserve buffers, set up pointers, install QEMU's ACPI tables)
> *at boot*. Then, at runtime, let the guest kernel and QEMU (the "device
> model") talk to each other directly. Keep runtime firmware involvement
> to zero.
> 
> You *really* don't want to debug three components at runtime, when you
> can solve the thing with two. (Two components whose build systems won't
> drive you mad, I should add.)
> 
> IMO, Achin's design nailed it. We can do that.
> 
I completely agree.

My questions were intended for gengdongjiu to clarify his/her position
and clear up any misunderstandings between what Achin suggested and what
he/she wrote.

Thanks,
-Christoffer
