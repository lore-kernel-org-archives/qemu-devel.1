Received: from eggs.gnu.org ([2001:4830:134:3::10]:60644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f4T7u-0003Yk-VD
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f4T7r-0004GJ-KT
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:18:06 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1f4T7r-0004C4-Aa
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:18:03 -0400
From: Christophe Lyon <christophe.lyon@st.com>
Date: Fri, 6 Apr 2018 17:17:28 +0200
Message-ID: <20180406151752.10854-1-christophe.lyon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [ARM/FDPIC 0/4] FDPIC ABI for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, christophe.lyon@linaro.org, peter.maydell@linaro.org

Hello,

This patch series implements the QEMU contribution of the FDPIC
ABI for ARM targets.

This ABI enables to run Linux on ARM MMU-less cores and supports
shared libraries to reduce the memory footprint.

Without MMU, text and data segment relative distances are different
from one process to another, hence the need for a dedicated FDPIC
register holding the start address of the data segment. One of the
side effects is that function pointers require two words to be
represented: the address of the code, and the data segment start
address. These two words are designated as "Function Descriptor",
hence the "FD PIC" name.

On ARM, the FDPIC register is r9 [3].

This work was developed some time ago by STMicroelectronics, and was
presented during Linaro Connect SFO15 (September 2015). You can watch
the discussion and read the slides [1].
This presentation was related to the toolchain published on github [2],
which is based on binutils-2.22, gcc-4.7, uclibc-0.9.33.2, gdb-7.5.1
and qemu-2.3.0, and for which pre-built binaries are available [2].

The ABI itself is described in details in [3].

Our Linux kernel patches have been updated and committed by Nicolas
Pitre (Linaro) in July 2017. They are required so that the loader is
able to handle this new file type. Indeed, the ELF files are tagged
with ELFOSABI_ARM_FDPIC. This new tag has been allocated by ARM, as
well as the new relocations involved.

This patch series has been rebased on top of QEMU from 2018-03-28.

I have also rebased the GCC patch series, but it is still WIP as
cleanup is still needed before I can request a review. It can be
useful to build a preview toolchain though, so my WIP branch is
available at [4].
To build such a toolchain, you'd also need to use my uClibc
branch [5].

I am currently working on updating the patches for the other toolchain
components, and will upstream them soon. This includes gcc, uclibc,
and gdb.

This series provides support for ARM v7 and later architectures and
has been used to run the GCC tests on arm-linux-gnueabi without
regression, as well as arm-linux-uclibceabi.

Are the QEMU patches OK for inclusion in master?

Thanks,

Christophe.


[1] http://connect.linaro.org/resource/sfo15/sfo15-406-arm-fdpic-toolset-kernel-libraries-for-cortex-m-cortex-r-mmuless-cores/
[2] https://github.com/mickael-guene/fdpic_manifest
[3] https://github.com/mickael-guene/fdpic_doc/blob/master/abi.txt
[4] https://git.linaro.org/people/christophe.lyon/gcc.git/log/?h=fdpic-upstream
[5] https://git.linaro.org/people/christophe.lyon/uclibc.git/log/?h=uClibc-0.9.33.2-fdpic-upstream

Christophe Lyon (4):
  linux-user: ARM-FDPIC: Add configure option to support loading of
    FDPIC binaries
  linux-user: ARM-FDPIC: Add support of FDPIC for ARM.
  linux-user: ARM-FDPIC: Add support for signals for FDPIC targets
  linux-user: ARM-FDPIC: Add arm get tls syscall support

 configure                       | 10 +++++
 include/elf.h                   |  1 +
 linux-user/arm/target_syscall.h |  1 +
 linux-user/elfload.c            | 35 ++++++++++++++++
 linux-user/main.c               |  8 ++++
 linux-user/qemu.h               |  3 ++
 linux-user/signal.c             | 91 +++++++++++++++++++++++++++++++++++++----
 target/arm/cpu.h                |  6 +++
 8 files changed, 147 insertions(+), 8 deletions(-)

-- 
2.6.3
