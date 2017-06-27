Received: from eggs.gnu.org ([2001:4830:134:3::10]:52324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dPtkJ-0006lo-R1
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dPtgo-0006CU-1S
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:50:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47764
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dPtgn-0006AN-IJ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:50:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5RGmwqv067853
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 12:50:07 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bbsubc330-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 12:50:07 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Tue, 27 Jun 2017 12:50:06 -0400
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Tue, 27 Jun 2017 12:50:01 -0400
MIME-Version: 1.0
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <cd6a24ee-ddfd-f6f1-a20d-2ec1323ffd3e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 00/14] Implement network booting
 directly into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

Hi Thomas,

This is really interesting :)

On 06/27/2017 07:48 AM, Thomas Huth wrote:
> It's already possible to do a network boot of an s390x guest with an
> external netboot image (based on a Linux installation), but it would
> be much more convenient if the s390-ccw firmware supported network
> booting right out of the box, without the need to assemble such an
> external image first.
>
> This patch series now introduces network booting via DHCP and TFTP
> directly into the s390-ccw firmware by re-using the networking stack
> from the SLOF firmware (see https://github.com/aik/SLOF/ for details),
> and adds a driver for virtio-net-ccw devices.
>
> Once the patches have been applied, you can download an .INS file
> via TFTP which contains the information about the further files
> that have to be loaded - kernel, initrd, etc. For example, you can
> use the built-in TFTP and DHCP server of QEMU for this by starting
> QEMU with:
>
>  qemu-system-s390x ... -device virtio-net,netdev=n1,bootindex=1 \
>        -netdev user,id=n1,tftp=/path/to/tftp,bootfile=generic.ins
>
> The .INS file has to use the same syntax as the .INS files that can
> already be found on s390x Linux distribution installation CD-ROMs.
>
> The patches are still in a rough shape, but before I continue here,
> I though I'd get some feedback first. Specifically:
>
> - This adds a lot of additional code to the s390-ccw firmware (and
>   the binary is afterwards three times as big as before, 75k instead
>   of 25k) ... is that still acceptable?

IMHO 75k is not that huge compared to the Linux based netboot image.

>
> - Is it OK to require loading an .INS file first? Or does anybody
>   have a better idea how to load multiple files (kernel, initrd,
>   etc. ...)?
>
> - The code from SLOF uses a different coding style (TABs instead
>   of space) ... is it OK to keep that coding style here so we
>   can share patches between SLOF and s390-ccw more easily?
>
> - The code only supports TFTP (via UDP) ... I think that is OK for
>   most use-cases, but if we ever want to support network booting
>   via HTTP or something else that is based on TCP, we would need to
>   use something else instead... Should we maybe rather head towards
>   grub2, petitboot or something different instead?

Can't it be extended to support HTTP boot?
>
>  Thomas
>
>
> Thomas Huth (14):
>   pc-bios/s390-ccw: Add the libc from the SLOF firmware
>   pc-bios/s390-ccw: Start using the libc from SLOF
>   pc-bios/s390-ccw: Add a write() function for stdio
>   pc-bios/s390-ccw: Add implementation of sbrk()
>   pc-bios/s390-ccw: Add the TFTP network loading stack from SLOF
>   libnet: Remove remainders of netsave code
>   libnet: Rework error message printing
>   libnet: Refactor some code of netload() into a separate function
>   pc-bios/s390-ccw: Make the basic libnet code compilable
>   pc-bios/s390-ccw: Add timer code for the libnet
>   pc-bios/s390-ccw: Add virtio-net driver code
>   pc-bios/s390-ccw: Load file via an intermediate .INS file
>   pc-bios/s390-ccw: Allow loading to address 0
>   pc-bios/s390-ccw: Wire up the netload code
>
>  configure                                  |   6 +-
>  hw/s390x/ipl.c                             |   2 +-
>  pc-bios/s390-ccw/Makefile                  |  14 +-
>  pc-bios/s390-ccw/bootmap.c                 |  10 +-
>  pc-bios/s390-ccw/bootmap.h                 |   1 +
>  pc-bios/s390-ccw/libc/Makefile             |  47 ++
>  pc-bios/s390-ccw/libc/README.txt           |  49 ++
>  pc-bios/s390-ccw/libc/ctype/Makefile.inc   |  21 +
>  pc-bios/s390-ccw/libc/ctype/isdigit.c      |  25 +
>  pc-bios/s390-ccw/libc/ctype/isprint.c      |  18 +
>  pc-bios/s390-ccw/libc/ctype/isspace.c      |  29 +
>  pc-bios/s390-ccw/libc/ctype/isxdigit.c     |  21 +
>  pc-bios/s390-ccw/libc/ctype/tolower.c      |  18 +
>  pc-bios/s390-ccw/libc/ctype/toupper.c      |  21 +
>  pc-bios/s390-ccw/libc/include/ctype.h      |  24 +
>  pc-bios/s390-ccw/libc/include/errno.h      |  34 +
>  pc-bios/s390-ccw/libc/include/limits.h     |  32 +
>  pc-bios/s390-ccw/libc/include/stdarg.h     |  22 +
>  pc-bios/s390-ccw/libc/include/stdbool.h    |  20 +
>  pc-bios/s390-ccw/libc/include/stddef.h     |  25 +
>  pc-bios/s390-ccw/libc/include/stdint.h     |  28 +
>  pc-bios/s390-ccw/libc/include/stdio.h      |  63 ++
>  pc-bios/s390-ccw/libc/include/stdlib.h     |  34 +
>  pc-bios/s390-ccw/libc/include/string.h     |  37 ++
>  pc-bios/s390-ccw/libc/include/sys/socket.h |  53 ++
>  pc-bios/s390-ccw/libc/include/unistd.h     |  28 +
>  pc-bios/s390-ccw/libc/stdio/Makefile.inc   |  24 +
>  pc-bios/s390-ccw/libc/stdio/fileno.c       |  19 +
>  pc-bios/s390-ccw/libc/stdio/fprintf.c      |  26 +
>  pc-bios/s390-ccw/libc/stdio/printf.c       |  27 +
>  pc-bios/s390-ccw/libc/stdio/putc.c         |  25 +
>  pc-bios/s390-ccw/libc/stdio/putchar.c      |  21 +
>  pc-bios/s390-ccw/libc/stdio/puts.c         |  28 +
>  pc-bios/s390-ccw/libc/stdio/setvbuf.c      |  28 +
>  pc-bios/s390-ccw/libc/stdio/sprintf.c      |  30 +
>  pc-bios/s390-ccw/libc/stdio/stdchnls.c     |  23 +
>  pc-bios/s390-ccw/libc/stdio/vfprintf.c     |  27 +
>  pc-bios/s390-ccw/libc/stdio/vsnprintf.c    | 298 +++++++++
>  pc-bios/s390-ccw/libc/stdio/vsprintf.c     |  19 +
>  pc-bios/s390-ccw/libc/stdlib/Makefile.inc  |  23 +
>  pc-bios/s390-ccw/libc/stdlib/atoi.c        |  18 +
>  pc-bios/s390-ccw/libc/stdlib/atol.c        |  18 +
>  pc-bios/s390-ccw/libc/stdlib/error.c       |  15 +
>  pc-bios/s390-ccw/libc/stdlib/free.c        |  26 +
>  pc-bios/s390-ccw/libc/stdlib/malloc.c      | 157 +++++
>  pc-bios/s390-ccw/libc/stdlib/malloc_defs.h |  16 +
>  pc-bios/s390-ccw/libc/stdlib/memalign.c    |  26 +
>  pc-bios/s390-ccw/libc/stdlib/rand.c        |  29 +
>  pc-bios/s390-ccw/libc/stdlib/realloc.c     |  40 ++
>  pc-bios/s390-ccw/libc/stdlib/strtol.c      | 115 ++++
>  pc-bios/s390-ccw/libc/stdlib/strtoul.c     | 105 ++++
>  pc-bios/s390-ccw/libc/string/Makefile.inc  |  23 +
>  pc-bios/s390-ccw/libc/string/memchr.c      |  29 +
>  pc-bios/s390-ccw/libc/string/memcmp.c      |  30 +
>  pc-bios/s390-ccw/libc/string/memcpy.c      |  27 +
>  pc-bios/s390-ccw/libc/string/memmove.c     |  42 ++
>  pc-bios/s390-ccw/libc/string/memset.c      |  25 +
>  pc-bios/s390-ccw/libc/string/strcasecmp.c  |  28 +
>  pc-bios/s390-ccw/libc/string/strcat.c      |  24 +
>  pc-bios/s390-ccw/libc/string/strchr.c      |  28 +
>  pc-bios/s390-ccw/libc/string/strcmp.c      |  28 +
>  pc-bios/s390-ccw/libc/string/strcpy.c      |  25 +
>  pc-bios/s390-ccw/libc/string/strlen.c      |  27 +
>  pc-bios/s390-ccw/libc/string/strncasecmp.c |  32 +
>  pc-bios/s390-ccw/libc/string/strncmp.c     |  31 +
>  pc-bios/s390-ccw/libc/string/strncpy.c     |  33 +
>  pc-bios/s390-ccw/libc/string/strstr.c      |  37 ++
>  pc-bios/s390-ccw/libc/string/strtok.c      |  45 ++
>  pc-bios/s390-ccw/libnet/Makefile           |  42 ++
>  pc-bios/s390-ccw/libnet/args.c             | 179 ++++++
>  pc-bios/s390-ccw/libnet/args.h             |  23 +
>  pc-bios/s390-ccw/libnet/dhcp.c             | 955 +++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/libnet/dhcp.h             |  49 ++
>  pc-bios/s390-ccw/libnet/dhcpv6.c           | 212 +++++++
>  pc-bios/s390-ccw/libnet/dhcpv6.h           | 154 +++++
>  pc-bios/s390-ccw/libnet/dns.c              | 526 ++++++++++++++++
>  pc-bios/s390-ccw/libnet/dns.h              |  28 +
>  pc-bios/s390-ccw/libnet/ethernet.c         | 189 ++++++
>  pc-bios/s390-ccw/libnet/ethernet.h         |  47 ++
>  pc-bios/s390-ccw/libnet/icmpv6.c           | 409 ++++++++++++
>  pc-bios/s390-ccw/libnet/icmpv6.h           | 135 ++++
>  pc-bios/s390-ccw/libnet/ipv4.c             | 898 +++++++++++++++++++++++++++
>  pc-bios/s390-ccw/libnet/ipv4.h             |  97 +++
>  pc-bios/s390-ccw/libnet/ipv6.c             | 774 +++++++++++++++++++++++
>  pc-bios/s390-ccw/libnet/ipv6.h             | 188 ++++++
>  pc-bios/s390-ccw/libnet/ndp.c              | 184 ++++++
>  pc-bios/s390-ccw/libnet/ndp.h              |  72 +++
>  pc-bios/s390-ccw/libnet/netapps.h          |  25 +
>  pc-bios/s390-ccw/libnet/netload.c          | 600 ++++++++++++++++++
>  pc-bios/s390-ccw/libnet/tcp.c              |  46 ++
>  pc-bios/s390-ccw/libnet/tcp.h              |  27 +
>  pc-bios/s390-ccw/libnet/tftp.c             | 595 ++++++++++++++++++
>  pc-bios/s390-ccw/libnet/tftp.h             |  50 ++
>  pc-bios/s390-ccw/libnet/time.h             |   6 +
>  pc-bios/s390-ccw/libnet/timer.c            |  40 ++
>  pc-bios/s390-ccw/libnet/udp.c              | 115 ++++
>  pc-bios/s390-ccw/libnet/udp.h              |  53 ++
>  pc-bios/s390-ccw/main.c                    |   3 +-
>  pc-bios/s390-ccw/s390-ccw.h                |  30 +-
>  pc-bios/s390-ccw/sbrk.c                    |  39 ++
>  pc-bios/s390-ccw/sclp.c                    |  32 +-
>  pc-bios/s390-ccw/virtio-net.c              | 125 ++++
>  pc-bios/s390-ccw/virtio.c                  |  16 +-
>  pc-bios/s390-ccw/virtio.h                  |  11 +
>  104 files changed, 9296 insertions(+), 57 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/libc/Makefile
>  create mode 100644 pc-bios/s390-ccw/libc/README.txt
>  create mode 100644 pc-bios/s390-ccw/libc/ctype/Makefile.inc
>  create mode 100644 pc-bios/s390-ccw/libc/ctype/isdigit.c
>  create mode 100644 pc-bios/s390-ccw/libc/ctype/isprint.c
>  create mode 100644 pc-bios/s390-ccw/libc/ctype/isspace.c
>  create mode 100644 pc-bios/s390-ccw/libc/ctype/isxdigit.c
>  create mode 100644 pc-bios/s390-ccw/libc/ctype/tolower.c
>  create mode 100644 pc-bios/s390-ccw/libc/ctype/toupper.c
>  create mode 100644 pc-bios/s390-ccw/libc/include/ctype.h
>  create mode 100644 pc-bios/s390-ccw/libc/include/errno.h
>  create mode 100644 pc-bios/s390-ccw/libc/include/limits.h
>  create mode 100644 pc-bios/s390-ccw/libc/include/stdarg.h
>  create mode 100644 pc-bios/s390-ccw/libc/include/stdbool.h
>  create mode 100644 pc-bios/s390-ccw/libc/include/stddef.h
>  create mode 100644 pc-bios/s390-ccw/libc/include/stdint.h
>  create mode 100644 pc-bios/s390-ccw/libc/include/stdio.h
>  create mode 100644 pc-bios/s390-ccw/libc/include/stdlib.h
>  create mode 100644 pc-bios/s390-ccw/libc/include/string.h
>  create mode 100644 pc-bios/s390-ccw/libc/include/sys/socket.h
>  create mode 100644 pc-bios/s390-ccw/libc/include/unistd.h
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/Makefile.inc
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/fileno.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/fprintf.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/printf.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/putc.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/putchar.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/puts.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/setvbuf.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/sprintf.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/stdchnls.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/vfprintf.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/vsnprintf.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdio/vsprintf.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdlib/Makefile.inc
>  create mode 100644 pc-bios/s390-ccw/libc/stdlib/atoi.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdlib/atol.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdlib/error.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdlib/free.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdlib/malloc.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdlib/malloc_defs.h
>  create mode 100644 pc-bios/s390-ccw/libc/stdlib/memalign.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdlib/rand.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdlib/realloc.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdlib/strtol.c
>  create mode 100644 pc-bios/s390-ccw/libc/stdlib/strtoul.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/Makefile.inc
>  create mode 100644 pc-bios/s390-ccw/libc/string/memchr.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/memcmp.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/memcpy.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/memmove.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/memset.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/strcasecmp.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/strcat.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/strchr.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/strcmp.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/strcpy.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/strlen.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/strncasecmp.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/strncmp.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/strncpy.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/strstr.c
>  create mode 100644 pc-bios/s390-ccw/libc/string/strtok.c
>  create mode 100644 pc-bios/s390-ccw/libnet/Makefile
>  create mode 100644 pc-bios/s390-ccw/libnet/args.c
>  create mode 100644 pc-bios/s390-ccw/libnet/args.h
>  create mode 100644 pc-bios/s390-ccw/libnet/dhcp.c
>  create mode 100644 pc-bios/s390-ccw/libnet/dhcp.h
>  create mode 100644 pc-bios/s390-ccw/libnet/dhcpv6.c
>  create mode 100644 pc-bios/s390-ccw/libnet/dhcpv6.h
>  create mode 100644 pc-bios/s390-ccw/libnet/dns.c
>  create mode 100644 pc-bios/s390-ccw/libnet/dns.h
>  create mode 100644 pc-bios/s390-ccw/libnet/ethernet.c
>  create mode 100644 pc-bios/s390-ccw/libnet/ethernet.h
>  create mode 100644 pc-bios/s390-ccw/libnet/icmpv6.c
>  create mode 100644 pc-bios/s390-ccw/libnet/icmpv6.h
>  create mode 100644 pc-bios/s390-ccw/libnet/ipv4.c
>  create mode 100644 pc-bios/s390-ccw/libnet/ipv4.h
>  create mode 100644 pc-bios/s390-ccw/libnet/ipv6.c
>  create mode 100644 pc-bios/s390-ccw/libnet/ipv6.h
>  create mode 100644 pc-bios/s390-ccw/libnet/ndp.c
>  create mode 100644 pc-bios/s390-ccw/libnet/ndp.h
>  create mode 100644 pc-bios/s390-ccw/libnet/netapps.h
>  create mode 100644 pc-bios/s390-ccw/libnet/netload.c
>  create mode 100644 pc-bios/s390-ccw/libnet/tcp.c
>  create mode 100644 pc-bios/s390-ccw/libnet/tcp.h
>  create mode 100644 pc-bios/s390-ccw/libnet/tftp.c
>  create mode 100644 pc-bios/s390-ccw/libnet/tftp.h
>  create mode 100644 pc-bios/s390-ccw/libnet/time.h
>  create mode 100644 pc-bios/s390-ccw/libnet/timer.c
>  create mode 100644 pc-bios/s390-ccw/libnet/udp.c
>  create mode 100644 pc-bios/s390-ccw/libnet/udp.h
>  create mode 100644 pc-bios/s390-ccw/sbrk.c
>  create mode 100644 pc-bios/s390-ccw/virtio-net.c
>
