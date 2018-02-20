Received: from eggs.gnu.org ([2001:4830:134:3::10]:44179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eoBnL-0006kg-JM
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eoBnI-0003tM-DM
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:33:35 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:52095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eoBnI-0003sd-34
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 12:33:32 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 20 Feb 2018 18:33:03 +0100
Message-Id: <20180220173307.25125-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 0/4] linux-user: select CPU type according
 ELF header values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aaron Sierra <asierra@xes-inc.com>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>, YunQiang Su <syq@debian.org>, Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <laurent@vivier.eu>

This idea has been suggested to me before by Philippe
Mathieu-Daudé, and recently YunQiang Su has proposed a
patch to manage the MIPS r6 case.

Based on this, this series tries to clean-up the original
patch, and introduces the use for m68k architecture and
port the patch from YunQiang Su.

v5: Use EF_MIPS_ARCH mask to read MIPS architecture flags
    -> removed Richard's R-b because of this change
    Some architectures like sparc32plus are
    32bit architectures using 64bit processors.
    We need to select the CPU according to the
    TARGET_ABI ("sparc" path to target_elf.h)
    and the TARGET_ARCH ("sparc64").
    (Reported by Peter Maydell)
v4: Add YunQiang Su's S-o-b
    I don't use cpu type as suggested by Igor because
    his latest series "generalize parsing of cpu_model (part 4)" v3
    doesn't seem to need this anymore (use of parse_cpu_model())
v3: fix code indent problem reported by patchew
    remove useless "!= 0"
    check for EF_M68K_M68000
    add EF_M68K_* flags in elf.h
    set 680x0 default CPU to m68040
    change "#if ... #endif" structure for ppc
v2: move cpu_model selection to linux-user/*/target_elf.h
    provide eflags to cpu_get_model() instead of fd
    (and modify other patches accordingly)

Laurent Vivier (2):
  linux-user: Move CPU type name selection to a function
  linux-user,m68k: select CPU according to ELF header values

YunQiang Su (2):
  linux-user: introduce functions to detect CPU type
  linux-user: MIPS set cpu to r6 CPU if binary is R6

 include/elf.h                      | 35 ++++++++++++++++++++++
 linux-user/aarch64/target_elf.h    | 14 +++++++++
 linux-user/alpha/target_elf.h      | 14 +++++++++
 linux-user/arm/target_elf.h        | 14 +++++++++
 linux-user/cris/target_elf.h       | 14 +++++++++
 linux-user/elfload.c               | 35 ++++++++++++++++++++++
 linux-user/hppa/target_elf.h       | 14 +++++++++
 linux-user/i386/target_elf.h       | 14 +++++++++
 linux-user/m68k/target_elf.h       | 20 +++++++++++++
 linux-user/main.c                  | 59 +++++++-------------------------------
 linux-user/microblaze/target_elf.h | 14 +++++++++
 linux-user/mips/target_elf.h       | 17 +++++++++++
 linux-user/mips64/target_elf.h     | 17 +++++++++++
 linux-user/nios2/target_elf.h      | 14 +++++++++
 linux-user/openrisc/target_elf.h   | 14 +++++++++
 linux-user/ppc/target_elf.h        | 18 ++++++++++++
 linux-user/qemu.h                  |  1 +
 linux-user/s390x/target_elf.h      | 14 +++++++++
 linux-user/sh4/target_elf.h        | 14 +++++++++
 linux-user/sparc/target_elf.h      | 18 ++++++++++++
 linux-user/sparc64/target_elf.h    | 14 +++++++++
 linux-user/tilegx/target_elf.h     | 14 +++++++++
 linux-user/unicore32/target_elf.h  | 14 +++++++++
 linux-user/x86_64/target_elf.h     | 14 +++++++++
 24 files changed, 382 insertions(+), 48 deletions(-)
 create mode 100644 linux-user/aarch64/target_elf.h
 create mode 100644 linux-user/alpha/target_elf.h
 create mode 100644 linux-user/arm/target_elf.h
 create mode 100644 linux-user/cris/target_elf.h
 create mode 100644 linux-user/hppa/target_elf.h
 create mode 100644 linux-user/i386/target_elf.h
 create mode 100644 linux-user/m68k/target_elf.h
 create mode 100644 linux-user/microblaze/target_elf.h
 create mode 100644 linux-user/mips/target_elf.h
 create mode 100644 linux-user/mips64/target_elf.h
 create mode 100644 linux-user/nios2/target_elf.h
 create mode 100644 linux-user/openrisc/target_elf.h
 create mode 100644 linux-user/ppc/target_elf.h
 create mode 100644 linux-user/s390x/target_elf.h
 create mode 100644 linux-user/sh4/target_elf.h
 create mode 100644 linux-user/sparc/target_elf.h
 create mode 100644 linux-user/sparc64/target_elf.h
 create mode 100644 linux-user/tilegx/target_elf.h
 create mode 100644 linux-user/unicore32/target_elf.h
 create mode 100644 linux-user/x86_64/target_elf.h

-- 
2.14.3
