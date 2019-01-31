Received: from eggs.gnu.org ([209.51.188.92]:38101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexandro@phi.nz>) id 1gpLlN-0006wg-Er
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 18:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexandro@phi.nz>) id 1gpLlM-0004GQ-GE
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 18:28:53 -0500
From: "Alexandro Sanchez Bach" <alexandro@phi.nz>
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
In-Reply-To: <cb465eba-8c54-af8e-fe0e-ce90f71d213a@redhat.com>
Date: Fri, 1 Feb 2019 00:28:35 +0100
Message-ID: <002701d4b9bc$b1fe72e0$15fb58a0$@phi.nz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Markus Armbruster' <armbru@redhat.com>
Cc: 'Peter Maydell' <peter.maydell@linaro.org>, 'Peter Krempa' <pkrempa@redhat.com>, 'Qemu-block' <qemu-block@nongnu.org>, 'Libvirt' <libvir-list@redhat.com>, 'QEMU Developers' <qemu-devel@nongnu.org>, =?utf-8?B?J0zDoXN6bMOzIMOJcnNlayc=?= <lersek@redhat.com>, "'Justin Terry (VM)'" <juterry@microsoft.com>, "'Ning, Yu'" <yu.ning@intel.com>

>> This is all greek to me.  I take it there's something wrong with =
these=20
>> accelerators that makes (read-only?) flash memory not work, even=20
>> though the read-only mapping we now create for traditional BIOS =
works. =20
>> Weird, but I'm of course willing to take your word for it.

> Yes, as I wrote in the other message even read-only flash memory =
supports commands, and these accelerators do not support direct reads + =
MMIO writes on the same memory slot.
> At least I checked HAX code and it doesn't; I don't know about WHPX.

(CC'd Yu Ning @ Intel's HAXM team)

Not sure, if I'm understanding the issue correctly, but isn't =
`HAX_VM_IOCTL_SET_RAM2` with the `HAX_RAM_INFO_ROM` flag precisely what =
you are looking for?

More precisely, HAX_VM_IOCTL_SET_RAM2 maps an HVA range to a GPA range, =
the HAX_RAM_INFO_ROM flag should allow only guest memory reads to that =
range [1]. When the guest attempts to write, this should trigger a VM =
exit that will be handled by QEMU. Also, this seems to be handled here:
https://github.com/qemu/qemu/blob/15bede554162dda822cd762c689edb6fa32b6e3=
b/target/i386/hax-mem.c#L205-L207

Best,
Alexandro

[1] https://github.com/intel/haxm/blob/master/docs/api.md
