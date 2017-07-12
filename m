Received: from eggs.gnu.org ([2001:4830:134:3::10]:33011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVFGx-00051o-LN
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVFGu-00024y-Jo
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:53:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVFGu-00024R-Aa
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:53:32 -0400
References: <1499781397-19749-1-git-send-email-thuth@redhat.com>
	<2efa5d82-3cb2-ef8a-53b0-54a630637d98@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d81c6ea2-beb1-12bf-c19b-eb8180f26a59@redhat.com>
Date: Wed, 12 Jul 2017 12:53:23 +0200
MIME-Version: 1.0
In-Reply-To: <2efa5d82-3cb2-ef8a-53b0-54a630637d98@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/11] Implement network booting in the
 s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 12.07.2017 10:33, Christian Borntraeger wrote:
> On 07/11/2017 03:56 PM, Thomas Huth wrote:
>> It's already possible to do a network boot of an s390x guest with an
>> external netboot image based on a Linux installation, but it would
>> be much more convenient if the s390-ccw firmware supported network
>> booting right out of the box, without the need to assemble such an
>> external image first.
>>
>> This patch series now introduces a s390-netboot.img that can be used
>> for network booting via DHCP and TFTP by re-using the networking stack
>> from the SLOF firmware (see https://github.com/aik/SLOF/ for details),
>> and adds a driver for virtio-net-ccw devices.
>>
>> The code can only be built if the roms/SLOF submodule has been checked
>> out (there is a sanity check for this in the Makefile). Once it has
>> been built, you can download a combined kernel + initrd image via TFTP
>> by starting QEMU for example with:
>>
>>  qemu-system-s390x ... -device virtio-net,netdev=3Dn1,bootindex=3D1 \
>>        -netdev user,id=3Dn1,tftp=3D/path/to/tftp,bootfile=3Dkernel.img
>>
>> Note that this version does not support downloading via config
>> files (i.e. pxelinux config files or .INS config files) yet. This
>> will be added later.
>>
>> v4:
>>  - Cosmetic clean-ups according to the review feedback from v3
>>  - Fixed bug in the find_dev() function (spotted by Cornelia in v3)
>>  - Added an additional patch to remove some unused structs from
>>    virtio.h
>>
>> v3:
>>  - Adressed the review feedback from v2
>>  - The last remaining SLOF patch has now been merged (big thanks to
>>    Alexey!), so not sending this as RFC anymore - it is ready now for
>>    integration, I think.
>>
>> v2:
>>  - Put the network boot loader into a separate s390-netboot.img
>>    binary instead of linking it directly into the s390-ccw firmware.
>>  - Use the SLOF sources from the roms/SLOF/ submodule instead of
>>    copying them into the pc-bios/s390-ccw folder
>>  - Removed the .INS config file loading code for now - only support
>>    combined kernel + initrd images in this initial implementation.
>>
>> Thomas Huth (11):
>>   pc-bios/s390-ccw: Move libc functions to separate header
>>   pc-bios/s390-ccw: Move ebc2asc to sclp.c
>>   pc-bios/s390-ccw: Move virtio-block related functions into a separat=
e
>>     file
>>   pc-bios/s390-ccw: Add a write() function for stdio
>>   pc-bios/s390-ccw: Move byteswap functions to a separate header
>>   pc-bios/s390-ccw: Remove unused structs from virtio.h
>>   pc-bios/s390-ccw: Add code for virtio feature negotiation
>>   roms/SLOF: Update submodule to latest status
>>   pc-bios/s390-ccw: Add core files for the network bootloading program
>>   pc-bios/s390-ccw: Add virtio-net driver code
>>   pc-bios/s390-ccw: Link libnet into the netboot image and do the TFTP
>>     load
>>
>>  pc-bios/s390-ccw/Makefile        |  13 +-
>>  pc-bios/s390-ccw/bootmap.c       |   2 +
>>  pc-bios/s390-ccw/bootmap.h       |  26 ---
>>  pc-bios/s390-ccw/bswap.h         |  30 ++++
>>  pc-bios/s390-ccw/libc.h          |  45 +++++
>>  pc-bios/s390-ccw/main.c          |  14 +-
>>  pc-bios/s390-ccw/netboot.mak     |  51 ++++++
>>  pc-bios/s390-ccw/netmain.c       | 362 ++++++++++++++++++++++++++++++=
+++++++++
>>  pc-bios/s390-ccw/s390-ccw.h      |  33 +---
>>  pc-bios/s390-ccw/sclp.c          |  37 ++--
>>  pc-bios/s390-ccw/virtio-blkdev.c | 296 ++++++++++++++++++++++++++++++=
++
>>  pc-bios/s390-ccw/virtio-net.c    | 135 +++++++++++++++
>>  pc-bios/s390-ccw/virtio-scsi.c   |   1 +
>>  pc-bios/s390-ccw/virtio.c        | 306 ++++--------------------------=
---
>>  pc-bios/s390-ccw/virtio.h        |  46 ++---
>>  roms/SLOF                        |   2 +-
>>  16 files changed, 1011 insertions(+), 388 deletions(-)
>>  create mode 100644 pc-bios/s390-ccw/bswap.h
>>  create mode 100644 pc-bios/s390-ccw/libc.h
>>  create mode 100644 pc-bios/s390-ccw/netboot.mak
>>  create mode 100644 pc-bios/s390-ccw/netmain.c
>>  create mode 100644 pc-bios/s390-ccw/virtio-blkdev.c
>>  create mode 100644 pc-bios/s390-ccw/virtio-net.c
>>
>=20
> Was going to apply but then I updated the slof thing but building fails=
. Not sure yet why.
>=20
> In file included from /home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctyp=
e/isdigit.c:13:0:
> /home/cborntra/REPOS/qemu/roms/SLOF/lib/libc/ctype/isdigit.c:15:17: err=
or: expected =E2=80=98)=E2=80=99 before =E2=80=98ch=E2=80=99
>  int isdigit(int ch)

What a bummer! Sorry, I've only cross-compiled the s390-ccw BIOS so far,
and that worked fine (since s390x machines are a little bit hard to get
here), but seems like there is still something ugly going on when you
build the code natively ... likely somethings wrong in the Makefile ...
I'll try to figure it out ...

 Thomas
