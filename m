Received: from eggs.gnu.org ([2001:4830:134:3::10]:39473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX5as-0002Xp-Sd
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:34:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX5ap-0008Pv-Jh
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:34:34 -0500
Date: Wed, 12 Dec 2018 15:34:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181212153426.2ca5a481.cohuck@redhat.com>
In-Reply-To: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/15] s390: vfio-ccw dasd ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>

On Wed, 12 Dec 2018 09:11:03 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

Hm, I think you need to adjust your cc: list. I added some more folks
(and removed Dong Jia, whose address is no longer valid AFAIK).

> This is to support booting from vfio-ccw dasd devices. We basically implement
> the real hardware ipl procedure. This allows for booting Linux guests on
> vfio-ccw devices.
> 
> vfio-ccw's channel program prefetch algorithm complicates ipl because most ipl
> channel programs dynamically modify themselves. Details on the ipl process and
> how we worked around this issue can be found in docs/devel/s390-dasd-ipl.txt.
> 
> NOTE: It has been a while, but I've finally chased down my infamous "reset bug".
> On subsystem reset (I see this right after host ipl) we sometimes end up getting
> an unexpected unit check status from a dasd device. This causes the first start
> subchannel instruction to fail due to the pending unit check status. My solution
> to this problem, as advised by the kernel folks, is to simply retry my ssch
> instructions before declaring failure when unexpected unit checks happen. In the
> event of a persistent error, after two retries we'll give up and print some
> useful error info for the user.

So, is that a status we only see because the vfio-ccw driver keeps the
subchannel enabled (as by the other recent thread)?

Is there any value in distinguishing different unit checks, or is retry
the best strategy in any case?

> 
> Changelog
> ==========
> 
> rfc -> v1
> ---------
> - Retry start subchannel operations on unexpected unit check status
> - Print more complete state information on i/o error
> - Fixed asm constraints (Q -> QS)
> - Align lowcore to 8k boundary
> - Initialize next_cpa in run_dynamic_ccw_program to avoid compiler warning
> - Cleanup: Rework handling of i/o interrupts in assembler
> - Fix netboot image (include cio.o in make file)
> - Misc cleanups
> 
> Jason J. Herne (15):
>   s390 vfio-ccw: Add bootindex property and IPLB data
>   s390-bios: decouple cio setup from virtio
>   s390-bios: decouple common boot logic from virtio
>   s390-bios: Extend find_dev() for non-virtio devices
>   s390-bios: Factor finding boot device out of virtio code path
>   s390-bios: Clean up cio.h
>   s390-bios: Decouple channel i/o logic from virtio
>   s390-bios: Map low core memory
>   s390-bios: ptr2u32 and u32toptr
>   s390-bios: Support for running format-0/1 channel programs
>   s390-bios: cio error handling
>   s390-bios: Refactor virtio to run channel programs via cio
>   s390-bios: Use control unit type to determine boot method
>   s390-bios: Add channel command codes/structs needed for dasd-ipl
>   s390-bios: Support booting from real dasd device
> 
>  docs/devel/s390-dasd-ipl.txt     | 132 ++++++++++++++
>  hw/s390x/ipl.c                   |  15 ++
>  hw/s390x/s390-ccw.c              |   9 +
>  hw/vfio/ccw.c                    |  13 +-
>  include/hw/s390x/s390-ccw.h      |   1 +
>  include/hw/s390x/vfio-ccw.h      |  38 ++++
>  pc-bios/s390-ccw/Makefile        |   2 +-
>  pc-bios/s390-ccw/cio.c           | 374 +++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/cio.h           | 236 +++++++++++++++++++-----
>  pc-bios/s390-ccw/dasd-ipl.c      | 249 ++++++++++++++++++++++++++
>  pc-bios/s390-ccw/dasd-ipl.h      |  16 ++
>  pc-bios/s390-ccw/libc.h          |  23 +++
>  pc-bios/s390-ccw/main.c          | 161 +++++++++++------
>  pc-bios/s390-ccw/netboot.mak     |   2 +-
>  pc-bios/s390-ccw/netmain.c       |   1 +
>  pc-bios/s390-ccw/s390-arch.h     | 113 ++++++++++++
>  pc-bios/s390-ccw/s390-ccw.h      |  10 +-
>  pc-bios/s390-ccw/start.S         |  33 +++-
>  pc-bios/s390-ccw/virtio-blkdev.c |   1 +
>  pc-bios/s390-ccw/virtio.c        |  46 +----
>  roms/SLOF                        |   2 +-
>  tests/boot-serial-test.c         |   2 +-
>  22 files changed, 1308 insertions(+), 171 deletions(-)
>  create mode 100644 docs/devel/s390-dasd-ipl.txt
>  create mode 100644 include/hw/s390x/vfio-ccw.h
>  create mode 100644 pc-bios/s390-ccw/cio.c
>  create mode 100644 pc-bios/s390-ccw/dasd-ipl.c
>  create mode 100644 pc-bios/s390-ccw/dasd-ipl.h
>  create mode 100644 pc-bios/s390-ccw/s390-arch.h
> 
> --
> 2.7.4
> 
