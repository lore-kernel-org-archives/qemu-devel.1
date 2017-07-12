Received: from eggs.gnu.org ([2001:4830:134:3::10]:45934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHG0-0000se-5V
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVHFv-0002ns-As
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:00:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVHFu-0002mz-TB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:00:39 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CCxU9U054081
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 09:00:37 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncj8hrb7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 09:00:37 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 12 Jul 2017 07:00:36 -0600
References: <1499863793-18627-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 12 Jul 2017 15:00:29 +0200
MIME-Version: 1.0
In-Reply-To: <1499863793-18627-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <5d875407-37fd-bd27-8a04-619247fc2d91@de.ibm.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On 07/12/2017 02:49 PM, Thomas Huth wrote:
> It's already possible to do a network boot of an s390x guest with an
> external netboot image based on a Linux installation, but it would
> be much more convenient if the s390-ccw firmware supported network
> booting right out of the box, without the need to assemble such an
> external image first.
> 
> This patch series now introduces a s390-netboot.img that can be used
> for network booting via DHCP and TFTP by re-using the networking stack
> from the SLOF firmware (see https://github.com/aik/SLOF/ for details),
> and adds a driver for virtio-net-ccw devices.
> 
> The code can only be built if the roms/SLOF submodule has been checked
> out (there is a sanity check for this in the Makefile). Once it has
> been built, you can download a combined kernel + initrd image via TFTP
> by starting QEMU for example with:
> 
>  qemu-system-s390x ... -device virtio-net,netdev=n1,bootindex=1 \
>        -netdev user,id=n1,tftp=/path/to/tftp,bootfile=kernel.img
> 
> Note that this version does not support downloading via config
> files (i.e. pxelinux config files or .INS config files) yet. This
> will be added later.
> 
> v5:
>  - Fixed problem when compiling the code natively on a s390x machine
>    (do not try to re-use the Makefile.inc files from SLOF, and define
>    our own rules instead)
>  - Fixed typos that Cornelia discovered while reviewing v4
> 
> v4:
>  - Cosmetic clean-ups according to the review feedback from v3
>  - Fixed bug in the find_dev() function (spotted by Cornelia in v3)
>  - Added an additional patch to remove some unused structs from
>    virtio.h
> 
> v3:
>  - Adressed the review feedback from v2
>  - The last remaining SLOF patch has now been merged (big thanks to
>    Alexey!), so not sending this as RFC anymore - it is ready now for
>    integration, I think.
> 
> v2:
>  - Put the network boot loader into a separate s390-netboot.img
>    binary instead of linking it directly into the s390-ccw firmware.
>  - Use the SLOF sources from the roms/SLOF/ submodule instead of
>    copying them into the pc-bios/s390-ccw folder
>  - Removed the .INS config file loading code for now - only support
>    combined kernel + initrd images in this initial implementation.
> 
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
> 
>  pc-bios/s390-ccw/Makefile        |  13 +-
>  pc-bios/s390-ccw/bootmap.c       |   2 +
>  pc-bios/s390-ccw/bootmap.h       |  26 ---
>  pc-bios/s390-ccw/bswap.h         |  30 ++++
>  pc-bios/s390-ccw/libc.h          |  45 +++++
>  pc-bios/s390-ccw/main.c          |  14 +-
>  pc-bios/s390-ccw/netboot.mak     |  59 +++++++
>  pc-bios/s390-ccw/netmain.c       | 361 +++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/s390-ccw.h      |  33 +---
>  pc-bios/s390-ccw/sclp.c          |  37 ++--
>  pc-bios/s390-ccw/virtio-blkdev.c | 296 ++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio-net.c    | 135 +++++++++++++++
>  pc-bios/s390-ccw/virtio-scsi.c   |   1 +
>  pc-bios/s390-ccw/virtio.c        | 306 ++++-----------------------------
>  pc-bios/s390-ccw/virtio.h        |  46 ++---
>  roms/SLOF                        |   2 +-
>  16 files changed, 1018 insertions(+), 388 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/bswap.h
>  create mode 100644 pc-bios/s390-ccw/libc.h
>  create mode 100644 pc-bios/s390-ccw/netboot.mak
>  create mode 100644 pc-bios/s390-ccw/netmain.c
>  create mode 100644 pc-bios/s390-ccw/virtio-blkdev.c
>  create mode 100644 pc-bios/s390-ccw/virtio-net.c
> 

thanks applied.

(will do some testing and rebuilding of the image files on top). Where do
we want to put the binary result? pc-bios/s390-netboot.img I assume?
