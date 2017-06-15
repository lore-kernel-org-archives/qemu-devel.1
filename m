Received: from eggs.gnu.org ([2001:4830:134:3::10]:42466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLZKr-0001rf-Ff
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 14:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLZKq-00081V-BJ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 14:17:37 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLZKq-00081D-2u
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 14:17:36 -0400
Received: by mail-wm0-x233.google.com with SMTP id d73so6088763wma.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 11:17:36 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jun 2017 19:17:14 +0100
Message-ID: <CAFEAcA9+HauZoeSxrdXE+cENswUPsjoSOVFJ-wMfboYH5wC2=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU issues on SPARC hosts due to
 more-than-page-alignment requirement for MAP_SHARED|MAP_FIXED...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

It turns out that SPARC hosts impose a requirement that
if you mmap MAP_SHARED|MAP_FIXED then the address must be
aligned to SHMLBA alignment, which for SPARC is 16K and
larger than the 8K page size:
 http://lxr.linux.no/#linux+v4.10.1/arch/sparc/kernel/sys_sparc_64.c#L158

QEMU doesn't really cope with this. In particular, ivmshm
doesn't work:

$ ppc64-softmmu/qemu-system-ppc64 -display none -device
ivshmem,shm=/qtest-20273-1334572184,size=0x1
qemu-system-ppc64: System page size 0x2000 is not enabled in
page_size_mask (0x11000). Performance may be slow
qemu-system-ppc64: -device
ivshmem,shm=/qtest-20273-1334572184,size=0x1: ivshmem is deprecated,
please use ivshmem-plain or ivshmem-doorbell instead
Unexpected error in file_ram_alloc() at /home/pm215/qemu/exec.c:1599:
qemu-system-ppc64: -device
ivshmem,shm=/qtest-20273-1334572184,size=0x1: unable to map backing
store for guest RAM: Invalid argument
Aborted

(noticed because this is a make check failure).

exec.c calls qemu_fd_getpagesize() to figure out the alignment
here (on a file in /dev/shm/) and ends up in its default codepath
that returns getpagesize(), which is too small.

What's the best way to fix this? As far as I can tell
the restriction applies to any mapping, not just /dev/shm files.
QEMU's assumptions that pagesize is the alignment requirement
seem fairly widespread :-(

thanks
-- PMM
