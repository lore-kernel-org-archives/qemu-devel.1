Received: from eggs.gnu.org ([209.51.188.92]:42456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpMAp-0005AS-IO
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 18:55:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpMAo-0000w0-N1
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 18:55:11 -0500
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
	<002701d4b9bc$b1fe72e0$15fb58a0$@phi.nz>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3ace3624-893b-82e1-3132-0dcd1896ec94@redhat.com>
Date: Fri, 1 Feb 2019 00:54:56 +0100
MIME-Version: 1.0
In-Reply-To: <002701d4b9bc$b1fe72e0$15fb58a0$@phi.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexandro Sanchez Bach <alexandro@phi.nz>, 'Markus Armbruster' <armbru@redhat.com>
Cc: 'Peter Maydell' <peter.maydell@linaro.org>, 'Peter Krempa' <pkrempa@redhat.com>, 'Qemu-block' <qemu-block@nongnu.org>, 'Libvirt' <libvir-list@redhat.com>, 'QEMU Developers' <qemu-devel@nongnu.org>, =?UTF-8?B?J0zDoXN6bMOzIMOJcnNlayc=?= <lersek@redhat.com>, "'Justin Terry (VM)'" <juterry@microsoft.com>, "'Ning, Yu'" <yu.ning@intel.com>

On 01/02/19 00:28, Alexandro Sanchez Bach wrote:
> (CC'd Yu Ning @ Intel's HAXM team)
> 
> Not sure, if I'm understanding the issue correctly, but isn't
> `HAX_VM_IOCTL_SET_RAM2` with the `HAX_RAM_INFO_ROM` flag precisely
> what you are looking for?
> 
> More precisely, HAX_VM_IOCTL_SET_RAM2 maps an HVA range to a GPA
> range, the HAX_RAM_INFO_ROM flag should allow only guest memory reads
> to that range [1]. When the guest attempts to write, this should
> trigger a VM exit that will be handled by QEMU.

The missing handling is in the hypervisor:

    if (ret == -EACCES) {
        /*
         * For some reason, during boot-up, Chrome OS guests make
hundreds of
         * attempts to write to GPAs close to 4GB, which are mapped into
BIOS
         * (read-only) and thus result in EPT violations.
         * TODO: Handle this case properly.
         */
        hax_warning("%s: Unexpected EPT violation cause. Skipping
instruction"
                    " (len=%u)\n", __func__, vcpu->vmx.exit_instr_length);
        advance_rip(vcpu);
        return HAX_EXIT;
}

> Also, this seems to be handled here:
> https://github.com/qemu/qemu/blob/15bede554162dda822cd762c689edb6fa32b6e3b/target/i386/hax-mem.c#L205-L207

Right, though to be precise it should be changed to

     if (memory_region_is_rom(section->mr) ||
	 memory_region_is_romd(section->mr)) {         flags |= HAX_RAM_INFO_ROM;
     }

for that to work.

Paolo
