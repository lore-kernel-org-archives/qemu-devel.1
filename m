Received: from eggs.gnu.org ([2001:4830:134:3::10]:38145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ffR5s-0007BA-JV
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ffR5r-0007ic-Bg
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:36:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ffR5r-0007iR-5E
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:36:47 -0400
Date: Tue, 17 Jul 2018 16:36:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180717163643.2ebe04a7@redhat.com>
In-Reply-To: <0d565394-3b13-f290-bf2c-5807f403ead7@redhat.com>
References: <20180716125948.11666-1-marcandre.lureau@redhat.com>
	<20180716125948.11666-3-marcandre.lureau@redhat.com>
	<20180717120326.0c62f545@redhat.com>
	<CAMxuvaxOOeHW_iCzp+xSaH6=jqq+6yZHcWNzEK=AFqu3UFjAjA@mail.gmail.com>
	<0d565394-3b13-f290-bf2c-5807f403ead7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 2/5] tpm: implement virtual memory
 device for TPM PPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 17 Jul 2018 15:04:25 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 07/17/18 12:39, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >=20
> > On Tue, Jul 17, 2018 at 12:03 PM, Igor Mammedov <imammedo@redhat.com> w=
rote: =20
> >> On Mon, 16 Jul 2018 14:59:45 +0200
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >> =20
> >>> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>>
> >>> Implement a virtual memory device for the TPM Physical Presence inter=
face.
> >>> The memory is located at 0xFED45000 and used by ACPI to send messages=
 to the
> >>> firmware (BIOS) and by the firmware to provide parameters for each on=
e of
> >>> the supported codes. =20
> >> ...
> >> another question wrt E820 table, is firmware putting a reservation rec=
ord
> >> for this RAM area overlay or should we do it QEMU? =20
>=20
> What OS requires this memmap entry?
>=20
> > There doesn't seem to be any reservation done in ovmf, or on my
> > laptop. =20
>=20
> Relevant point, about your laptop.
>=20
> > I also wonder if it should be done. =20
>=20
> IMO: no, it shouldn't.
>=20
> > And how OS deal with that today (/proc/iomem is correct).
> >=20
> > Laszlo, any idea? =20
>=20
> In my experience, exposing such MMIO areas that belong to *platform*
> devices, in the UEFI memory map, is an inconsistent practice. I can list
> at least four different cases:
>=20
> (1) A UEFI runtime driver is using the MMIO area for providing a UEFI
> runtime service. In this case, the firmware must expose the area as
> "MMIO" type memory, and set the "runtime" attribute on it. In response,
> the OS will map the area with virtual addresses, directly in response to
> the memmap entry.
>=20
> (2) A firmware SMM driver is using the MMIO area for providing a
> privileged part of a UEFI runtime service. Because SMM uses its own page
> table anyway (protected from the OS), advertizing the area in the UEFI
> memmap is unneeded. It can simply be left as a gap.
>=20
> (3) Linux requires the firmware to cover every MMCONFIG area (each of
> which belongs to a PCIe host bridge, which is a platform device) with a
> "reserved" type memmap entry. To me this looks like an outlier, although
> I *very* vaguely recall that some spec recommended this.
>=20
> Ah, right, the PCI Firmware Specification says, under "MCFG Table
> Description": "*If* the operating system does not natively comprehend
> reserving the MMCFG region, the MMCFG region must be reserved by
> firmware." (Emphasis mine.) In other words, this is a provision in the
> PCI firmware spec so that platform firmware paper over the fact that the
> ACPI subsystem in the OS kernel is limited. Linux, given that it
> understand MCFG just fine, totally should not *require* the firmware to
> reserve this region in the UEFI memory map as well. Anyway, Linux does
> require it (incorrectly, in my opinion), so OVMF complies.
>=20
> (4) To my understanding, unless given Linux or Windows quirks like (3),
> or UEFI runtime drivers like (1), we shouldn't expose, in the UEFI
> memmap, MMIO areas related to platform devices. In particular, the
> "MMIO" type memory *without* the "runtime" attribute (see (1)) should
> never be used in the UEFI memmap (and edk2 will never create such
> entries) -- the UEFI spec says that all such areas (resources) should be
> communicated through ACPI tables ("All system memory-mapped IO
> information should come from ACPI tables" -- see EfiMemoryMappedIO in
> "Table 26. Memory Type Usage after ExitBootServices()").
>=20
>=20
> In brief, the TPM PPI MMIO area should just be left as a gap in the UEFI
> memmap. (Case (4) applies.)
so I guess we are good as the patch should fit the bill for (4)

>=20
> Thanks,
> Laszlo
