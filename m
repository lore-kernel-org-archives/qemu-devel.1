Received: from eggs.gnu.org ([2001:4830:134:3::10]:59226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euIzn-0001oi-D0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euIzj-0007Y1-DA
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:27:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58364 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1euIzi-0007Xa-RT
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:27:38 -0500
Date: Fri, 9 Mar 2018 15:27:37 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180309142737.2qlsf6hhyayenmjl@sirius.home.kraxel.org>
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<90ba320e-2a05-8962-dc6b-252b3e15d1b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ba320e-2a05-8962-dc6b-252b3e15d1b7@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

  Hi,

> For OVMF (x86), I guess the initial set of properties should come from
> the "-D FOO[=BAR]" build flags that OVMF currently supports. (The list
> might grow or change incompatibly over time, so this is just a raw
> starter idea.)

> (0) ARCH (one of IA32, IA32X64, X64) -- the bitnesses of the PEI and DXE
> phases of the firmware.
> 
> IA32 stands for "32-bit PEI and DXE". Such firmware is usable for
> booting 32-bit OSes only, and runs on both qemu-system-i386 and
> qemu-system-x86_64.
> 
> IA32X64 stands for "32-bit PEI, 64-bit DXE". Needs qemu-system-x86_64
> and runs 64-bit OSes only.
> 
> X64 stands for "64-bit PEI and DXE". Needs qemu-system-x86_64 and runs
> 64-bit OSes only.

I'd simply put that info the 'arch' bucket.  IA32 gets 'i386' (assuming
we simply use qemu target names), IA32X64 + X64 get 'x86_64'.

> (1) SECURE_BOOT_ENABLE (boolean) -- whether the Secure Boot UEFI feature
> is built into the firmware image.

Probably useful for upper management (above libvirt), for enabling
secure boot key enrollment etc. in the UI.

> (2) SMM_REQUIRE (boolean) -- whether the SMM driver stack is included in
> the firmware.

Needed (libvirt must enable smm).

> (3) HTTP_BOOT_ENABLE (boolean) -- whether UEFI HTTP boot is available in
> the firmware image, in addition to the default PXE boot.

> (4) TLS_ENABLE (boolean) -- configurable independently of
> HTTP_BOOT_ENABLE, but only really makes sense in combination.

> (5) NETWORK_IP6_ENABLE (boolean) -- determines whether IPv6 support is
> available.

Do we actually need formal flags for these?  Which application would
use them?

For humans this can go into the freeform "description" text field.

> (6) FD_SIZE_IN_KB (one of: 1024, 2048, 4096) -- the size of the combined
> firmware image (executable portion and variable store together), in KB.

Hmm, dunno.  Might be useful as varstores are not portable between
builds of different sizes, so libvirt could use this for sanity checks.

> (7) DEBUG_ON_SERIAL_PORT (boolean) -- whether OVMF sends its debug
> messages to the QEMU debug IO port, or to the serial port.

> (8) SOURCE_DEBUG_ENABLE (boolean) -- whether OVMF includes the edk2
> debug agent that allows it to be debugged from a proprietary debugger
> program, likely connected via the emulated serial port.

> (9) CSM_ENABLE (boolean) -- whether OVMF includes traditional BIOS
> support, by including the SeaBIOS Compatibility Support Module.

Same question as for 3+4+5: Do we really need those?

> Given that the SeaBIOS CSM itself can be built with various
> configurations, it might make sense to list further properties when this
> property is enabled.

I doubt this is useful, established practice is that people just use
seabios directly instead if using the ovmf+csm combo.

> (10) E1000_ENABLE (boolean) -- whether OVMF includes the
> non-redistributable, binary only E1000(E) UEFI driver module from Intel
> (previously known as "PROEFI", more recently known as "BootUtil").

> (11) USE_OLD_SHELL (boolean) -- whether the UEFI shell implementation
> built into OVMF is the old (EDK1 / EFI-1 style) shell which lives in a
> separate repository, or the new (EDK2 / UEFI-2 style) shell which lives
> within the edk2 project.

> (12) TOOLCHAIN (string): the edk2 toolchain identifier with which the
> firmware was built.

> (13) TARGET (one of NOOPT, DEBUG, RELEASE) -- the target for which the
> firmware image was built.

Same question as for 3+4+5+7+8+9: Do we really need those?

> For ArmVirt, we have:
> 
> (12) ARCH (one of ARM and AARCH64) -- 32-bit / 64-bit distinction.

Likewise just use arch.

> (17) Well, what do I call this, let's call it ENTRY_POINT (one of Qemu,
> QemuKernel, Xen).
> 
> This distinguishes what VMM the ArmVirt firmware was built for, and for
> QEMU, it also distinguishes "boot from flash" (Qemu) or "boot as payload
> for another, earlier boot firmware" (QemuKernel).

Hmm, that looks simliar to u-boot, which I think can also be build as
both flash image and kernel image (loadable via -kernel).  So I guess we
want that one, as how-to-load-this-blob option (-bios vs -pflash vs -kernel).

cheers,
  Gerd
