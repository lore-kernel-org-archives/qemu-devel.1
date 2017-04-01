Received: from eggs.gnu.org ([2001:4830:134:3::10]:36494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiong.y.zhang@intel.com>) id 1cu8sw-00035x-LF
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 22:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiong.y.zhang@intel.com>) id 1cu8st-0007Ng-Db
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 22:35:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:24788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiong.y.zhang@intel.com>)
	id 1cu8ss-0007M8-WF
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 22:35:23 -0400
From: "Zhang, Xiong Y" <xiong.y.zhang@intel.com>
Date: Sat, 1 Apr 2017 02:35:14 +0000
Message-ID: <8082FF9BCB2B054996454E47167FF4EC1C495DAF@SHSMSX104.ccr.corp.intel.com>
References: <1490869641-29873-1-git-send-email-xiong.y.zhang@intel.com>
	<20170330090148.16048141@t450s.home>
	<8082FF9BCB2B054996454E47167FF4EC1C4930B3@SHSMSX104.ccr.corp.intel.com>
	<20170330205511.28be6306@t450s.home>
	<20170331190349.493158f3@Igors-MacBook-Pro.local>
	<20170331112726.69625d03@t450s.home>
In-Reply-To: <20170331112726.69625d03@t450s.home>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Revert "vfio/pci-quirks.c: Disable stolen
 memory for igd VFIO"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zhang, Xiong Y" <xiong.y.zhang@intel.com>

> On Fri, 31 Mar 2017 19:03:49 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > On Thu, 30 Mar 2017 20:55:11 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >
> > > On Fri, 31 Mar 2017 02:27:11 +0000
> > > "Zhang, Xiong Y" <xiong.y.zhang@intel.com> wrote:
> > >
> > > > > On Thu, 30 Mar 2017 18:27:21 +0800
> > > > > Xiong Zhang <xiong.y.zhang@intel.com> wrote:
> > > > >
> > > > > > This reverts commit
> c2b2e158cc7b1cb431bd6039824ec13c3184a775.
> > > > > >
> > > > > > The original patch intend to prevent linux i915 driver from usi=
ng
> > > > > > stolen meory. But this patch breaks windows IGD driver loading =
on
> > > > > > Gen9+, as IGD HW will use stolen memory on Gen9+, once windows
> IGD
> > > > > > driver see zero size stolen memory, it will unload.
> > > > > > Meanwhile stolen memory will be disabled in 915 when i915 run a=
s
> > > > > > a guest.
> > > > >
> > > > > Does this mean that legacy mode IGD assignment is not going to wo=
rk
> > > > > on Gen9+ with Windows?  Will it continue to work with Gen8-?
> > > > [Zhang, Xiong Y] I try to use the following qemu command to enable
> legacy mode on SKyLake, but It seems the entry point of wins IGD driver i=
sn't
> called(I couldn't confirm this as I don't have the source code, but I did=
n't see
> any IGD driver info from windbg while I could see many info in upt mode),=
 so
> driver doesn't bind to IGD after win 8.1 boot up.
> > > >   #qemu-system-x86_64 -M pc -enable-kvm -smp 2 -m 2G  -vga none
> -nographic -cpu host -hda "$IMAGE" -device
> vfio-pci,host=3D00:02.0,x-vga=3Dtrue,id=3Dhostdev0,bus=3Dpci.0,addr=3D0x2
> > > > Is this the right method to enable legacy mode ?
> > >
> > > Yeah, that should do it.  x-vga should not be necessary, but shouldn'=
t
> > > hurt IIRC.  Any dmesg errors regarding the ROM?  I think we have
> > > trouble with the ROM if the host is booted in UEFI mode.
> >
> > 1.
> > here is dmesg messages when host is booted with CSM mode enabled
> > and host's bios load option rom on boot:
> >
> > [165041.359929] vfio-pci 0000:00:02.0: vgaarb: changed VGA decodes:
> olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
> > [165073.898940] vfio-pci 0000:00:02.0: vgaarb: changed VGA decodes:
> olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
> > [165074.687515] vfio-pci 0000:00:02.0: enabling device (0400 -> 0403)
> > [165074.791598] vfio_ecap_init: 0000:00:02.0 hiding ecap 0x1b@0x100
> >
> > have output on monitor connected via HDMI
> >
> > 2.
> > and here is dmesg in pure UEFI mode (where host's bios doesn't load opt=
ion
> rom):
> >
> > [   21.034983] vfio-pci 0000:00:02.0: vgaarb: changed VGA decodes:
> olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
> > [   22.025361] vfio_ecap_init: 0000:00:02.0 hiding ecap 0x1b@0x100
> > [   22.030970] vfio-pci 0000:00:02.0: Invalid PCI ROM header signature:
> expecting 0xaa55, got 0xffff
> > [   22.031036] vfio-pci 0000:00:02.0: Invalid PCI ROM header signature:
> expecting 0xaa55, got 0xffff
> > [   24.738793] vfio-pci 0000:00:02.0: Invalid PCI ROM header signature:
> expecting 0xaa55, got 0xffff
> > [   27.776904] vfio-pci 0000:00:02.0: vgaarb: changed VGA decodes:
> olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
> >
> > no output on monitor connected via HDMI when using Kabylake CPU
> (HD630)
> > but pure UEFI mode used to work (external output) with Skylake CPU
> (HD510)
>=20
> In my limited experience, I've never been able to use IGD assignment on
> a pure UEFI host unless I provide the ROM via file.  For instance on my
> laptop I switched to CSM and booted a live CD to dump the ROM, which I
> can then use regardless of the host BIOS mode.
>=20
> I just updated my rom-parser to include a version to fixup ROMs for
> vendor/device ID and checksum which should help with this:
>=20
> https://github.com/awilliam/rom-parser
>=20
> Update the device ID to match your ROM and let it fix the checksum.
> Maybe Xiong has some insight into why the VGA ROM often doesn't seem to
> exist on native pure UEFI hosts.
>=20
[Zhang, Xiong Y] According to my limited UEFI knowledge, I could explain th=
is, but it may be wrong.
VGA ROM seems a graphic driver in bios, and supply graphic service to grub =
and the early phase of OS.
The content of IGD VGA ROM is filled by system bios.
1. turn on csm, bios supply legacy bios intxx service to grub and OS. VGA R=
OM contain a 16 bit image as a vga bios.=20
This image is what we want in vfio legacy mode.=20
2. turn off csm, it is native uefi mode and supply uefi runtime service to =
grub and OS, the interface is gst->ConOut and gst->RuntimeServices.
The backend of gst->ConOut for graphic card is GOP(graphics output protocol=
). How to implement IGD GOP, it could be a 32 bit image in VGA ROM, or a ue=
fi driver. So in native uefi, VGA ROM could be one of three form:
a. no contents,  GOP uefi driver in bios could implement all the function.
b. 32 bit image   supply driver for GOP
c. 16 bit image + 32 bit image

Attach UEFI GOP definition:
11.9 Graphics Output Protocol
The goal of this section is to replace the functionality that currently exi=
sts with VGA hardware and
its corresponding video BIOS. The Graphics Output Protocol is a software ab=
straction and its goal is
to support any foreseeable graphics hardware and not require VGA hardware, =
while at the same time
also lending itself to implementation on the current generation of VGA hard=
ware.
Graphics output is important in the pre-boot space to support modern firmwa=
re features. These
features include the display of logos, the localization of output to any la=
nguage, and setup and
configuration screens.
Graphics output may also be required as part of the startup of an operating=
 system. There are
potentially times in modern operating systems prior to the loading of a hig=
h performance OS
graphics driver where access to graphics output device is required. The Gra=
phics Output Protocol
supports this capability by providing the EFI OS loader access to a hardwar=
e frame buffer and
enough information to allow the OS to draw directly to the graphics output =
device.
The EFI_GRAPHICS_OUTPUT_PROTOCOL supports three member functions to support=
 the
limited graphics needs of the pre-boot environment. These member functions =
allow the caller to
draw to a virtualized frame buffer, retrieve the supported video modes, and=
 to set a video mode.
These simple primitives are sufficient to support the general needs of pre-=
OS firmware code.
The EFI_GRAPHICS_OUTPUT_PROTOCOL also exports enough information about the =
current
mode for operating system startup software to access the linear frame buffe=
r directly.
thanks
> Alex
