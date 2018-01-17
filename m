Received: from eggs.gnu.org ([2001:4830:134:3::10]:57314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpyZ-0000Ke-E6
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpyT-0006o0-Hz
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:50:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpyT-0006ng-93
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:50:01 -0500
Date: Wed, 17 Jan 2018 16:49:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180117164950.3c818541@redhat.com>
In-Reply-To: <20180116222212.1266-1-laurent@vivier.eu>
References: <20180116222212.1266-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] linux-user: select CPU type
 according ELF header values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, YunQiang Su <syq@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1E?= =?UTF-8?B?YXVkw6k=?= <f4bug@amsat.org>, Aaron Sierra <asierra@xes-inc.com>

On Tue, 16 Jan 2018 23:22:08 +0100
Laurent Vivier <laurent@vivier.eu> wrote:

> This idea has been suggested to me before by Philippe
> Mathieu-Daud=C3=A9, and recently YunQiang Su has proposed a
> patch to manage the MIPS r6 case.
>=20
> Based on this, this series tries to clean-up the original
> patch, and introduces the use for m68k architecture and
> port the patch from YunQiang Su.
>=20
> v3: fix code indent problem reported by patchew
>     remove useless "!=3D 0"
>     check for EF_M68K_M68000
>     add EF_M68K_* flags in elf.h
>     set 680x0 default CPU to m68040
>     change "#if ... #endif" structure for ppc
> v2: move cpu_model selection to linux-user/*/target_elf.h
>     provide eflags to cpu_get_model() instead of fd
>     (and modify other patches accordingly)
Sorry for not noticing it earlier, but could you please
fix series to use cpu type names instead of cpu_model?

I've just posted series that completes cpu_model refactoring
  [PATCH 00/24] generalize parsing of cpu_model (part 4)
which removes remnants of the code using cpu_model to
instantiate CPUs, including reworking how default
cpu type for *-user is picked up.

After that cpu_model shouldn't be used anywhere in the code
except of routines that process "-cpu" CLI and cpu types
should be used directly.

So you might not need 1/4 after that or it would have
to be reworked and probably other patches where where
cpu_model is used.


> Laurent Vivier (2):
>   linux-user: Move CPU type name selection to a function
>   linux-user,m68k: select CPU according to ELF header values
>=20
> YunQiang Su (2):
>   linux-user: introduce functions to detect CPU type
>   linux-user: MIPS set cpu to r6 CPU if binary is R6
>=20
>  include/elf.h                      | 32 +++++++++++++++++++++
>  linux-user/aarch64/target_elf.h    | 14 +++++++++
>  linux-user/alpha/target_elf.h      | 14 +++++++++
>  linux-user/arm/target_elf.h        | 14 +++++++++
>  linux-user/cris/target_elf.h       | 14 +++++++++
>  linux-user/elfload.c               | 35 ++++++++++++++++++++++
>  linux-user/hppa/target_elf.h       | 14 +++++++++
>  linux-user/i386/target_elf.h       | 14 +++++++++
>  linux-user/m68k/target_elf.h       | 20 +++++++++++++
>  linux-user/main.c                  | 59 +++++++-------------------------=
------
>  linux-user/microblaze/target_elf.h | 14 +++++++++
>  linux-user/mips/target_elf.h       | 17 +++++++++++
>  linux-user/mips64/target_elf.h     | 17 +++++++++++
>  linux-user/nios2/target_elf.h      | 14 +++++++++
>  linux-user/openrisc/target_elf.h   | 14 +++++++++
>  linux-user/ppc/target_elf.h        | 18 ++++++++++++
>  linux-user/qemu.h                  |  1 +
>  linux-user/s390x/target_elf.h      | 14 +++++++++
>  linux-user/sh4/target_elf.h        | 14 +++++++++
>  linux-user/sparc/target_elf.h      | 14 +++++++++
>  linux-user/sparc64/target_elf.h    | 14 +++++++++
>  linux-user/tilegx/target_elf.h     | 14 +++++++++
>  linux-user/unicore32/target_elf.h  | 14 +++++++++
>  linux-user/x86_64/target_elf.h     | 14 +++++++++
>  24 files changed, 375 insertions(+), 48 deletions(-)
>  create mode 100644 linux-user/aarch64/target_elf.h
>  create mode 100644 linux-user/alpha/target_elf.h
>  create mode 100644 linux-user/arm/target_elf.h
>  create mode 100644 linux-user/cris/target_elf.h
>  create mode 100644 linux-user/hppa/target_elf.h
>  create mode 100644 linux-user/i386/target_elf.h
>  create mode 100644 linux-user/m68k/target_elf.h
>  create mode 100644 linux-user/microblaze/target_elf.h
>  create mode 100644 linux-user/mips/target_elf.h
>  create mode 100644 linux-user/mips64/target_elf.h
>  create mode 100644 linux-user/nios2/target_elf.h
>  create mode 100644 linux-user/openrisc/target_elf.h
>  create mode 100644 linux-user/ppc/target_elf.h
>  create mode 100644 linux-user/s390x/target_elf.h
>  create mode 100644 linux-user/sh4/target_elf.h
>  create mode 100644 linux-user/sparc/target_elf.h
>  create mode 100644 linux-user/sparc64/target_elf.h
>  create mode 100644 linux-user/tilegx/target_elf.h
>  create mode 100644 linux-user/unicore32/target_elf.h
>  create mode 100644 linux-user/x86_64/target_elf.h
>=20
