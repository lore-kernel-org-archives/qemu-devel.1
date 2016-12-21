Received: from eggs.gnu.org ([2001:4830:134:3::10]:46379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cJl7e-0000TW-D3
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 12:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1cJl7b-0005lT-7I
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 12:56:14 -0500
Received: from mout.gmx.net ([212.227.17.22]:61503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1cJl7a-0005l2-Ro
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 12:56:11 -0500
References: <20161216191405.9473-1-rth@twiddle.net>
	<91a51975-dad9-d029-c2c8-2497f188b1a3@tuxfamily.org>
From: Helge Deller <deller@gmx.de>
Message-ID: <c3db1cb9-37bd-b69c-4007-9602a197dc72@gmx.de>
Date: Wed, 21 Dec 2016 18:55:51 +0100
MIME-Version: 1.0
In-Reply-To: <91a51975-dad9-d029-c2c8-2497f188b1a3@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/26] New hppa-linux-user target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 18.12.2016 07:56, Thomas Huth wrote:
> On 16.12.2016 20:13, Richard Henderson wrote:
>> This is a linux-user only port, emulating a 32-bit only version of a
>> pa-2.0 cpu.  This is good enough to do well with both the gcc and glibc
>> testsuites.  Helge Deller has provided invaluable assistance testing 
>> with a more complete debian chroot.
>>
>> What's missing:
>>   * Space registers.  Since Linux sets them all equal (for a flat
>>     address space) and uses them like address-space identifiers,
>>     we can simply set them all to 0 and ignore them.
>>
>>   * Architecture subsets.  There's no markup for running a pure pa1.0
>>     or pa1.1 cpu.  I happily accept everything up to pa2.0 at the moment.
>>
>>   * Wide mode.  While I have pa2.0 instructions, I don't support running
>>     in 64-bit mode.  Since neither the linux kernel nor glibc support a
>>     64-bit userland, it would be a lot more work than just adding the insns.
>>
>>   * Multimedia instructions.  These are tied to wide mode, so...
>>
>> When squashing the patches down from my development tree, I wanted to
>> preserve Helge's contributions, so the linux-user part is more patches
>> than I would normally have preserved.
>>
>>
>> r~
>>
>>
>> Helge Deller (3):
>>   linux-user: Handle TIOCSTART and TIOCSTOP
>>   linux-user: Add SIOCGPGRP, SIOCGSTAMP, SIOCGSTAMPNS
>>   linux-user: Add some hppa ioctls
>>
>> Richard Henderson (23):
>>   Revert "Remove remainders of HPPA backend"
>>   linux-user: Support stack-grows-up in elfload.c
>>   linux-user: Handle ERFKILL and EHWPOISON
>>   linux-user: Handle more IPV6 sockopts
>>   linux-user: Add HPPA socket.h definitions
>>   linux-user: Add HPPA syscall numbers
>>   linux-user: Add HPPA termbits.h
>>   linux-user: Add HPPA target_syscall.h
>>   linux-user: Add HPPA definitions to syscall_defs.h
>>   linux-user: Add HPPA target_structs.h
>>   linux-user: Add HPPA target_signal.h and target_cpu.h
>>   linux-user: Add HPPA signal handling
>>   linux-user: Add HPPA startup and main loop
>>   target-hppa: Add softfloat specializations
>>   target-hppa: Add framework and enable compilation
>>   target-hppa: Add nullification framework
>>   target-hppa: Implement basic arithmetic
>>   target-hppa: Implement branches
>>   target-hppa: Implement linux-user gateway page
>>   target-hppa: Implement shifts and deposits
>>   target-hppa: Implement loads and stores
>>   target-hppa: Implement system and memory-management insns
>>   target-hppa: Implement floating-point insns
>>
>>  configure                           |    7 +-
>>  default-configs/hppa-linux-user.mak |    1 +
>>  disas.c                             |    2 +
>>  disas/Makefile.objs                 |    1 +
>>  disas/hppa.c                        | 2832 +++++++++++++++++++++++++
>>  fpu/softfloat-specialize.h          |   20 +-
>>  linux-user/alpha/target_syscall.h   |    2 +
>>  linux-user/elfload.c                |  259 ++-
>>  linux-user/errno_defs.h             |    3 +
>>  linux-user/hppa/sockbits.h          |   97 +
>>  linux-user/hppa/syscall_nr.h        |  353 ++++
>>  linux-user/hppa/target_cpu.h        |   35 +
>>  linux-user/hppa/target_signal.h     |   29 +
>>  linux-user/hppa/target_structs.h    |   54 +
>>  linux-user/hppa/target_syscall.h    |  237 +++
>>  linux-user/hppa/termbits.h          |  219 ++
>>  linux-user/ioctls.h                 |    8 +
>>  linux-user/main.c                   |  185 +-
>>  linux-user/mips/target_syscall.h    |    5 +
>>  linux-user/mips64/target_syscall.h  |    5 +
>>  linux-user/qemu.h                   |    3 +
>>  linux-user/signal.c                 |  191 +-
>>  linux-user/socket.h                 |    2 +
>>  linux-user/syscall.c                |   41 +-
>>  linux-user/syscall_defs.h           |  154 +-
>>  linux-user/syscall_types.h          |    6 +
>>  target-hppa/Makefile.objs           |    1 +
>>  target-hppa/cpu-qom.h               |   52 +
>>  target-hppa/cpu.c                   |  165 ++
>>  target-hppa/cpu.h                   |  144 ++
>>  target-hppa/gdbstub.c               |  111 +
>>  target-hppa/helper.c                |  137 ++
>>  target-hppa/helper.h                |   66 +
>>  target-hppa/op_helper.c             |  570 +++++
>>  target-hppa/translate.c             | 3946 +++++++++++++++++++++++++++++++++++
>>  35 files changed, 9864 insertions(+), 79 deletions(-)
>>  create mode 100644 default-configs/hppa-linux-user.mak
>>  create mode 100644 disas/hppa.c
>>  create mode 100644 linux-user/hppa/sockbits.h
>>  create mode 100644 linux-user/hppa/syscall_nr.h
>>  create mode 100644 linux-user/hppa/target_cpu.h
>>  create mode 100644 linux-user/hppa/target_signal.h
>>  create mode 100644 linux-user/hppa/target_structs.h
>>  create mode 100644 linux-user/hppa/target_syscall.h
>>  create mode 100644 linux-user/hppa/termbits.h
>>  create mode 100644 target-hppa/Makefile.objs
>>  create mode 100644 target-hppa/cpu-qom.h
>>  create mode 100644 target-hppa/cpu.c
>>  create mode 100644 target-hppa/cpu.h
>>  create mode 100644 target-hppa/gdbstub.c
>>  create mode 100644 target-hppa/helper.c
>>  create mode 100644 target-hppa/helper.h
>>  create mode 100644 target-hppa/op_helper.c
>>  create mode 100644 target-hppa/translate.c
> 
> IMHO we should not add new targets without having somebody volunteering
> to look after them, too. So there should be an update to MAINTAINERS
> here, too, even if it's just for "Odd fixes". So could you or Helge
> please volunteer for the maintainers job here, too?

Sure, I volunteer.

Helge
