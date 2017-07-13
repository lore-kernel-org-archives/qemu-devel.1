Received: from eggs.gnu.org ([2001:4830:134:3::10]:34532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dVeIY-0000Ae-UF
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1dVeIT-0005pw-VJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:36:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44837
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1dVeIT-0005oA-Ob
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:36:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DDYNZM112151
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 09:36:47 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bnt3qh19n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 09:36:46 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 14:36:44 +0100
References: <1499863793-18627-1-git-send-email-thuth@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 13 Jul 2017 15:36:41 +0200
MIME-Version: 1.0
In-Reply-To: <1499863793-18627-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <d621462b-9c27-e1b2-b7ca-868fdf2a59a8@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/11] Implement network booting in the
 s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

On 12.07.2017 14:49, Thomas Huth wrote:
> It's already possible to do a network boot of an s390x guest with an
> external netboot image based on a Linux installation, but it would
> be much more convenient if the s390-ccw firmware supported network
> booting right out of the box, without the need to assemble such an
> external image first.
>=20
> This patch series now introduces a s390-netboot.img that can be used
> for network booting via DHCP and TFTP by re-using the networking stack
> from the SLOF firmware (see https://github.com/aik/SLOF/ for details),
> and adds a driver for virtio-net-ccw devices.
>=20
> The code can only be built if the roms/SLOF submodule has been checked
> out (there is a sanity check for this in the Makefile). Once it has
> been built, you can download a combined kernel + initrd image via TFTP
> by starting QEMU for example with:
>=20
>  qemu-system-s390x ... -device virtio-net,netdev=3Dn1,bootindex=3D1 \
>        -netdev user,id=3Dn1,tftp=3D/path/to/tftp,bootfile=3Dkernel.img
>=20
> Note that this version does not support downloading via config
> files (i.e. pxelinux config files or .INS config files) yet. This
> will be added later.
>=20
> v5:
>  - Fixed problem when compiling the code natively on a s390x machine
>    (do not try to re-use the Makefile.inc files from SLOF, and define
>    our own rules instead)
>  - Fixed typos that Cornelia discovered while reviewing v4
>=20
> v4:
>  - Cosmetic clean-ups according to the review feedback from v3
>  - Fixed bug in the find_dev() function (spotted by Cornelia in v3)
>  - Added an additional patch to remove some unused structs from
>    virtio.h
>=20
> v3:
>  - Adressed the review feedback from v2
>  - The last remaining SLOF patch has now been merged (big thanks to
>    Alexey!), so not sending this as RFC anymore - it is ready now for
>    integration, I think.
>=20
> v2:
>  - Put the network boot loader into a separate s390-netboot.img
>    binary instead of linking it directly into the s390-ccw firmware.
>  - Use the SLOF sources from the roms/SLOF/ submodule instead of
>    copying them into the pc-bios/s390-ccw folder
>  - Removed the .INS config file loading code for now - only support
>    combined kernel + initrd images in this initial implementation.
>=20
> Thomas Huth (11):
>   pc-bios/s390-ccw: Move libc functions to separate header
>   pc-bios/s390-ccw: Move ebc2asc to sclp.c
>   pc-bios/s390-ccw: Move virtio-block related functions into a separate
>     file
>   pc-bios/s390-ccw: Add a write() function for stdio
>   pc-bios/s390-ccw: Move byteswap functions to a separate header
>   pc-bios/s390-ccw: Remove unused structs from virtio.h
>   pc-bios/s390-ccw: Add code for virtio feature negotiation
>   roms/SLOF: Update submodule to latest status
>   pc-bios/s390-ccw: Add core files for the network bootloading program
>   pc-bios/s390-ccw: Add virtio-net driver code
>   pc-bios/s390-ccw: Link libnet into the netboot image and do the TFTP
>     load
>=20
>  pc-bios/s390-ccw/Makefile        |  13 +-
>  pc-bios/s390-ccw/bootmap.c       |   2 +
>  pc-bios/s390-ccw/bootmap.h       |  26 ---
>  pc-bios/s390-ccw/bswap.h         |  30 ++++
>  pc-bios/s390-ccw/libc.h          |  45 +++++
>  pc-bios/s390-ccw/main.c          |  14 +-
>  pc-bios/s390-ccw/netboot.mak     |  59 +++++++
>  pc-bios/s390-ccw/netmain.c       | 361 +++++++++++++++++++++++++++++++=
++++++++
>  pc-bios/s390-ccw/s390-ccw.h      |  33 +---
>  pc-bios/s390-ccw/sclp.c          |  37 ++--
>  pc-bios/s390-ccw/virtio-blkdev.c | 296 +++++++++++++++++++++++++++++++=
+
>  pc-bios/s390-ccw/virtio-net.c    | 135 +++++++++++++++
>  pc-bios/s390-ccw/virtio-scsi.c   |   1 +
>  pc-bios/s390-ccw/virtio.c        | 306 ++++---------------------------=
--
>  pc-bios/s390-ccw/virtio.h        |  46 ++---
>  roms/SLOF                        |   2 +-
>  16 files changed, 1018 insertions(+), 388 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/bswap.h
>  create mode 100644 pc-bios/s390-ccw/libc.h
>  create mode 100644 pc-bios/s390-ccw/netboot.mak
>  create mode 100644 pc-bios/s390-ccw/netmain.c
>  create mode 100644 pc-bios/s390-ccw/virtio-blkdev.c
>  create mode 100644 pc-bios/s390-ccw/virtio-net.c
>=20
With the patches applied I could successfully perform a network boot
using a libvirt-defined dnsmasq TFTP server (even emulating a PXELINUX
setup with a special crafted boot image :-). So, FWIW:

(Series) Tested-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards
   Viktor Mihajlovski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
