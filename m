Received: from eggs.gnu.org ([2001:4830:134:3::10]:33966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dLaDO-0004s3-0E
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 15:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dLaDI-00021c-NK
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 15:13:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dLaDI-00021N-H3
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 15:13:52 -0400
References: <CAFEAcA9+HauZoeSxrdXE+cENswUPsjoSOVFJ-wMfboYH5wC2=Q@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c1efba1b-0af9-50a5-e200-a3f74a88d1c1@redhat.com>
Date: Thu, 15 Jun 2017 21:13:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+HauZoeSxrdXE+cENswUPsjoSOVFJ-wMfboYH5wC2=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU issues on SPARC hosts due to
 more-than-page-alignment requirement for MAP_SHARED|MAP_FIXED...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 06/15/17 20:17, Peter Maydell wrote:
> It turns out that SPARC hosts impose a requirement that
> if you mmap MAP_SHARED|MAP_FIXED then the address must be
> aligned to SHMLBA alignment, which for SPARC is 16K and
> larger than the 8K page size:
>  http://lxr.linux.no/#linux+v4.10.1/arch/sparc/kernel/sys_sparc_64.c#L158
> 
> QEMU doesn't really cope with this. In particular, ivmshm
> doesn't work:
> 
> $ ppc64-softmmu/qemu-system-ppc64 -display none -device
> ivshmem,shm=/qtest-20273-1334572184,size=0x1
> qemu-system-ppc64: System page size 0x2000 is not enabled in
> page_size_mask (0x11000). Performance may be slow
> qemu-system-ppc64: -device
> ivshmem,shm=/qtest-20273-1334572184,size=0x1: ivshmem is deprecated,
> please use ivshmem-plain or ivshmem-doorbell instead
> Unexpected error in file_ram_alloc() at /home/pm215/qemu/exec.c:1599:
> qemu-system-ppc64: -device
> ivshmem,shm=/qtest-20273-1334572184,size=0x1: unable to map backing
> store for guest RAM: Invalid argument
> Aborted
> 
> (noticed because this is a make check failure).
> 
> exec.c calls qemu_fd_getpagesize() to figure out the alignment
> here (on a file in /dev/shm/) and ends up in its default codepath
> that returns getpagesize(), which is too small.
> 
> What's the best way to fix this? As far as I can tell
> the restriction applies to any mapping, not just /dev/shm files.
> QEMU's assumptions that pagesize is the alignment requirement
> seem fairly widespread :-(

In POSIX, SHMLBA is specified for shmat(), and not specified for mmap().

http://pubs.opengroup.org/onlinepubs/9699919799/functions/shmat.html
http://pubs.opengroup.org/onlinepubs/9699919799/functions/mmap.html

Apparently, /dev/shm (tmpfs) stands for the same sysv memory sharing
that shmat() stands for. Perhaps we can collect the /dev/shm mappings
and apply the shmat() restriction(s) to them explicitly -- but only to them.

If that's not the case, i.e. Linux on SPARC enforces SHMLBA for all
kinds of mmap() -- which I would call a POSIX conformance bug --, then
we can perhaps generally round up to SHMLBA within qemu_fd_getpagesize()
and qemu_mempath_getpagesize(), on SPARC hosts.

Laszlo
