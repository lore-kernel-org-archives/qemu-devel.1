Received: from eggs.gnu.org ([209.51.188.92]:45289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3L30-0005BZ-Ri
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h3L2y-0002R0-Sv
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:32:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h3L2y-0002Pm-JR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:32:52 -0400
References: <20190308211557.22589-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <11181bec-9285-c79a-eb38-e12ac8df9aac@redhat.com>
Date: Mon, 11 Mar 2019 14:32:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190308211557.22589-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] docs/booting.rst: start documenting
 the boot process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, rth@twiddle.net, f4bug@amsat.org, shannon.zhaosl@gmail.com, hpoussin@reactos.org, david@gibson.dropbear.id.au, mark.cave-ayland@ilande.co.uk, borntraeger@de.ibm.com, thuth@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, ehabkost@redhat.com, armbru@redhat.com, agraf@suse.de

On 08/03/19 22:15, Alex Benn=C3=A9e wrote:
> While working on some test cases I realised there was quite a lot of
> assumed knowledge about how things boot up. I thought it would be
> worth gathering this together in a user facing document where we could
> pour in the details and background to the boot process. As it's quite
> wordy I thought it should be a separate document to the manual (which
> can obviously reference this). So far I've managed almost a thousand
> words and haven't actually related anything to QEMU's options yet.

This might be more blog material, but it's certainly good stuff!

Paolo

> So going forward:
>=20
>   - is this a useful document to have in docs?
>   - are there any other areas to mention?
>     - out auto-magic -bios selection seems like something worth coverin=
g
>   - should we have some worked examples of command lines?
>     - I was thinking for example of read-only and pflash examples
>   - we should also describe why direct kernel boots exits
>     - and also the fact they are not that direct (some code executes
>       before a kernel - even if it's less than a full firmware)
>=20
> Submitted for comment....
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/booting.rst | 127 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 docs/booting.rst
>=20
> diff --git a/docs/booting.rst b/docs/booting.rst
> new file mode 100644
> index 0000000000..a8a644ff9a
> --- /dev/null
> +++ b/docs/booting.rst
> @@ -0,0 +1,127 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Anatomy of a Boot, a QEMU perspective
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document attempts to give an overview of how machines boot-up and
> +how this matters to QEMU. We will discuss firmware and BIOSes and the
> +things they do before the OS kernel is loaded and your usable system
> +is finally ready.
> +
> +Firmware
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +When a CPU is powered up it knows nothing about it's environment. It's
> +internal state, including the program counter (PC), will be reset to a
> +defined set of values and it will attempt to fetch it's first
> +instruction and execute it. It is the job of the firmware to bring a
> +CPU up from it's first few instructions to running in a relatively
> +sane execution environment. Firmware tends to be specific to the
> +hardware in question and is stored on non-volatile memory (memory that
> +survives a power off) usually a ROM or flash device on the computers
> +main board.
> +
> +Some examples of what firmware does include:
> +
> +Early Hardware Setup
> +--------------------
> +
> +Modern hardware often requires configuring before it is usable. For
> +example most modern systems won't have working RAM until the memory
> +controller has been programmed with the correct timings for whatever
> +memory is installed on the system. Processors may boot with a very
> +restricted view of the memory map until RAM and other key peripherals
> +have been configured to appear in it's address space. Some hardware
> +may not even appear until some sort of blob has been loaded into it so
> +it can start responding to the CPU.
> +
> +Fortunately for QEMU we don't have to worry too much about this very
> +low level configuration. The device model we present to the CPU at
> +start-up will generally respond to IO access from processor straight
> +away.
> +
> +BIOS or Firmware Services
> +-------------------------
> +
> +In the early days of the PC era the BIOS or Basic Input/Output System
> +provided an abstraction interface to the operating system which
> +allowed them to do basic IO operations without having to directly
> +drive the hardware. Since then the scope of these firmware services
> +have grown as systems become more and more complex.
> +
> +Modern firmware often follows the Unified Extensible Firmware
> +Interface (UEFI) which provides services like secure boot, persistent
> +variables and external time-keeping.
> +
> +There can often be multiple levels of firmware service functions. For
> +example systems which support secure execution enclaves generally have
> +a firmware component that executes in this secure mode which the
> +operating system can call in a defined secure manner to undertake
> +security sensitive tasks on it's behalf.
> +
> +Hardware Enumeration
> +--------------------
> +
> +It's easy to assume that modern hardware is built to be discover-able
> +and all the operating system needs to do is enumerate the various
> +buses on the system to find out what hardware exists. While buses like
> +PCI and USB do support discovery there is usually much more on a
> +modern system than just these two things.
> +
> +In the embedded world it used to be acceptable to have a custom
> +compiled kernel which knew where everything is meant to be. However
> +this was a brittle approach and not very flexible - most obviously if
> +you try and use a kernel compiled for one piece of hardware on another
> +piece of hardware that might nominally have the same processor.
> +
> +The more modern approach is to have a "generic" kernel that has a
> +number of different drivers compiled in which are then enabled based
> +on a hardware description provided by the firmware. This allows
> +flexibility on both sides. The software distribution is less concerned
> +about managing lots of different kernels for different pieces of
> +hardware. The hardware manufacturer is also able to make small changes
> +to the board over time to fix bugs or change minor components.
> +
> +The two main methods for this are the Advanced Configuration and Power
> +Interface (ACPI) and Device Trees. ACPI originated from the PC world
> +although is becoming increasingly common for "enterprise" hardware
> +like servers. Device Trees of various forms have existed for a while
> +with perhaps the most common being Flattened Device Trees (FDT).
> +
> +Boot Code
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The line between firmware and boot code is a very blurry one. However
> +from a functionality point of view we have moved from ensuring the
> +hardware is usable as a computing device to finding and loading a
> +kernel which is then going to take over control of the system. Modern
> +firmware often has the ability to boot a kernel directly and in some
> +systems you might chain through several boot loaders before the final
> +kernel takes control.
> +
> +The boot loader needs to do 3 things:
> +
> +  - find a kernel and load it into RAM
> +  - ensure the CPU is in the correct mode for the kernel to boot
> +  - pass any information the kernel may need to boot and can't find it=
self
> +
> +Once it has done these things it can jump to the kernel and let it get
> +on with things.
> +
> +Kernel
> +=3D=3D=3D=3D=3D=3D
> +
> +The Kernel now takes over and will be in charge of the system from now
> +on. It will enumerate all the devices on the system (again) and load
> +drivers that can control them. It will then locate some sort of
> +file-system and eventually start running programs that actually do
> +work.
> +
> +------------------------
> +How this relates to QEMU
> +------------------------
> +
> +TODO:
> +
> +  - -bios and -drive flash
> +  - dynamic and fixed hardware definitions
> +  - direct kernel boots
>=20
