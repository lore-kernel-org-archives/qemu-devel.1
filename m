Received: from eggs.gnu.org ([2001:4830:134:3::10]:33918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fK3eM-0004Cs-4x
	for qemu-devel@nongnu.org; Sat, 19 May 2018 11:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fK3eL-0002Zs-0r
	for qemu-devel@nongnu.org; Sat, 19 May 2018 11:20:02 -0400
Date: Sat, 19 May 2018 17:19:49 +0200
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20180519171949.0031d971@thl530.multi.box>
In-Reply-To: <7d552162-5165-c022-ce6d-4903da7d2262@xenosoft.de>
References: <4521b265-855f-7f06-ffff-3fa394380922@xenosoft.de>
	<b3243bab-58b6-0b43-67b5-94a2f90d9199@tuxfamily.org>
	<5BD35D0B-E490-4693-8858-E11B7401709F@xenosoft.de>
	<1821476d-7724-ad71-eb3f-69c731633582@tuxfamily.org>
	<886dc490-c96a-ad5a-e1f7-8e41a686a53e@xenosoft.de>
	<20180518131303.6f0778eb@bahia.lan>
	<e9333edf-fa2a-6ad8-412b-459b0b8002e9@xenosoft.de>
	<20180518141642.6ad639ac@bahia.lan>
	<8bde9b6f-b80f-e87e-e4d3-ace15454cf3d@xenosoft.de>
	<3db651e3-a237-fbaa-6ffe-ecc5db43ad0f@tuxfamily.org>
	<E9FA9AA6-FDA6-467F-9B72-B331756464A7@xenosoft.de>
	<ccaa7d46-79d4-c223-3828-ae22a59392db@tuxfamily.org>
	<7d552162-5165-c022-ce6d-4903da7d2262@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PPC64] P5020DS: Booting from img
 possible (-drive)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>, qemu-devel@nongnu.org

Am Sat, 19 May 2018 16:03:02 +0200
schrieb Christian Zigotzky <chzigotzky@xenosoft.de>:

> On 19 May 2018 at 08:15AM, Thomas Huth wrote:
> > On 19.05.2018 06:58, Christian Zigotzky wrote: =20
> >> Thomas wrote:
> >> =20
> >>> No clue, so just a blind guess: Is "CoreNet Generic" the right
> >>> machine? What happens if you set "CONFIG_CORENET_GENERIC=3Dn" in
> >>> your kernel config? =20
> >> I think it=E2=80=98s the right machine. =20
> > It's likely the right selection for the real hardware, but it's
> > maybe the wrong machine type for the QEMU ppce500 machine.
> >
> >   Thomas
> > =20
> Hello Thomas,
>=20
> Thanks for your reply. I compiled the RC5 of kernel 4.17 without
> corenet generic support today. ubuntu MATE 16.04 LTS PowerPC
> boots!!!!!!!!!

Cool! :-)

> With the following command I can boot it with a VirtIO graphics cards.
>=20
> qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -kernel=20
> /home/christian/Downloads/uImage-4.17-without_corenet -drive=20
> file=3D/home/christian/Dokumente/ubuntu_MATE_16.04.3_LTS_PowerPC_QEMU/ubu=
ntu_MATE_16.04_PowerPC.img,index=3D0,if=3Dvirtio=20
> -net nic,vlan=3D0,model=3De1000 -net user,vlan=3D0 -append "rw
> root=3D/dev/vda3" -device virtio-vga

Note that "vlan=3D0" won't work with the next version (2.13) of QEMU
anymore. But since that's the default, you can simply omit that
"vlan=3D0" in both -net options. Or if you are using the latest and
greatest QEMU v2.12 already, you can also use "-nic user,model=3De1000"
instead.

> Unfortunately mouse and keyboard doesn't work in the virtual machine.

I guess with the ppce500 machine, you've also got to specify them
manually, too. You've got two options, virtio and USB. For virtio, try:

 -device virtio-mouse-pci -device virtio-keyboard-pci

And for USB, try something like:

 -device qemu-xhci -device usb-mouse -device usb-kbd

If "qemu-xhci" does not work, you could also try "pci-ohci" instead.

 HTH,
  Thomas
